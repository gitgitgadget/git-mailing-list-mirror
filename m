From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/17] fsck: don't put a void*-shaped peg in a char*-shaped hole
Date: Sun, 19 May 2013 22:27:08 +0200
Message-ID: <1368995232-11042-14-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADY-0004ax-OV
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab3ESU2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:18 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:57958 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754787Ab3ESU2Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:16 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-af-519935df4c0b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id ED.86.02295.FD539915; Sun, 19 May 2013 16:28:15 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5W026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:14 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqHvfdGagwe3tNhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj67I97AXPuCoe72pkb2A8x9HFyMkhIWAi0Xj8CiuELSZx4d56ti5GLg4hgcuMEifW
	b2KHcM4zSWz7O4EFpIpNQFdiUU8zE4gtIiAr8f3wRkYQm1lgAqPE0v5CEFtYIEDi5M0+NhCb
	RUBV4s+/t2A2r4CrxPxFc5ggtilIXJ61hhnE5gSKb2nfBXaFkICLxL/+26wTGHkXMDKsYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdI11MvNLNFLTSndxAgJKp4djN/WyRxiFOBgVOLh1Xg3PVCI
	NbGsuDL3EKMkB5OSKO87k5mBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR49wgB5XhTEiurUovy
	YVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzmwOgREixKTU+tSMvMKUFIM3Fwgggu
	kA08QBukQQp5iwsSc4sz0yGKTjEqSonzMoMkBEASGaV5cANg8f+KURzoH2FeW5AqHmDqgOt+
	BTSYCWgw67WpIINLEhFSUg2MEVbzDVM4eB/kXjKMuqz2oHGFalaABfPZw08lHR36z739uMZQ
	faLZyj/SnUIutgpn9BQdxdhEtlzjymT0EzVUjM9WYut+conjcHa/5Le/J3XPuYndqDRcaL/m
	immr6MqC5WHhxhMc7uYozn+2/++8r54b/jCo3kvizxO8JK1e6NCuvNRR1liJpTgj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224913>

The source of this nonsense was

    04d3975937 fsck: reduce stack footprint

, which wedged a pointer to parent into the object_array_entry's name
field.  The parent pointer was passed to traverse_one_object(), even
though that function *didn't use it*.

The useless code has been deleted over time.  Commit

    a1cdc25172 fsck: drop unused parameter from traverse_one_object()

removed the parent pointer from traverse_one_object()'s
signature. Commit

    c0aa335c95 Remove unused variables

removed the code that read the parent pointer back out of the name
field.

This commit takes the last step: don't write the parent pointer into
the name field in the first place.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
I thought that this misuse of the name field was going to be a
showstopper for changing how the name's memory is managed, but then I
noticed that the value stored here is never used.

 builtin/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index bb9a2cd..9909b6d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -112,7 +112,7 @@ static int mark_object(struct object *obj, int type, void *data)
 		return 1;
 	}
 
-	add_object_array(obj, (void *) parent, &pending);
+	add_object_array(obj, NULL, &pending);
 	return 0;
 }
 
-- 
1.8.2.3
