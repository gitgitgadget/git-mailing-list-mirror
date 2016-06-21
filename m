Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0AE1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 10:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbcFUKjb (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:39:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:59629 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbcFUKgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 06:36:04 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LjuR3-1bm9w349dJ-00bpPr; Tue, 21 Jun 2016 12:35:23
 +0200
Date:	Tue, 21 Jun 2016 12:35:20 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 8/9] format-patch: avoid freopen()
In-Reply-To: <cover.1466505222.git.johannes.schindelin@gmx.de>
Message-ID: <b923b096901728b2f82313a083285ed31df52942.1466505223.git.johannes.schindelin@gmx.de>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9Yrxr24ZfEJnFqkpajiZ/Enw+wNFLhWvKQItxtl/vYHsQ7zy59g
 Rt4PiKcK7gZwWkrVUym+bGXSZYWxLywREvUWbEvvtjHXC492g6bXHy0/neQGQ1Y1veYRMQi
 EkcL4XuFfRPeqGsKrL1vmrW8OAvjtu/1CLMk8FwDnKAbgiKzMeY8OP/S4TeAEzDA7hR7xuC
 NB2QBQWIjNLylKY63f1Zw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:b11qqgVWET0=:qrvhyY44S0fYRssfWE0DiC
 sPqiQnJVKjju4UoFaUjsYdPv7MFIqzww72uh7ERjclyk2uvxyM4Zq3tGxmQXIAT5L+B6C+E91
 8bVFrSaq4BE/W25HWp+eytFg/yglugOrNySppl2RwnUxVJocYZjp/QfGJOYMAgfHC2RgUsBeF
 Q81jR/udrKWfte9+gCsPFav2M4IjyHysEis6BDvZmAcCNGXJDxgaRmeA0ltiGD/e0fjyniFQ9
 UspzQ4sNb9QJPIxlTbblCb1OIyeEZjzL0XBfDj6GZgr545YNh9nnzgIf4cFa6X1idI2P1+O1x
 okgqpILwhJMIU2FdJwJyUEbPn7+JRjTM04KrVr53bi/jiNGqWFH9tBzISfHqJ0MkLausFNxo9
 fIIIfBr7r560KkgxVLYpRigz4MbU4/QVtFgao3pDjFnQkrMV7zgevIdJGuRaPr5NfKQogEiDx
 xoYLl+d7uo1LwuwLg+vQw/z/vA7pQqqxrIBI9iqegDf5kh1jQjKyv+KQjAFIPRpw1UPSkgSUY
 Rg1ayUltQfN1kO7oBcgpQZJKL9k5mvUPAps2/ZEYRpV2QcHzYoCUssny6SCGFdudVm3iHpf0Y
 g9zgt6WROU2NQbMjru/4ulGk7nDyEewqN1MA7WrGv0JME52PML6suzSdwD/TOlOPGV5BANI6u
 Eev0+EVPYFuzT6kebD3eQ5DCy8l1S8UpSOmNnr/9EvcW4iWzvj4rJwYwUE9lvKXJ1TO1rhqxH
 Z1SaOWa2IC69u/YfFPaZm1VRoVBJSlJoL4I+bsUQwnmMdlaoLH9Dr1E6L+frah5/WPwknH7hJ
 m1GMFMU
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We just taught the relevant functions to respect the diffopt.file field,
to allow writing somewhere else than stdout. Let's make use of it.

Technically, we do not need to avoid that call in a builtin: we assume
that builtins (as opposed to library functions) are stand-alone programs
that may do with their (global) state. Yet, we want to be able to reuse
that code in properly lib-ified code, e.g. when converting scripts into
builtins.

Further, while we did not *have* to touch the cmd_show() and cmd_cherry()
code paths (because they do not want to write anywhere but stdout as of
yet), it just makes sense to be consistent, making it easier and safer to
move the code later.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/log.c | 64 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index abd889b..8dcf205 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -236,7 +236,7 @@ static void show_early_header(struct rev_info *rev, const char *stage, int nr)
 		if (rev->commit_format != CMIT_FMT_ONELINE)
 			putchar(rev->diffopt.line_termination);
 	}
