Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D41F207BC
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757893AbdDRXSR (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:17 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33116 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbdDRXSN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:13 -0400
Received: by mail-pf0-f174.google.com with SMTP id a188so3419980pfa.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kjOclDfuk0G+siCba0ux4uWsU3vl9N75vD6NpdFfHAU=;
        b=GLJGPQhp+CkH8vq4NMKx6lklPFOLXX7FMOXEUq4J0SNI+w69LVUmGFITrxFEXEwSP8
         LkV30UQSo1fudoWw2UFLBu+qPg6N+TnKCaIg/rTSw0HDxQNaFyIFW4RvH9v2q0tr7BGJ
         Qtbbxu2Mh+n80IRhmcgdhxTs6i+HfTONgpZ7FPf7pvQ42co2mIRR1Ry6OlJAd/xZsH5D
         eR61lceR39SsRWeNuEWRt9sG5XRwZJaWClkBChhHzamSLeczxUmzXB4Zjh8tp9eALgkO
         e3LFJL94cm2SoH22By/wnL1iuwOU3Z8fj9NAqLg72+alI7nMcHjusnSr7faO7rXdHx0i
         nXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kjOclDfuk0G+siCba0ux4uWsU3vl9N75vD6NpdFfHAU=;
        b=OMfUX3MBdo1d7XTuYJ4Pzp8FtTaO7QenklgdSE4S8moEcp1Ln3itbNma6WnmlHWroE
         flhLgYTGoNQr8AfbnsLKbjV5PqYVxsEqUNmAu3FO/QSaUqP7armFY0XvxuBWNN7uLlTN
         jqhAGfWEsJE/EBKsvgauLgIXVMgvp5FsHmSrc6/3200BzE9YXE5icHt2sweXS/SjVqK5
         pInO7Z16EOQW2Wf8/yhBpNlinHGYd3pn85yF9CS+FttnDsPLiNJPOPBzIWWK/OY7caUk
         JTgQmquhHCyU3nBlYp6NDRYq9O77cW7a7nBxoKH6yaF5105WkVemfNY4uZld1LmkVvhY
         c2pQ==
X-Gm-Message-State: AN3rC/7M5lZRcYy5nqgaKf0RhV/AeQonFvbnWEAGQaMSG9m4uo0l0K82
        /bAPe1je0Rc52d+j
X-Received: by 10.84.238.22 with SMTP id u22mr26718289plk.137.1492557492527;
        Tue, 18 Apr 2017 16:18:12 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 01/11] t5550: use write_script to generate post-update hook
Date:   Tue, 18 Apr 2017 16:17:55 -0700
Message-Id: <20170418231805.61835-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The post-update hooks created in t5550-http-fetch-dumb.sh is missing the
"!#/bin/sh" line which can cause issues with portability.  Instead
create the hook using the 'write_script' function which includes the
proper "#!" line.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t5550-http-fetch-dumb.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 87308cdce..8552184e7 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -20,8 +20,9 @@ test_expect_success 'create http-accessible bare repository with loose objects'
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	 git config core.bare true &&
 	 mkdir -p hooks &&
-	 echo "exec git update-server-info" >hooks/post-update &&
-	 chmod +x hooks/post-update &&
+	 write_script "hooks/post-update" <<-\EOF &&
+	 exec git update-server-info
+	EOF
 	 hooks/post-update
 	) &&
 	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-- 
2.12.2.816.g2cccc81164-goog

