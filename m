Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 530041F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 10:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeCTKDe (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 06:03:34 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:20217 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbeCTKD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 06:03:27 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yE6xeoWARwheayE74epmBE; Tue, 20 Mar 2018 10:03:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521540206;
        bh=7jtPyGAsuAJzgBejONAyH7F6W9E2Qubt9ptfP2WRqFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=lHgdA64VZABV8A4BvJkzgp1OBcVnQlaeBcvLgA+0zi1D6fG2l8QJjx3q/vS7rF3Hx
         aUrAlKVRG7xDfnsJfKBIVbXYsX73zQB7wM+mxuJJnOcdiFGdkxGZDH4XwdU3DfpYyg
         ONfc6yyLu+xRt5MyTpR+CC6CpeDUZagGmYHTsrVc=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=AY_qUPc9FH1NDX_s4xAA:9
 a=KyAYxXx2a9WEbE37:21 a=RfpIGNdEWSzI4p6e:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/3] rebase -i --keep-empty: don't prune empty commits
Date:   Tue, 20 Mar 2018 10:03:14 +0000
Message-Id: <20180320100315.15261-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320100315.15261-1-phillip.wood@talktalk.net>
References: <20180320100315.15261-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfFipN0lfhBOo3glaR57Fn9rZpeA3R79sBGkG4TXW4Wn2CejklkCWRaLXjp7Jg74lOHMxaJ/ya8lM46lJ/1xh7WZV7kOG/AjG3SylN0gu717Cim3zcl5I
 eaqgeiB6+5aBFAPlDePluECndGLFElMJG6I7IXxupGdc3DYEQPZgWw3E+7hjrHPct3YGZC2p+BIc1py3y8EssMIi1Jv69XxePfzN+G/TojH6/TPPwlNNRFcZ
 eCKzH4hAChAVOvWT6T9Ni7Shi8o6Xt5Apsl8oAq2LVwI/TkHxykkgxJaVUMbOLq0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are empty commits on the left hand side of $upstream...HEAD
then the empty commits on the right hand side that we want to keep are
pruned by --cherry-pick. Fix this by using --cherry-mark instead of
--cherry-pick and keeping the commits that are empty or are not marked
as cherry-picks.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                       | 18 +++++++++++-------
 t/t3421-rebase-topology-linear.sh |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4d3f60594c..96ff812c8d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2470,7 +2470,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	init_revisions(&revs, NULL);
 	revs.verbose_header = 1;
 	revs.max_parents = 1;
-	revs.cherry_pick = 1;
+	revs.cherry_mark = 1;
 	revs.limited = 1;
 	revs.reverse = 1;
 	revs.right_only = 1;
@@ -2495,14 +2495,18 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 		return error(_("make_script: error preparing revisions"));
 
 	while ((commit = get_revision(&revs))) {
+		int is_empty  = is_original_commit_empty(commit);
+
 		strbuf_reset(&buf);
-		if (!keep_empty && is_original_commit_empty(commit))
+		if (!keep_empty && is_empty)
 			strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, "%s %s ", insn,
-			    oid_to_hex(&commit->object.oid));
-		pretty_print_commit(&pp, commit, &buf);
-		strbuf_addch(&buf, '\n');
-		fputs(buf.buf, out);
+		if (is_empty || !(commit->object.flags & PATCHSAME)) {
+			strbuf_addf(&buf, "%s %s ", insn,
+				    oid_to_hex(&commit->object.oid));
+			pretty_print_commit(&pp, commit, &buf);
+			strbuf_addch(&buf, '\n');
+			fputs(buf.buf, out);
+		}
 	}
 	strbuf_release(&buf);
 	return 0;
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 68fe2003ef..52fc6885e5 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -215,7 +215,7 @@ test_run_rebase () {
 }
 test_run_rebase success ''
 test_run_rebase failure -m
-test_run_rebase failure -i
+test_run_rebase success -i
 test_run_rebase failure -p
 
 #       m
-- 
2.16.2

