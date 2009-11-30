From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Detailed diagnostic when parsing an object name fails.
Date: Mon, 30 Nov 2009 21:57:18 +0100
Message-ID: <vpqiqcrd93l.fsf@bauges.imag.fr>
References: <1259603421-10055-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtywbkc05.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 22:01:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFDMk-0004cj-83
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 22:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbZK3VAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 16:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbZK3VAf
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 16:00:35 -0500
Received: from imag.imag.fr ([129.88.30.1]:57185 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbZK3VAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 16:00:30 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAUKvJZI006385
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Nov 2009 21:57:20 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NFDJ8-00038I-Tp; Mon, 30 Nov 2009 21:57:18 +0100
In-Reply-To: <7vtywbkc05.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 30 Nov 2009 12\:12\:42 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 30 Nov 2009 21:57:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134140>

Junio C Hamano <gitster@pobox.com> writes:

>> $ ../git show HEAD:test-lib.sh 
>> fatal: Path 't/test-lib.sh' exists, but not 'test-lib.sh'.
>> Did you mean 'HEAD:t/test-lib.sh'?
>
> The first thought that comes to mind is that if it makes more sense to
> just fall back to the interpretation of the input when the tool has
> already figured out to second guess the intention of the user like the
> above message does.
>
> That would obviously break scripts that try to make sure the _absense_ of
> a path in a tree-ish (or in the index if you lack "HEAD" in your example),
> expecting:
>
>    git rev-parse HEAD:test-lib.sh ||
>    echo "test-lib.sh shouldn't be at the top level"

There's another (more important IMO) problem: if HEAD contains both
file.txt and subdir/file.txt, then what should

cd subdir
git show HEAD:file.txt

do? Allowing HEAD:file-in-a-subdirectory.txt would indirectly mean
teaching users to use in, and they'd be bitten by an ambiguous
behavior one day or another ...

> Perhaps the second step would be to teach the machinery to understand a
> syntax like "<tree-ish>:./<path>" and have it prefix the path to the
> current subdirectory from the root of the work tree, and with such an
> enhancement, the suggestion given by this patch would probably change to
> "Did you mean 'HEAD:./test-lib.sh'?", but that would be a separate
> topic.

Exactly. I think this HEAD:./relative-path syntax has been discussed
here already, but I don't remember the outcome of the discussion. If
it's ever implemented, my patch, modified as you suggest will help
users to discover the feature ;-).

BTW, I finally had time to write a test. Current version below FYI
(fixed a segfault discovered by testing too), but I'll resend properly
when I get enough feedback.


>From 1bc1c8d114b538f57a5ba4a501436229d644d587 Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Mon, 30 Nov 2009 17:32:39 +0100
Subject: [PATCH] Detailed diagnosis when parsing an object name fails.

The previous error message was the same in many situations (unknown
revision or path not in the working tree). We try to help the user as
much as possible to understand the error, especially with the
sha1:filename notation. In this case, we say whether the sha1 or the
filename is problematic, and diagnose the confusion between
relative-to-root and relative-to-$PWD confusion precisely.

The 6 new error messages are tested.
---
 cache.h                        |    6 ++-
 setup.c                        |   15 +++++-
 sha1_name.c                    |   95 ++++++++++++++++++++++++++++++++++++++--
 t/t1506-rev-parse-diagnosis.sh |   67 ++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+), 7 deletions(-)
 create mode 100755 t/t1506-rev-parse-diagnosis.sh

diff --git a/cache.h b/cache.h
index 0e69384..5c8cb5f 100644
--- a/cache.h
+++ b/cache.h
@@ -708,7 +708,11 @@ static inline unsigned int hexval(unsigned char c)
 #define DEFAULT_ABBREV 7
 
 extern int get_sha1(const char *str, unsigned char *sha1);
-extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
+static inline get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
+{
+	return get_sha1_with_mode_1(str, sha1, mode, 0, NULL);
+}
+extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int fatal, const char *prefix);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/setup.c b/setup.c
index f67250b..3094e8b 100644
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
+	get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
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
index 44bb62d..030e2ac 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -804,7 +804,77 @@ int get_sha1(const char *name, unsigned char *sha1)
 	return get_sha1_with_mode(name, sha1, &unused);
 }
 
