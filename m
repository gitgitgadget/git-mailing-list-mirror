Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783642018B
	for <e@80x24.org>; Wed, 22 Jun 2016 15:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbcFVPDF (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:03:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:60271 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbcFVPCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:02:07 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MfVzj-1b08qZ1lJD-00P8Wo; Wed, 22 Jun 2016 17:01:36
 +0200
Date:	Wed, 22 Jun 2016 17:01:32 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 02/10] log-tree: respect diffopt's configured output file
 stream
In-Reply-To: <cover.1466607667.git.johannes.schindelin@gmx.de>
Message-ID: <4fa4ffb8c749509f91b646eb909fd45b899c011e.1466607667.git.johannes.schindelin@gmx.de>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:igC19J3P2eRPFBIIW7fHzJlF0gEG/H4FJqDdPmespw0zCKlOOJ9
 vOQLRmY8lHc+zfj489XgXZtcqe5MPdTS2UmRxdBFMeAQgplax1tBiLPWqCA18flgUirf2Ib
 ranajdiHi+6ZMytPNOpZJZr47YoaQyyTVphmdmlCd6o4tGiUs4E9nHedYm6X5gNowWF3k1w
 CzwX/0UC1szrRgYG+Sq3Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:AkZn5XuQhQk=:EoPndgy1Yw5MsqUTiKVb2k
 0aHk0pTsLRtnC1DxoS44+PhHBVNYiOBoXWh3mwmNSWoEu58dpmHCTfKpBH+wPqpVpJuDwyvmp
 SIBibV6oKP2f2Q+rasaijMsu+iwLyfLpwwVZyrUcC10IFSslyo0nlR0LoYtEUuXnmtaH3pxCc
 u1UcwJ9ki9iYOpfR0uNjqa+RsMSJRuUlLsAN6KE4G8VF6Etwm8YhhfKUywv/pQHCua+/6DKvI
 QULxpncV+lLlhxwGPErka0yTn6z629AQRPFGD1+v1jszwD+OZ7PKgVe3cHNsp5vVwoONGqqn8
 NQCOvAiByqQP/IuWOH1NtPfiwRe4/1aDtc4+yi9nGoZsGUJbRUDYh8/DGktm0d6VQ5s8SwO0U
 yYLytTOSLvND5H4z8jogwwSMWFLcoKQDaFQmx8tv00DkR8q1/7fySVgLJyhc3/WLXCsAfXYiC
 xiq1W2Eh4mJD0F5zugM9Trm7xOHux3LeoZi9Y+ofM/4GW2r3R5wXLkp2gWVkzssXrSfzC6I+w
 rIBhVIuNs9KMyUyR2MVn5re7RcmQ4/4MBoEoJmLfGJ1/HqL/4okujClJSmGmK4Wkcvwfl3q/9
 ekchPyY6+cWONuZFa5fgs1shUmy8oKA/8plweSa5x7+F/FJuL/e60VcAXZ3boFCzdbrd1gKCv
 XZhE9WmklhAJU83dw8+W2uRhBRJ4tRj2x8vGXKDSEQ1z2/bx9059RTeOB5OU7RL4zMXISXOIg
 0VyiUCnWKnXtW9jZh2pUdjyZjzYpWyxQnpWC5v+l8fJICOnNtQbSWx7HlfASwro2X9xfkySG8
 feiB+Kz
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The diff options already know how to print the output anywhere else
than stdout. The same is needed for log output in general, e.g.
when writing patches to files in `git format-patch`. Let's allow
users to use log_tree_commit() *without* changing global state via
freopen().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 log-tree.c | 64 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 456d7e3..cf24027 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -159,12 +159,12 @@ void load_ref_decorations(int flags)
 	}
 }
 
-static void show_parents(struct commit *commit, int abbrev)
+static void show_parents(struct commit *commit, int abbrev, FILE *file)
 {
 	struct commit_list *p;
 	for (p = commit->parents; p ; p = p->next) {
 		struct commit *parent = p->item;
-		printf(" %s", find_unique_abbrev(parent->object.oid.hash, abbrev));
+		fprintf(file, " %s", find_unique_abbrev(parent->object.oid.hash, abbrev));
 	}
 }
 
