From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/17] describe: make own copy of refname
Date: Sun, 19 May 2013 22:26:56 +0200
Message-ID: <1368995232-11042-2-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeAD4-0004EN-N4
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab3ESU16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:27:58 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:43726 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754541Ab3ESU15 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:27:57 -0400
X-AuditID: 12074411-b7f286d0000008e8-b7-519935cc1256
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id DA.D1.02280.CC539915; Sun, 19 May 2013 16:27:56 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5K026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:27:55 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqHvGdGagwYeZVhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtj1rof7AV7OCrePLrE3MB4gq2LkZNDQsBEYvPyjYwQtpjEhXvrgeJcHEIClxkl9py9
	BeWcZ5I4deE0K0gVm4CuxKKeZiYQW0RAVuL7YYhuZoEJjBJL+wtBbGEBS4nNS26xg9gsAqoS
	Ow6sA6vnFXCR6J67jR1im4LE5VlrmEFsTgFXiS3tu8DmCwHV/Ou/zTqBkXcBI8MqRrnEnNJc
	3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJCgEtzBOOOk3CFGAQ5GJR7ehg/TA4VYE8uK
	K3MPMUpyMCmJ8r4zmRkoxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3jxBQjjclsbIqtSgfJiXN
	waIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwesOMlSwKDU9tSItM6cEIc3EwQkiuEA28ABt
	WARSyFtckJhbnJkOUXSKUVFKnPciSEIAJJFRmgc3ABb/rxjFgf4R5j0CUsUDTB1w3a+ABjMB
	DWa9NhVkcEkiQkqqgdHzirdHfrhmQFOD8f5vm7yn9yekGs11mZv3YO/yu5lqQq4r1R63Rlc9
	3XS4yOZjD78S7/q5ba/sVGramizbP61OuDBZK9g0JCSscmnPvfb6jKgFxrEPJO4flL6Yfcin
	Tcr9o5d3s/iGN+f73i7jytN7Xb/4yomq7Ja1HhECGtrbDa7P4ZggrMRSnJFoqMVc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224907>

Do not retain a reference to the refname passed to the each_ref_fn
callback get_name(), because there is no guarantee of the lifetimes of
these names.  Instead, make a local copy when needed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/describe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 6636a68..3dc09eb 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -42,7 +42,7 @@ struct commit_name {
 	unsigned prio:2; /* annotated tag = 2, tag = 1, head = 0 */
 	unsigned name_checked:1;
 	unsigned char sha1[20];
-	const char *path;
+	char *path;
 };
 static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
@@ -126,12 +126,14 @@ static void add_to_known_names(const char *path,
 			} else {
 				e->next = NULL;
 			}
+			e->path = NULL;
 		}
 		e->tag = tag;
 		e->prio = prio;
 		e->name_checked = 0;
 		hashcpy(e->sha1, sha1);
-		e->path = path;
+		free(e->path);
+		e->path = xstrdup(path);
 	}
 }
 
-- 
1.8.2.3