-int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
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
+		char *fullname = malloc(strlen(filename)
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
+static void diagnose_invalid_index_path(int stage,
+					const char *prefix,
+					const char *filename)
+{
+	struct stat st;
+
+	if (!prefix)
+		prefix = "";
+
+	if (!lstat(filename, &st))
+		die("Path '%s' exists on disk, but not in the index.", filename);
+	if (errno == ENOENT || errno == ENOTDIR) {
+		struct cache_entry *ce;
+		int pos;
+		int namelen = strlen(filename) + strlen(prefix);
+		char *fullname = malloc(namelen + 1);
+		strcpy(fullname, prefix);
+		strcat(fullname, filename);
+		pos = cache_name_pos(fullname, namelen);
+		if (pos < 0)
+			pos = -pos - 1;
+		ce = active_cache[pos];
+		if (ce_namelen(ce) == namelen &&
+		    !memcmp(ce->name, fullname, namelen))
+			die("Path '%s' is in the index, but not '%s'.\n"
+			    "Did you mean ':%d:%s'?",
+			    fullname, filename,
+			    stage, fullname);
+
+		die("Path '%s' does not exist (neither on disk nor in the index).",
+		    filename);
+	}
+}
+
+
+int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode, int fatal, const char *prefix)
 {
 	int ret, bracket_depth;
 	int namelen = strlen(name);
@@ -850,6 +920,8 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 			}
 			pos++;
 		}
+		if (fatal)
+			diagnose_invalid_index_path(stage, prefix, cp);
 		return -1;
 	}
 	for (cp = name, bracket_depth = 0; *cp; cp++) {
@@ -862,9 +934,24 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 	}
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
-		if (!get_sha1_1(name, cp-name, tree_sha1))
-			return get_tree_entry(tree_sha1, cp+1, sha1,
-					      mode);
+		char *object_name;
+		if (fatal) {
+			object_name = malloc(cp-name+1);
+			strncpy(object_name, name, cp-name);
+			object_name[cp-name] = '\0';
+		}
+		if (!get_sha1_1(name, cp-name, tree_sha1)) {
+			const char *filename = cp+1;
+			ret = get_tree_entry(tree_sha1, filename, sha1, mode);
+			if (fatal)
+				diagnose_invalid_sha1_path(prefix, filename,
+							   tree_sha1, object_name);
+
+			return ret;
+		} else {
+			if (fatal)
+				die("Invalid object name '%s'.", object_name);
+		}
 	}
 	return ret;
 }
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
new file mode 100755
index 0000000..8112d56
--- /dev/null
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -0,0 +1,67 @@
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
+	cd subdir &&
+	git rev-parse HEAD:file.txt &&
+	git rev-parse HEAD:subdir/file2.txt &&
+	test $HASH_file = $(git rev-parse HEAD:file.txt) &&
+	test $HASH_file = $(git rev-parse :file.txt) &&
+	test $HASH_file = $(git rev-parse :0:file.txt) &&
+	cd ..
+'
+
+test_expect_success 'incorrect revision id' '
+	test_must_fail git rev-parse foobar:file.txt 2>&1 |
+		grep "Invalid object name '"'"'foobar'"'"'." &&
+	test_must_fail git rev-parse foobar 2>&1 |
+		grep "unknown revision or path not in the working tree."
+'
+
+test_expect_success 'incorrect file in sha1:path' '
+	test_must_fail git rev-parse HEAD:nothing.txt 2>&1 |
+		grep "fatal: Path '"'"'nothing.txt'"'"' does not exist in '"'"'HEAD'"'"'" &&
+	test_must_fail git rev-parse HEAD:index-only.txt 2>&1 |
+		grep "fatal: Path '"'"'index-only.txt'"'"' exists on disk, but not in '"'"'HEAD'"'"'." &&
+	cd subdir &&
+	test_must_fail git rev-parse HEAD:file2.txt 2>&1 |
+		grep "Did you mean '"'"'HEAD:subdir/file2.txt'"'"'?" &&
+	cd ..
+'
+
+test_expect_success 'incorrect file in :path and :0:path' '
+	test_must_fail git rev-parse :nothing.txt 2>&1 |
+		grep "fatal: Path '"'"'nothing.txt'"'"' does not exist (neither on disk nor in the index)." &&
+	test_must_fail git rev-parse :1:nothing.txt 2>&1 |
+		grep "Path '"'"'nothing.txt'"'"' does not exist (neither on disk nor in the index)." &&
+	cd subdir &&
+	test_must_fail git rev-parse :file2.txt 2>&1 |
+		grep "Did you mean '"'"':0:subdir/file2.txt'"'"'?" &&
+	cd .. &&
+	test_must_fail git rev-parse :disk-only.txt 2>&1 |
+		grep "fatal: Path '"'"'disk-only.txt'"'"' exists on disk, but not in the index."
+'
+
+test_done
-- 
1.6.6.rc0.256.g6060


--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
