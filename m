Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5784820179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbcFTK7B (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:59:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:55366 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932365AbcFTK67 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:58:59 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LpcBS-1bqm691lvK-00fTKB; Mon, 20 Jun 2016 12:58:35
 +0200
Date:	Mon, 20 Jun 2016 12:55:13 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/7] log-tree: respect diffopt's configured output file
 stream
In-Reply-To: <cover.1466420060.git.johannes.schindelin@gmx.de>
Message-ID: <babf95df5f610feb6c2ae7f2ed3cff98bab47fe2.1466420060.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MJOKsTO5fLlYzn3tG64ZkenshpP+ifEBt5yve9nt8CH5gPrzCw5
 TV25PkcxhdoqYzJIvAJMh6Pck8xMiQPvGwHqP3LpKNpZBhqhfmVbzia2BmF4fCt/TkdPJiT
 4KE1pWhq0lFmIHJG+nAdZtMjrCibe3hp5l35R3Pa5FS0fwRbUgTKESiyHFvONd8W4AREKbC
 ufHTLs1a61UJSTAaLojvw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:cLa5L9P4sRM=:dW042XKEjh2YmOaHUpsCvS
 7mN3MccPmOaUHp+b972FwJIZEm9FoSdfYU6MT+/664HRkFGVQ6rTJ0rawdYzCdYVATZjjhGpQ
 5i6FGdej1LcFYoWsr4MuwS9U5gNG60QAtBaXJQKOQkbXtT8Siin/p+moiZwHVAtZuqLo6ZT6h
 HNwXnXI5hGbiwNiVKkJBh5SwhG6yMFX5u3iRcp4uNi4Z6XY5xc5cpelStl2pAirwsflgwiJ/x
 aZkM21LJ5iKqd0Zu5hf/33jgLgrKd+LEz8Ox4Ix2UsgIcYBGYKbHTYh6US/twkvaw1QX67qRH
 Sxv/eYe5ta5ZbCahEr/cjL7pHoj2JgS8cEUSyDTaAwopZDI7JtRfGYk0T8/LsD2LNnvAGENP3
 ytxQimGVQ164E+khvGJ75YYLHkxKh75PTYA8hhlPAWlBtdmyJ/zo6rSzJcRkotaeeDsW+6Hl3
 91BPfxXQPd5CbWUlJyExZA2Owzw4DBB6nZFpGj+NgyolBQ1KeS9/M4cXCti9YAa5UXH0p6bz/
 3TY9Ij2uXzsAwzAWSy7yls585Mi6ECutbK2C8Lj5le2jQeHOGw9nuXMwS993gJyCdEpyFksq7
 XbLpJGcNurpbvk3jmNjWKaH7rwa+TLo8vMGIjhZqmvNBvJvRdSvOsHAfVvE/xuE0806BnK+xX
 S/cKUDAi+vQfMCCMdnQFwU0pUteWKpWHWT4YVlgVOK5mvY08mYTgqWcEMJQEZOxj+qzb1bA0E
 XOfOO6dt6xQ+lVn5ICZE727H/1nyuO1alvLjlpjR/qsahqFztyIqvkNb8pIAAwpZunwsLxlcq
 80mL4iT
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
 log-tree.c | 65 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 78a5381..968428a 100644
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
+			fputc('\n', opt->diffopt.file);
 			graph_show_remainder(opt->graph);
 		}
-		putchar(opt->diffopt.line_termination);
+		fputc(opt->diffopt.line_termination, opt->diffopt.file);
 		return;
 	}
 
@@ -589,7 +589,7 @@ void show_log(struct rev_info *opt)
 		if (opt->diffopt.line_termination == '\n' &&
 		    !opt->missing_newline)
 			graph_show_padding(opt->graph);
-		putchar(opt->diffopt.line_termination);
+		fputc(opt->diffopt.line_termination, opt->diffopt.file);
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
+			fputc(' ', opt->diffopt.file);
 		} else {
-			putchar('\n');
+			fputc('\n', opt->diffopt.file);
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
+		fputc(opt->diffopt.line_termination, opt->diffopt.file);
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
+			fputc('\n', opt->diffopt.file);
 		}
 	}
 	diff_flush(&opt->diffopt);
@@ -872,7 +872,7 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		return line_log_print(opt, commit);
 
 	if (opt->track_linear && !opt->linear && !opt->reverse_output_stage)
-		printf("\n%s\n", opt->break_bar);
+		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	shown = log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent = NULL;
@@ -880,8 +880,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		shown = 1;
 	}
 	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
-		printf("\n%s\n", opt->break_bar);
+		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	opt->loginfo = NULL;
-	maybe_flush_or_die(stdout, "stdout");
+	if (opt->diffopt.file == stdout)
+		maybe_flush_or_die(stdout, "stdout");
 	return shown;
 }
-- 
2.9.0.119.g370c5a9


