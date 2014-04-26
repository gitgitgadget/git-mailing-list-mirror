From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 3/4] replace: factor object resolution out of replace_object
Date: Sat, 26 Apr 2014 22:00:56 +0200
Message-ID: <20140426200058.21546.63153.chriscool@tuxfamily.org>
References: <20140426194404.21546.82305.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 26 22:02:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We8o9-0008Th-OH
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 22:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbaDZUCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 16:02:11 -0400
Received: from [194.158.98.15] ([194.158.98.15]:40330 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751322AbaDZUB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 16:01:58 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 8DDD949;
	Sat, 26 Apr 2014 22:01:35 +0200 (CEST)
X-git-sha1: 640877182e02623d127a1ec3596ef6f052b62663 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140426194404.21546.82305.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247181>

From: Jeff King <peff@peff.net>

As we add new options that operate on objects before
replacing them, we'll want to be able to feed raw sha1s
straight into replace_object. Split replace_object into the
object-resolution part and the actual replacement.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 29cf699..af40129 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -123,19 +123,17 @@ static int delete_replace_ref(const char *name, const char *ref,
 	return 0;
 }
 
-static int replace_object(const char *object_ref, const char *replace_ref,
-			  int force)
+static int replace_object_sha1(const char *object_ref,
+			       unsigned char object[20],
+			       const char *replace_ref,
+			       unsigned char repl[20],
+			       int force)
 {
-	unsigned char object[20], prev[20], repl[20];
+	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
 	struct ref_lock *lock;
 
-	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
-	if (get_sha1(replace_ref, repl))
-		die("Failed to resolve '%s' as a valid ref.", replace_ref);
-
 	if (snprintf(ref, sizeof(ref),
 		     "refs/replace/%s",
 		     sha1_to_hex(object)) > sizeof(ref) - 1)
@@ -166,6 +164,18 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	return 0;
 }
 
+static int replace_object(const char *object_ref, const char *replace_ref, int force)
+{
+	unsigned char object[20], repl[20];
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+	if (get_sha1(replace_ref, repl))
+		die("Failed to resolve '%s' as a valid ref.", replace_ref);
+
+	return replace_object_sha1(object_ref, object, replace_ref, repl, force);
+}
+
 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int force = 0;
-- 
1.9.1.636.g20d5f34
