From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/25] describe: make own copy of refname
Date: Sat, 25 May 2013 11:08:00 +0200
Message-ID: <1369472904-12875-2-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAVP-0006Ka-F4
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab3EYJJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:04 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:58121 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664Ab3EYJIy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:08:54 -0400
X-AuditID: 12074411-b7f286d0000008e8-e1-51a07fa5b392
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.12.02280.5AF70A15; Sat, 25 May 2013 05:08:53 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gub000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:08:51 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqLu0fkGgweND0hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzpi17gd7wR6OijePLjE3MJ5g62Lk5JAQMJFY9WYnE4QtJnHh3nqg
	OBeHkMBlRonNq94wgiSEBC4wSSx9yA1iswnoSizqaQZrEBFwlDjx4DorSAOzQC+jxMNH38ES
	wgI2Ei9v/mfpYuTgYBFQlVgzWx4kzCvgIvFg9TFWiGUKEpdnrWEGKeEUcJV4e4ITYpWLxPNP
	51gnMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqpebWaKXmlK6iRESZII7GGeclDvE
	KMDBqMTDK1A+P1CINbGsuDL3EKMkB5OSKC9/7YJAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
	DClAOd6UxMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBO/eOqBGwaLU9NSK
	tMycEoQ0EwcniOAC2cADtOEsSCFvcUFibnFmOkTRKUZFKXHemyAJAZBERmke3ABYOnjFKA70
	jzDvApAqHmAqget+BTSYCWjwzdz5IINLEhFSUg2MetMvfd2+8yP7NuEXgb8EV7iHta72a3M5
	vPrSqQPfNzMrPZA65STR+uNwo6WSqfQ71/6zjKXPfMKn+Ge1m7mxbrjlLrXM7/sajl3pGYuU
	f/+6evTHv7oVW//MKnTn3XDjgmqB8vy0x6mqV44WT7rv93HLhQaDy8vY37xaqF18 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225518>

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
