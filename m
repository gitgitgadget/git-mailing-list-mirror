Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2331FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbcHWQN5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:13:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:65354 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbcHWQN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:13:56 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LwrwO-1b5Fvz0Y5w-016NLP; Tue, 23 Aug 2016 18:07:19
 +0200
Date:   Tue, 23 Aug 2016 18:07:18 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/15] sequencer: lib'ify walk_revs_populate_todo()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <fc1bc9ae5aeb315813d35701e19928cfe52557e3.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sJ2H5Ati9l4cZt4ie27I9G9aPhHpyV7p1MqhL84Dl0J+XazjE7O
 sOAcqvCzTB1+MzeyJST5PfICVLsEOAElFZEHxM/73RPhuiGCCc+Mm1c3q8oBnytWIYsG63U
 x45COr06ccsmIgGovQCvc5fYscVHxz2IvshxDYEj/i+c7U1LKtRIM4o6gbdebb3I/RGekPD
 79YEmzyBaC359PdML9GIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VGQVV66JxM8=:oPgkzPYs/kkZnPUwABROVV
 U/Fc/yIsFCfD19LY67bgTxqah2dPS8SvIBFxvNHKgyLwUXywVMUBoAjKyTkqyFqusRdjRxs/L
 60mPlwMyi4Pp2vpwQoHZOxl+3+872ZezpW77yXI9ICreZj5rRQKXThov/7xmRV0HG0uD82v8O
 EcyOiUzGtkr7xi+ltUC7asGbornoBKXV7rue4gDkdNqmp5HVaeMbag7J0D/8QA6IXmcPmIWEt
 0fZSihU3DvXfB6N+nYcoOWy63e00KSDWhQPK75xs+ZsBEZIa0QyjXMESEguiYJIFnjiQnMRz+
 gE8BgfK9bBhtWud9kv/myA9HJqxGOsovwHavXNLbdlTBbjmVqAqe/R5uhPhJBa8f5TpE7X7Ar
 gtnDBi409N404/xd1hOmGgXKCeT0m4rvw/UkZkRd4FqLY2TYNcA09MkVVhrYZJZRBOfUnv3ql
 gaJ6WenI6J8c6Zyk4kntJRq+HOtGF5shUpi7R48uybo+ry3YsRgwqCf8k5ifdYTJpPUU//V1x
 kosxn0S3+abT0UBUPcP901+5OLtI1hp8qhWiGH63F3zYilZTFyKPpoUlW7FhTYHlnwytcxr9j
 qSTH3daER5IiVRoVaCLS/XNvm3ew4nmvt17qDZHcopgpfJhnikcRS9YjZ5BgLSEQoaAvfuhwn
 G6wMor4jYvXhZFGe0/3wdqtCvoy8copnS8PYDxZ/I4n8UIK0g0hAGaHB6t/CDCOGYezBujWHI
 peYG0dVFmXzQglLBZpDo+/lqFzRpBmpqrzeCUgKjr3jRPMsO42FBpmyroM9pBo3raeISAfGTv
 HeuPGZf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 808cd53..1bcea84 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -816,17 +816,19 @@ static int read_populate_opts(struct replay_opts **opts)
 	return 0;
 }
 
-static void walk_revs_populate_todo(struct commit_list **todo_list,
+static int walk_revs_populate_todo(struct commit_list **todo_list,
 				struct replay_opts *opts)
 {
 	struct commit *commit;
 	struct commit_list **next;
 
-	prepare_revs(opts);
+	if (prepare_revs(opts))
+		return -1;
 
 	next = todo_list;
 	while ((commit = get_revision(opts->revs)))
 		next = commit_list_append(commit, next);
+	return 0;
 }
 
 static int create_seq_dir(void)
@@ -1111,8 +1113,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	 * progress
 	 */
 
-	walk_revs_populate_todo(&todo_list, opts);
-	if (create_seq_dir() < 0)
+	if (walk_revs_populate_todo(&todo_list, opts) ||
+			create_seq_dir() < 0)
 		return -1;
 	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
 		return error(_("Can't revert as initial commit"));
-- 
2.10.0.rc1.99.gcd66998


