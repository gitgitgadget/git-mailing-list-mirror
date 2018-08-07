Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDC5208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 07:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbeHGJiy (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 05:38:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52563 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388730AbeHGJix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 05:38:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so16156864wmh.2
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 00:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kuLK32Oa0F93oV5zGFI9SH+JtBVRCPcN00tum+2lcRg=;
        b=rgST8Gx4/rRvbDfZtHvTtMtUyTwcDTw0l4p8CIyghNeVtHkUAv2tEdfFc5EYsfhLLe
         lAgF+pWTpXTvFxtmznOCXUaoJdmWMzNMwJxo9/F5YDDiF4OAqFHwOQBOdMqZBxiUlqB7
         u500x4ZyJ+tepUwHrbIFx5WgKjm0rOYoPvhxFo3QHUIjljjgI+BUV4NZo2FwS0TxD0QH
         Kwp9Gm8WweknTR4oUnQCfFfwRC49iUdUlCLieJEpZrovZhympJkP7T371HjBPCKmxlub
         3tkS20WHadBlgltH6lgJBbvOSVJ7oLLR+ORgj5jV3H29Qz5HLdqmu/Q6ZKBB8sjSJpRJ
         ff6Q==
X-Gm-Message-State: AOUpUlGIvRSous1EaLY+hwAa43U6N4gxqG4EsAtVRlTMh3ilUJqDfdw8
        e3R1JjR4nt8NakD6Iv7c15CfDEv9kSyTyA==
X-Google-Smtp-Source: AA+uWPz9EEMCNNphM4wwkem0RpI60cXg3CXEsbMj+ms7wXORuhDl4tyqNKZUaVjY4fUfblmfknpMkw==
X-Received: by 2002:a1c:d0ce:: with SMTP id h197-v6mr794523wmg.97.1533626751933;
        Tue, 07 Aug 2018 00:25:51 -0700 (PDT)
Received: from skisela-redhat.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q70-v6sm1055255wmd.39.2018.08.07.00.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 00:25:51 -0700 (PDT)
From:   Sebastian Kisela <skisela@redhat.com>
To:     git@vger.kernel.org
Cc:     skisela@redhat.com
Subject: [PATCH 2/2] git-instaweb: fix apache2 config with apache >= 2.4
Date:   Tue,  7 Aug 2018 09:25:48 +0200
Message-Id: <20180807072548.12764-2-skisela@redhat.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180807072548.12764-1-skisela@redhat.com>
References: <20180807072548.12764-1-skisela@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The generated apache2 config fails with apache >= 2.4.  The error log
states:

    AH00136: Server MUST relinquish startup privileges before accepting
    connections.  Please ensure mod_unixd or other system security
    module is loaded.
    AH00016: Configuration Failed

Fix this by loading the unixd module.  This works with older httpd as
well, so no IfVersion conditional is needed.  (Tested with httpd-2.2.15
on CentOS-6.)

Written with assistance of Todd Zullinger <tmz@pobox.com>

Signed-off-by: Sebastian Kisela <skisela@redhat.com>
---
 git-instaweb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index e42e58528..b1da2c374 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -358,7 +358,7 @@ EOF
 			break
 		fi
 	done
-	for mod in mime dir env log_config authz_core
+	for mod in mime dir env log_config authz_core unixd
 	do
 		if test -e $module_path/mod_${mod}.so
 		then
-- 
2.18.0.99.gd2ee41e0e

