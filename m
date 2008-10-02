From: Pierre Habouzit <madcoder@debian.org>
Subject: [RESEND PATCH] parse-opt: migrate builtin-merge-file.
Date: Thu,  2 Oct 2008 14:59:20 +0200
Message-ID: <1222952360-9262-3-git-send-email-madcoder@debian.org>
References: <20080930224623.GQ21310@spearce.org>
 <1222952360-9262-1-git-send-email-madcoder@debian.org>
 <1222952360-9262-2-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Pierre Habouzit <madcoder@debian.org>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Oct 02 15:00:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlNnK-0002AS-LM
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 15:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbYJBM70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 08:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753496AbYJBM7Z
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 08:59:25 -0400
Received: from pan.madism.org ([88.191.52.104]:35581 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbYJBM7X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 08:59:23 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 48BFF3BFD8;
	Thu,  2 Oct 2008 14:59:22 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B6BE494CA15; Thu,  2 Oct 2008 14:59:20 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.431.gb53ee
In-Reply-To: <1222952360-9262-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97322>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-merge-file.c |   68 +++++++++++++++++++++++++++----------------------
 1 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 45c9853..9d4e874 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -2,21 +2,44 @@
 #include "cache.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
+#include "parse-options.h"
 
-static const char merge_file_usage[] =
-"git merge-file [-p | --stdout] [--diff3] [-q | --quiet] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
+static const char *const merge_file_usage[] = {
+	"git merge-file [options] [-L name1 [-L orig [-L name2]]] file1 orig_file file2",
+	NULL
+};
+
+static int label_cb(const struct option *opt, const char *arg, int unset)
+{
+	static int label_count = 0;
+	const char **names = (const char **)opt->value;
+
+	if (label_count >= 3)
+		return error("too many labels on the command line");
+	names[label_count++] = arg;
+	return 0;
+}
 
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
-	const char *names[3];
+	const char *names[3] = { NULL, NULL, NULL };
 	mmfile_t mmfs[3];
 	mmbuffer_t result = {NULL, 0};
 	xpparam_t xpp = {XDF_NEED_MINIMAL};
 	int ret = 0, i = 0, to_stdout = 0;
 	int merge_level = XDL_MERGE_ZEALOUS_ALNUM;
-	int merge_style = 0;
+	int merge_style = 0, quiet = 0;
 	int nongit;
 
+	struct option options[] = {
+		OPT_BOOLEAN('p', "stdout", &to_stdout, "send results to standard output"),
+		OPT_SET_INT(0, "diff3", &merge_style, "use a diff3 based merge", XDL_MERGE_DIFF3),
+		OPT__QUIET(&quiet),
+		OPT_CALLBACK('L', NULL, names, "name",
+			     "set labels for file1/orig_file/file2", &label_cb),
+		OPT_END(),
+	};
+
 	prefix = setup_git_directory_gently(&nongit);
 	if (!nongit) {
 		/* Read the configuration file */
@@ -25,37 +48,20 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			merge_style = git_xmerge_style;
 	}
 
-	while (argc > 4) {
-		if (!strcmp(argv[1], "-L") && i < 3) {
-			names[i++] = argv[2];
-			argc--;
-			argv++;
-		} else if (!strcmp(argv[1], "-p") ||
-				!strcmp(argv[1], "--stdout"))
-			to_stdout = 1;
-		else if (!strcmp(argv[1], "-q") ||
-				!strcmp(argv[1], "--quiet"))
-			freopen("/dev/null", "w", stderr);
-		else if (!strcmp(argv[1], "--diff3"))
-			merge_style = XDL_MERGE_DIFF3;
-		else
-			usage(merge_file_usage);
-		argc--;
-		argv++;
-	}
-
-	if (argc != 4)
-		usage(merge_file_usage);
-
-	for (; i < 3; i++)
-		names[i] = argv[i + 1];
+	argc = parse_options(argc, argv, options, merge_file_usage, 0);
+	if (argc != 3)
+		usage_with_options(merge_file_usage, options);
+	if (quiet)
+		freopen("/dev/null", "w", stderr);
 
 	for (i = 0; i < 3; i++) {
-		if (read_mmfile(mmfs + i, argv[i + 1]))
+		if (!names[i])
+			names[i] = argv[i];
+		if (read_mmfile(mmfs + i, argv[i]))
 			return -1;
 		if (buffer_is_binary(mmfs[i].ptr, mmfs[i].size))
 			return error("Cannot merge binary files: %s\n",
-					argv[i + 1]);
+					argv[i]);
 	}
 
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
@@ -65,7 +71,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		free(mmfs[i].ptr);
 
 	if (ret >= 0) {
-		const char *filename = argv[1];
+		const char *filename = argv[0];
 		FILE *f = to_stdout ? stdout : fopen(filename, "wb");
 
 		if (!f)
-- 
1.6.0.2.431.gb53ee
