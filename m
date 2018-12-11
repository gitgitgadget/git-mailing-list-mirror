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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9DF20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 16:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbeLKQLy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 11:11:54 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48352 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729651AbeLKQLw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Dec 2018 11:11:52 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBG8x7T000918;
        Tue, 11 Dec 2018 08:11:44 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2p8cpp3qxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Dec 2018 08:11:43 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 11 Dec 2018 08:11:40 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 11 Dec 2018 08:11:41 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 24FB4220EE10;
        Tue, 11 Dec 2018 08:11:42 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <Johannes.Schindelin@gmx.de>,
        <predatoramigo@gmail.com>, <phillip.wood@talktalk.net>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 4/8] am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
Date:   Tue, 11 Dec 2018 08:11:35 -0800
Message-ID: <20181211161139.31686-5-newren@gmail.com>
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
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110146
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The post-rewrite hook is supposed to be invoked for each rewritten
commit.  The fact that a commit was selected and processed by the rebase
operation (even though when we hit an error a user said it had no more
useful changes), suggests we should write an entry for it.  In
particular, let's treat it as an empty commit trivially squashed into
its parent.

This brings the rebase--am and rebase--merge backends in sync with the
behavior of the interactive rebase backend.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c                 | 9 +++++++++
 git-rebase--merge.sh         | 2 ++
 t/t5407-post-rewrite-hook.sh | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 8f27f3375b..af9d034838 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2000,6 +2000,15 @@ static void am_skip(struct am_state *state)
 	if (clean_index(&head, &head))
 		die(_("failed to clean index"));
 
+	if (state->rebasing) {
+		FILE *fp = xfopen(am_path(state, "rewritten"), "a");
+
+		assert(!is_null_oid(&state->orig_commit));
+		fprintf(fp, "%s ", oid_to_hex(&state->orig_commit));
+		fprintf(fp, "%s\n", oid_to_hex(&head));
+		fclose(fp);
+	}
+
 	am_next(state);
 	am_load(state);
 	am_run(state, 0);
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index aa2f2f0872..91250cbaed 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -121,6 +121,8 @@ continue)
 skip)
 	read_state
 	git rerere clear
+	cmt="$(cat "$state_dir/cmt.$msgnum")"
+	echo "$cmt $(git rev-parse HEAD^0)" >> "$state_dir/rewritten"
 	msgnum=$(($msgnum + 1))
 	while test "$msgnum" -le "$end"
 	do
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 6426ec8991..a4a5903cba 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -78,6 +78,7 @@ test_expect_success 'git rebase --skip' '
 	git rebase --continue &&
 	echo rebase >expected.args &&
 	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD^)
 	$(git rev-parse D) $(git rev-parse HEAD)
 	EOF
 	verify_hook_input
@@ -91,6 +92,7 @@ test_expect_success 'git rebase --skip the last one' '
 	echo rebase >expected.args &&
 	cat >expected.data <<-EOF &&
 	$(git rev-parse E) $(git rev-parse HEAD)
+	$(git rev-parse F) $(git rev-parse HEAD)
 	EOF
 	verify_hook_input
 '
@@ -120,6 +122,7 @@ test_expect_success 'git rebase -m --skip' '
 	git rebase --continue &&
 	echo rebase >expected.args &&
 	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD^)
 	$(git rev-parse D) $(git rev-parse HEAD)
 	EOF
 	verify_hook_input
-- 
2.20.0.8.g5de428d695

