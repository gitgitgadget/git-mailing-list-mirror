From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-opt: migrate fmt-merge-msg.
Date: Sun, 28 Sep 2008 11:45:37 +0200
Message-ID: <1222595139-32087-2-git-send-email-madcoder@debian.org>
References: <1222595139-32087-1-git-send-email-madcoder@debian.org>
Cc: spearce@spearce.org, gitster@pobox.com,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 11:58:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjt3F-0005X7-Fj
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 11:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbYI1J5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 05:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYI1J5f
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 05:57:35 -0400
Received: from pan.madism.org ([88.191.52.104]:49826 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbYI1J5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 05:57:30 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E59D23A66F;
	Sun, 28 Sep 2008 11:45:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 28B067ADE21; Sun, 28 Sep 2008 11:45:39 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.516.g12936
In-Reply-To: <1222595139-32087-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96952>

Also fix an inefficient printf("%s", ...) where we can use write_in_full.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-fmt-merge-msg.c |   50 +++++++++++++++++++++-------------------------
 1 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index a1879f1..654d996 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -5,8 +5,10 @@
 #include "revision.h"
 #include "tag.h"
 
-static const char *fmt_merge_msg_usage =
-	"git fmt-merge-msg [--log] [--no-log] [--file <file>]";
+static const char * const fmt_merge_msg_usage[] = {
+	"git fmt-merge-msg [--log|--no-log] [--file <file>]",
+	NULL
+};
 
 static int merge_log;
 
@@ -342,37 +344,31 @@ int fmt_merge_msg(int merge_log, struct strbuf *in, struct strbuf *out) {
 
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
+	const char *inpath = NULL;
+	struct option options[] = {
+		OPT_BOOLEAN(0, "log", &merge_log, "populate log with the shortlog"),
+		OPT_STRING('F', "file", &inpath, "file", "file to read from"),
+		OPT_END()
+	};
+
 	FILE *in = stdin;
 	struct strbuf input, output;
 	int ret;
 
 	git_config(fmt_merge_msg_config, NULL);
-
-	while (argc > 1) {
-		if (!strcmp(argv[1], "--log"))
-			merge_log = 1;
-		else if (!strcmp(argv[1], "--no-log"))
-			merge_log = 0;
-		else if (!strcmp(argv[1], "-F") || !strcmp(argv[1], "--file")) {
-			if (argc < 3)
-				die ("Which file?");
-			if (!strcmp(argv[2], "-"))
-				in = stdin;
-			else {
-				fclose(in);
-				in = fopen(argv[2], "r");
-				if (!in)
-					die("cannot open %s", argv[2]);
-			}
-			argc--; argv++;
-		} else
-			break;
-		argc--; argv++;
+	argc = parse_options(argc, argv, options, fmt_merge_msg_usage, 0);
+	if (argc > 0)
+		usage_with_options(fmt_merge_msg_usage, options);
+
+	if (!inpath || strcmp(inpath, "-"))
+		in = stdin;
+	else {
+		fclose(in);
+		in = fopen(argv[2], "r");
+		if (!in)
+			die("cannot open %s", argv[2]);
 	}
 
-	if (argc > 1)
-		usage(fmt_merge_msg_usage);
-
 	strbuf_init(&input, 0);
 	if (strbuf_read(&input, fileno(in), 0) < 0)
 		die("could not read input file %s", strerror(errno));
@@ -381,6 +377,6 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	ret = fmt_merge_msg(merge_log, &input, &output);
 	if (ret)
 		return ret;
-	printf("%s", output.buf);
+	write_in_full(STDOUT_FILENO, output.buf, output.len);
 	return 0;
 }
-- 
1.6.0.2.516.g12936
