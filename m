From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Introduce git version --list-features for porcelain use
Date: Thu, 21 Jun 2007 00:59:03 -0400
Message-ID: <20070621045903.GA14047@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 06:59:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1ElE-0003ef-NC
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 06:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbXFUE7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 00:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbXFUE7J
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 00:59:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37495 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbXFUE7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 00:59:08 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1El7-00027l-GY; Thu, 21 Jun 2007 00:59:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 04D9B20FBAE; Thu, 21 Jun 2007 00:59:03 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50593>

As a porcelain author I'm finding it difficult to keep track of
what features I can use in git-gui.  Newer versions of Git have
newer capabilities but they don't always immediately get newer
version numbers that I can easily test for.

This is a simple plumbing option that lets a porcelain ask the
plumbing for its capabilities, at which point the porcelain can
work around anything missing, or recommend to the user that they
upgrade their plumbing layer.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Because 'maint' does not support `git-blame -w` I can't apply your
 recent (and insanely good idea) 'git-gui: use "blame -w -C -C" for
 "where did it come from, originally?"' without something like the
 following, so I know that `git blame -w -C -C` will be accepted
 by the underlying plumbing.  ;-)

 help.c           |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t0000-basic.sh |   16 +++++++++++
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 1cd33ec..9f24a0f 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,11 @@
 #include "common-cmds.h"
 #include <sys/ioctl.h>
 
+static const char *supported_features[] = {
+	"blame-ignore-whitespace",
+	"list-features",
+};
+
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
@@ -190,10 +195,78 @@ void help_unknown_cmd(const char *cmd)
 	exit(1);
 }
 
+static int is_feature_name_sane(const char *a)
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
+static int cmp_feature(const void *a_, const void *b_)
+{
+	const char *a = *((const char **)a_);
+	const char *b = *((const char **)b_);
+	return strcmp(a, b);
+}
+
+static void list_features()
+{
+	unsigned cnt = ARRAY_SIZE(supported_features);
+	unsigned i;
+
+	qsort(supported_features, cnt,
+		sizeof(supported_features[0]), cmp_feature);
+	for (i = 0; i < cnt; i++) {
+		const char *f = supported_features[i];
+		if (!is_feature_name_sane(f))
+			die("feature name \"%s\" is bogus", f);
+		printf("%s\n", f);
+	}
+}
+
+static int supports_feature(const char *the_feature)
+{
+	unsigned cnt = ARRAY_SIZE(supported_features);
+	unsigned i;
+
+	for (i = 0; i < cnt; i++) {
+		if (!strcmp(supported_features[i], the_feature))
+			return 0;
+	}
+	return 1;
+}
+
+static const char version_usage[] =
+"git-version [(--list-features | --supports-feature=<name>*)]";
+
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
-	printf("git version %s\n", git_version_string);
-	return 0;
+	int i, ret = 0, list = 0, test = 0;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--list-features"))
+			list = 1;
+		else if (!prefixcmp(arg, "--supports-feature=")) {
+			test = 1;
+			ret |= supports_feature(arg + 19);
+		} else
+			usage(version_usage);
+	}
+
+	if (list && test)
+		die("cannot use both --list-features and --supports-feature");
+	if (list)
+		list_features();
+	if (!list && !test)
+		printf("git version %s\n", git_version_string);
+	return ret;
 }
 
 int cmd_help(int argc, const char **argv, const char *prefix)
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 8bfe832..9fc5824 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -31,6 +31,22 @@ fi
 . ./test-lib.sh
 
 ################################################################
+# git version
+
+test_expect_success \
+	'git version is functional' \
+	'git version'
+test_expect_success \
+	'git version --list-features' \
+	'git version --list-features'
+test_expect_success \
+	'feature "list-features" is supported' \
+	'git version --supports-feature=list-features'
+test_expect_failure \
+	'feature "THISNEVERWILLBEAGITFEATURE" is not supported' \
+	'git version --supports-feature=THISNEVERWILLBEAGITFEATURE'
+
+################################################################
 # git-init has been done in an empty repository.
 # make sure it is empty.
 
-- 
1.5.2.2.1050.g51a8b
