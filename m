Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B30E1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 21:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfAGVa1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 16:30:27 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:50496 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGVa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 16:30:27 -0500
Received: by mail-qk1-f202.google.com with SMTP id x125so1411614qka.17
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 13:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ItPYR7HM/NAvtb3Khti+z35znycOU8NPCJLi19p3I08=;
        b=WUZl/xpq52poN8+lCVwZ9Arnc1SfLBacdNcaNtS3mPgMCovp/d5ocpxfQukUa+ju9G
         dD6UE3EwKp7taEOl68jdtnzVM0s3nWrjOzgFqH7K1h49kKSnMkOesaGudvVyLQsCaOoA
         0+u+X7AwzOF1HoinUyaE6BPg+URXwuCANqs/Pa/y7vBg0nU7J6UmdAtJVPZV2Sd5EUIk
         xbwCDviimPUcx7fKXoTZS2i/1LpY6pHG8IuPUM7vpB/77ssK3MHRtv63ynC3oIblfDED
         EUnfXt4d8pN48leAiWQ05KL5zkbUGSIaut6UuRLNs+nWZbH7oeUunOC8G4EaR0YwYbgZ
         Kv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ItPYR7HM/NAvtb3Khti+z35znycOU8NPCJLi19p3I08=;
        b=FVAardEAeECvghTsHktQUfWOKJLNX0MZnhDZQfLhULqwIQ2Q8pvCcdbBqvPSH50bV3
         D7pcaHg+gVvFL3t33LNkOc8BmW16t+6mbhAjZ/Qo/1RpwYhXzwmdcL2bD7sawGhtsjI1
         z6sRD9ltwht/XpsVvAxb+vSLNqQ3CAfkYydUR45xPwQRNs52aSmDGJqjhMcNE8gohgUI
         wHOUpCasbFyv9E8OUjN3iQiChdD79O9iGMS3D5eNdC8Oqfqq8GXXFXeXtEQdgIGwxCAS
         Gsrlsi7v5P4usniwo2/ez+YZq2IzAeyXPN21mbfBLA8NCanQ+a6UkyDAL26hxgl4SDOo
         jy5w==
X-Gm-Message-State: AJcUukeu2LGGbI4ko8j6muc//J5+TpsoauWw+p+RQH4W7Yed1+039CWK
        PvoUg4/cWF+S7e3X4BHSgp2/DnrEcdfsqhNueL+8Gp1ItOVd8xQ+9uVhol1/GL/3anxttIbVCqK
        t4faZTaE9mgKi65ExM7AfObiYRLsJy8FEapAKmL8hnXIsQRfosALe
X-Google-Smtp-Source: ALg8bN6iVBuOEf2Jxz7tArPJFPm4nJLz2LLd79lHZkp8ikh0jI9dYJil8FCttp2UF+fHlB9zUqY/Si02
X-Received: by 2002:a37:4788:: with SMTP id u130mr45048725qka.60.1546896625621;
 Mon, 07 Jan 2019 13:30:25 -0800 (PST)
Date:   Mon,  7 Jan 2019 16:30:12 -0500
Message-Id: <20190107213013.231514-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH] blame: add the ability to ignore commits
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commits that make formatting changes or renames are often not
interesting when blaming a file.  This commit, similar to
git-hyper-blame, allows one to specify certain revisions to ignore during
the blame process.

To ignore a revision, put its committish in a file specified by
--ignore-file=<file> or use -i <rev>, which can be repeated.  The file
.git-blame-ignore-revs is checked by default.

It's useful to be alerted to the presence of an ignored commit in the
history of a line.  Those lines will be marked with '*' in the
non-porcelain output.  The '*' is attached to the line number to keep
from breaking tools that rely on the whitespace between columns.

A blame_entry attributed to an ignored commit will get passed to its
parent.  If an ignored commit changed a line, an ancestor that changed
the line will get blamed.  However, if an ignored commit added lines, a
commit changing a nearby line may get blamed.  If no commit is found,
the original commit for the file will get blamed.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 Documentation/git-blame.txt | 15 +++++++++
 blame.c                     | 38 +++++++++++++++++----
 blame.h                     |  3 ++
 builtin/blame.c             | 66 +++++++++++++++++++++++++++++++++++--
 4 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 16323eb80e31..e41375374892 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
+	    [-i <rev>] [--no-default-ignores] [--ignore-file=<file>]
 	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
 	    [--] <file>
 
@@ -84,6 +85,20 @@ include::blame-options.txt[]
 	Ignore whitespace when comparing the parent's version and
 	the child's to find where the lines came from.
 
