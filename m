From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Introduce git-supported-features for porcelain use
Date: Wed, 30 May 2007 00:31:13 -0400
Message-ID: <20070530043113.GA12300@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 06:31:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtFqO-0003f9-KZ
	for gcvg-git@gmane.org; Wed, 30 May 2007 06:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbXE3EbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 00:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbXE3EbU
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 00:31:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44062 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbXE3EbT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 00:31:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtFq8-0000md-00; Wed, 30 May 2007 00:31:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 24D3B20FBAE; Wed, 30 May 2007 00:31:14 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48735>

As a porcelain author I'm finding it difficult to keep track of
what features I can use in git-gui.  Newer versions of Git have
newer capabilities but they don't always immediately get newer
version numbers that I can easily test for.

This is a simple plumbing command that lets a porcelain ask the
plumbing for its capabilities, at which point the porcelain can
work around anything missing, or recommend to the user that they
upgrade their plumbing layer.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitignore                               |    1 +
 Documentation/git-supported-features.txt |   37 +++++++++++++++++
 Makefile                                 |    1 +
 builtin-supported-features.c             |   66 ++++++++++++++++++++++++++++++
 builtin.h                                |    1 +
 git.c                                    |    1 +
 t/t0000-basic.sh                         |   10 +++++
 7 files changed, 117 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-supported-features.txt
 create mode 100644 builtin-supported-features.c

diff --git a/.gitignore b/.gitignore
index 4dc0c39..6ff18d4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -126,6 +126,7 @@ git-ssh-push
 git-ssh-upload
 git-status
 git-stripspace
+git-supported-features
 git-svn
 git-svnimport
 git-symbolic-ref
diff --git a/Documentation/git-supported-features.txt b/Documentation/git-supported-features.txt
new file mode 100644
index 0000000..28e2c21
--- /dev/null
+++ b/Documentation/git-supported-features.txt
@@ -0,0 +1,37 @@
+git-supported-features(1)
+===================
+
+NAME
+----
+git-supported-features - Report capabilities of the plumbing
+
+SYNOPSIS
+--------
+'git-supported-features' [<name>]
+
+DESCRIPTION
+-----------
+Given no arguments this plumbing utility displays a list of feature
+strings, one per line, that this particular version of the Git
+plumbing supports.  These strings can be matched by higher level
+porcelain to determine what capabilities are available to its use.
+
+Given one argument (the name of the feature to test) the program
+exits with 0 if the feature is supported, and 1 if it is not.
+Other exit codes are undefined at this time.
+
+NOTES
+-----
+The exact list of feature strings is undefined by this manual page.
+
+Feature strings use a restricted character set, relying only on
+`a`-`z` (lowercase), `0`-`9` and `-` (hypen).  This restriction is
+intentional, as it makes parsing output in shell quite simple.
+
+Author
+------
+Written by Shawn O. Pearce <spearce@spearce.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 7527734..03ab471 100644
--- a/Makefile
+++ b/Makefile
@@ -372,6 +372,7 @@ BUILTIN_OBJS = \
 	builtin-shortlog.o \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
+	builtin-supported-features.o \
 	builtin-symbolic-ref.o \
 	builtin-tar-tree.o \
 	builtin-unpack-objects.o \
diff --git a/builtin-supported-features.c b/builtin-supported-features.c
new file mode 100644
index 0000000..79007f4
--- /dev/null
+++ b/builtin-supported-features.c
@@ -0,0 +1,66 @@
+#include "builtin.h"
+
+static const char *features[] = {
+	"git-k",
+	"redirect-stderr",
+	"supported-features",
+};
+
+static int is_sane(const char *a)
+{
+	if (!*a || *a == '-')
+		return 0;
+	for (; *a; a++) {
+		if (! ((*a >= 'a' && *a <= 'z')
+		    || (*a >= '0' && *a <= '9')
+		    || *a == '-'))
+			return 0;
+	}
+	return 1;
+}
+
+static int sort_feature(const void *a_, const void *b_)
+{
+	const char *a = *((const char **)a_);
+	const char *b = *((const char **)b_);
+	return strcmp(a, b);
+}
+
+static void list_features()
+{
+	unsigned cnt = ARRAY_SIZE(features);
+	unsigned i;
+
+	qsort(features, cnt, sizeof(features[0]), sort_feature);
+	for (i = 0; i < cnt; i++) {
+		if (!is_sane(features[i]))
+			die("feature name \"%s\" is bogus", features[i]);
+		printf("%s\n", features[i]);
+	}
+}
+
+static int test_feature(const char *the_feature)
+{
+	unsigned cnt = ARRAY_SIZE(features);
+	unsigned i;
+
+	for (i = 0; i < cnt; i++) {
+		if (!strcmp(features[i], the_feature))
+			return 0;
+	}
+	return 1;
+}
+
+static const char supported_features_usage[] =
+"git-supported-features [<feature>]";
+
+int cmd_supported_features(int argc, const char **argv, const char *prefix)
+{
+	if (argc == 1)
+		list_features();
+	else if (argc == 2)
+		return test_feature(argv[1]);
+	else
+		usage(supported_features_usage);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 39290d1..f33432c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -71,6 +71,7 @@ extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
+extern int cmd_supported_features(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 29b55a1..377fae9 100644
--- a/git.c
+++ b/git.c
@@ -284,6 +284,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
+		{ "supported-features", cmd_supported_features },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 186de70..7d0d9c9 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -31,6 +31,16 @@ fi
 . ./test-lib.sh
 
 ################################################################
+# git-supported-features should always work.
+
+test_expect_success \
+	'supported-features is functional' \
+	'git-supported-features'
+test_expect_success \
+	'supported-features recognizes itself' \
+	'git-supported-features supported-features'
+
+################################################################
 # git-init has been done in an empty repository.
 # make sure it is empty.
 
-- 
1.5.2.869.g6b3ba
