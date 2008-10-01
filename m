From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/3] parse-opt: migrate fmt-merge-msg.
Date: Wed,  1 Oct 2008 08:05:04 +0200
Message-ID: <1222841106-26148-1-git-send-email-madcoder@debian.org>
References: <20080930224623.GQ21310@spearce.org>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Pierre Habouzit <madcoder@debian.org>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 08:06:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkur0-0000sL-Bl
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 08:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbYJAGFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 02:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbYJAGFR
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 02:05:17 -0400
Received: from pan.madism.org ([88.191.52.104]:50332 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbYJAGFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 02:05:16 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 335EC3BAD9;
	Wed,  1 Oct 2008 08:05:15 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 78B7894A271; Wed,  1 Oct 2008 08:05:06 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.415.g9800c0.dirty
In-Reply-To: <20080930224623.GQ21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97203>

Also fix an inefficient printf("%s", ...) where we can use write_in_full.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-fmt-merge-msg.c |   52 +++++++++++++++++++++-------------------------
 1 files changed, 24 insertions(+), 28 deletions(-)

   > It may actually be a good idea to rebase this against master.
   >
   > Reading Junio's notes for sg/merge-options (the branch this conflict
   > is coming out of) it sounds like we'd want to revert that anyway.
   > Its been around since April and Junio was talking about it needing
   > to be in a 1.7.0 release.  Its not going to graduate anytime soon.

   Fair enough, here it is.


diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index df02ba7..78c04bf 100644
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
 
 static int merge_summary;
 
@@ -347,38 +349,32 @@ int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
 
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
+	const char *inpath = NULL;
+	struct option options[] = {
+		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
+		OPT_BOOLEAN(0, "summary", &merge_summary, "alias for --log"),
+		OPT_STRING('F', "file",   &inpath, "file", "file to read from"),
+		OPT_END()
+	};
+
 	FILE *in = stdin;
 	struct strbuf input, output;
 	int ret;
 
 	git_config(fmt_merge_msg_config, NULL);
-
-	while (argc > 1) {
-		if (!strcmp(argv[1], "--log") || !strcmp(argv[1], "--summary"))
-			merge_summary = 1;
-		else if (!strcmp(argv[1], "--no-log")
-				|| !strcmp(argv[1], "--no-summary"))
-			merge_summary = 0;
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
@@ -387,6 +383,6 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	ret = fmt_merge_msg(merge_summary, &input, &output);
 	if (ret)
 		return ret;
-	printf("%s", output.buf);
+	write_in_full(STDOUT_FILENO, output.buf, output.len);
 	return 0;
 }
-- 
1.6.0.2.415.g9800c0.dirty
