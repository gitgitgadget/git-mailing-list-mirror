From: Thomas Egerer <thomas.egerer@secunet.com>
Subject: [PATCH] pretty.c: Make user defined format honor color option
Date: Thu, 17 Mar 2011 09:33:05 +0100
Message-ID: <4D81C741.8060108@secunet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010508040705060600050006"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 09:33:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q08dk-0007Nd-Cg
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 09:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab1CQIc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 04:32:58 -0400
Received: from a.mx.secunet.com ([195.81.216.161]:47426 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482Ab1CQIc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 04:32:56 -0400
Received: from localhost (alg1 [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9216E1A0071
	for <git@vger.kernel.org>; Thu, 17 Mar 2011 09:23:53 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mail-srv1.secumail.de (unknown [10.53.40.200])
	by a.mx.secunet.com (Postfix) with ESMTP id 998E91A005D
	for <git@vger.kernel.org>; Thu, 17 Mar 2011 09:23:52 +0100 (CET)
Received: from [10.182.7.178] ([10.182.7.178]) by mail-srv1.secumail.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 17 Mar 2011 09:32:53 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20101227 Icedove/3.0.11
X-Enigmail-Version: 1.0.1
X-OriginalArrivalTime: 17 Mar 2011 08:32:53.0970 (UTC) FILETIME=[E8E72B20:01CBE47D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169225>

This is a multi-part message in MIME format.
--------------010508040705060600050006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch fixes that the pretty-formats tformat and format ignore
git's color option.

Signed-off-by: Thomas Egerer <thomas.egerer@secunet.com>
---
 commit.h   |    1 +
 log-tree.c |    1 +
 pretty.c   |   29 +++++++++++++++++------------
 3 files changed, 19 insertions(+), 12 deletions(-)



--------------010508040705060600050006
Content-Type: text/x-patch;
 name="0001-pretty.c-Make-user-defined-format-honor-color-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-pretty.c-Make-user-defined-format-honor-color-option.pa";
 filename*1="tch"

diff --git a/commit.h b/commit.h
index 659c87c..d23bf99 100644
--- a/commit.h
+++ b/commit.h
@@ -78,6 +78,7 @@ struct pretty_print_context
 	int show_notes;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
+	unsigned colorize:1;
 };
 
 struct userformat_want {
diff --git a/log-tree.c b/log-tree.c
index b46ed3b..63017d2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -505,6 +505,7 @@ void show_log(struct rev_info *opt)
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
 	ctx.reflog_info = opt->reflog_info;
+	ctx.colorize = (DIFF_OPT_TST(&opt->diffopt, COLOR_DIFF) != 0);
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
 
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index 8549934..3c3467f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -743,7 +743,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
 	const char *msg = c->message;
+	char cbuf[COLOR_MAXLEN];
 	struct commit_list *p;
+	size_t consumed = 0;
+	char *color = NULL;
 	int h1, h2;
 
 	/* these are independent of the commit */
@@ -751,29 +754,31 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	case 'C':
 		if (placeholder[1] == '(') {
 			const char *end = strchr(placeholder + 2, ')');
-			char color[COLOR_MAXLEN];
 			if (!end)
 				return 0;
 			color_parse_mem(placeholder + 2,
 					end - (placeholder + 2),
-					"--pretty format", color);
-			strbuf_addstr(sb, color);
-			return end - placeholder + 1;
+					"--pretty format", cbuf);
+			consumed = end - placeholder + 1;
+			color = cbuf;
 		}
 		if (!prefixcmp(placeholder + 1, "red")) {
-			strbuf_addstr(sb, GIT_COLOR_RED);
-			return 4;
+			color = GIT_COLOR_RED;
+			consumed = 4;
 		} else if (!prefixcmp(placeholder + 1, "green")) {
-			strbuf_addstr(sb, GIT_COLOR_GREEN);
-			return 6;
+			color = GIT_COLOR_GREEN;
+			consumed = 6;
 		} else if (!prefixcmp(placeholder + 1, "blue")) {
-			strbuf_addstr(sb, GIT_COLOR_BLUE);
-			return 5;
+			color = GIT_COLOR_BLUE;
+			consumed = 5;
 		} else if (!prefixcmp(placeholder + 1, "reset")) {
-			strbuf_addstr(sb, GIT_COLOR_RESET);
-			return 6;
+			color = GIT_COLOR_RESET;
+			consumed = 6;
 		} else
 			return 0;
+		if (color && (c->pretty_ctx->colorize == 1))
+			strbuf_addstr(sb, color);
+		return consumed;
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;


--------------010508040705060600050006--