-	printf(_("Final output: %d %s\n"), nr, stage);
+	fprintf(rev->diffopt.file, _("Final output: %d %s\n"), nr, stage);
 }
 
 static struct itimerval early_output_timer;
@@ -445,7 +445,7 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
 	pp.fmt = rev->commit_format;
 	pp.date_mode = rev->date_mode;
 	pp_user_info(&pp, "Tagger", &out, buf, get_log_output_encoding());
-	printf("%s", out.buf);
+	fprintf(rev->diffopt.file, "%s", out.buf);
 	strbuf_release(&out);
 }
 
@@ -456,7 +456,7 @@ static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, con
 	char *buf;
 	unsigned long size;
 
-	fflush(stdout);
+	fflush(rev->diffopt.file);
 	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
 	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
 		return stream_blob_to_fd(1, sha1, NULL, 0);
@@ -496,7 +496,7 @@ static int show_tag_object(const unsigned char *sha1, struct rev_info *rev)
 	}
 
 	if (offset < size)
-		fwrite(buf + offset, size - offset, 1, stdout);
+		fwrite(buf + offset, size - offset, 1, rev->diffopt.file);
 	free(buf);
 	return 0;
 }
@@ -505,7 +505,8 @@ static int show_tree_object(const unsigned char *sha1,
 		struct strbuf *base,
 		const char *pathname, unsigned mode, int stage, void *context)
 {
-	printf("%s%s\n", pathname, S_ISDIR(mode) ? "/" : "");
+	FILE *file = context;
+	fprintf(file, "%s%s\n", pathname, S_ISDIR(mode) ? "/" : "");
 	return 0;
 }
 
@@ -565,7 +566,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 
 			if (rev.shown_one)
 				putchar('\n');
