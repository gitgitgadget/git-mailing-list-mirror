From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] Move code resolving packed refs into its own function.
Date: Sat, 30 Sep 2006 22:01:58 +0200
Message-ID: <20060930220158.d331bb7c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 21:55:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTkw3-00065g-3f
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 21:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbWI3Tzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 15:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWI3Tzk
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 15:55:40 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:41098 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751802AbWI3Tzj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Sep 2006 15:55:39 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 1E45168B57;
	Sat, 30 Sep 2006 21:55:38 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28150>

This patch move Linus' packed refs resolving code from
"resolve_ref" into a new "resolve_packed_ref" extern
function so that it can be reused when needed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h |    2 ++
 refs.c  |   34 ++++++++++++++++++++--------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index 4e01a74..f37bc18 100644
--- a/cache.h
+++ b/cache.h
@@ -296,6 +296,8 @@ extern int get_sha1_hex(const char *hex,
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
+extern const char *resolve_packed_ref(const char *ref, unsigned char *sha1, int, int *);
+
 extern int create_symref(const char *ref, const char *refs_heads_master);
 extern int validate_symref(const char *ref);
 
diff --git a/refs.c b/refs.c
index 3d4cdd1..5e3988b 100644
--- a/refs.c
+++ b/refs.c
@@ -148,6 +148,25 @@ static struct ref_list *get_loose_refs(v
 	return refs;
 }
 
+const char *resolve_packed_ref(const char *ref, unsigned char *sha1,
+			       int reading, int *flag)
+{
+	struct ref_list *list = get_packed_refs();
+	while (list) {
+		if (!strcmp(ref, list->name)) {
+			hashcpy(sha1, list->sha1);
+			if (flag)
+				*flag |= REF_ISPACKED;
+			return ref;
+		}
+		list = list->next;
+	}
+	if (reading || errno != ENOENT)
+		return NULL;
+	hashclr(sha1);
+	return ref;
+}
+
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 
@@ -177,20 +196,7 @@ const char *resolve_ref(const char *ref,
 		 * reading.
 		 */
 		if (lstat(path, &st) < 0) {
-			struct ref_list *list = get_packed_refs();
-			while (list) {
-				if (!strcmp(ref, list->name)) {
-					hashcpy(sha1, list->sha1);
-					if (flag)
-						*flag |= REF_ISPACKED;
-					return ref;
-				}
-				list = list->next;
-			}
-			if (reading || errno != ENOENT)
-				return NULL;
-			hashclr(sha1);
-			return ref;
+			return resolve_packed_ref(ref, sha1, reading, flag);
 		}
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
-- 
1.4.2.1.g7cf04