+-i <rev>::
+	Ignore revision when assigning blame.  Lines that were changed by an
+	ignored commit will be marked with a `*` in the blame output.  Lines
+	that were added by an ignored commit may be attributed commits making
+	nearby changes or to the first commit touching the file.
+
+--no-default-ignores::
+	Do not automatically ignore revisions in the file
+	`.git-blame-ignore-revs`.
+
+--ignore-file=<file>::
+	Ignore revisions listed in `file`, one revision per line.  Whitespace
+	and comments beginning with `#` are ignored.
+
 --abbrev=<n>::
 	Instead of using the default 7+1 hexadecimal digits as the
 	abbreviated object name, use <n>+1 digits. Note that 1 column
diff --git a/blame.c b/blame.c
index d84c93778080..9e338cfa83e3 100644
--- a/blame.c
+++ b/blame.c
@@ -474,7 +474,8 @@ void blame_coalesce(struct blame_scoreboard *sb)
 
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (ent->suspect == next->suspect &&
-		    ent->s_lno + ent->num_lines == next->s_lno) {
+		    ent->s_lno + ent->num_lines == next->s_lno &&
+		    ent->ignored == next->ignored) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
 			blame_origin_decref(next->suspect);
@@ -726,6 +727,8 @@ static void split_overlap(struct blame_entry *split,
 	int chunk_end_lno;
 	memset(split, 0, sizeof(struct blame_entry [3]));
 
+	split[0].ignored = split[1].ignored = split[2].ignored = e->ignored;
+
 	if (e->s_lno < tlno) {
 		/* there is a pre-chunk part not blamed on parent */
 		split[0].suspect = blame_origin_incref(e->suspect);
@@ -845,10 +848,10 @@ static struct blame_entry *reverse_blame(struct blame_entry *head,
  */
 static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			int tlno, int offset, int same,
-			struct blame_origin *parent)
+			struct blame_origin *parent, int ignore_diffs)
 {
 	struct blame_entry *e = **srcq;
-	struct blame_entry *samep = NULL, *diffp = NULL;
+	struct blame_entry *samep = NULL, *diffp = NULL, *ignoredp = NULL;
 
 	while (e && e->s_lno < tlno) {
 		struct blame_entry *next = e->next;
@@ -862,6 +865,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			int len = tlno - e->s_lno;
 			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
 			n->suspect = e->suspect;
+			n->ignored = e->ignored;
 			n->lno = e->lno + len;
 			n->s_lno = e->s_lno + len;
 			n->num_lines = e->num_lines - len;
@@ -916,6 +920,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			int len = same - e->s_lno;
 			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
 			n->suspect = blame_origin_incref(e->suspect);
+			n->ignored = e->ignored;
 			n->lno = e->lno + len;
 			n->s_lno = e->s_lno + len;
 			n->num_lines = e->num_lines - len;
@@ -925,10 +930,24 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			n->next = samep;
 			samep = n;
 		}
-		e->next = diffp;
-		diffp = e;
+		if (ignore_diffs) {
+			/* These go to the parent, like the ones before tlno. */
+			blame_origin_decref(e->suspect);
+			e->suspect = blame_origin_incref(parent);
+			e->s_lno += offset;
+			e->ignored = 1;
+			e->next = ignoredp;
+			ignoredp = e;
+		} else {
+			e->next = diffp;
+			diffp = e;
+		}
 		e = next;
 	}
+	if (ignoredp) {
+		**dstq = reverse_blame(ignoredp, **dstq);
+		*dstq = &ignoredp->next;
+	}
 	**srcq = reverse_blame(diffp, reverse_blame(samep, e));
 	/* Move across elements that are in the unblamable portion */
 	if (diffp)
@@ -938,6 +957,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 struct blame_chunk_cb_data {
 	struct blame_origin *parent;
 	long offset;
+	int ignore_diffs;
 	struct blame_entry **dstq;
 	struct blame_entry **srcq;
 };
@@ -950,7 +970,7 @@ static int blame_chunk_cb(long start_a, long count_a,
 	if (start_a - start_b != d->offset)
 		die("internal error in blame::blame_chunk_cb");
 	blame_chunk(&d->dstq, &d->srcq, start_b, start_a - start_b,
-		    start_b + count_b, d->parent);
+		    start_b + count_b, d->parent, d->ignore_diffs);
 	d->offset = start_a + count_a - (start_b + count_b);
 	return 0;
 }
@@ -973,18 +993,22 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 
 	d.parent = parent;
 	d.offset = 0;
+	d.ignore_diffs = 0;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
 	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
 	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
 	sb->num_get_patch++;
 
+	if (oidset_contains(&sb->ignores, &target->commit->object.oid))
+		d.ignore_diffs = 1;
+
 	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
 		die("unable to generate diff (%s -> %s)",
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
 	/* The rest are the same as the parent */
-	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent);
+	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent, 0);
 	*d.dstq = NULL;
 	queue_blames(sb, parent, newdest);
 
