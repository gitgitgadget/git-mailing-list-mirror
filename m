From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] diffcore-rename: fall back to -C when -C -C busts the
 rename limit
Date: Tue, 22 Mar 2011 14:50:49 -0700
Message-ID: <1300830649-22830-3-git-send-email-gitster@pobox.com>
References: <7vk4fqkewo.fsf@alter.siamese.dyndns.org>
 <1300830649-22830-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 22:51:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q29Tt-0008Vq-Sb
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 22:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355Ab1CVVvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 17:51:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab1CVVvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 17:51:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDF5B4662;
	Tue, 22 Mar 2011 17:52:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7q6o
	IIfCxyEk7xHF5rXeTXI16n0=; b=mOqgHMW/nlDTG5cL7KUkZB+MAq7Cm90o9qJf
	zDZ8Y5YgVtNlSqfzYuDkEU1zc/XxmFme56H2p7X/dKikvSnuMql7Ndq/Q+BMe5se
	BuTKeg16/AqducXqmmCsj5QmmxfcjRDVUYy7OJeXLgNxSa/yNCBV1KibKCfY3tMi
	PAK34B4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	poJSKigKToqDBrn72G1zN/tdBvn+nxyhIt5jmvHvOf+bFJ0OLeZvUz82GxaPR4XT
	jYel/6YQTzEzp+LoT4uBIrGSkGdzo4GE+AmqI/dHw7VLhqkpjjnb8VJOn0I564HH
	NesHJX6dl/zER276LAVygx8O5TDUHjAqbrqNBXq/6v8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3F2A465E;
	Tue, 22 Mar 2011 17:52:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8611A465A; Tue, 22 Mar 2011
 17:52:36 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.554.gfdad8
In-Reply-To: <1300830649-22830-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B45612B0-54CE-11E0-8F68-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169783>

When there are too many paths in the project, the number of rename source
candidates "git diff -C -C" finds will exceed the rename detection limit,
and no inexact rename detection is performed.  We however could fall back
to "git diff -C" if the number of modified paths is sufficiently small.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/diff-tree.c    |   12 +++++++++++-
 builtin/log.c          |    9 +++++++++
 diff.c                 |   26 ++++++++++++++++++++++++++
 diff.h                 |    2 ++
 diffcore-rename.c      |   38 ++++++++++++++++++++++++++++++++++++--
 merge-recursive.c      |   10 +++-------
 t/t4001-diff-rename.sh |   25 +++++++++++++++++++++++++
 7 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0d2a3e9..be6417d 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -163,6 +163,9 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	}
 
 	if (read_stdin) {
+		int saved_nrl = 0;
+		int saved_dcctc = 0;
+
 		if (opt->diffopt.detect_rename)
 			opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
 					       DIFF_SETUP_USE_CACHE);
@@ -173,9 +176,16 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 				fputs(line, stdout);
 				fflush(stdout);
 			}
-			else
+			else {
 				diff_tree_stdin(line);
+				if (saved_nrl < opt->diffopt.needed_rename_limit)
+					saved_nrl = opt->diffopt.needed_rename_limit;
+				if (opt->diffopt.degraded_cc_to_c)
+					saved_dcctc = 1;
+			}
 		}
+		opt->diffopt.degraded_cc_to_c = saved_dcctc;
+		opt->diffopt.needed_rename_limit = saved_nrl;
 	}
 
 	return diff_result_code(&opt->diffopt, 0);
diff --git a/builtin/log.c b/builtin/log.c
index 796e9e5..707fd57 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -247,6 +247,8 @@ static void finish_early_output(struct rev_info *rev)
 static int cmd_log_walk(struct rev_info *rev)
 {
 	struct commit *commit;
+	int saved_nrl = 0;
+	int saved_dcctc = 0;
 
 	if (rev->early_output)
 		setup_early_output(rev);
@@ -277,7 +279,14 @@ static int cmd_log_walk(struct rev_info *rev)
 		}
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
+		if (saved_nrl < rev->diffopt.needed_rename_limit)
+			saved_nrl = rev->diffopt.needed_rename_limit;
+		if (rev->diffopt.degraded_cc_to_c)
+			saved_dcctc = 1;
 	}
+	rev->diffopt.degraded_cc_to_c = saved_dcctc;
+	rev->diffopt.needed_rename_limit = saved_nrl;
+
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
 	    DIFF_OPT_TST(&rev->diffopt, CHECK_FAILED)) {
 		return 02;
diff --git a/diff.c b/diff.c
index 9b3eb99..13f322b 100644
--- a/diff.c
+++ b/diff.c
@@ -3956,6 +3956,28 @@ static int is_summary_empty(const struct diff_queue_struct *q)
 	return 1;
 }
 
+static const char rename_limit_warning[] =
+"inexact rename detection was skipped due to too many files.";
+
+static const char degrade_cc_to_c_warning[] =
+"only found copies from modified paths due to too many files.";
+
+static const char rename_limit_advice[] =
+"you may want to set your %s variable to at least "
+"%d and retry the command.";
+
+void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
+{
+	if (degraded_cc)
+		warning(degrade_cc_to_c_warning);
+	else if (needed)
+		warning(rename_limit_warning);
+	else
+		return;
+	if (0 < needed && needed < 32767)
+		warning(rename_limit_advice, varname, needed);
+}
+
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -4237,6 +4259,10 @@ void diffcore_std(struct diff_options *options)
 int diff_result_code(struct diff_options *opt, int status)
 {
 	int result = 0;
+
+	diff_warn_rename_limit("diff.renamelimit",
+			       opt->needed_rename_limit,
+			       opt->degraded_cc_to_c);
 	if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
 	    !(opt->output_format & DIFF_FORMAT_CHECKDIFF))
 		return status;
