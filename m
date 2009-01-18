From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/3] git-archive: add support for --submodules
Date: Sun, 18 Jan 2009 11:53:19 +0100
Message-ID: <1232275999-14852-4-git-send-email-hjemli@gmail.com>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
 <1232275999-14852-3-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 11:55:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOVJ1-0008GS-OH
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 11:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763807AbZARKxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 05:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763586AbZARKx2
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 05:53:28 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:49589 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762074AbZARKxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 05:53:25 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id n0IArKDd021200;
	Sun, 18 Jan 2009 11:53:21 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
In-Reply-To: <1232275999-14852-3-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106169>

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-archive.txt |    7 +++-
 archive.c                     |    4 ++
 t/t5001-archive-submodules.sh |   78 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)
 create mode 100755 t/t5001-archive-submodules.sh

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 41cbf9c..84e0b43 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git archive' --format=<fmt> [--list] [--prefix=<prefix>/] [<extra>]
-	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
-	      [path...]
+	      [--remote=<repo> [--exec=<git-upload-archive>]] [--submodules]
+	      <tree-ish> [path...]
 
 DESCRIPTION
 -----------
@@ -59,6 +59,9 @@ OPTIONS
 	Used with --remote to specify the path to the
 	'git-upload-archive' on the remote side.
 
+--submodules::
+	Include files from checked out submodules.
+
 <tree-ish>::
 	The tree or commit to produce an archive for.
 
diff --git a/archive.c b/archive.c
index 9ac455d..0c024b8 100644
--- a/archive.c
+++ b/archive.c
@@ -255,6 +255,7 @@ static int parse_archive_args(int argc, const char **argv,
 	const char *exec = NULL;
 	int compression_level = -1;
 	int verbose = 0;
+	int submodules = 0;
 	int i;
 	int list = 0;
 	struct option opts[] = {
@@ -262,6 +263,8 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_STRING(0, "prefix", &base, "prefix",
 			"prepend prefix to each pathname in the archive"),
+		OPT_BOOLEAN(0, "submodules", &submodules,
+			"recurse into submodules"),
 		OPT__VERBOSE(&verbose),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
@@ -320,6 +323,7 @@ static int parse_archive_args(int argc, const char **argv,
 	args->base = base;
 	args->baselen = strlen(base);
 
+	set_traverse_gitlinks(submodules);
 	return argc;
 }
 
diff --git a/t/t5001-archive-submodules.sh b/t/t5001-archive-submodules.sh
new file mode 100755
index 0000000..5a499a4
--- /dev/null
+++ b/t/t5001-archive-submodules.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='git archive can include submodule content'
+
+. ./test-lib.sh
+
+add_file()
+{
+	git add $1 &&
+	git commit -m "added $1"
+}
+
+add_submodule()
+{
+	mkdir $1 && (
+		cd $1 &&
+		git init &&
+		echo "File $2" >$2 &&
+		add_file $2
+	) &&
+	add_file $1
+}
+
+test_expect_success 'setup submodules' '
+	echo "File 1" >1 &&
+	add_file 1 &&
+	add_submodule 2 3 &&
+	add_submodule 4 5 &&
+	(cd 4 && add_submodule 6 7)
+'
+
+test_expect_success 'git archive usually ignores submodules' '
+	cat <<EOF >expected &&
+1
+2/
+4/
+EOF
+	git archive HEAD >normal.tar &&
+	tar -tf normal.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git archive includes submodules when requested' '
+	cat <<EOF >expected &&
+1
+2/
+2/3
+4/
+4/5
+4/6/
+4/6/7
+EOF
+	git archive --submodules HEAD >full.tar &&
+	tar -tf full.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git archive ignores uninteresting submodules' '
+	cat <<EOF >expected &&
+1
+2/
+4/
+4/5
+4/6/
+4/6/7
+EOF
+	rm -rf 2/.git &&
+	git archive --submodules HEAD >partial.tar &&
+	tar -tf partial.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git archive fails on missing object in interesting submodule' '
+	find 4/.git/objects -type f | xargs rm &&
+	test_must_fail git archive --submodules HEAD
+'
+
+test_done
-- 
1.6.1.150.g5e733b