diff --git a/blame.h b/blame.h
index be3a895043e0..3fe71a59d372 100644
--- a/blame.h
+++ b/blame.h
@@ -92,6 +92,7 @@ struct blame_entry {
 	 * scanning the lines over and over.
 	 */
 	unsigned score;
+	int ignored;
 };
 
 /*
@@ -117,6 +118,8 @@ struct blame_scoreboard {
 	/* linked list of blames */
 	struct blame_entry *ent;
 
+	struct oidset ignores;
+
 	/* look-up a line in the final buffer */
 	int num_lines;
 	int *lineno;
diff --git a/builtin/blame.c b/builtin/blame.c
index 6d798f99392e..698834426771 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -516,8 +516,13 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 						   ci.author_tz.buf,
 						   show_raw_time));
 			}
-			printf(" %*d) ",
-			       max_digits, ent->lno + 1 + cnt);
+			if (ent->ignored) {
+				printf(" %*d%c) ", max_digits - 1,
+				       ent->lno + 1 + cnt, '*');
+			} else {
+				printf(" %*d) ", max_digits,
+				       ent->lno + 1 + cnt);
+			}
 		}
 		if (reset)
 			fputs(reset, stdout);
@@ -603,6 +608,7 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 {
 	int longest_src_lines = 0;
 	int longest_dst_lines = 0;
+	int has_ignore = 0;
 	unsigned largest_score = 0;
 	struct blame_entry *e;
 	int compute_auto_abbrev = (abbrev < 0);
@@ -639,9 +645,11 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 			longest_dst_lines = num;
 		if (largest_score < blame_entry_score(sb, e))
 			largest_score = blame_entry_score(sb, e);
+		if (e->ignored)
+			has_ignore = 1;
 	}
 	max_orig_digits = decimal_width(longest_src_lines);
-	max_digits = decimal_width(longest_dst_lines);
+	max_digits = decimal_width(longest_dst_lines) + has_ignore;
 	max_score_digits = decimal_width(largest_score);
 
 	if (compute_auto_abbrev)
@@ -774,6 +782,43 @@ static int is_a_rev(const char *name)
 	return OBJ_NONE < oid_object_info(the_repository, &oid, NULL);
 }
 
+static void handle_ignore_list(struct blame_scoreboard *sb,
+			       struct string_list *ignores)
+{
+	struct string_list_item *i;
+	struct object_id oid;
+
+	oidset_init(&sb->ignores, 0);
+	for_each_string_list_item(i, ignores) {
+		if (get_oid_committish(i->string, &oid))
+			die(_("Can't find revision '%s' to ignore"), i->string);
+		oidset_insert(&sb->ignores, &oid);
+	}
+}
+
+static int handle_ignore_file(const char *path, struct string_list *ignores)
+{
+	FILE *fp = fopen(path, "r");
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!fp)
+		return -1;
+	while (!strbuf_getline(&sb, fp)) {
+		const char *hash;
+
+		hash = strchr(sb.buf, '#');
+		if (hash)
+			strbuf_setlen(&sb, hash - sb.buf);
+		strbuf_trim(&sb);
+		if (!sb.len)
+			continue;
+		string_list_append(ignores, sb.buf);
+	}
+	fclose(fp);
+	strbuf_release(&sb);
+	return 0;
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -785,8 +830,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct progress_info pi = { NULL, 0 };
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
+	struct string_list ignore_list = STRING_LIST_INIT_DUP;
 	int output_option = 0, opt = 0;
 	int show_stats = 0;
+	int no_default_ignores = 0;
+	const char *ignore_file = NULL;
 	const char *revs_file = NULL;
 	const char *contents_from = NULL;
 	const struct option options[] = {
@@ -806,6 +854,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_STRING_LIST('i', NULL, &ignore_list, N_("rev"), N_("Ignore <rev> when blaming")),
+		OPT_BOOL(0, "no-default-ignores", &no_default_ignores, N_("Do not ignore revisions from the .git-blame-ignore-revs file")),
+		OPT_STRING(0, "ignore-file", &ignore_file, N_("file"), N_("Ignore revisions from <file>")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
 
@@ -987,6 +1038,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		argv[argc - 1] = "--";
 	}
 
+	if (!no_default_ignores)
+		handle_ignore_file(".git-blame-ignore-revs", &ignore_list);
+	if (ignore_file) {
+		if (handle_ignore_file(ignore_file, &ignore_list))
+			die(_("Unable to open ignore-file '%s'"), ignore_file);
+	}
+
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
 
@@ -995,6 +1053,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
 	sb.repo = the_repository;
+	handle_ignore_list(&sb, &ignore_list);
+	string_list_clear(&ignore_list, 0);
 	setup_scoreboard(&sb, path, &o);
 	lno = sb.num_lines;
 
-- 
2.20.1.97.g81188d93c3-goog

