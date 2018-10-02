Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5731F453
	for <e@80x24.org>; Tue,  2 Oct 2018 17:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeJCAkL (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 20:40:11 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:9532 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeJCAkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 20:40:11 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 7OtMgc0MNVlGZ7OtTgNKnt; Tue, 02 Oct 2018 18:55:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538502936;
        bh=5zAfwI85mKH1DQVg46djY86Rm2IFkR5AsFrC/Re7aLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=WZSnPVkd67Z206xGm2AMHye/55wgkfY/IwRK2gQKIm9wHB4M/TGqOUK/Jln6U3tLq
         Pd/reo9yEzRBiFqF5tZQcJR0H6RrWEhGc4abzNoL7PxzobQJPqwgZTUVZvcFNOqAZS
         zKndxhZAZNbDm7ZOn1d7rm+mQpts9V7mCBhoUmE0=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=EaTrdlfBmmo0FKB1FiUA:9
 a=CgHqBV2zeH8inHE3:21 a=9uuab78wC2ypK9ax:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/5] diff --color-moved-ws: fix a memory leak
Date:   Tue,  2 Oct 2018 18:55:12 +0100
Message-Id: <20181002175514.31495-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002175514.31495-1-phillip.wood@talktalk.net>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFMBIxGeQbHF1R5SaElQS4Sbh0TL5VhT8X9MtReA7c4mU4pTQXiJjUK1BEk/33ZUFV9znylhkUV3QufOzLVVahoFvlqFArhOww2wT87/eC7Z7DYYtgOa
 KBbnyzBuxv6CvT8zaQaByqXfqkmsgf4zgQ0n7PPZ1GwqY3tN7D0q9NwdpRviuUODf7lP7PPczhVwn/YLlB7KefMnBbqEOjXZ/zvUMqAPW1SCNRYomkE5gVqM
 /x6FG/HdzaER83bGgQnaP5AH5TUL3GU8PMqPMPEtJYAeS96bgrioloSQrtXtSVDm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Don't duplicate the indentation string if we're not going to use it.
This was found with asan.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 0096bdc339..efadd05c90 100644
--- a/diff.c
+++ b/diff.c
@@ -785,11 +785,15 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 	const struct emitted_diff_symbol *longer =  a->len > b->len ? a : b;
 	const struct emitted_diff_symbol *shorter = a->len > b->len ? b : a;
 	int d = longer->len - shorter->len;
+	int ret = !strncmp(longer->line + d, shorter->line, shorter->len);
+
+	if (!ret)
+		return ret;
 
 	out->string = xmemdupz(longer->line, d);
 	out->current_longer = (a == longer);
 
-	return !strncmp(longer->line + d, shorter->line, shorter->len);
+	return ret;
 }
 
 static int cmp_in_block_with_wsd(const struct diff_options *o,
-- 
2.19.0

