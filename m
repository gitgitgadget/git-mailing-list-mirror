From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v4 5/6] rev-parse: add --prefix option
Date: Sun, 16 Jun 2013 15:18:17 +0100
Message-ID: <ce84ea4a18d862363772edc57286572ee272ab43.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 16:19:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoDnw-0001yI-1M
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 16:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab3FPOTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 10:19:36 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:38109 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3FPOTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 10:19:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 2CDE26064E7;
	Sun, 16 Jun 2013 15:19:35 +0100 (BST)
X-Quarantine-ID: <9ywLF4l1FabS>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ywLF4l1FabS; Sun, 16 Jun 2013 15:19:34 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 6C1896064D5;
	Sun, 16 Jun 2013 15:19:34 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 6187B161E03F;
	Sun, 16 Jun 2013 15:19:34 +0100 (BST)
X-Quarantine-ID: <brhfbt1x57gv>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id brhfbt1x57gv; Sun, 16 Jun 2013 15:19:33 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 345E7161E2DC;
	Sun, 16 Jun 2013 15:19:22 +0100 (BST)
X-Mailer: git-send-email 1.8.3.779.g691e267
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228013>

This makes 'git rev-parse' behave as if it were invoked from the
specified subdirectory of a repository, with the difference that any
file paths which it prints are prefixed with the full path from the top
of the working tree.

This is useful for shell scripts where we may want to cd to the top of
the working tree but need to handle relative paths given by the user on
the command line.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-rev-parse.txt | 16 +++++++
 builtin/rev-parse.c             | 24 ++++++++---
 t/t1513-rev-parse-prefix.sh     | 96 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 5 deletions(-)
 create mode 100755 t/t1513-rev-parse-prefix.sh

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 947d62f..993903c 100644
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
1.8.3.779.g691e267