@@ -172,7 +172,7 @@ static void show_children(struct rev_info *opt, struct commit *commit, int abbre
 {
 	struct commit_list *p = lookup_decoration(&opt->children, &commit->object);
 	for ( ; p; p = p->next) {
-		printf(" %s", find_unique_abbrev(p->item->object.oid.hash, abbrev));
+		fprintf(opt->diffopt.file, " %s", find_unique_abbrev(p->item->object.oid.hash, abbrev));
 	}
 }
 
@@ -286,11 +286,11 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (opt->show_source && commit->util)
-		printf("\t%s", (char *) commit->util);
+		fprintf(opt->diffopt.file, "\t%s", (char *) commit->util);
 	if (!opt->show_decorations)
 		return;
 	format_decorations(&sb, commit, opt->diffopt.use_color);
-	fputs(sb.buf, stdout);
+	fputs(sb.buf, opt->diffopt.file);
 	strbuf_release(&sb);
 }
 
@@ -364,18 +364,18 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		subject = "Subject: ";
 	}
 
-	printf("From %s Mon Sep 17 00:00:00 2001\n", name);
+	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
 	graph_show_oneline(opt->graph);
 	if (opt->message_id) {
-		printf("Message-Id: <%s>\n", opt->message_id);
+		fprintf(opt->diffopt.file, "Message-Id: <%s>\n", opt->message_id);
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->ref_message_ids && opt->ref_message_ids->nr > 0) {
 		int i, n;
 		n = opt->ref_message_ids->nr;
-		printf("In-Reply-To: <%s>\n", opt->ref_message_ids->items[n-1].string);
+		fprintf(opt->diffopt.file, "In-Reply-To: <%s>\n", opt->ref_message_ids->items[n-1].string);
 		for (i = 0; i < n; i++)
-			printf("%s<%s>\n", (i > 0 ? "\t" : "References: "),
+			fprintf(opt->diffopt.file, "%s<%s>\n", (i > 0 ? "\t" : "References: "),
 			       opt->ref_message_ids->items[i].string);
 		graph_show_oneline(opt->graph);
 	}
@@ -432,7 +432,7 @@ static void show_sig_lines(struct rev_info *opt, int status, const char *bol)
 	reset = diff_get_color_opt(&opt->diffopt, DIFF_RESET);
 	while (*bol) {
 		eol = strchrnul(bol, '\n');
-		printf("%s%.*s%s%s", color, (int)(eol - bol), bol, reset,
+		fprintf(opt->diffopt.file, "%s%.*s%s%s", color, (int)(eol - bol), bol, reset,
 		       *eol ? "\n" : "");
 		graph_show_oneline(opt->graph);
 		bol = (*eol) ? (eol + 1) : eol;
@@ -553,17 +553,17 @@ void show_log(struct rev_info *opt)
 
 		if (!opt->graph)
 			put_revision_mark(opt, commit);
-		fputs(find_unique_abbrev(commit->object.oid.hash, abbrev_commit), stdout);
+		fputs(find_unique_abbrev(commit->object.oid.hash, abbrev_commit), opt->diffopt.file);
 		if (opt->print_parents)
-			show_parents(commit, abbrev_commit);
+			show_parents(commit, abbrev_commit, opt->diffopt.file);
 		if (opt->children.name)
 			show_children(opt, commit, abbrev_commit);
 		show_decorations(opt, commit);
 		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
-			putchar('\n');
+			putc('\n', opt->diffopt.file);
 			graph_show_remainder(opt->graph);
 		}
-		putchar(opt->diffopt.line_termination);
+		putc(opt->diffopt.line_termination, opt->diffopt.file);
 		return;
 	}
 
@@ -589,7 +589,7 @@ void show_log(struct rev_info *opt)
 		if (opt->diffopt.line_termination == '\n' &&
 		    !opt->missing_newline)
 			graph_show_padding(opt->graph);
-		putchar(opt->diffopt.line_termination);
+		putc(opt->diffopt.line_termination, opt->diffopt.file);
 	}
 	opt->shown_one = 1;
 
