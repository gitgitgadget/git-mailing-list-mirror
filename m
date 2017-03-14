Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDB520951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbdCNVrv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:51 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36045 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdCNVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:05 -0400
Received: by mail-pg0-f46.google.com with SMTP id g2so79009156pge.3
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYAxPnFixdoXadXFWiACV01grqEkH94m1Q565jxSuH4=;
        b=WKsZiIxEO7Ff/9/087Lmhy+I9v8Lo1JG23apDy7X93QNbEL2Tc28RtFGTDeT/uXsqI
         HSNABvTOTHSQFkw1cNc4a5H9qVBKm/ei/Q2g/71fYnmJMpWKQkXdF8Bgn6n696ETUj7S
         dvBH97mT83y5knVT8hWPaEZl+T9iRuNw32kfz0Q5IbWF0Lt1ar0ymtKJiypNeRsWxaK5
         zmdBBnHe33EE/6SKxBdfU+8sRGwzXuOIdJRHE/HW6Qjnemj7IVOyowKlsZdbFZ1qL4/c
         TA8FEUHQy62R18yujOz7DW3XraUSdrfO0ug2uIYJPVGkHiaAsx/j6XzAdC5jktRVkHJW
         1bPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYAxPnFixdoXadXFWiACV01grqEkH94m1Q565jxSuH4=;
        b=MsdLYveX3wiY7N4FOcPKtObyAXTwhy2p2VouxUoVPukasvul1znzj48+b3SA8XhE2Q
         iidSuF4RBSdqiPsNU2esqxJqsNfPoLQo0HZLPrNFwRTJ6whi4blc5wYA7Dkun4opHCm5
         Hr7zJFNxsNTp/gFxgOPR9XH1sLEGWec1JUDCu0G/a41wJkznByr6hKsHXnRmFF7A469Q
         c+/5gL1XZkGz7+ROVdjenwGHdWcX1zL9g1IgaGC16CEktTFft8TvMlLthmb4uzOFGdAs
         Jj2SnZpkGnhGDyEhGjrybRejBefnxRzN+J/sA1M3c1WgWcVk1956e0EJsjM6nmOYCIYF
         yz3A==
X-Gm-Message-State: AMke39nh0dNUttcIP8ITo1EynFndr/vZdDY7bPnfaKNPUSV7dzIeF351/gUgmzrQQOFh9irX
X-Received: by 10.84.135.34 with SMTP id 31mr57913486pli.50.1489528019100;
        Tue, 14 Mar 2017 14:46:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id i3sm40220357pfg.117.2017.03.14.14.46.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:46:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 08/19] make is_submodule_populated gently
Date:   Tue, 14 Mar 2017 14:46:31 -0700
Message-Id: <20170314214642.7701-9-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need the gentle version in a later patch. As we have just one caller,
migrate the caller.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/grep.c | 2 +-
 submodule.c    | 7 ++-----
 submodule.h    | 8 +++++++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2c727ef499..b17835aed6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -616,7 +616,7 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 {
 	if (!is_submodule_initialized(path))
 		return 0;
-	if (!is_submodule_populated(path)) {
+	if (!is_submodule_populated_gently(path, NULL)) {
 		/*
 		 * If searching history, check for the presense of the
 		 * submodule's gitdir before skipping the submodule.
diff --git a/submodule.c b/submodule.c
index 45e93a1d55..04d185738f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -234,15 +234,12 @@ int is_submodule_initialized(const char *path)
 	return ret;
 }
 
-/*
- * Determine if a submodule has been populated at a given 'path'
- */
-int is_submodule_populated(const char *path)
+int is_submodule_populated_gently(const char *path, int *return_error_code)
 {
 	int ret = 0;
 	char *gitdir = xstrfmt("%s/.git", path);
 
-	if (resolve_gitdir(gitdir))
+	if (resolve_gitdir_gently(gitdir, return_error_code))
 		ret = 1;
 
 	free(gitdir);
diff --git a/submodule.h b/submodule.h
index 05ab674f06..0b915bd3ac 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,7 +41,13 @@ extern int submodule_config(const char *var, const char *value, void *cb);
 extern void gitmodules_config(void);
 extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
-extern int is_submodule_populated(const char *path);
+/*
+ * Determine if a submodule has been populated at a given 'path' by checking if
+ * the <path>/.git resolves to a valid git repository.
+ * If return_error_code is NULL, die on error.
+ * Otherwise the return error code is the same as of resolve_gitdir_gently.
+ */
+extern int is_submodule_populated_gently(const char *path, int *return_error_code);
 extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty

