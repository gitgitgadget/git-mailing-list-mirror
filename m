Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B5C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbiCBRLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243684AbiCBRLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A18CCC73
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r10so3851610wrp.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtK9acu7P0DFfCP4zSQ9uou/wbZrvbfhEbmK88zj+XA=;
        b=IzvWE786b1oSDDUmeaPSKBilb+YOnoUwkoLwPaHmqIZu8zB8YUmMUkjhFFHR/6vR3N
         ou9OqlvsX9K0OCEvPIDWkcfT+mm7HXMb9l6q/qIM+yKDLVHWZb3qA4B4WugDnVAhlQPa
         rmeHq3/cYKE08rmnXceE7T8RBzFbsnBWYbGuvXuGi4zZUmLQI07SbFwJFhoVAKRmLHnp
         3IuenEKusqFQAIFf9z0KdteDNIce7fjvMl8NP8ho6WTsdtUKJnEy9S3bWiUdbZBSk/7k
         XPJsvLx8lzrNGPv6kxU6jkESAFY+rrWwARKkCSz4SFQjdwWBTInxjNOLIOqz1oSkkg9U
         kFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gtK9acu7P0DFfCP4zSQ9uou/wbZrvbfhEbmK88zj+XA=;
        b=ZKQ3kAOY/ktdLT3lW/7wX+SWDvIiagmqmozLttH//mMS+AilZXrh4kz4SbM18/LM8c
         1HHFty3eG25rPklWExAaMgfcS3oJEX8uO/S4zcLdlhUjiWh6h4zhlTv5du6qOJXxbc4P
         c04zuhX0jLr9uls/cEBJhevG1gxW/6L2X9q3F6YHs1K2IX0KYzuBdroukH0qT/uoj1ji
         CtmegNCCs+LO9Y3+NOUb42geAb7TBIjKBcEg38nNuMInrBr7XEFUSEudA2gVBhIja66+
         ++8pjX2w3v42ulXgmr5vZB91c1mAnuz0C07WCIN+wowzzWIWny5pm0ul50VYc3Nm7nHS
         YGHQ==
X-Gm-Message-State: AOAM532h9/g1o4wZuVdaDRxGxSXtL9fP4Ss41wjI0hIbIqM+gGkPZDFq
        rURzFB5U3QNFUkj5/53DLULKKX6zhyurfQ==
X-Google-Smtp-Source: ABdhPJxxN0BCoGj8EOYk/yee72xQJZGZ0SPSBztFIhwROnhC26uUyqUk4LtXHtFj+iIaNKWFk9v/Cg==
X-Received: by 2002:a5d:4a08:0:b0:1ed:b997:46d8 with SMTP id m8-20020a5d4a08000000b001edb99746d8mr23395699wrq.440.1646241034565;
        Wed, 02 Mar 2022 09:10:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/14] lockfile API users: simplify and don't leak "path"
Date:   Wed,  2 Mar 2022 18:10:17 +0100
Message-Id: <patch-11.14-cc8beed10be-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in code added in 6c622f9f0bb (commit-graph: write
commit-graph chains, 2019-06-18). We needed to free the "lock_name" if
we encounter errors, and the "graph_name" after we'd run unlink() on
it.

For the case of write_commit_graph_file() refactoring the code to free
the "lock_name" after we were done using the "struct lock_file lk"
would have made the control flow more complex. Luckily we can free the
"lock_file" right after the hold_lock_file_for_update() call, if it
makes use of "path" at all it'll have copied its contents to a "struct
strbuf" of its own.

While I'm at it let's fix code added in fb10ca5b543 (sparse-checkout:
write using lockfile, 2019-11-21) in write_patterns_and_update() to
avoid the same complexity that I thought I needed when I wrote the
initial fix for write_commit_graph_file(). We can free the
"sparse_filename" right after calling hold_lock_file_for_update(), we
don't need to wait until we're exiting the function to do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/sparse-checkout.c | 3 +--
 commit-graph.c            | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 9c338d33ea2..270ad49c2b8 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -328,11 +328,11 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
 	fd = hold_lock_file_for_update(&lk, sparse_filename,
 				      LOCK_DIE_ON_ERROR);
+	free(sparse_filename);
 
 	result = update_working_directory(pl);
 	if (result) {
 		rollback_lock_file(&lk);
-		free(sparse_filename);
 		clear_pattern_list(pl);
 		update_working_directory(NULL);
 		return result;
@@ -348,7 +348,6 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	fflush(fp);
 	commit_lock_file(&lk);
 
-	free(sparse_filename);
 	clear_pattern_list(pl);
 
 	return 0;
diff --git a/commit-graph.c b/commit-graph.c
index aab0b292774..b8cde7ea27d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1854,6 +1854,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		hold_lock_file_for_update_mode(&lk, lock_name,
 					       LOCK_DIE_ON_ERROR, 0444);
+		free(lock_name);
 
 		fd = git_mkstemp_mode(ctx->graph_name, 0444);
 		if (fd < 0) {
@@ -1978,6 +1979,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		} else {
 			char *graph_name = get_commit_graph_filename(ctx->odb);
 			unlink(graph_name);
+			free(graph_name);
 		}
 
 		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(hash_to_hex(file_hash));
-- 
2.35.1.1228.g56895c6ee86

