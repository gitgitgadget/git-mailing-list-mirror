Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007FB20356
	for <e@80x24.org>; Tue, 18 Jul 2017 19:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbdGRTFl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:05:41 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36743 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdGRTFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:05:39 -0400
Received: by mail-pg0-f48.google.com with SMTP id u5so17451505pgq.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xFvUkUutcivGg7OtH48ssFSKSDDbXgMnOMjKfOrs+Ag=;
        b=IBCR70ZSOk0hjJOOr72uveQmUsf02WonvjVYZoVRmrLYHfTDpc8Lr+QKr4QwYhaV2i
         zEDtHMbbadyVogRbCPT05U8OJfwdpikYUPDR9xTktcj8R+bWsP6VPQI7ReSdoIDujryE
         DEANcF4NNmlxJwgN3FibpOy1WNPQBPUwTGST34khIvG35nRLXqvCBPJQ4Oy+jGI+Xnq9
         p30sSbgOafLUuN7lCyOZLcs/wRBe4sU8Q1EV0MfoGaWgzujKyTEMUSDmKdUbftpBIQJ/
         dtmmzr/tDfLW2h3cCS5BPrXyPueXO5vBSsCl5GXlh1Wi9vL5gamzu1P5byDYSszaLp8z
         7ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xFvUkUutcivGg7OtH48ssFSKSDDbXgMnOMjKfOrs+Ag=;
        b=Vn5br7VzHy/MA4KZELlBu1u41JNEQnKNdTGiI5Q5/uWBkaSiUcPti6QD1yjtNDoyVy
         lxCIw8SLiU3ocq351Mg5QjDqLAQHOhkjUP4P8MuleviugZ1XaPIHm/qvAwJtVevhM8qp
         PhhWmMtcE4zt+XyJ3HKIaj2FAaeSVOLTdCCxREWFo6jY1KJoOOTln9pwLJna6kuP2IMS
         nESEt8Eg2ZtxZoTFox80wRA3cfl/cZ7gW6TiLjvgjvwFn65Up2KNctyon0Sc2WiOYRMg
         iPW6qDmPa/uF6UP7mGbefagfZQu5aoKxWbEUz+MXPuKbXqezLPi/5z19plB4t/yyji3h
         0r0g==
X-Gm-Message-State: AIVw112THML5csqCDuoknLTF3uVD2uAwvSU7hORD4bjznczuxtIjsQ15
        znVuRsMNs3SlX10fWZefQg==
X-Received: by 10.84.204.133 with SMTP id b5mr3479705ple.124.1500404738714;
        Tue, 18 Jul 2017 12:05:38 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t11sm6894649pfi.66.2017.07.18.12.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 12:05:37 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 01/10] repo_read_index: don't discard the index
Date:   Tue, 18 Jul 2017 12:05:18 -0700
Message-Id: <20170718190527.78049-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170718190527.78049-1-bmwill@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have 'repo_read_index()' behave more like the other read_index family of
functions and don't discard the index if it has already been populated
and instead rely on the quick return of read_index_from which has:

  /* istate->initialized covers both .git/index and .git/sharedindex.xxx */
  if (istate->initialized)
    return istate->cache_nr;

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 2 --
 repository.h | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/repository.c b/repository.c
index edca90740..8e60af1d5 100644
--- a/repository.c
+++ b/repository.c
@@ -235,8 +235,6 @@ int repo_read_index(struct repository *repo)
 {
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
-	else
-		discard_index(repo->index);
 
 	return read_index_from(repo->index, repo->index_file);
 }
diff --git a/repository.h b/repository.h
index 417787f3e..7f5e24a0a 100644
--- a/repository.h
+++ b/repository.h
@@ -92,6 +92,14 @@ extern int repo_submodule_init(struct repository *submodule,
 			       const char *path);
 extern void repo_clear(struct repository *repo);
 
+/*
+ * Populates the repository's index from its index_file, an index struct will
+ * be allocated if needed.
+ *
+ * Return the number of index entries in the populated index or a value less
+ * than zero if an error occured.  If the repository's index has already been
+ * populated then the number of entries will simply be returned.
+ */
 extern int repo_read_index(struct repository *repo);
 
 #endif /* REPOSITORY_H */
-- 
2.13.2.932.g7449e964c-goog