diff --git a/diff.h b/diff.h
index 007a055..b8dde8a 100644
--- a/diff.h
+++ b/diff.h
@@ -111,6 +111,7 @@ struct diff_options {
 	int rename_score;
 	int rename_limit;
 	int needed_rename_limit;
+	int degraded_cc_to_c;
 	int show_rename_progress;
 	int dirstat_percent;
 	int setup;
@@ -273,6 +274,7 @@ extern void diffcore_fix_diff_index(struct diff_options *);
 
 extern int diff_queue_is_empty(void);
 extern void diff_flush(struct diff_options*);
+extern void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
 
 /* diff-raw status letters */
 #define DIFF_STATUS_ADDED		'A'
diff --git a/diffcore-rename.c b/diffcore-rename.c
index a932f76..f62587e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -420,11 +420,18 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
 		m[worst] = *o;
 }
 
+/*
+ * Returns:
+ * 0 if we are under the limit;
+ * 1 if we need to disable inexact rename detection;
+ * 2 if we would be under the limit if we were given -C instead of -C -C.
+ */
 static int too_many_rename_candidates(int num_create,
 				      struct diff_options *options)
 {
 	int rename_limit = options->rename_limit;
 	int num_src = rename_src_nr;
+	int i;
 
 	options->needed_rename_limit = 0;
 
@@ -445,6 +452,20 @@ static int too_many_rename_candidates(int num_create,
 
 	options->needed_rename_limit =
 		num_src > num_create ? num_src : num_create;
+
+	/* Are we running under -C -C? */
+	if (!DIFF_OPT_TST(options, FIND_COPIES_HARDER))
+		return 1;
+
+	/* Would we bust the limit if we were running under -C? */
+	for (num_src = i = 0; i < rename_src_nr; i++) {
+		if (diff_unmodified_pair(rename_src[i].p))
+			continue;
+		num_src++;
+	}
+	if ((num_create <= rename_limit || num_src <= rename_limit) &&
+	    (num_create * num_src <= rename_limit * rename_limit))
+		return 2;
 	return 1;
 }
 
@@ -476,7 +497,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
-	int i, j, rename_count;
+	int i, j, rename_count, skip_unmodified = 0;
 	int num_create, num_src, dst_cnt;
 	struct progress *progress = NULL;
 
@@ -539,8 +560,16 @@ void diffcore_rename(struct diff_options *options)
 	if (!num_create)
 		goto cleanup;
 
-	if (too_many_rename_candidates(num_create, options))
+	switch (too_many_rename_candidates(num_create, options)) {
+	case 1:
 		goto cleanup;
+	case 2:
+		options->degraded_cc_to_c = 1;
+		skip_unmodified = 1;
+		break;
+	default:
+		break;
+	}
 
 	if (options->show_rename_progress) {
 		progress = start_progress_delay(
@@ -563,6 +592,11 @@ void diffcore_rename(struct diff_options *options)
 		for (j = 0; j < rename_src_nr; j++) {
 			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
+
+			if (skip_unmodified &&
+			    diff_unmodified_pair(rename_src[j].p))
+				continue;
+
 			this_src.score = estimate_similarity(one, two,
 							     minimum_score);
 			this_src.name_score = basename_same(one, two);
diff --git a/merge-recursive.c b/merge-recursive.c
index 8e82a8b..3ae4d53 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -22,11 +22,6 @@
 #include "dir.h"
 #include "submodule.h"
 
-static const char rename_limit_advice[] =
-"inexact rename detection was skipped because there were too many\n"
-"  files. You may want to set your merge.renamelimit variable to at least\n"
-"  %d and retry this merge.";
-
 static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 				      const char *subtree_shift)
 {
@@ -1656,8 +1651,9 @@ int merge_recursive(struct merge_options *o,
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
 	flush_output(o);
-	if (o->needed_rename_limit)
-		warning(rename_limit_advice, o->needed_rename_limit);
+	if (show(o, 2))
+		diff_warn_rename_limit("merge.renamelimit",
+				       o->needed_rename_limit, 0);
 	return clean;
 }
 
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 71bac83..301f3a0 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -77,4 +77,29 @@ test_expect_success  'favour same basenames even with minor differences' '
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
 	git status | grep "renamed: .*path1 -> subdir/path1"'
 
+test_expect_success 'setup for many rename source candidates' '
+	git reset --hard &&
+	for i in 0 1 2 3 4 5 6 7 8 9;
+	do
+		for j in 0 1 2 3 4 5 6 7 8 9;
+		do
+			echo "$i$j" >"path$i$j"
+		done
+	done &&
+	git add "path??" &&
+	test_tick &&
+	git commit -m "hundred" &&
+	(cat path1; echo new) >new-path &&
+	echo old >>path1 &&
+	git add new-path path1 &&
+	git diff -l 4 -C -C --cached --name-status >actual 2>actual.err &&
+	sed -e "s/^\([CM]\)[0-9]*	/\1	/" actual >actual.munged &&
+	cat >expect <<-EOF &&
+	C	path1	new-path
+	M	path1
+	EOF
+	test_cmp expect actual.munged &&
+	grep warning actual.err
+'
+
 test_done
-- 
1.7.4.1.554.gfdad8
