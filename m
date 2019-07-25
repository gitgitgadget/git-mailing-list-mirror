Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E981F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403775AbfGYRqU (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33387 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403772AbfGYRqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id f20so14164710pgj.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKVdqZBVeolsqbTMGNVVXf+1QOe7THcdY8lkghiPKf4=;
        b=nKUdw4Z0Z+g6AizO8q0jfT7YupuNTjKpmonYevtam7UHas7HgKYWTh9lH20L/wL97K
         SxDqCd5/V6e71b9MUMej4574JwAo0wNm9ot2ursV6gnNVbg6KF/pWsfSHasrTYwXd2WL
         AN9/cLAvraTBRuiMoBTv4ARSTaH1aPF0ZirOb8mhJnnkqmidy8qnTLkf9P8IB6IYaW8n
         zSb/rTt9N2zN236mSxyaYCCIN/Qi8jNA5SnfLLsnOSGgE2ylpyefdElgosC9Ql02q0r2
         uUwmtXovYTQU9Z0bYeXJtgn9T/aua4JI5Z9De/sQqbunA06Q1HeJP7+SjXhLimhTLNG6
         XpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKVdqZBVeolsqbTMGNVVXf+1QOe7THcdY8lkghiPKf4=;
        b=RdYQT72/olxXKO6xCS3Baz+1F8G0urKbdcwCD4Ax8kSheEtTBhVTK11+bHkOdz6FTW
         u0Gb0KQ9cIdxKpAO9f4IG9LaKA+ybrTIhre6jyxuJXJ5XaTXvpQGkE2dH8riwj3JmjWS
         JdhDqwkdZsBqZBzXjNB0Nzk2y+AK+8cXeDU/lUwA1PAGQD6rCUj31xeShG2YE6L8hMUu
         4gKAAvszAlB2FIyIwA3QQdWjiKezWPTKMbRc7wH715VWxUtZq3Uebl4O4Pj+cbghErjP
         i7d59CMnLbyS8eSSucv70l0mdqs8Icdzu38+eAFZRctiEQoe8hj7Ai+JCeVEEyjcpFu0
         xHxg==
X-Gm-Message-State: APjAAAVZGNa6DJAnCo8A/COsl5U5uxceF6Lz8I6Pm/ADT4fdQhsGz8FJ
        h1de2DWEWyffiZCvgJXwjJHDXG28
X-Google-Smtp-Source: APXvYqxs8EsUSdPHunudId0bWkDl0hMaen0ybAkJISLVoJ4KnMuf1uvynfSgmCUGchqo7DtfjJkLiA==
X-Received: by 2002:a63:8f16:: with SMTP id n22mr16891930pgd.306.1564076778355;
        Thu, 25 Jul 2019 10:46:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:17 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 01/19] merge-recursive: fix minor memory leak in error condition
Date:   Thu, 25 Jul 2019 10:45:53 -0700
Message-Id: <20190725174611.14802-2-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Returning before freeing the allocated buffer is suboptimal; as with
elsewhere in the same function, make sure buf gets free'd.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 12300131fc..1163508811 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -934,9 +934,11 @@ static int update_file_flags(struct merge_options *opt,
 		}
 
 		buf = read_object_file(&contents->oid, &type, &size);
-		if (!buf)
-			return err(opt, _("cannot read object %s '%s'"),
-				   oid_to_hex(&contents->oid), path);
+		if (!buf) {
+			ret = err(opt, _("cannot read object %s '%s'"),
+				  oid_to_hex(&contents->oid), path);
+			goto free_buf;
+		}
 		if (type != OBJ_BLOB) {
 			ret = err(opt, _("blob expected for %s '%s'"),
 				  oid_to_hex(&contents->oid), path);
-- 
2.22.0.559.g28a8880890.dirty

