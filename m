Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54849C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbiCBRLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243702AbiCBRLg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71324C4B53
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t11so3839712wrm.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQR9zKjxdfFJLNk8+W36FFhOWgjqIUfht7NZmwjIdQw=;
        b=WJ/SxG/8sXLeY7tK0McwNnKoMqjh1QIdrlyX5XqeAYTtqNbIJzHxtxGQjDt3lEaJLo
         MR4hHl9Ehx0r0EDOBX11UmDPL88kIjHXRscjwZoU11oC0ZikhnW+inHnb5fTPN0X8aLN
         5dRgWPiD4p+CwExvqkLmO/dD/Jsizqmj4YLqa3PIFMQC3c2hXLBJ7Gpc7USH1nZ3OL6N
         7C0elWhtYZKL/MiG+PwtoJiq2D5m347Bgh8T6DqmMF7YC8UnliEYWDJsWLHIu1StMzZT
         pQH4L5p7cvp/06o+VRZQZUWWw+Fs8aLTCZpJzJ75AAk4Iw0CE5lDVYmpPzOfpM6aBE1s
         eyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQR9zKjxdfFJLNk8+W36FFhOWgjqIUfht7NZmwjIdQw=;
        b=Ix5ZTAi6IY5Y4jymIA4j8iUvxVihk/drXLiCju0cK4HaSs9YL6QYrJMLpfz2kslpJw
         SsyZ0b75PvhIJvvOfJrI3ykPffRwFrPwbysmOkbqntzd9qmuqDw3Cdg9xJsYDzQsKn5r
         10JkVnncJ3Ni1KIFVrlIl35DlXf57DH+Q/u0uatraOTnGaE6dlDf+Acm7TejB+ETH/Fj
         vNWhvpEKBzsTote3P4CnjOyiwiu5HEKGFegJd7drc+ODOcxXYMYpl9nQNBQu7xzuDgd2
         qGY/VaIQ+O/g7LEYy8qSpCmYIfKWO9OpHlbLDFdPypiLpo5oQ1egPxtndwwEcpyurUoS
         InDg==
X-Gm-Message-State: AOAM530ldxHg9RsBn9GmFqhJB47EBHpeLCZas9DxJ4Fhsnn6HZppGxgO
        VaOZ3A5S5be0A9K3b5b6yVrWKdG3eKAtfw==
X-Google-Smtp-Source: ABdhPJwD8/QLrEEtqExNwUeADm9hpAHX7f75i9fxkVYOP4BE4MaQaE4wwdt73go2126AcyP8EWXD0w==
X-Received: by 2002:adf:a319:0:b0:1ef:7cc6:d03 with SMTP id c25-20020adfa319000000b001ef7cc60d03mr18032178wrb.411.1646241037635;
        Wed, 02 Mar 2022 09:10:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/14] repository.c: free the "path cache" in repo_clear()
Date:   Wed,  2 Mar 2022 18:10:20 +0100
Message-Id: <patch-14.14-954de5191c3-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "struct path_cache" added in 102de880d24 (path.c: migrate global
git_path_* to take a repository argument, 2018-05-17) is only used
directly by code in repository.[ch] (but populated in path.[ch]).

Let's move this code to repository.[ch], and stop leaking this memory
when we run repo_clear(). To avoid the cast change it from a "const
char *" to a "char *".

This also removes the "PATH_CACHE_INIT" macro, which has never been
used for anything. For the "struct repository" we already make a hard
assumption that it (and "the_repository") can be identically
initialized by making it a "static" variable, so making use of a
"PATH_CACHE_INIT" somewhere would have been confusing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 path.h       | 14 --------------
 repository.c | 16 ++++++++++++++++
 repository.h | 14 +++++++++++++-
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/path.h b/path.h
index b68691a86b8..0a59c85a62e 100644
--- a/path.h
+++ b/path.h
@@ -169,20 +169,6 @@ void report_linked_checkout_garbage(void);
 		return r->cached_paths.var; \
 	}
 
-struct path_cache {
-	const char *squash_msg;
-	const char *merge_msg;
-	const char *merge_rr;
-	const char *merge_mode;
-	const char *merge_head;
-	const char *merge_autostash;
-	const char *auto_merge;
-	const char *fetch_head;
-	const char *shallow;
-};
-
-#define PATH_CACHE_INIT { 0 }
-
 const char *git_path_squash_msg(struct repository *r);
 const char *git_path_merge_msg(struct repository *r);
 const char *git_path_merge_rr(struct repository *r);
diff --git a/repository.c b/repository.c
index 34610c5a33e..9b86f3f1214 100644
--- a/repository.c
+++ b/repository.c
@@ -240,6 +240,20 @@ int repo_submodule_init(struct repository *subrepo,
 	return ret;
 }
 
+static void repo_clear_path_cache(struct repo_path_cache *cache)
+{
+	FREE_AND_NULL(cache->squash_msg);
+	FREE_AND_NULL(cache->squash_msg);
+	FREE_AND_NULL(cache->merge_msg);
+	FREE_AND_NULL(cache->merge_rr);
+	FREE_AND_NULL(cache->merge_mode);
+	FREE_AND_NULL(cache->merge_head);
+	FREE_AND_NULL(cache->merge_autostash);
+	FREE_AND_NULL(cache->auto_merge);
+	FREE_AND_NULL(cache->fetch_head);
+	FREE_AND_NULL(cache->shallow);
+}
+
 void repo_clear(struct repository *repo)
 {
 	FREE_AND_NULL(repo->gitdir);
@@ -280,6 +294,8 @@ void repo_clear(struct repository *repo)
 		remote_state_clear(repo->remote_state);
 		FREE_AND_NULL(repo->remote_state);
 	}
+
+	repo_clear_path_cache(&repo->cached_paths);
 }
 
 int repo_read_index(struct repository *repo)
diff --git a/repository.h b/repository.h
index ca837cb9e91..e29f361703d 100644
--- a/repository.h
+++ b/repository.h
@@ -44,6 +44,18 @@ struct repo_settings {
 	int core_multi_pack_index;
 };
 
+struct repo_path_cache {
+	char *squash_msg;
+	char *merge_msg;
+	char *merge_rr;
+	char *merge_mode;
+	char *merge_head;
+	char *merge_autostash;
+	char *auto_merge;
+	char *fetch_head;
+	char *shallow;
+};
+
 struct repository {
 	/* Environment */
 	/*
@@ -82,7 +94,7 @@ struct repository {
 	/*
 	 * Contains path to often used file names.
 	 */
-	struct path_cache cached_paths;
+	struct repo_path_cache cached_paths;
 
 	/*
 	 * Path to the repository's graft file.
-- 
2.35.1.1228.g56895c6ee86

