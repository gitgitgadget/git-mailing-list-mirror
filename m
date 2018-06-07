Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DC41F403
	for <e@80x24.org>; Thu,  7 Jun 2018 17:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933273AbeFGRNy (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 13:13:54 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44634 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932409AbeFGRNx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jun 2018 13:13:53 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57H94Jw032535;
        Thu, 7 Jun 2018 10:13:47 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbs3gheku-1;
        Thu, 07 Jun 2018 10:13:47 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 30F2422BCF81;
        Thu,  7 Jun 2018 10:13:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 287D62CDE86;
        Thu,  7 Jun 2018 10:13:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        alban.gruin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 1/3] git-rebase, sequencer: add a --quiet option for the interactive machinery
Date:   Thu,  7 Jun 2018 10:13:42 -0700
Message-Id: <20180607171344.23331-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.13.ge6eabe3ad6
In-Reply-To: <20180607171344.23331-1-newren@gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607171344.23331-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070188
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While 'quiet' and 'interactive' may sound like antonyms, the interactive
machinery actually has logic that implements several
interactive_rebase=implied cases (--exec, --keep-empty, --rebase-merges)
which won't pop up an editor.  Further, we want to make the interactive
machinery also take over for git-rebase--merge and become the default
merge strategy, so it makes sense for these other cases to have a quiet
option.

git-rebase--interactive was already somewhat quieter than
git-rebase--merge and git-rebase--am, possibly because cherry-pick has
just traditionally been quieter.  As such, we only drop a few
informational messages -- "Rebasing (n/m)" and "Succesfully rebased..."

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-rebase--interactive.sh |  9 +++++++--
 git-rebase.sh              |  2 +-
 sequencer.c                | 19 +++++++++++++------
 sequencer.h                |  1 +
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 06a7b79307..1f2401f702 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -139,8 +139,12 @@ mark_action_done () {
 	if test "$last_count" != "$new_count"
 	then
 		last_count=$new_count
-		eval_gettext "Rebasing (\$new_count/\$total)"; printf "\r"
-		test -z "$verbose" || echo
+		if test -z "$GIT_QUIET"
+		then
+			eval_gettext "Rebasing (\$new_count/\$total)";
+			printf "\r"
+			test -z "$verbose" || echo
+		fi
 	fi
 }
 
@@ -713,6 +717,7 @@ Commit or stash your changes, and then run
 		"$hook" rebase < "$rewritten_list"
 		true # we don't care if this hook failed
 	fi &&
+		test -z "$GIT_QUIET" &&
 		warn "$(eval_gettext "Successfully rebased and updated \$head_name.")"
 
 	return 1 # not failure; just to break the do_rest loop
diff --git a/git-rebase.sh b/git-rebase.sh
index 7d1612b31b..b639c0d4fe 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -136,7 +136,7 @@ write_basic_state () {
 	echo "$head_name" > "$state_dir"/head-name &&
 	echo "$onto" > "$state_dir"/onto &&
 	echo "$orig_head" > "$state_dir"/orig-head &&
-	echo "$GIT_QUIET" > "$state_dir"/quiet &&
+	test t = "$GIT_QUIET" && : > "$state_dir"/quiet
 	test t = "$verbose" && : > "$state_dir"/verbose
 	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
 	test -n "$strategy_opts" && echo "$strategy_opts" > \
diff --git a/sequencer.c b/sequencer.c
index a2843e3906..d418d40bee 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -143,6 +143,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
+static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
 static GIT_PATH_FUNC(rebase_path_signoff, "rebase-merge/signoff")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
@@ -2251,6 +2252,9 @@ static int read_populate_opts(struct replay_opts *opts)
 		if (file_exists(rebase_path_verbose()))
 			opts->verbose = 1;
 
+		if (file_exists(rebase_path_quiet()))
+			opts->quiet = 1;
+
 		if (file_exists(rebase_path_signoff())) {
 			opts->allow_ff = 0;
 			opts->signoff = 1;
@@ -3171,10 +3175,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					fprintf(f, "%d\n", todo_list->done_nr);
 					fclose(f);
 				}
-				fprintf(stderr, "Rebasing (%d/%d)%s",
-					todo_list->done_nr,
-					todo_list->total_nr,
-					opts->verbose ? "\n" : "\r");
+				if (!opts->quiet)
+					fprintf(stderr, "Rebasing (%d/%d)%s",
+						todo_list->done_nr,
+						todo_list->total_nr,
+						opts->verbose ? "\n" : "\r");
 			}
 			unlink(rebase_path_message());
 			unlink(rebase_path_author_script());
@@ -3385,8 +3390,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		}
 		apply_autostash(opts);
 
-		fprintf(stderr, "Successfully rebased and updated %s.\n",
-			head_ref.buf);
+		if (!opts->quiet)
+			fprintf(stderr,
+				"Successfully rebased and updated %s.\n",
+				head_ref.buf);
 
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
diff --git a/sequencer.h b/sequencer.h
index c5787c6b56..da652a421f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -33,6 +33,7 @@ struct replay_opts {
 	int allow_empty_message;
 	int keep_redundant_commits;
 	int verbose;
+	int quiet;
 
 	int mainline;
 
-- 
2.18.0.rc1.12.g2996b9442d

