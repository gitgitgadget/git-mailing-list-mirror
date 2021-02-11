Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0504C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 21:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DA464E45
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 21:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBKVcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 16:32:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61107 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhBKVcs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 16:32:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B05DAC781;
        Thu, 11 Feb 2021 16:32:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=+fXBRMLcnWj/UQ7O5vstMvzEkGo=; b=pMzcCcQNmSPDoTz89nc0r3wPjG/6
        VAAUBxFu3HoBaNQYNzrwmZ06rbz6oUKdvLyTJY4rBa7ncRWLYoAxU46YkWcPNCUE
        AcoEiIZJbFGe8JAk2fjeF8Rf2G9WyHtbhle0VGC4Sxf2NNUtCU6naDlI2UnddaRC
        t5r9YXORcZw+4JI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
        uHJAJLSkgzsfuC571dPrPDDon6k1ov5ef/YPG1eLtdgsvZm4mmzvuLSRvG4gHkZl
        bDKd8+fR4R/9jsMOkYmglt31Ennsxf3iw7dut/MSN+PQROxmeUpjiXFeKbAcx2ub
        Pudklq8oWjZTy1FAX+9otFeAFNGnWR2gnutrTaTM7BQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 140EBAC780;
        Thu, 11 Feb 2021 16:32:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AEF7AC77F;
        Thu, 11 Feb 2021 16:32:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] diff: --{rotate,skip}-to=<path>
cc:     ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 11 Feb 2021 13:32:01 -0800
Message-ID: <xmqqo8gqwasu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94819284-6CB0-11EB-9C48-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the implementation of "git difftool", there is a case where the
user wants to start viewing the diffs at a specific path and
continue on to the rest, optionally wrapping around to the
beginning.  Since it is somewhat cumbersome to implement such a
feature as a post-processing step of "git diff" output, let's
support it internally with two new options.

 - "git diff --rotate-to=C", when the resulting patch would show
   paths A B C D E without the option, would "rotate" the paths to
   shows patch to C D E A B instead.  It is an error when there is
   no patch for C is shown.

 - "git diff --skip-to=C" would instead "skip" the paths before C,
   and shows patch to C D E.  Again, it is an error when there is no
   patch for C is shown.

 - "git log [-p]" also accepts these two options, but it is not an
   error if there is no change to the specified path.  Instead, the
   set of output paths are rotated or skipped to the specified path
   or the first path that sorts after the specified path.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Please do not take the presense of --skip-to and --rotate-to as
   encouraging "git difftool" to gain the same pair of options.  I
   think "--skip-to" would suffice for the originally presented use
   case (i.e. eeek, my difftool session got interrupted when I was
   looking at path X, and I only have just a few more paths to go,
   X, Y and Z) and if that is the case, there is no need to expose
   "--rotate-to" to the end users.  Of course, if it is easy to quit
   the "difftool" session in the middle, then giving the users only
   "--rotate-to" without exposing "--skip-to" is also OK.

   I decided to diagnose a pathname that is not in the diff-queue as
   an error when running the "diff" family, while allowing the
   command to continue when running the "log" family, so it may turn
   out to be that "git difftool --skip-to" do not have to implement
   its own error handling after all.

   It has been quite a long time for me to write any real patch with
   a non-trivial amount of code change myself, so I may be getting
   rusty, but it is refreshing to write code every so often ;-)

 Documentation/diff-options.txt |  8 ++++
 Documentation/gitdiffcore.txt  | 21 ++++++++++
 Makefile                       |  1 +
 builtin/diff-files.c           |  1 +
 builtin/diff-index.c           |  2 +
 builtin/diff-tree.c            |  3 ++
 builtin/diff.c                 |  1 +
 diff.c                         | 21 ++++++++++
 diff.h                         | 21 ++++++++++
 diffcore-rotate.c              | 46 ++++++++++++++++++++++
 diffcore.h                     |  1 +
 t/t4056-diff-order.sh          | 72 +++++++++++++++++++++++++++++++++-
 12 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 diffcore-rotate.c

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e5733ccb2d..7c5b3cf42b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -700,6 +700,14 @@ matches a pattern if removing any number of the final pathname
 components matches the pattern.  For example, the pattern "`foo*bar`"
 matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
 
+--skip-to=<file>::
+--rotate-to=<file::
+	Discard the files before the named <file> from the output
+	(i.e. 'skip to'), or move them to the end of the output
+	(i.e. 'rotate to').  These were invented primarily for use
+	of the `git difftool` command, and may not be very useful
+	otherwise.
+
 ifndef::git-format-patch[]
 -R::
 	Swap two inputs; that is, show differences from index or
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index c970d9fe43..2bd1220477 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -74,6 +74,7 @@ into another list.  There are currently 5 such transformations:
 - diffcore-merge-broken
 - diffcore-pickaxe
 - diffcore-order
+- diffcore-rotate
 
 These are applied in sequence.  The set of filepairs 'git diff-{asterisk}'
 commands find are used as the input to diffcore-break, and
