Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C734220189
	for <e@80x24.org>; Mon, 20 Jun 2016 10:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbcFTK7j (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:59:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:57063 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575AbcFTK7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:59:36 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MUI8w-1any9n02UM-00QzLQ; Mon, 20 Jun 2016 12:59:17
 +0200
Date:	Mon, 20 Jun 2016 12:55:55 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/7] format-patch: avoid freopen()
In-Reply-To: <cover.1466420060.git.johannes.schindelin@gmx.de>
Message-ID: <8b1f13155c7ba6dde7994c920fbff7019be51054.1466420060.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ixii51TYkxPtBoLgUFdCxaqxeDbcQHRWTBhZDA9O2ask64leHin
 3x6qY9f2b1MRfObS21J2j8NM+RLn2ZQt93WmEEVRwjQeautNeXRKpkFXfj0/sLtyw3rX48z
 OPlamK2cAAEMUuHYka/ozQzgAcNZlBdbcSjCRKG41ny577WW1TrAuUOIP025WjP94ak2c5O
 m6QuZM39KsMVYpqO/KO2w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YzKhS9kxdYU=:mlHNPJX7++R821rw1TFrS+
 18CjXWeUiF8Ceio9x6iGjINeJorNNlDnvoa2GTFpS0O0juNrnT0nGqfOZfF01fHQ+r1lTpSzu
 IPumFpQrnDlVctteXLd5DQJL9VW70iNL9VMPdPrrm9klre2Xw/XWM/bZeE6OSC9Vjwxjym3RI
 Dla+YXx1m7YkxO2YcXhnxG8tqhYEzAsorsdTN8IuzlMDqJ/ORu7Q5rPCZBR/NBuDH5Ba8pVKO
 EH4lfsdugEE5HDRirw3Yyc8OXFLYO6nYa4vB74M1AIrZhpO96BD0ReNbgiRmyZOxuvxKmU004
 up1hdMQjNFIZp4MelvCudTK9WxzdWM03FpYLC9kvBFBU+kQUxvKJ0kqCJ46cAplSC36dVPfFK
 +jvcA0XegphV3l/QbM1u0e8ByZur9dL0fwKe3iKls20sHyed/RuJ2Z5FVexNAT7pjbXmxxhCI
 FpxQl2cOI9WPebPWSAcqsE6iEQmxCBTSrYqoCiHesoEOLUmFt5Cy+hmV0hqbTiO+qxp5oRtqt
 H5uIOuj+UdhgRlg/4gdQ51kV/z0AlgtuhMuOeCrd/KA8UyU9/q6hXQwqJ88IKW1owbwqiwVBA
 Kd/4ZwNKR2TP8amBLM03Tm4Xs4RrzyTLbs2WraZMRNFXhZH1O8mPj1MqkyASBZIjKoXdBCJPP
 uziVkSXFpbuLUKsh99Fc1Hw15rVB65W0XBjn2pTz5OO71MM+5Ip8XZqLeMQPsnQIDmqoAjuRh
 eoWzzrf+VSP9dYoT6CTrAN9nG7qbsO4GrYOpFooT8X3A92t0c0ur5bZtdHgp9jCeVo1/NUUhL
 7RhuWRi
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
index abd889b..db034a8 100644
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
+		fputc('\n', file);
+	fputc('\n', file);
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
2.9.0.119.g370c5a9


