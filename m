Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA51C20A26
	for <e@80x24.org>; Fri, 22 Sep 2017 23:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbdIVXfY (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 19:35:24 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33544 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdIVXfX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 19:35:23 -0400
Received: by mail-wr0-f196.google.com with SMTP id b9so1323841wra.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qgEk6LWZX2WYFlD62ALE3xs0KE2gyPDR918yT+HvI0=;
        b=iqR8/yDpRk2QPSyX7HCW+KVzF5s0iftSCmdZ8RIbWedMUu/9RuzBuQRzptLP9twSzm
         d9SYxVbTPrW1FG1vFU5eanik/83UqWCs5YQ0UXdHpDSJXV5qbqREriyzeyC2jwwI5voo
         luV2OKDbTFix66RgFlOO4yi4YL0exR0kzwVlGckF3ZAr0P0pNU1NwV+A+XBZqgj6xiHb
         3Siqh0c+0YpXc4aMva0erft08Mg91dUD4gvTjAjsqSdIcLgHMV+g31QrRoNV0TbKg29s
         tMe0zHEY4lR9kS2BhjaO/KY6ml9DTwXFgCh+M9o+UmHUsdnvfE3dCwyn3CQO+eRYGtzj
         zpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qgEk6LWZX2WYFlD62ALE3xs0KE2gyPDR918yT+HvI0=;
        b=L82vtiyQmQrX5J2l/q9p1Z54l6Q8EBxhWrC796WoE7OZwRvgQBYwAy9ZFGpPjQqKpV
         qygLk3Aq4OTh+p/DitEclXYxAyVbfXMfY/L3U7LlHguqgWYElp3HIVB14OIGxwBl+hC8
         6A5QMXWAUhIzjBMYn9VCbzNHjZJNjnuyxT8A9N/yYRhr0NGsCddMmz9jRrdj59Uln10h
         S34sby3F9i5pCAZnI2emzQ7JVjIoaMp1Ldp9WZblrVTlC/YPzHZJyLm7sKkMGEMnnDlX
         1RoM89+oEZYKk2WpJTQ4LZoDbYF67kwf9YU0nArcamDxRuPtNs5NWvENaxylmf6lLbns
         dAHA==
X-Gm-Message-State: AHPjjUi4vIwk3L0yUFHkGcxG3Nf4ZA3jS8HT8DL6S5m9W0L/GGcOvv1X
        vduHUC6qcgILN75AcLO0YMPXqA==
X-Google-Smtp-Source: AOwi7QA5V2VUQpIX4RGgkFkmJMAPrSUO4XQDu6/U299LB5Zjzog90RVirQsjM/CmqBLPXOTNsAsuhg==
X-Received: by 10.223.161.137 with SMTP id u9mr552430wru.280.1506123322386;
        Fri, 22 Sep 2017 16:35:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id e77sm2071333wmf.27.2017.09.22.16.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 16:35:21 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 2/6] commit: fix memory leak in `reduce_heads()`
Date:   Sat, 23 Sep 2017 01:34:50 +0200
Message-Id: <75117f05084a342ec5dd53d613cfaf2fbfb13054.1506120292.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506120291.git.martin.agren@gmail.com>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net> <cover.1506120291.git.martin.agren@gmail.com>
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
Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/commit.c b/commit.c
index d3150d627..f73976bcc 100644
--- a/commit.c
+++ b/commit.c
@@ -1080,6 +1080,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	num_head = remove_redundant(array, num_head);
 	for (i = 0; i < num_head; i++)
 		tail = &commit_list_insert(array[i], tail)->next;
+	free(array);
 	return result;
 }
 
-- 
2.14.1.727.g9ddaf86