@@ -607,28 +607,28 @@ void show_log(struct rev_info *opt)
 		log_write_email_headers(opt, commit, &ctx.subject, &extra_headers,
 					&ctx.need_8bit_cte);
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
-		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), stdout);
+		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), opt->diffopt.file);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
-			fputs("commit ", stdout);
+			fputs("commit ", opt->diffopt.file);
 
 		if (!opt->graph)
 			put_revision_mark(opt, commit);
 		fputs(find_unique_abbrev(commit->object.oid.hash, abbrev_commit),
-		      stdout);
+		      opt->diffopt.file);
 		if (opt->print_parents)
-			show_parents(commit, abbrev_commit);
+			show_parents(commit, abbrev_commit, opt->diffopt.file);
 		if (opt->children.name)
 			show_children(opt, commit, abbrev_commit);
 		if (parent)
-			printf(" (from %s)",
+			fprintf(opt->diffopt.file, " (from %s)",
 			       find_unique_abbrev(parent->object.oid.hash,
 						  abbrev_commit));
-		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), stdout);
+		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), opt->diffopt.file);
 		show_decorations(opt, commit);
 		if (opt->commit_format == CMIT_FMT_ONELINE) {
-			putchar(' ');
+			putc(' ', opt->diffopt.file);
 		} else {
-			putchar('\n');
+			putc('\n', opt->diffopt.file);
 			graph_show_oneline(opt->graph);
 		}
 		if (opt->reflog_info) {
@@ -702,7 +702,7 @@ void show_log(struct rev_info *opt)
 	}
 
 	if (opt->show_log_size) {
-		printf("log size %i\n", (int)msgbuf.len);
+		fprintf(opt->diffopt.file, "log size %i\n", (int)msgbuf.len);
 		graph_show_oneline(opt->graph);
 	}
 
@@ -718,11 +718,11 @@ void show_log(struct rev_info *opt)
 	if (opt->graph)
 		graph_show_commit_msg(opt->graph, &msgbuf);
 	else
-		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, opt->diffopt.file);
 	if (opt->use_terminator && !commit_format_is_empty(opt->commit_format)) {
 		if (!opt->missing_newline)
 			graph_show_padding(opt->graph);
-		putchar(opt->diffopt.line_termination);
+		putc(opt->diffopt.line_termination, opt->diffopt.file);
 	}
 
 	strbuf_release(&msgbuf);
@@ -759,7 +759,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 				struct strbuf *msg = NULL;
 				msg = opt->diffopt.output_prefix(&opt->diffopt,
 					opt->diffopt.output_prefix_data);
-				fwrite(msg->buf, msg->len, 1, stdout);
+				fwrite(msg->buf, msg->len, 1, opt->diffopt.file);
 			}
 
 			/*
@@ -774,8 +774,8 @@ int log_tree_diff_flush(struct rev_info *opt)
 			 */
 			if (!opt->shown_dashes &&
 			    (pch & opt->diffopt.output_format) == pch)
-				printf("---");
-			putchar('\n');
+				fprintf(opt->diffopt.file, "---");
+			putc('\n', opt->diffopt.file);
 		}
 	}
 	diff_flush(&opt->diffopt);
@@ -873,7 +873,7 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		return line_log_print(opt, commit);
 
 	if (opt->track_linear && !opt->linear && !opt->reverse_output_stage)
-		printf("\n%s\n", opt->break_bar);
+		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	shown = log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent = NULL;
@@ -881,9 +881,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		shown = 1;
 	}
 	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
-		printf("\n%s\n", opt->break_bar);
+		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	opt->loginfo = NULL;
-	maybe_flush_or_die(stdout, "stdout");
+	maybe_flush_or_die(opt->diffopt.file, "stdout");
 	if (close_file)
 		fclose(opt->diffopt.file);
 	return shown;
-- 
2.9.0.118.g0e1a633


