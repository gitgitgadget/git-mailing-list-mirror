From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] Detailed diagnosis when parsing an object name fails.
Date: Sun,  6 Dec 2009 19:45:28 +0100
Message-ID: <1260125128-17857-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhbs4dkjr.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 06 19:46:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHM7U-0003z4-9Y
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 19:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933894AbZLFSp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 13:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933833AbZLFSp4
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 13:45:56 -0500
Received: from mx1.imag.fr ([129.88.30.5]:34549 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932935AbZLFSpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 13:45:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nB6IhamE013619
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Dec 2009 19:43:36 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NHM7F-0006mL-9o; Sun, 06 Dec 2009 19:45:53 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NHM7F-00074i-7i; Sun, 06 Dec 2009 19:45:53 +0100
X-Mailer: git-send-email 1.6.6.rc0.355.gcb53a.dirty
In-Reply-To: <vpqhbs4dkjr.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 06 Dec 2009 19:43:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nB6IhamE013619
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1260729818.62529@Q93cYjrw5Gl5e6M+lD5MIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134687>

The previous error message was the same in many situations (unknown
revision or path not in the working tree). We try to help the user as
much as possible to understand the error, especially with the
sha1:filename notation. In this case, we say whether the sha1 or the
filename is problematic, and diagnose the confusion between
relative-to-root and relative-to-$PWD confusion precisely.

The 7 new error messages are tested.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This should address Junio's comments (BTW, I forgot to say "thanks for
the review" :-) ).


 cache.h                        |    6 ++-
 setup.c                        |   15 +++++-
 sha1_name.c                    |  115 ++++++++++++++++++++++++++++++++++++++--
 t/t1506-rev-parse-diagnosis.sh |   69 ++++++++++++++++++++++++
 4 files changed, 198 insertions(+), 7 deletions(-)
 create mode 100755 t/t1506-rev-parse-diagnosis.sh

diff --git a/cache.h b/cache.h
index 0e69384..563862c 100644
--- a/cache.h
+++ b/cache.h
@@ -708,7 +708,11 @@ static inline unsigned int hexval(unsigned char c)
 #define DEFAULT_ABBREV 7
 
 extern int get_sha1(const char *str, unsigned char *sha1);
-extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
+static inline get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
+{
+	return get_sha1_with_mode_1(str, sha1, mode, 1, NULL);
+}
+extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int gently, const char *prefix);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/setup.c b/setup.c
index f67250b..5792eb7 100644
--- a/setup.c
+++ b/setup.c
@@ -74,6 +74,18 @@ int check_filename(const char *prefix, const char *arg)
 	die_errno("failed to stat '%s'", arg);
 }
 