@@ -276,6 +277,26 @@ Documentation
 t
 ------------------------------------------------
 
+diffcore-rotate: For Changing At Which Path Output Starts
+---------------------------------------------------------
+
+This transformation takes one pathname, and rotates the set of
+filepairs so that the filepair for the given pathname comes first,
+optionally discarding the paths that come before it.  This is used
+to implement the `--skip-to` and the `--rotate-to` options.  It is
+an error when the specified pathname is not in the set of filepairs,
+but it is not useful to error out when used with "git log" family of
+commands, because it is unreasonable to expect that a given path
+would be modified by each and every commit shown by the "git log"
+command.  For this reason, when used with "git log", the filepair
+that sorts the same as, or the first one that sorts after, the given
+pathname is where the output starts.
+
+Use of this transformation combined with diffcore-order will produce
+unexpected results, as the input to this transformation is likely
+not sorted when diffcore-order is in effect.
+
+
 SEE ALSO
 --------
 linkgit:git-diff[1],
diff --git a/Makefile b/Makefile
index 5a239cac20..9b1bde2e0e 100644
--- a/Makefile
+++ b/Makefile
@@ -863,6 +863,7 @@ LIB_OBJS += diffcore-delta.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
+LIB_OBJS += diffcore-rotate.o
 LIB_OBJS += dir-iterator.o
 LIB_OBJS += dir.o
 LIB_OBJS += editor.o
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 4742a4559b..e037efb07e 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -54,6 +54,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
+	rev.diffopt.rotate_to_strict = 1;
 
 	/*
 	 * Make sure there are NO revision (i.e. pending object) parameter,
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 7f5281c461..06635e8fb2 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -41,6 +41,8 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 
+	rev.diffopt.rotate_to_strict = 1;
+
 	/*
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 9fc95e959f..b6a9a9328e 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -156,6 +156,8 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	if (merge_base && opt->pending.nr != 2)
 		die(_("--merge-base only works with two commits"));
 
+	opt->diffopt.rotate_to_strict = 1;
+
 	/*
 	 * NOTE!  We expect "a..b" to expand to "^a b" but it is
 	 * perfectly valid for revision range parser to yield "b ^a",
@@ -192,6 +194,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		int saved_nrl = 0;
 		int saved_dcctc = 0;
 
+		opt->diffopt.rotate_to_strict = 0;
 		if (opt->diffopt.detect_rename) {
 			if (!the_index.cache)
 				repo_read_index(the_repository);
diff --git a/builtin/diff.c b/builtin/diff.c
index 5cfe1717e8..f1b88c7389 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -491,6 +491,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	}
 
 	rev.diffopt.flags.recursive = 1;
+	rev.diffopt.rotate_to_strict = 1;
 
 	setup_diff_pager(&rev.diffopt);
 
diff --git a/diff.c b/diff.c
index 69e3bc00ed..71e4738548 100644
--- a/diff.c
+++ b/diff.c
@@ -5348,6 +5348,19 @@ static int diff_opt_word_diff_regex(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_rotate_to(const struct option *opt, const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!strcmp(opt->long_name, "skip-to"))
+		options->skip_instead_of_rotate = 1;
+	else
+		options->skip_instead_of_rotate = 0;
+	options->rotate_to = arg;
+	return 0;
+}
+
 static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] = {
@@ -5599,6 +5612,12 @@ static void prep_parse_options(struct diff_options *options)
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
 		OPT_FILENAME('O', NULL, &options->orderfile,
 			     N_("control the order in which files appear in the output")),
+		OPT_CALLBACK_F(0, "rotate-to", options, N_("<path>"),
+			       N_("show the change in the specified path first"),
+			       PARSE_OPT_NONEG, diff_opt_rotate_to),
+		OPT_CALLBACK_F(0, "skip-to", options, N_("<path>"),
+			       N_("skip the output to the specified path"),
+			       PARSE_OPT_NONEG, diff_opt_rotate_to),
 		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
 			       N_("look for differences that change the number of occurrences of the specified object"),
 			       PARSE_OPT_NONEG, diff_opt_find_object),
@@ -6669,6 +6688,8 @@ void diffcore_std(struct diff_options *options)
 		diffcore_pickaxe(options);
 	if (options->orderfile)
 		diffcore_order(options->orderfile);
+	if (options->rotate_to)
+		diffcore_rotate(options);
 	if (!options->found_follow)
 		/* See try_to_follow_renames() in tree-diff.c */
 		diff_resolve_rename_copy();
