Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671852018B
	for <e@80x24.org>; Wed, 22 Jun 2016 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbcFVPDC (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:03:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:52377 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbcFVPCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:02:07 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M0gww-1bVc750LZ0-00unIN; Wed, 22 Jun 2016 17:01:29
 +0200
Date:	Wed, 22 Jun 2016 17:01:28 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 01/10] Prepare log/log-tree to reuse the diffopt.close_file
 attribute
In-Reply-To: <cover.1466607667.git.johannes.schindelin@gmx.de>
Message-ID: <044f3c6359b63eaa18229cd73e6815e8e15c9778.1466607667.git.johannes.schindelin@gmx.de>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TupFC0IuGto7qsOTjX9LuqJTyugTVBwG1Vk2PRRuR2xgJnlm98B
 TIt1R0KfSryAkdDvLRQFxEZ6s6qjwT2BzKouLXfn5ZAKW+q88tBHdZB8C1XkngUWyiiJW1o
 UefsapzeUjMIjBkO0JQVbljfp3t3NtFhZymFmL9sTlnrWZvjKBx0Vl55s3cWQmfXFzBhrUA
 fDlGA5CmyRRA/KBVudZcQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CPBhS0qzscs=:hdOSixOQxZZKa50DO1NUBy
 2rn78XauV2byeOguQaeu9+Eg8ehSLCHxCFxfnU0CHANibWmGLsE/1qbt5lphpo55Nj6tkGfqz
 Pciuvcw80p8A++88coanAE2qJcjwHR+FGAMGNuSNzl31rAS20NpatG60ESoYte1oZV/Od83u2
 kZCqnDzoav1kCcycmofuxwHCyR8oWyQ9cnh0GI3+t38SHRg+xf9EuW6S6hPUuacxz1cbgTqYn
 X7Vq2OXLTiUQcVGfv+kW/ls7u5GcffTxRLGk/sfamnEXup2j2Cl1cZyQzn8rjXM0/h+jGsZ78
 2IRwPMEe9P/zIstgK3uwY/ouJQWrEqh1+TIsgZTClcmGWyh62cT+daDlvoson+U1fPwxgxMo8
 OiH6aN+UrLpVF32oWBkoTj6T97OpaBuiyUAC1BJ6bNW3VTpyevNNy2nj9g3+JnR7q+rNjZ/0C
 xznR/MnObxBCiOjKD+ljfJUgNpu0U5c1Rr5lj5Q2qgXsO0liojUGRQxHN02xvRbJrwpMoT7U7
 2KR56zGt/YsVXmgO6qpTvT87j/xnDCOoymAyjCAHCZDmuVLpoAeJw/uG6OvOTWI7VlZVZJYgM
 uhtSfuU51qfQuygqQ5Q4T3gKAKWbLRWShQCM6IDRaIeUFi5ZylG469rde/evUPju9Qqy5lEeu
 PXvk9YWxakQQipo/G6Dpe2mWbgTdjlTV6xfcq/0kEV0+55rZXXbUVILbLaAAu1JSu8c0yAh2J
 HAmClgrY5Xn+cEgPIokNECAooXBSoWmYc5SadRPm46J3/8OBSlAgH4VdX9v6++ppoj2PoYBK7
 UVbnRXO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We are about to teach the log-tree machinery to reuse the diffopt.file
field to output to a file stream other than stdout, in line with the
diff machinery already writing to diffopt.file.

However, we might want to write something after the diff in
log_tree_commit() (e.g. with the --show-linear-break option), therefore
we must not let the diff machinery close the file (as per
diffopt.close_file.

This means that log_tree_commit() itself must override the
diffopt.close_file flag and close the file, and if log_tree_commit() is
called in a loop, the caller is responsible to do the same.

Note: format-patch has an `--output-directory` option. Due to the fact
that format-patch's options are parsed first, and that the parse-options
machinery accepts uniquely abbreviated options, the diff options
`--output` (and `-o`) are shadowed. Therefore close_file is not set to 1
so that cmd_format_patch() does *not* need to handle the close_file flag
differently, even if it calls log_tree_commit() in a loop.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/log.c | 15 ++++++++++++---
 log-tree.c    |  5 ++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 099f4f7..27bc88d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -243,9 +243,10 @@ static struct itimerval early_output_timer;
 
 static void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
-	int i = revs->early_output;
+	int i = revs->early_output, close_file = revs->diffopt.close_file;
 	int show_header = 1;
 
+	revs->diffopt.close_file = 0;
 	sort_in_topological_order(&list, revs->sort_order);
 	while (list && i) {
 		struct commit *commit = list->item;
@@ -262,14 +263,19 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 		case commit_ignore:
 			break;
 		case commit_error:
+			if (close_file)
+				fclose(revs->diffopt.file);
 			return;
 		}
 		list = list->next;
 	}
 
 	/* Did we already get enough commits for the early output? */
-	if (!i)
+	if (!i) {
+		if (close_file)
+			fclose(revs->diffopt.file);
 		return;
+	}
 
 	/*
 	 * ..if no, then repeat it twice a second until we
@@ -331,7 +337,7 @@ static int cmd_log_walk(struct rev_info *rev)
 {
 	struct commit *commit;
 	int saved_nrl = 0;
-	int saved_dcctc = 0;
+	int saved_dcctc = 0, close_file = rev->diffopt.close_file;
 
 	if (rev->early_output)
 		setup_early_output(rev);
@@ -347,6 +353,7 @@ static int cmd_log_walk(struct rev_info *rev)
 	 * and HAS_CHANGES being accumulated in rev->diffopt, so be careful to
 	 * retain that state information if replacing rev->diffopt in this loop
 	 */
+	rev->diffopt.close_file = 0;
 	while ((commit = get_revision(rev)) != NULL) {
 		if (!log_tree_commit(rev, commit) && rev->max_count >= 0)
 			/*
@@ -367,6 +374,8 @@ static int cmd_log_walk(struct rev_info *rev)
 	}
 	rev->diffopt.degraded_cc_to_c = saved_dcctc;
 	rev->diffopt.needed_rename_limit = saved_nrl;
+	if (close_file)
+		fclose(rev->diffopt.file);
 
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
 	    DIFF_OPT_TST(&rev->diffopt, CHECK_FAILED)) {
diff --git a/log-tree.c b/log-tree.c
index 78a5381..456d7e3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -862,11 +862,12 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 int log_tree_commit(struct rev_info *opt, struct commit *commit)
 {
 	struct log_info log;
-	int shown;
+	int shown, close_file = opt->diffopt.close_file;
 
 	log.commit = commit;
 	log.parent = NULL;
 	opt->loginfo = &log;
+	opt->diffopt.close_file = 0;
 
 	if (opt->line_level_traverse)
 		return line_log_print(opt, commit);
@@ -883,5 +884,7 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		printf("\n%s\n", opt->break_bar);
 	opt->loginfo = NULL;
 	maybe_flush_or_die(stdout, "stdout");
+	if (close_file)
+		fclose(opt->diffopt.file);
 	return shown;
 }
-- 
2.9.0.118.g0e1a633