+static void NORETURN die_verify_filename(const char *prefix, const char *arg)
+{
+	unsigned char sha1[20];
+	unsigned mode;
+	/* try a detailed diagnostic ... */
+	get_sha1_with_mode_1(arg, sha1, &mode, 0, prefix);
+	/* ... or fall back the most general message. */
+	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
+	    "Use '--' to separate paths from revisions", arg);
+
+}
+
 /*
  * Verify a filename that we got as an argument for a pathspec
  * entry. Note that a filename that begins with "-" never verifies
@@ -87,8 +99,7 @@ void verify_filename(const char *prefix, const char *arg)
 		die("bad flag '%s' used after filename", arg);
 	if (check_filename(prefix, arg))
 		return;
-	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
-	    "Use '--' to separate paths from revisions", arg);
+	die_verify_filename(prefix, arg);
 }
 
 /*
diff --git a/sha1_name.c b/sha1_name.c
index 44bb62d..1bc09ac 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -804,7 +804,96 @@ int get_sha1(const char *name, unsigned char *sha1)
 	return get_sha1_with_mode(name, sha1, &unused);
 }
 
-int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
+/* Must be called only when object_name:filename doesn't exist. */
+static void diagnose_invalid_sha1_path(const char *prefix,
+				       const char *filename,
+				       const char *tree_sha1,
+				       const char *object_name)
+{
+	struct stat st;
+	unsigned char sha1[20];
+	unsigned mode;
+
+	if (!prefix)
+		prefix = "";
+
+	if (!lstat(filename, &st))
+		die("Path '%s' exists on disk, but not in '%s'.",
+		    filename, object_name);
+	if (errno == ENOENT || errno == ENOTDIR) {
+		char *fullname = xmalloc(strlen(filename)
+					     + strlen(prefix) + 1);
+		strcpy(fullname, prefix);
+		strcat(fullname, filename);
+
+		if (!get_tree_entry(tree_sha1, fullname,
+				    sha1, &mode)) {
+			die("Path '%s' exists, but not '%s'.\n"
+			    "Did you mean '%s:%s'?",
+			    fullname,
+			    filename,
+			    object_name,
+			    fullname);
+		}
+		die("Path '%s' does not exist in '%s'",
+		    filename, object_name);
+	}
+}
+
+/* Must be called only when :stage:filename doesn't exist. */
+static void diagnose_invalid_index_path(int stage,
+					const char *prefix,
+					const char *filename)
+{
+	struct stat st;
+	struct cache_entry *ce;
+	int pos;
+	int namelen = strlen(filename);
+	int fullnamelen;
+	char *fullname;
+
+	if (!prefix)
+		prefix = "";
+
+	/* Wrong stage number? */
+	pos = cache_name_pos(filename, namelen);
+	if (pos < 0)
+		pos = -pos - 1;
+	ce = active_cache[pos];
+	if (ce_namelen(ce) == namelen &&
+	    !memcmp(ce->name, filename, namelen))
+		die("Path '%s' is in the index, but not at stage %d.\n"
+		    "Did you mean ':%d:%s'?",
+		    filename, stage,
+		    ce_stage(ce), filename);
+
+	/* Confusion between relative and absolute filenames? */
+	fullnamelen = namelen + strlen(prefix);
+	fullname = xmalloc(fullnamelen + 1);
+	strcpy(fullname, prefix);
+	strcat(fullname, filename);
+	pos = cache_name_pos(fullname, fullnamelen);
+	if (pos < 0)
+		pos = -pos - 1;
+	ce = active_cache[pos];
+	if (ce_namelen(ce) == fullnamelen &&
+	    !memcmp(ce->name, fullname, fullnamelen))
+		die("Path '%s' is in the index, but not '%s'.\n"
+		    "Did you mean ':%d:%s'?",
+		    fullname, filename,
+		    ce_stage(ce), fullname);
+
+	if (!lstat(filename, &st))
+		die("Path '%s' exists on disk, but not in the index.", filename);
+	if (errno == ENOENT || errno == ENOTDIR)
+		die("Path '%s' does not exist (neither on disk nor in the index).",
+		    filename);
+
+	free(fullname);
+}
+
+
+int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode, int gently, const char *prefix)
 {
 	int ret, bracket_depth;
 	int namelen = strlen(name);
@@ -850,6 +939,8 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 			}
 			pos++;
 		}
