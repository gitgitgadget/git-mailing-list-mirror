Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FE41F453
	for <e@80x24.org>; Tue,  2 Oct 2018 17:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeJCAkN (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 20:40:13 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:33180 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeJCAkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 20:40:11 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 7OtMgc0MNVlGZ7OtVgNKo9; Tue, 02 Oct 2018 18:55:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538502938;
        bh=/YwCUiVIhkqSHYvr4PxPqGr1p+0w8pLg+zti1Shu29w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=RzOqRNc++Xv3VXfPmpX9CIol8fS5mfa3X7j8FnWcaMkFJ0AupPePiGih/Hj8MB5iG
         YNZWfCmeEGqojyudWODmaLYJctikWEMIOzloSC7XZa0JDyQ1T1qvK7zXvmXqOhubJz
         1DVA/4y9lNT5pDAJAZrFnkC11b6e5MfCbjW5gO0Y=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=FVCVqbMd_-HzSxj5j7YA:9
 a=Vm1BYxNBd15DAg0M:21 a=xFJIqMZrjgypuhHE:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 5/5] diff --color-moved: fix a memory leak
Date:   Tue,  2 Oct 2018 18:55:14 +0100
Message-Id: <20181002175514.31495-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002175514.31495-1-phillip.wood@talktalk.net>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMYzgtMvpplU7/Oycl6R9aNNCniRpDaNLAAhEprwuX7Gav6sj6CaR5XY97S/egWDs3R4cR8xu8c3YAyLKP+PXHwSxmc3S+yogqEhS8wgDzw7oK8XJkSK
 4+ke2PUJqPOjmyoQPkRGryWZtix29uAujZThlfs3lvowebxsM9uyYbtYXZ/eohNwFg5iml/nEzJdlNcohiX62erfer4bsuLsplN6OLrgUCQ77FWhIRQdCW6G
 BYsdMQmyeiByS59Hwjxrw8evVog1rNaP7xTBvW2CHUkJaU5LshSkJjOWVqUHvn6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Free the hashmap items as well as the hashmap itself. This was found
with asan.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 4464feacf8..94cc1b5592 100644
--- a/diff.c
+++ b/diff.c
@@ -5770,8 +5770,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
 				dim_moved_lines(o);
 
-			hashmap_free(&add_lines, 0);
-			hashmap_free(&del_lines, 0);
+			hashmap_free(&add_lines, 1);
+			hashmap_free(&del_lines, 1);
 		}
 
 		for (i = 0; i < esm.nr; i++)
-- 
2.19.0

