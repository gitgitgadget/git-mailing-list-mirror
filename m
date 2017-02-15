Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5922013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbdBOAfk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:40 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:34549 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdBOAfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:09 -0500
Received: by mail-it0-f47.google.com with SMTP id k200so22182835itb.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c5G7qmmfClb2XDPmwvTGBlf4/Zb7penjPVlMSlEcBdM=;
        b=KtQ7c3f3U7BzKqB7/AinZxZYdRcWkGoiCgOOnFttcs6lmBajdmluxI2Vposx3a1F7j
         VbLOyMPFysQMrKwOxPnQl2EkbVOgih2TmSxQCqaJo1/ZN35B2kSXNDZpDpKc51Zzsw1i
         2Eq1AwOqFWtQbAVzGvuOMk+S/Ot95NZvzTQj9EXXjczDQLhN71bEvdl5QTcgjy0nntug
         96MpeSYBNHxXdbcTA2kt9eNSOfVPm4VxIhxlwRLLUYJhnndxOxW4RsmPv6y8Pau+yJRj
         lIvLv8bYpPpBPkcj5FlCjgavw0DhfE+pjPiOI4+TBrx/I6q9ENeACv9S67uv4O+XvlVv
         dJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c5G7qmmfClb2XDPmwvTGBlf4/Zb7penjPVlMSlEcBdM=;
        b=sCum12cTgN2wEISLHQ2lA/+Tbp92Fyn966bWN9pXiwBlz1PwGZEuqrJtjX4mF2y+Du
         UexbtULkzpy2PYZbqvyGPzZzMZTPl6qrwy9EJLfLV22CLsDmnKVIyUw560T9Z3zYQNOC
         VeOtEP2qnkCgKYJBk9bTVYIVJqpRLgSSzYYz5EsLUnOtZn1a1S/CwsoD4f2TTuryIhOy
         5N8F6VeJj8SKsDjCisUAwPX7MpnqC6Cea2HsaMlrHiZXRMJSQuIKvEg4/V8XtmYXktIB
         EhcHdqCJU/gSj0m8pRDTiRyP+T2Qa784bAE3DmdR4Q5uVuWajg1OT6CAEE1TFSfyqXyd
         Mjdw==
X-Gm-Message-State: AMke39nqoAFrICxAD0BhseZFX4pUgXNgAc/pN4MrJLaIroA0kQ11nlZV5ferjXbzc5O9mine
X-Received: by 10.84.192.107 with SMTP id b98mr39870219pld.160.1487118907839;
        Tue, 14 Feb 2017 16:35:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id y6sm3407474pgc.1.2017.02.14.16.35.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/14] make is_submodule_populated gently
Date:   Tue, 14 Feb 2017 16:34:12 -0800
Message-Id: <20170215003423.20245-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
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
 submodule.c    | 4 ++--
 submodule.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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
index 3b98766a6b..9bbdd3ce7c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -237,12 +237,12 @@ int is_submodule_initialized(const char *path)
 /*
  * Determine if a submodule has been populated at a given 'path'
  */
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
index 05ab674f06..689033e538 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,7 +41,7 @@ extern int submodule_config(const char *var, const char *value, void *cb);
 extern void gitmodules_config(void);
 extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
-extern int is_submodule_populated(const char *path);
+extern int is_submodule_populated_gently(const char *path, int *return_error_code);
 extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-- 
2.12.0.rc0.16.gd1691994b4.dirty

