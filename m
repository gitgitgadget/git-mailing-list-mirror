From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] mv: let 'git mv file no-such-dir/' error out
Date: Tue,  3 Dec 2013 09:32:04 +0100
Message-ID: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Duy Nguyen <pclouds@gmail.com>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 03 09:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnlPF-0003F5-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 09:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab3LCIc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 03:32:29 -0500
Received: from mx1.imag.fr ([129.88.30.5]:59586 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab3LCIc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 03:32:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rB38WG2e015599
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Dec 2013 09:32:16 +0100
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VnlOz-0003Tp-53; Tue, 03 Dec 2013 09:32:17 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VnlOy-0003ll-Qp; Tue, 03 Dec 2013 09:32:16 +0100
X-Mailer: git-send-email 1.8.5.rc3.4.g8bd3721
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 03 Dec 2013 09:32:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rB38WG2e015599
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1386664339.75339@onUV1IAbde3+q1DJh3I6uA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238675>

Git used to trim the trailing slash, and make the command equivalent to
'git mv file no-such-dir', which created the file no-such-dir (while the
trailing slash explicitly stated that it could only be a directory).

This patch skips the trailing slash removal for the destination path. The
path with its trailing slash is passed to rename(2), which errors out
with the appropriate message:

  $ git mv file no-such-dir/
  fatal: renaming 'file' failed: Not a directory

Original-patch-by: Duy Nguyen <pclouds@gmail.com>
Tests, tweaks and commit message by: Matthieu Moy <Matthieu.Moy@imag.fr>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/mv.c  | 23 ++++++++++++++++-------
 t/t7001-mv.sh | 10 ++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2e0e61b..08fbc03 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -16,9 +16,12 @@ static const char * const builtin_mv_usage[] = {
 	NULL
 };
 
+#define DUP_BASENAME 1
+#define KEEP_TRAILING_SLASH 2
+
 static const char **internal_copy_pathspec(const char *prefix,
 					   const char **pathspec,
-					   int count, int base_name)
+					   int count, unsigned flags)
 {
 	int i;
 	const char **result = xmalloc((count + 1) * sizeof(const char *));
@@ -27,11 +30,12 @@ static const char **internal_copy_pathspec(const char *prefix,
 	for (i = 0; i < count; i++) {
 		int length = strlen(result[i]);
 		int to_copy = length;
-		while (to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
+		while (!(flags & KEEP_TRAILING_SLASH) &&
+		       to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
 			to_copy--;
-		if (to_copy != length || base_name) {
+		if (to_copy != length || flags & DUP_BASENAME) {
 			char *it = xmemdupz(result[i], to_copy);
-			if (base_name) {
+			if (flags & DUP_BASENAME) {
 				result[i] = xstrdup(basename(it));
 				free(it);
 			} else
@@ -87,16 +91,21 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 	source = internal_copy_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
-	dest_path = internal_copy_pathspec(prefix, argv + argc, 1, 0);
+	/*
+	 * Keep trailing slash, needed to let
+	 * "git mv file no-such-dir/" error out.
+	 */
+	dest_path = internal_copy_pathspec(prefix, argv + argc, 1,
+					   KEEP_TRAILING_SLASH);
 	submodule_gitfile = xcalloc(argc, sizeof(char *));
 
 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
-		destination = internal_copy_pathspec(dest_path[0], argv, argc, 1);
+		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
 		dest_path[0] = add_slash(dest_path[0]);
-		destination = internal_copy_pathspec(dest_path[0], argv, argc, 1);
+		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	} else {
 		if (argc != 1)
 			die("destination '%s' is not a directory", dest_path[0]);
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index b90e985..e5c8084 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -72,6 +72,16 @@ rm -f idontexist untracked1 untracked2 \
      .git/index.lock
 
 test_expect_success \
+    'moving to target with trailing slash' \
+    'test_must_fail git mv path0/COPYING no-such-dir/ &&
+     test_must_fail git mv path0/COPYING no-such-dir// &&
+     git mv path0/ no-such-dir/'
+
+test_expect_success \
+    'clean up' \
+    'git reset --hard'
+
+test_expect_success \
     'adding another file' \
     'cp "$TEST_DIRECTORY"/../README path0/README &&
      git add path0/README &&
-- 
1.8.5.rc3.4.g8bd3721
