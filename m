Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390492013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756243AbdBPAic (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:38:32 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33636 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756103AbdBPAia (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:30 -0500
Received: by mail-pg0-f49.google.com with SMTP id 204so909570pge.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vAJDFM5tMcGcXBfJ/cMnQAgNWy3EV9iASGT4ejm9LUo=;
        b=R60eE5oiUOjzeHBOD5RvnQVsD5sab5gkoV1fBp3TCSdWesGvHssTs4SrdWEt8ZMOYp
         gv9WqmplquPORkVMy77QyJCjZiqhtjWCUPtVGCAaWNrklsBYW/9onwNTMwOHUhu+Cdn/
         +EybGxdr3RCCZWUFpFs+hssC+eQY2lpkdPqXn/cfk4YOHJAVrGBFhYP0p46OMTpHNPJu
         5LbOqpiyKkkyMCcPGtzZzm5fKItDcpNjmxxpEGBr1KAyuZAj4sx0jgT8WztvX5fXkY6j
         LSBX6PXDRBxTiZWw85oZTMcXE+0yr09yHIAUdymlSA+cN05OXbj5SBYQ++HgbinwPv54
         UBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vAJDFM5tMcGcXBfJ/cMnQAgNWy3EV9iASGT4ejm9LUo=;
        b=rJFtueuZI52IMYi3rHh4iFS2oXeffDqKUA85pKYT3nA2UAtbCGafmI6fr1zmGAjDbY
         UzdU4VBVGARkjE3jIFKkfEkH9E6SO17bv5MO5MvMc7KBYqIFXAlHrSixxYaS/cl0tqpO
         9lk8cOk0+CIpHx2/3J3e/nMn6ZLaIWGdeKiGPTB9D4UJmCubIRH0cfBm8+ixlpL2hgaK
         FJ/r5AF3CH9kKZr8To1bz5uRTUIid0IGQB+45ncPVkRvfX6rfOaM4KORbAcXCQPYuBCO
         PxXiaFcVCyx8c4uQoIXMWqQjZJmitzCfIO0IpVBVxss49Np5KVKLgfT8iflKseJf175l
         cPSw==
X-Gm-Message-State: AMke39mHAI7bcWpDZ96sWOBTZkYxgy1aqjqxnAW8ySKRKF6iLlrYSpoHYKWHLhIoq0fzrZVh
X-Received: by 10.99.225.5 with SMTP id z5mr41491768pgh.145.1487205504560;
        Wed, 15 Feb 2017 16:38:24 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id 75sm5144275pgg.47.2017.02.15.16.38.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:23 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/15] make is_submodule_populated gently
Date:   Wed, 15 Feb 2017 16:38:00 -0800
Message-Id: <20170216003811.18273-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
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
index 3b98766a6b..0e55372f37 100644
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
2.12.0.rc1.16.ge4278d41a0.dirty

