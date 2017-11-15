Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6259202A0
	for <e@80x24.org>; Wed, 15 Nov 2017 10:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbdKOKlx (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 05:41:53 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:56702 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757302AbdKOKlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 05:41:51 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id Ev8Ye2oFbAp17Ev8eeU638; Wed, 15 Nov 2017 10:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510742509;
        bh=1XHp28XmMw6UCi44WDoFVYVW7L+w0QR3BfXBi5QzCRI=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=ZCE1pXn4oTBmRBi4mKFUwSjv3uXxqXqLj3bcXyX7vscUeq6bmitNi4F6FZ3wDar1W
         0i3hA4D6VfF/AbDH+SnZ8Zya5HbRQ0fngE8cotGfwpSvMpULbEqGktobqpw6SAICoS
         vYMYB7q+BBBzo2XhSzg5ZctCN0WL/DCPk6HKSNqw=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=evINK-nbAAAA:8 a=6OKZUBrC7mN1K_v3ApQA:9
 a=p4C4o649-LDtgnF9:21 a=jcQZlxrdbTxSS9eC:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] sequencer: reschedule pick if index can't be locked
Date:   Wed, 15 Nov 2017 10:41:25 +0000
Message-Id: <20171115104125.1686-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGl44xPplNAs9Vp2GwHkxWZv77pScsnVC63inDz/ssv0VC5JJTxadmWh5/URHB0eA6fc0z2w5YpHs6Dt5ngeBTKgIkAI9bejkja6Mf1YEBkgNLjJVA34
 fi1OflKoHlkeR8Gr9wKMK+EcvFQIlc4+1QCi/ivjIRXzBf9nWUmXabddkXZcJ6u0W9jlEgIk+q4hCzM8nlHfl91/M5lQoNTFfN6VMfyGD0FwZXJox+xJuHb1
 dZHhO/cIv1++WwFQHE5nl6Az6MK0yNQyh7OQ94QIZ5k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Return an error instead of dying if the index cannot be locked in
do_recursive_merge() as if the commit cannot be picked it needs to be
rescheduled when performing an interactive rebase. If the pick is not
rescheduled and the user runs 'git rebase --continue' rather than 'git
rebase --abort' then the commit gets silently dropped.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 6d027b06c8d8dc69b14d05752637a65aa121ab24..8c10442b84068d3fb7ec809ef1faa0203cb83e60 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -438,7 +438,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	char **xopt;
 	static struct lock_file index_lock;
 
-	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR))
+		return -1;
 
 	read_cache();
 
-- 
2.15.0

