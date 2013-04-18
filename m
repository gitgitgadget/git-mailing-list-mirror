From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 1/2] rev-parse: add --prefix option
Date: Thu, 18 Apr 2013 20:50:41 +0100
Message-ID: <82316c445320b3cec3a35cbc87ad94a04ed26d1e.1366314439.git.john@keeping.me.uk>
References: <cover.1365539059.git.john@keeping.me.uk>
 <cover.1366314439.git.john@keeping.me.uk>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 21:51:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USurZ-0006zc-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 21:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936557Ab3DRTvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 15:51:17 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:35248 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936535Ab3DRTvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 15:51:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 270B0CDA617;
	Thu, 18 Apr 2013 20:51:15 +0100 (BST)
X-Quarantine-ID: <Fk2zuJ-kkKli>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fk2zuJ-kkKli; Thu, 18 Apr 2013 20:51:14 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 0941ECDA5BE;
	Thu, 18 Apr 2013 20:51:01 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.424.g1899e5e.dirty
In-Reply-To: <cover.1366314439.git.john@keeping.me.uk>
In-Reply-To: <cover.1366314439.git.john@keeping.me.uk>
References: <cover.1366314439.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221687>

This makes 'git rev-parse' behave as if it were invoked from the
specified subdirectory of a repository, with the difference that any
file paths which it prints are prefixed with the full path from the top
of the working tree.

This is useful for shell scripts where we may want to cd to the top of
the working tree but need to handle relative paths given by the user on
the command line.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
Changes since v2:
    - Rewrite commit message
    - Add a new test for 'prefix ignored with HEAD:top'
    - Use '<<-\EOF' where appropriate in t1513

 Documentation/git-rev-parse.txt | 16 +++++++
 builtin/rev-parse.c             | 24 ++++++++---
 t/t1513-rev-parse-prefix.sh     | 96 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 5 deletions(-)
 create mode 100755 t/t1513-rev-parse-prefix.sh

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 1f9ed6c..0ab2b77 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -59,6 +59,22 @@ OPTIONS
 	If there is no parameter given by the user, use `<arg>`
 	instead.
 
+--prefix <arg>::
+	Behave as if 'git rev-parse' was invoked from the `<arg>`
+	subdirectory of the working tree.  Any relative filenames are
+	resolved as if they are prefixed by `<arg>` and will be printed
+	in that form.
++
+This can be used to convert arguments to a command run in a subdirectory
+so that they can still be used after moving to the top-level of the
+repository.  For example:
++
+----
+prefix=$(git rev-parse --show-prefix)
+cd "$(git rev-parse --show-toplevel)"
+eval "set -- $(git rev-parse --sq --prefix "$prefix" "$@")"
+----
+
 --verify::
 	Verify that exactly one parameter is provided, and that it
 	can be turned into a raw 20-byte SHA-1 that can be used to
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index f267a1d..de894c7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -212,11 +212,17 @@ static void show_datestring(const char *flag, const char *datestr)
 	show(buffer);
 }
 
-static int show_file(const char *arg)
+static int show_file(const char *arg, int output_prefix)
 {
 	show_default();
 	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV)) {
-		show(arg);
+		if (output_prefix) {
+			const char *prefix = startup_info->prefix;
+			show(prefix_filename(prefix,
+					     prefix ? strlen(prefix) : 0,
+					     arg));
+		} else
+			show(arg);
 		return 1;
 	}
 	return 0;
@@ -470,6 +476,7 @@ N_("git rev-parse --parseopt [options] -- [<args>...]\n"
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
+	int output_prefix = 0;
 	unsigned char sha1[20];
 	const char *name = NULL;
 
@@ -503,7 +510,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 
 		if (as_is) {
-			if (show_file(arg) && as_is < 2)
+			if (show_file(arg, output_prefix) && as_is < 2)
 				verify_filename(prefix, arg, 0);
 			continue;
 		}
@@ -527,7 +534,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				as_is = 2;
 				/* Pass on the "--" if we show anything but files.. */
 				if (filter & (DO_FLAGS | DO_REVS))
-					show_file(arg);
+					show_file(arg, 0);
 				continue;
 			}
 			if (!strcmp(arg, "--default")) {
@@ -535,6 +542,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				i++;
 				continue;
 			}
+			if (!strcmp(arg, "--prefix")) {
+				prefix = argv[i+1];
+				startup_info->prefix = prefix;
+				output_prefix = 1;
+				i++;
+				continue;
+			}
 			if (!strcmp(arg, "--revs-only")) {
 				filter &= ~DO_NOREV;
 				continue;
@@ -754,7 +768,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		if (verify)
 			die_no_single_rev(quiet);
 		as_is = 1;
-		if (!show_file(arg))
+		if (!show_file(arg, output_prefix))
 			continue;
 		verify_filename(prefix, arg, 1);
 	}
diff --git a/t/t1513-rev-parse-prefix.sh b/t/t1513-rev-parse-prefix.sh
new file mode 100755
index 0000000..87ec3ae
--- /dev/null
+++ b/t/t1513-rev-parse-prefix.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='Tests for rev-parse --prefix'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p sub1/sub2 &&
+	echo top >top &&
+	echo file1 >sub1/file1 &&
+	echo file2 >sub1/sub2/file2 &&
+	git add top sub1/file1 sub1/sub2/file2 &&
+	git commit -m commit
+'
+
+test_expect_success 'empty prefix -- file' '
+	git rev-parse --prefix "" -- top sub1/file1 >actual &&
+	cat <<-\EOF >expected &&
+	--
+	top
+	sub1/file1
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'valid prefix -- file' '
+	git rev-parse --prefix sub1/ -- file1 sub2/file2 >actual &&
+	cat <<-\EOF >expected &&
+	--
+	sub1/file1
+	sub1/sub2/file2
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'valid prefix -- ../file' '
+	git rev-parse --prefix sub1/ -- ../top sub2/file2 >actual &&
+	cat <<-\EOF >expected &&
+	--
+	sub1/../top
+	sub1/sub2/file2
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'empty prefix HEAD:./path' '
+	git rev-parse --prefix "" HEAD:./top >actual &&
+	git rev-parse HEAD:top >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'valid prefix HEAD:./path' '
+	git rev-parse --prefix sub1/ HEAD:./file1 >actual &&
+	git rev-parse HEAD:sub1/file1 >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'valid prefix HEAD:../path' '
+	git rev-parse --prefix sub1/ HEAD:../top >actual &&
+	git rev-parse HEAD:top >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'prefix ignored with HEAD:top' '
+	git rev-parse --prefix sub1/ HEAD:top >actual &&
+	git rev-parse HEAD:top >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'disambiguate path with valid prefix' '
+	git rev-parse --prefix sub1/ file1 >actual &&
+	cat <<-\EOF >expected &&
+	sub1/file1
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'file and refs with prefix' '
+	git rev-parse --prefix sub1/ master file1 >actual &&
+	cat <<-EOF >expected &&
+	$(git rev-parse master)
+	sub1/file1
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'two-levels deep' '
+	git rev-parse --prefix sub1/sub2/ -- file2 >actual &&
+	cat <<-\EOF >expected &&
+	--
+	sub1/sub2/file2
+	EOF
+	test_cmp expected actual
+'
+
+test_done
-- 
1.8.2.1.424.g1899e5e.dirty
