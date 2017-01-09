Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BA981FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 18:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423111AbdAISum (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 13:50:42 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36471 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423108AbdAISul (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 13:50:41 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so20269016pfu.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kjJX27PyTdCQUvHccfbiVozuU+jWYx97a4xB1lHsYPc=;
        b=uUGAs8nqFDl8gDd4I7+Hyb1UYcn0D/3dRxUp7YIcx9yXLjqUpX1rdvrUJppzEVSqD6
         cPSP8riiNK7WsycedJM+RUIrDWfvknA+w81BkUtQrH4ahgMChjW5aIE6ROZx1KiWbJCk
         WPWEr0bmqAXYvas/Wnmi0Fsjo1PWGdui340UWzNhQDfL0UnOSSoIQn8iHnX/OsDJRlBa
         GHlhZ3lNZzZmOMdPrL36AT7EsZXr4Y0X9TaJ6X/thrgjmdNKtpT1iwbjhy90Q117C6tW
         +PVVeYSAo/hJWEEB3xhDz/ozqg26Ypb99ha2iPnVbnXDiH/uE5I0sd2CCA9/PTW2TYfU
         eAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kjJX27PyTdCQUvHccfbiVozuU+jWYx97a4xB1lHsYPc=;
        b=Z1VxiOTD9L4Jgxc+MEMGQMs9C8qmYnBQrHT3tr2AzywwMDnsh72ySh1Hnz/QMo3lYl
         +JN0wsDW/GdteDCHTOg/PTTy7QKuTQQWSnTE5CUBQUippM1uodnUI1jCLsfIAmHnTLgi
         BdAc9M6RU2E/Y88FavKbjZK8StUtM6XkLNkPVbmMRnQaZSBICbqqN9tzO4da3FKtsCEr
         lCxZPlD7lXA3dm/pdt+BH+tauIHLV9wjNDK/K4M9+Q0VI1Jbx0qXmFOEIPIdkkCzKP7K
         2M+tx70IsJp8YdTNpmEmretA8q0kZSxP0xrj9FP2E1ZmecOtj0jYRntvZxu9TAJJjReR
         Dqwg==
X-Gm-Message-State: AIkVDXLhjYno10EJbuafQwQvRWslvX01IFJMTg6XwiyKwkQgoymsCiGD1DMX5HdYP1uRuN2p
X-Received: by 10.98.201.25 with SMTP id k25mr71612967pfg.108.1483987840393;
        Mon, 09 Jan 2017 10:50:40 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id k192sm162988408pgc.3.2017.01.09.10.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 10:50:39 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: [PATCH 2/2] real_path: set errno when max number of symlinks is exceeded
Date:   Mon,  9 Jan 2017 10:50:24 -0800
Message-Id: <20170109185024.73006-2-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170109185024.73006-1-bmwill@google.com>
References: <xmqqzij0t7uh.fsf@gitster.mtv.corp.google.com>
 <20170109185024.73006-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set errno to ELOOP when the maximum number of symlinks is exceeded, as
would be done by other symlink-resolving functions.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 abspath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/abspath.c b/abspath.c
index 0393213e5..fce40fddc 100644
--- a/abspath.c
+++ b/abspath.c
@@ -141,6 +141,8 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			strbuf_reset(&symlink);
 
 			if (num_symlinks++ > MAXSYMLINKS) {
+				errno = ELOOP;
+
 				if (die_on_error)
 					die("More than %d nested symlinks "
 					    "on path '%s'", MAXSYMLINKS, path);
-- 
2.11.0.390.gc69c2f50cf-goog

