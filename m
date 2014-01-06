From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/17] safe_create_leading_directories(): split on first of multiple slashes
Date: Mon,  6 Jan 2014 14:45:23 +0100
Message-ID: <1389015935-21936-6-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AVd-0005p1-E2
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbaAFNqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:23 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50604 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482AbaAFNqT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:19 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-e2-52cab3aa6d19
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 2E.A9.18966.AA3BAC25; Mon,  6 Jan 2014 08:46:18 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfP6021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:17 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqLtq86kgg857VhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa7py1gc2D1+Pv+A5PHzll32T0uXlL2eDzxBKvH501yAaxR3DZJiSVlwZnp
	efp2CdwZ9yZcZi04y1Fx9FVlA+MTti5GTg4JAROJQ2dPskDYYhIX7q0HinNxCAlcZpQ4OvkU
	O4RzjEli0rtpjCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBRYzSnRN+wZWJCwQL7F04zagBAcH
	i4CqxPN1RiBhXgEXicWnn7OBhCUEFCRWXxcCCXMKuEpMm3YY7CAhoJI1hx6xTGDkXcDIsIpR
	LjGnNFc3NzEzpzg1Wbc4OTEvL7VI10gvN7NELzWldBMjJKB4dzD+XydziFGAg1GJh9fj2ckg
	IdbEsuLK3EOMkhxMSqK8nKtPBQnxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4eVaAJTjTUmsrEot
	yodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwmmwCahQsSk1PrUjLzClBSDNxcIII
	LpANPEAbFEAKeYsLEnOLM9Mhik4xKkqJ8woCo1dIACSRUZoHNwAW+68YxYH+Eea1AWnnAaYN
	uO5XQIOZgAaHxoENLklESEk1MAa1tslu7dzFUZbvpBqkdb5xytkgKwXm2mmcHv4S7ZyV5bf+
	bfgZLaG/arnA+9rzD6uMTXZeD2mXsmYJz/7zu1jlybR3k+5O7D41a8fkJPG+/X+DJ2w1Yn2y
	+PGZV71BR5Q/KOzcoTb9WZmjs2n6z5aKW593L7fcf9uyS+3/XO2DYfe2Bv+dka/E 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239993>

If the input path has multiple slashes between path components (e.g.,
"foo//bar"), then the old code was breaking the path at the last
slash, not the first one.  So in the above example, the second slash
was overwritten with NUL, resulting in the parent directory being
sought as "foo/".

When stat() is called on "foo/", it fails with ENOTDIR if "foo" exists
but is not a directory.  This caused the wrong path to be taken in the
subsequent logic.

So instead, split path components at the first intercomponent slash
rather than the last one.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 54202e8..f3190c6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -115,9 +115,10 @@ int safe_create_leading_directories(char *path)
 
 		if (!slash)
 			break;
-		while (*(slash + 1) == '/')
-			slash++;
+
 		next_component = slash + 1;
+		while (*next_component == '/')
+			next_component++;
 		if (!*next_component)
 			break;
 
-- 
1.8.5.2