-			printf("%stag %s%s\n",
+			fprintf(rev.diffopt.file, "%stag %s%s\n",
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					t->tag,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
@@ -584,12 +585,12 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		case OBJ_TREE:
 			if (rev.shown_one)
 				putchar('\n');
-			printf("%stree %s%s\n\n",
+			fprintf(rev.diffopt.file, "%stree %s%s\n\n",
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
 			read_tree_recursive((struct tree *)o, "", 0, 0, &match_all,
-					show_tree_object, NULL);
+					show_tree_object, rev.diffopt.file);
 			rev.shown_one = 1;
 			break;
 		case OBJ_COMMIT:
@@ -799,7 +800,7 @@ static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;
 
-static int reopen_stdout(struct commit *commit, const char *subject,
+static int open_next_file(struct commit *commit, const char *subject,
 			 struct rev_info *rev, int quiet)
 {
 	struct strbuf filename = STRBUF_INIT;
@@ -823,7 +824,7 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 	if (!quiet)
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
 
-	if (freopen(filename.buf, "w", stdout) == NULL)
+	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL)
 		return error(_("Cannot open patch file %s"), filename.buf);
 
 	strbuf_release(&filename);
@@ -882,15 +883,15 @@ static void gen_message_id(struct rev_info *info, char *base)
 	info->message_id = strbuf_detach(&buf, NULL);
 }
 
-static void print_signature(void)
+static void print_signature(FILE *file)
 {
 	if (!signature || !*signature)
 		return;
 
-	printf("-- \n%s", signature);
+	fprintf(file, "-- \n%s", signature);
 	if (signature[strlen(signature)-1] != '\n')
-		putchar('\n');
-	putchar('\n');
+		putc('\n', file);
+	putc('\n', file);
 }
 
 static void add_branch_description(struct strbuf *buf, const char *branch_name)
@@ -959,7 +960,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	committer = git_committer_info(0);
 
 	if (!use_stdout &&
-	    reopen_stdout(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
+	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
 		return;
 
 	log_write_email_headers(rev, head, &pp.subject, &pp.after_subject,
@@ -982,7 +983,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
 	pp_remainder(&pp, &msg, &sb, 0);
 	add_branch_description(&sb, branch_name);
-	printf("%s\n", sb.buf);
+	fprintf(rev->diffopt.file, "%s\n", sb.buf);
 
 	strbuf_release(&sb);
 
@@ -991,6 +992,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	log.wrap = 72;
 	log.in1 = 2;
 	log.in2 = 4;
+	log.file = rev->diffopt.file;
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
@@ -1013,8 +1015,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	diffcore_std(&opts);
 	diff_flush(&opts);
 
-	printf("\n");
-	print_signature();
+	fprintf(rev->diffopt.file, "\n");
+	print_signature(rev->diffopt.file);
 }
 
 static const char *clean_message_id(const char *msg_id)
@@ -1324,7 +1326,7 @@ static void prepare_bases(struct base_tree_info *bases,
 	}
 }
 
-static void print_bases(struct base_tree_info *bases)
+static void print_bases(struct base_tree_info *bases, FILE *file)
 {
 	int i;
 
@@ -1333,11 +1335,11 @@ static void print_bases(struct base_tree_info *bases)
 		return;
 
 	/* Show the base commit */
-	printf("base-commit: %s\n", oid_to_hex(&bases->base_commit));
+	fprintf(file, "base-commit: %s\n", oid_to_hex(&bases->base_commit));
 
 	/* Show the prerequisite patches */
 	for (i = bases->nr_patch_id - 1; i >= 0; i--)
-		printf("prerequisite-patch-id: %s\n", oid_to_hex(&bases->patch_id[i]));
+		fprintf(file, "prerequisite-patch-id: %s\n", oid_to_hex(&bases->patch_id[i]));
 
 	free(bases->patch_id);
 	bases->nr_patch_id = 0;
@@ -1694,7 +1696,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, branch_name, quiet);
-		print_bases(&bases);
+		print_bases(&bases, rev.diffopt.file);
 		total++;
 		start_number--;
 	}
@@ -1740,7 +1742,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!use_stdout &&
-		    reopen_stdout(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
+		    open_next_file(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("Failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
 		free_commit_buffer(commit);
@@ -1755,15 +1757,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.shown_one = 0;
 		if (shown) {
 			if (rev.mime_boundary)
-				printf("\n--%s%s--\n\n\n",
+				fprintf(rev.diffopt.file, "\n--%s%s--\n\n\n",
 				       mime_boundary_leader,
 				       rev.mime_boundary);
 			else
-				print_signature();
-			print_bases(&bases);
+				print_signature(rev.diffopt.file);
+			print_bases(&bases, rev.diffopt.file);
 		}
 		if (!use_stdout)
-			fclose(stdout);
+			fclose(rev.diffopt.file);
 	}
 	free(list);
 	free(branch_name);
@@ -1795,15 +1797,15 @@ static const char * const cherry_usage[] = {
 };
 
 static void print_commit(char sign, struct commit *commit, int verbose,
-			 int abbrev)
+			 int abbrev, FILE *file)
 {
 	if (!verbose) {
-		printf("%c %s\n", sign,
+		fprintf(file, "%c %s\n", sign,
 		       find_unique_abbrev(commit->object.oid.hash, abbrev));
 	} else {
 		struct strbuf buf = STRBUF_INIT;
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
-		printf("%c %s %s\n", sign,
+		fprintf(file, "%c %s %s\n", sign,
 		       find_unique_abbrev(commit->object.oid.hash, abbrev),
 		       buf.buf);
 		strbuf_release(&buf);
@@ -1884,7 +1886,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		commit = list->item;
 		if (has_commit_patch_id(commit, &ids))
 			sign = '-';
-		print_commit(sign, commit, verbose, abbrev);
+		print_commit(sign, commit, verbose, abbrev, revs.diffopt.file);
 		list = list->next;
 	}
 
-- 
2.9.0.118.g0e1a633