+		if (!gently)
+			diagnose_invalid_index_path(stage, prefix, cp);
 		return -1;
 	}
 	for (cp = name, bracket_depth = 0; *cp; cp++) {
@@ -862,9 +953,25 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 	}
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
-		if (!get_sha1_1(name, cp-name, tree_sha1))
-			return get_tree_entry(tree_sha1, cp+1, sha1,
-					      mode);
+		char *object_name;
+		if (!gently) {
+			object_name = xmalloc(cp-name+1);
+			strncpy(object_name, name, cp-name);
+			object_name[cp-name] = '\0';
+		}
+		if (!get_sha1_1(name, cp-name, tree_sha1)) {
+			const char *filename = cp+1;
+			ret = get_tree_entry(tree_sha1, filename, sha1, mode);
+			if (!gently) {
+				diagnose_invalid_sha1_path(prefix, filename,
+							   tree_sha1, object_name);
+				free(object_name);
+			}
+			return ret;
+		} else {
+			if (!gently)
+				die("Invalid object name '%s'.", object_name);
+		}
 	}
 	return ret;
 }
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
new file mode 100755
index 0000000..af721f9
--- /dev/null
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='test git rev-parse diagnosis for invalid argument'
+
+exec </dev/null
+
+. ./test-lib.sh
+
+HASH_file=
+
+test_expect_success 'set up basic repo' '
+	echo one > file.txt &&
+	mkdir subdir &&
+	echo two > subdir/file.txt &&
+	echo three > subdir/file2.txt &&
+	git add . &&
+	git commit -m init &&
+	echo four > index-only.txt &&
+	git add index-only.txt &&
+	echo five > disk-only.txt
+'
+
+test_expect_success 'correct file objects' '
+	HASH_file=$(git rev-parse HEAD:file.txt) &&
+	git rev-parse HEAD:subdir/file.txt &&
+	git rev-parse :index-only.txt &&
+	(cd subdir &&
+	 git rev-parse HEAD:subdir/file2.txt &&
+	 test $HASH_file = $(git rev-parse HEAD:file.txt) &&
+	 test $HASH_file = $(git rev-parse :file.txt) &&
+	 test $HASH_file = $(git rev-parse :0:file.txt) )
+'
+
+test_expect_success 'incorrect revision id' '
+	test_must_fail git rev-parse foobar:file.txt 2>error &&
+	grep "Invalid object name '"'"'foobar'"'"'." error &&
+	test_must_fail git rev-parse foobar 2> error &&
+	grep "unknown revision or path not in the working tree." error
+'
+
+test_expect_success 'incorrect file in sha1:path' '
+	test_must_fail git rev-parse HEAD:nothing.txt 2> error &&
+	grep "fatal: Path '"'"'nothing.txt'"'"' does not exist in '"'"'HEAD'"'"'" error &&
+	test_must_fail git rev-parse HEAD:index-only.txt 2> error &&
+	grep "fatal: Path '"'"'index-only.txt'"'"' exists on disk, but not in '"'"'HEAD'"'"'." error &&
+	(cd subdir &&
+	 test_must_fail git rev-parse HEAD:file2.txt 2> error &&
+	 grep "Did you mean '"'"'HEAD:subdir/file2.txt'"'"'?" error )
+'
+
+test_expect_success 'incorrect file in :path and :N:path' '
+	test_must_fail git rev-parse :nothing.txt 2> error &&
+	grep "fatal: Path '"'"'nothing.txt'"'"' does not exist (neither on disk nor in the index)." error &&
+	test_must_fail git rev-parse :1:nothing.txt 2> error &&
+	grep "Path '"'"'nothing.txt'"'"' does not exist (neither on disk nor in the index)." error &&
+	test_must_fail git rev-parse :1:file.txt 2> error &&
+	grep "Did you mean '"'"':0:file.txt'"'"'?" error &&
+	(cd subdir &&
+	 test_must_fail git rev-parse :1:file.txt 2> error &&
+	 grep "Did you mean '"'"':0:file.txt'"'"'?" error &&
+	 test_must_fail git rev-parse :file2.txt 2> error &&
+	 grep "Did you mean '"'"':0:subdir/file2.txt'"'"'?" error &&
+	 test_must_fail git rev-parse :2:file2.txt 2> error &&
+	 grep "Did you mean '"'"':0:subdir/file2.txt'"'"'?" error) &&
+	test_must_fail git rev-parse :disk-only.txt 2> error &&
+	grep "fatal: Path '"'"'disk-only.txt'"'"' exists on disk, but not in the index." error
+'
+
+test_done
-- 
1.6.6.rc0.355.gcb53a.dirty
