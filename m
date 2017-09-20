Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83D9620A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 19:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbdITTsR (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 15:48:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34845 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbdITTsR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 15:48:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id n64so2045530wrb.2
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 12:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D21EFppBTrKdgxE5yum9NovvJNC05QYnQFxWBLtkawk=;
        b=C0rJ1qjNJDHB+E6A7urxYmS9NjLdXt59sGGnR48SV6qWi9yNGu98Y9cPUiZQJ1FrnQ
         2kcVhd9CnIlEtq4zAjI7Q5pBb4YxxTzUha4t3fYO71NFYeFEHHaNdH09GyGjqZ84BuV2
         FUYj+smEkC1fMhHqst6CQg/HmLS5cJRwG4XvNX73wFTTLcu7ptM/ogYDqep5MsFht2v6
         KTKTeqpo+Ch8PWfBLax2eHxA3SUslWhHhqIbxn/u2/0I+ennGioDQiM6bdc02nnJ8QnG
         O+SQCs35INDlKlErMpRA4A8SmpTm9KLUrxSyJ3/W58Ch2EpZfZj3K7xJHbhOyjfqz84c
         fFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D21EFppBTrKdgxE5yum9NovvJNC05QYnQFxWBLtkawk=;
        b=Hz3r3O84Vz0mYjeSMIT2yXYXUHayGI5UaganWWX010UeF1SXKArSpO0aMSgX+cniQt
         nW+hSikWGc1tEJhUKqU8wB6MIvLghYOc0XR8o/v/xHDkORbEiRYEgKGGplT6X4bDObdV
         a+2u2t9groCJfSKDjOoIqW4qavomBoU7MPF10Bovy42l6lj4X2p8viTGqm5BG9uZXtnZ
         v3IWErIRCPK0NaQMyvpWuFDiPA1chMk1RACOzU/n7uVGWGB33k94nMKPyBDdND9+QRLM
         yR20aDix8nfW5H9NLvZRvKZGJotRlVnyHnkOmfSJ32fadQ5ThXnHCrjkK58FE5Lzm7s8
         HGQg==
X-Gm-Message-State: AHPjjUjIqjDZ2AaA94lPkF4Xb//8Rw2fD020L8rOmS2HpGyiVriffMRe
        2YTeyWlev+qsuZbue1TkjBl1heyv
X-Google-Smtp-Source: AOwi7QBhye1C/2mO/LtkHytTCg4muuZo6jQiV6erLSPkc52YrDALrEdPupmhCP0DsEzGsYz9q2scAQ==
X-Received: by 10.223.129.133 with SMTP id 5mr5679295wra.231.1505936895274;
        Wed, 20 Sep 2017 12:48:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t141sm2419652wme.33.2017.09.20.12.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 12:48:14 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] commit: fix memory leak in `reduce_heads()`
Date:   Wed, 20 Sep 2017 21:47:25 +0200
Message-Id: <1505936846-2195-3-git-send-email-martin.agren@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't free the temporary scratch space we use with
`remove_redundant()`. Free it similar to how we do it in
`get_merge_bases_many_0()`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/commit.c b/commit.c
index 9062980..1e0e633 100644
--- a/commit.c
+++ b/commit.c
@@ -1086,6 +1086,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	num_head = remove_redundant(array, num_head);
 	for (i = 0; i < num_head; i++)
 		tail = &commit_list_insert(array[i], tail)->next;
+	free(array);
 	return result;
 }
 
-- 
2.14.1

