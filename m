Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24AC120A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 16:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeLKQL7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 11:11:59 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48398 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729653AbeLKQL5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Dec 2018 11:11:57 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBG8wKU000913;
        Tue, 11 Dec 2018 08:11:50 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2p8cpp3qxq-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Dec 2018 08:11:48 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 11 Dec 2018 08:11:42 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 11 Dec 2018 08:11:42 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 34131220F5FF;
        Tue, 11 Dec 2018 08:11:42 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <Johannes.Schindelin@gmx.de>,
        <predatoramigo@gmail.com>, <phillip.wood@talktalk.net>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 5/8] git-rebase, sequencer: extend --quiet option for the interactive machinery
Date:   Tue, 11 Dec 2018 08:11:36 -0800
Message-ID: <20181211161139.31686-6-newren@gmail.com>
X-Mailer: git-send-email 2.20.0.8.g5de428d695
In-Reply-To: <20181211161139.31686-1-newren@gmail.com>
References: <20181122044841.20993-1-newren@gmail.com>
 <20181211161139.31686-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110146
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While 'quiet' and 'interactive' may sound like antonyms, the interactive
machinery actually has logic that implements several
interactive_rebase=implied cases (--exec, --keep-empty, --rebase-merges)
which won't pop up an editor.  The rewrite of interactive rebase in C
added a quiet option, though it only turns stats off.  Since we want to
make the interactive machinery also take over for git-rebase--merge, it
should fully implement the --quiet option.

git-rebase--interactive was already somewhat quieter than
git-rebase--merge and git-rebase--am, possibly because cherry-pick has
just traditionally been quieter.  As such, we only drop a few
informational messages -- "Rebasing (n/m)" and "Successfully rebased..."

Also, for simplicity, remove the differences in how quiet and verbose
options were recorded.  Having one be signalled by the presence of a
"verbose" file in the state_dir, while the other was signalled by the
contents of a "quiet" file was just weirdly inconsistent.  (This
inconsistency pre-dated the rewrite into C.)  Make them consistent by
having them both key off the presence of the file.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c      |  5 +----
 git-legacy-rebase.sh  |  2 +-
 git-rebase--common.sh |  2 +-
 sequencer.c           | 23 +++++++++++++----------
 sequencer.h           |  1 +
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 78e982298f..ec2e5fbf23 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -185,10 +185,7 @@ static int read_basic_state(struct rebase_options *opts)
 	if (get_oid(buf.buf, &opts->orig_head))
 		return error(_("invalid orig-head: '%s'"), buf.buf);
 
-	strbuf_reset(&buf);
-	if (read_one(state_dir_path("quiet", opts), &buf))
-		return -1;
-	if (buf.len)
+	if (file_exists(state_dir_path("quiet", opts)))
 		opts->flags &= ~REBASE_NO_QUIET;
 	else
 		opts->flags |= REBASE_NO_QUIET;
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index fccb33b959..f4088b7bda 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -113,7 +113,7 @@ read_basic_state () {
 	else
 		orig_head=$(cat "$state_dir"/head)
 	fi &&
-	GIT_QUIET=$(cat "$state_dir"/quiet) &&
+	test -f "$state_dir"/quiet && GIT_QUIET=t
 	test -f "$state_dir"/verbose && verbose=t
 	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
 	test -f "$state_dir"/strategy_opts &&
diff --git a/git-rebase--common.sh b/git-rebase--common.sh
index 7e39d22871..dc18c682fa 100644
--- a/git-rebase--common.sh
+++ b/git-rebase--common.sh
@@ -10,7 +10,7 @@ write_basic_state () {
 	echo "$head_name" > "$state_dir"/head-name &&
 	echo "$onto" > "$state_dir"/onto &&
 	echo "$orig_head" > "$state_dir"/orig-head &&
-	echo "$GIT_QUIET" > "$state_dir"/quiet &&
+	test t = "$GIT_QUIET" && : > "$state_dir"/quiet
 	test t = "$verbose" && : > "$state_dir"/verbose
 	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
 	test -n "$strategy_opts" && echo "$strategy_opts" > \
diff --git a/sequencer.c b/sequencer.c
index e1a4dd15f1..bc25615050 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -150,6 +150,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
+static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
 static GIT_PATH_FUNC(rebase_path_signoff, "rebase-merge/signoff")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
@@ -157,7 +158,6 @@ static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
 static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
-static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
 
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
@@ -2357,6 +2357,9 @@ static int read_populate_opts(struct replay_opts *opts)
 		if (file_exists(rebase_path_verbose()))
 			opts->verbose = 1;
 
+		if (file_exists(rebase_path_quiet()))
+			opts->quiet = 1;
+
 		if (file_exists(rebase_path_signoff())) {
 			opts->allow_ff = 0;
 			opts->signoff = 1;
@@ -2424,9 +2427,6 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 
 	if (quiet)
 		write_file(rebase_path_quiet(), "%s\n", quiet);
-	else
-		write_file(rebase_path_quiet(), "\n");
-
 	if (opts->verbose)
 		write_file(rebase_path_verbose(), "%s", "");
 	if (opts->strategy)
@@ -3503,10 +3503,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
@@ -3738,8 +3739,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
index 5071a73563..729222b583 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -39,6 +39,7 @@ struct replay_opts {
 	int allow_empty_message;
 	int keep_redundant_commits;
 	int verbose;
+	int quiet;
 
 	int mainline;
 
-- 
2.20.0.8.g5de428d695

