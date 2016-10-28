Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D1C2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966145AbcJ1SzX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:23 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36836 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965206AbcJ1SzW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:22 -0400
Received: by mail-pf0-f176.google.com with SMTP id e6so41411311pfk.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DjHAB5KHAjEMnKjdzHff9fRdJNPBZUVKA1k3NdeMp20=;
        b=LpxUa0F+iu8vSAOfXzPa2u6ND7jsaZa1TB9N3bzEu8CGrJyEhKZSTLGLXoAAFLrLKG
         gI1kjtatjNalxSmC1mdpyrXKwAfKgDR1m2Xwg64b8x1+oJV7GItcspgobJRBIG5bmqVN
         0ankHVgWx63SRZFUTzet3+8ymk0KEhkcEwp8mnY3AIzQXwCh2VD1+pOADHu8zz2c0HYA
         HpbmLv/GTd2YY7uxj7Rw9yx/4FvbMeZDH3eNcKpW1Apao7BKJucAyNNrVXrmN6gj+mjf
         OzPRWUAofK9D9HRQ9Ab0ZORZSsJw4s8+PA03EGzxMyJ9DTrlhE0HiqmzqX6ogC+oJzuS
         4aDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DjHAB5KHAjEMnKjdzHff9fRdJNPBZUVKA1k3NdeMp20=;
        b=WpUcBXUBl7NyKNlzc9nou9BSqALjrmX1BV0MoAA8Xw1mIf5xZnDYTmOOicyEN77MwP
         mBaRoVpBp5dJ+wH0GGJTvN/zCLmL9MX8Z1b/KRg1FxnQSVcewf5hImBmqhjs1d+ODV6C
         zfC2nR8rjuxjE3Bg2adpNhubRoH8sCvUwl3/zmHi+KJ27RdQWRG73jiLOvIrNroG66Y9
         OkP9ad5QXqMBWELBx4uXm6YstlX/TwCI5zuH39IRlLtyZgFZYYV0yMRhTj+7o0iSsZc/
         pB/FH99Dw/czNE1tbG/Im0/m/Q0Fx4GYh8B3DDjYAf3BwH8x9JM/mW8RLet+BnvO8ehe
         qiFQ==
X-Gm-Message-State: ABUngvftdoLFWYJSZl0p/GceVnM/JY8IQ9stacS40LSoSTUm9AXEaekn12MgNsSOGYW/x7ls
X-Received: by 10.98.65.85 with SMTP id o82mr27548767pfa.168.1477680920771;
        Fri, 28 Oct 2016 11:55:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id e6sm20679849pad.0.2016.10.28.11.55.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 01/36] commit.c: use strchrnul() to scan for one line
Date:   Fri, 28 Oct 2016 11:54:27 -0700
Message-Id: <20161028185502.8789-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 856fd4aeef..41b2fdd335 100644
--- a/commit.c
+++ b/commit.c
@@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p = skip_blank_lines(p + 2);
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
+		eol = strchrnul(p, '\n');
 	} else
 		eol = p;
 
-- 
2.10.1.714.ge3da0db

