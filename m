From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2 RFC] verify_filename: ask the caller to chose the kind of diagnosis
Date: Sun, 17 Jun 2012 20:39:01 +0200
Message-ID: <1339958341-22186-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq395tvlc0.fsf@bauges.imag.fr>
 <1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 17 20:39:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgKNo-0005XU-RH
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 20:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758134Ab2FQSjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 14:39:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34525 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758073Ab2FQSjV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 14:39:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5HId6js015395
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 17 Jun 2012 20:39:06 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SgKNa-0000Jt-3U; Sun, 17 Jun 2012 20:39:18 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SgKNa-0005ml-1p; Sun, 17 Jun 2012 20:39:18 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 17 Jun 2012 20:39:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5HId6js015395
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340563146.94577@+Nee2zR/47cxNn2v5xXchg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200126>

verify_filename can be called in two different contexts. Either we just
tried to interpret a string as an object name, and it fails, so we try
looking for a working tree file as a fallback, or we _know_ that we are
looking for a filename, and shouldn't even try interpreting the string as
an object name.

For example, with this change, we get:

  $ git log COPYING HEAD:inexistant
  fatal: HEAD:inexistant: no such path in the working tree.
  $ git log HEAD:inexistant
  fatal: Path 'inexistant' does not exist in 'HEAD'

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

This one is much less straightforward, hence the RFC. I did check all
the call sites of verify_filename, but I may not have fully understood
the logic at each call site.

A mistake in the diagnose_rev argument is not _that_ serious however,
since it does not change the potential failures, but only the error
message.

 builtin/grep.c                 | 7 +++++--
 builtin/reset.c                | 2 +-
 builtin/rev-parse.c            | 4 ++--
 cache.h                        | 9 ++++++++-
 revision.c                     | 5 +++--
 setup.c                        | 8 +++++---
 t/t1506-rev-parse-diagnosis.sh | 2 +-
 7 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index fe1726f..41924dc 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -927,8 +927,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	/* The rest are paths */
 	if (!seen_dashdash) {
 		int j;
-		for (j = i; j < argc; j++)
-			verify_filename(prefix, argv[j]);
+		if (i < argc) {
+			verify_filename(prefix, argv[i], 1);
+			for (j = i + 1; j < argc; j++)
+				verify_filename(prefix, argv[j], 0);
+		}
 	}
 
 	paths = get_pathspec(prefix, argv + i);
diff --git a/builtin/reset.c b/builtin/reset.c
index 8c2c1d5..4cc34c9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -285,7 +285,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			rev = argv[i++];
 		} else {
 			/* Otherwise we treat this as a filename */
-			verify_filename(prefix, argv[i]);
+			verify_filename(prefix, argv[i], 1);
 		}
 	}
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 733f626..13495b8 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -486,7 +486,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 
 		if (as_is) {
 			if (show_file(arg) && as_is < 2)
-				verify_filename(prefix, arg);
+				verify_filename(prefix, arg, 0);
 			continue;
 		}
 		if (!strcmp(arg,"-n")) {
@@ -734,7 +734,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		as_is = 1;
 		if (!show_file(arg))
 			continue;
-		verify_filename(prefix, arg);
+		verify_filename(prefix, arg, 1);
 	}
 	if (verify) {
 		if (revs_count == 1) {
diff --git a/cache.h b/cache.h
index 06413e1..d1a4d9e 100644
--- a/cache.h
+++ b/cache.h
@@ -409,7 +409,14 @@ extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path);
 extern const char *prefix_filename(const char *prefix, int len, const char *path);
 extern int check_filename(const char *prefix, const char *name);
-extern void verify_filename(const char *prefix, const char *name);
+/*
+ * Verify that "name" is a filename.
+ * The "diagnose_rev" is used to provide a user-friendly diagnosis. If
+ * 0, the diagnosis will try to diagnose "name" as an invalid object
+ * name (e.g. HEAD:foo). If non-zero, the diagnosis will only complain
+ * about an inexisting file.
+ */
+extern void verify_filename(const char *prefix, const char *name, int diagnose_rev);
 extern void verify_non_filename(const char *prefix, const char *name);
 
 #define INIT_DB_QUIET 0x0001
diff --git a/revision.c b/revision.c
index 935e7a7..756196a 100644
--- a/revision.c
+++ b/revision.c
@@ -1780,8 +1780,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			 *     as a valid filename.
 			 * but the latter we have checked in the main loop.
 			 */
-			for (j = i; j < argc; j++)
-				verify_filename(revs->prefix, argv[j]);
+			verify_filename(revs->prefix, arg, 1);			
+			for (j = i + 1; j < argc; j++)
+				verify_filename(revs->prefix, argv[j], 0);
 
 			append_prune_data(&prune_data, argv + i);
 			break;
diff --git a/setup.c b/setup.c
index 731851a..ca33092 100644
--- a/setup.c
+++ b/setup.c
@@ -53,11 +53,13 @@ int check_filename(const char *prefix, const char *arg)
 	die_errno("failed to stat '%s'", arg);
 }
 
-static void NORETURN die_verify_filename(const char *prefix, const char *arg)
+static void NORETURN die_verify_filename(const char *prefix, const char *arg, int diagnose_rev)
 {
 	unsigned char sha1[20];
 	unsigned mode;
 
+	if (!diagnose_rev)
+		die("%s: no such path in the working tree.", arg);
 	/*
 	 * Saying "'(icase)foo' does not exist in the index" when the
 	 * user gave us ":(icase)foo" is just stupid.  A magic pathspec
@@ -81,13 +83,13 @@ static void NORETURN die_verify_filename(const char *prefix, const char *arg)
  * it to be preceded by the "--" marker (or we want the user to
  * use a format like "./-filename")
  */
-void verify_filename(const char *prefix, const char *arg)
+void verify_filename(const char *prefix, const char *arg, int diagnose_rev)
 {
 	if (*arg == '-')
 		die("bad flag '%s' used after filename", arg);
 	if (check_filename(prefix, arg))
 		return;
-	die_verify_filename(prefix, arg);
+	die_verify_filename(prefix, arg, diagnose_rev);
 }
 
 /*
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 4a39ac5..a3f11e8 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -174,7 +174,7 @@ test_expect_success 'relative path when startup_info is NULL' '
 test_expect_success '<commit>:file correctly diagnosed after a pathname' '
 	test_must_fail git rev-parse file.txt HEAD:file.txt 1>actual 2>error &&
 	test_i18ngrep ! "exists on disk" error &&
-	test_i18ngrep "unknown revision or path not in the working tree" error &&
+	test_i18ngrep "no such path in the working tree" error &&
 	cat >expect <<EOF &&
 file.txt
 HEAD:file.txt
-- 
1.7.11.rc0.57.g84a04c7