diff --git a/diff.h b/diff.h
index 2ff2b1c7f2..45300e3597 100644
--- a/diff.h
+++ b/diff.h
@@ -227,6 +227,27 @@ enum diff_submodule_format {
 struct diff_options {
 	const char *orderfile;
 
+	/*
+	 * "--rotate-to=<file>" would start showing at <file> and when
+	 * the output reaches the end, wrap around by default.
+	 * Setting skip_instead_of_rotate to true stops the output at the
+	 * end, effectively discarding the earlier part of the output
+	 * before <file>'s diff (this is used to implement the
+	 * "--skip-to=<file>" option).
+	 *
+	 * When rotate_to_strict is set, it is an error if there is no
+	 * <file> in the diff.  Otherwise, the output starts at the
+	 * path that is the same as, or first path that sorts after,
+	 * <file>.  Because it is unreasonable to require the exact
+	 * match for "git log -p --rotate-to=<file>" (i.e. not all
+	 * commit would touch that single <file>), "git log" sets it
+	 * to false.  "git diff" sets it to true to detect an error
+	 * in the command line option.
+	 */
+	const char *rotate_to;
+	int skip_instead_of_rotate;
+	int rotate_to_strict;
+
 	/**
 	 * A constant string (can and typically does contain newlines to look for
 	 * a block of text, not just a single line) to filter out the filepairs
diff --git a/diffcore-rotate.c b/diffcore-rotate.c
new file mode 100644
index 0000000000..445f060ab0
--- /dev/null
+++ b/diffcore-rotate.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2021, Google LLC.
+ * Based on diffcore-order.c, which is Copyright (C) 2005, Junio C Hamano
+ */
+#include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
+
+void diffcore_rotate(struct diff_options *opt)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	int rotate_to, i;
+
+	if (!q->nr)
+		return;
+
+	for (i = 0; i < q->nr; i++) {
+		int cmp = strcmp(opt->rotate_to, q->queue[i]->two->path);
+		if (!cmp)
+			break; /* exact match */
+		if (!opt->rotate_to_strict && cmp < 0)
+			break; /* q->queue[i] is now past the target pathname */
+	}
+
+	if (q->nr <= i) {
+		/* we did not find the specified path */
+		if (opt->rotate_to_strict)
+			die(_("No such path '%s' in the diff"), opt->rotate_to);
+		return;
+	}
+
+	DIFF_QUEUE_CLEAR(&outq);
+	rotate_to = i;
+
+	for (i = rotate_to; i < q->nr; i++)
+		diff_q(&outq, q->queue[i]);
+	for (i = 0; i < rotate_to; i++) {
+		if (opt->skip_instead_of_rotate)
+			diff_free_filepair(q->queue[i]);
+		else
+			diff_q(&outq, q->queue[i]);
+	}
+	free(q->queue);
+	*q = outq;
+}
diff --git a/diffcore.h b/diffcore.h
index d2a63c5c71..c1592bcd01 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -164,6 +164,7 @@ void diffcore_rename(struct diff_options *);
 void diffcore_merge_broken(void);
 void diffcore_pickaxe(struct diff_options *);
 void diffcore_order(const char *orderfile);
+void diffcore_rotate(struct diff_options *);
 
 /* low-level interface to diffcore_order */
 struct obj_order {
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index 63ea7144bb..aec1d9d1b4 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='diff order'
+test_description='diff order & rotate'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -127,4 +127,74 @@ do
 	'
 done
 
+### rotate and skip
+
+test_expect_success 'rotate and skip setup' '
+	>sample1.t &&
+	>sample2.t &&
+	>sample3.t &&
+	>sample4.t &&
+	git add sample[1234].t &&
+	git commit -m "added" sample[1234].t &&
+	echo modified >>sample1.t &&
+	echo modified >>sample2.t &&
+	echo modified >>sample4.t &&
+	git commit -m "updated" sample[1234].t
+'
+
+test_expect_success 'diff --rotate-to' '
+	git diff --rotate-to=sample2.t --name-only HEAD^ >actual &&
+	test_write_lines sample2.t sample4.t sample1.t >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --skip-to' '
+	git diff --skip-to=sample2.t --name-only HEAD^ >actual &&
+	test_write_lines sample2.t sample4.t >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --rotate/skip-to error condition' '
+	test_must_fail git diff --rotate-to=sample3.t HEAD^ &&
+	test_must_fail git diff --skip-to=sample3.t HEAD^
+'
+
+test_expect_success 'log --rotate-to' '
+	git log --rotate-to=sample3.t --raw HEAD~2.. >raw &&
+	# just distill the commit header and paths
+	sed -n -e "s/^commit.*/commit/p" \
+	       -e "/^:/s/^.*	//p" raw >actual &&
+
+	cat >expect <<-\EOF &&
+	commit
+	sample4.t
+	sample1.t
+	sample2.t
+	commit
+	sample3.t
+	sample4.t
+	sample1.t
+	sample2.t
+	EOF
+
+	test_cmp expect actual
+'
+
+test_expect_success 'log --skip-to' '
+	git log --skip-to=sample3.t --raw HEAD~2.. >raw &&
+	# just distill the commit header and paths
+	sed -n -e "s/^commit.*/commit/p" \
+	       -e "/^:/s/^.*	//p" raw >actual &&
+
+	cat >expect <<-\EOF &&
+	commit
+	sample4.t
+	commit
+	sample3.t
+	sample4.t
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.30.1-633-gb004a83696

