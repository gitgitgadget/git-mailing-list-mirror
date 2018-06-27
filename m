Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF9A1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 15:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965572AbeF0Ps2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 11:48:28 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:43888 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965516AbeF0PsY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 11:48:24 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RFhCcl023591;
        Wed, 27 Jun 2018 08:48:07 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ju94mu3w3-1;
        Wed, 27 Jun 2018 08:48:07 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 7AB0A22378E2;
        Wed, 27 Jun 2018 08:48:07 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 6FBE02CDE86;
        Wed, 27 Jun 2018 08:48:07 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 2/2] Fix use of strategy options with interactive rebases
Date:   Wed, 27 Jun 2018 08:48:04 -0700
Message-Id: <20180627154804.3743-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180627154804.3743-1-newren@gmail.com>
References: <20180627073623.31725-1-newren@gmail.com>
 <20180627154804.3743-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270170
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-rebase.sh wrote strategy options to .git/rebase/merge/strategy_opts
in the following format:
  '--ours'  '--renormalize'
Note the double spaces.

git-rebase--interactive uses sequencer.c to parse that file, and
sequencer.c used split_cmdline() to get the individual strategy options.
After splitting, sequencer.c prefixed each "option" with a double dash,
so, concatenating all its options would result in:
  -- --ours -- --renormalize

So, when it ended up calling try_merge_strategy(), that in turn would run
  git merge-$strategy -- --ours -- --renormalize $merge_base -- $head $remote

instead of the expected/desired
  git merge-$strategy --ours --renormalize $merge_base -- $head $remote

Remove the extra spaces so that when it goes through split_cmdline() we end
up with the desired command line.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-rebase.sh              | 2 +-
 sequencer.c                | 7 ++++++-
 t/t3418-rebase-continue.sh | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 19bdebb480..f3b10c7f62 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -328,7 +328,7 @@ do
 		do_merge=t
 		;;
 	--strategy-option=*)
-		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--${1#--strategy-option=}")"
+		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--${1#--strategy-option=}" | sed -e s/^.//)"
 		do_merge=t
 		test -z "$strategy" && strategy=recursive
 		;;
diff --git a/sequencer.c b/sequencer.c
index 5354d4d51e..ef9237c814 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2206,6 +2206,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 {
 	int i;
+	char *strategy_opts_string;
 
 	strbuf_reset(buf);
 	if (!read_oneliner(buf, rebase_path_strategy(), 0))
@@ -2214,7 +2215,11 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
 		return;
 
-	opts->xopts_nr = split_cmdline(buf->buf, (const char ***)&opts->xopts);
+	strategy_opts_string = buf->buf;
+	if (*strategy_opts_string == ' ')
+		strategy_opts_string++;
+	opts->xopts_nr = split_cmdline(strategy_opts_string,
+				       (const char ***)&opts->xopts);
 	for (i = 0; i < opts->xopts_nr; i++) {
 		const char *arg = opts->xopts[i];
 
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 11546d6e14..c145dbac38 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -74,7 +74,7 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test -f funny.was.run
 '
 
-test_expect_failure 'rebase -i --continue handles merge strategy and options' '
+test_expect_success 'rebase -i --continue handles merge strategy and options' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F2-on-topic-branch &&
 	test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
-- 
2.18.0.9.g431b2c36d5

