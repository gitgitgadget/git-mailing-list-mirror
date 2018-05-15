Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECF31F406
	for <e@80x24.org>; Tue, 15 May 2018 01:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeEOBE3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:04:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34816 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeEOBE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:04:28 -0400
Received: by mail-pl0-f67.google.com with SMTP id i5-v6so8360601plt.2
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PtWYvl4qmf73jdoZBLSXEIwkvkz7fm4U5YW9ujEsnHM=;
        b=q4Zxuq5vEfx7x0rv7mFFaVrNzrZ3905Fxu65XIsVNkhf//YVFe3kD1bpLDKy8FXep5
         Vk2vY16SdDgIMdhHuTTs6Gb/vbll3GGCJwZ5Xu7oLOR4F6jdB5PYoopAYtBkm5rNgaQF
         7vMeN7f7XEvpVTAdfO2HyAdhW3DIege5UgU+SrgqR8jxKe4AJCeCshHkBwXlqFuwWXjG
         toTGHEYNkMmMrf/oK9JYQ2VVfkwUrXE7DO2PwAkIsrRPUjmnKFjC/tjYCXVbpBf0EwYH
         CQQ/aNU6xbdVUB/NTnG8yrNFUQ2zxy8n8v3YRsPAgvQL318otZFEBfZJ+eB41Siiti45
         5seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PtWYvl4qmf73jdoZBLSXEIwkvkz7fm4U5YW9ujEsnHM=;
        b=nbFLCV6XUscWY8HeYGL7w6qpriPjZ6ws0mEejoePPX4641GNVvC75vM3s58xaSEb9x
         NhFZdEjCMVsmg7X0wFaqwDXJ5Na5Qo0SCuaeXWjYDw+BdD6EgQsPISxlp8756Y2cLyX2
         Aia0dwlUSFDx8V/BXBMT/vaNeE0hoVZrxQiXdYtA5EG30QNjDe+hz2zmnFtSDmemM7kK
         klDcU91QFL6KWpLOir7Z+PLl3yl3jnoI8rFFNidBVNn4AWUTkR8UFi7Xvq+KVlr9X63e
         dWnAl+CV5zOSa/QiF/SuHYabdLb9JdqCx3X3gaLrWZ9nRh6YJWePENHVkwfCTIPr/u4P
         q7sw==
X-Gm-Message-State: ALKqPwd1lwDnwxzEouNHAoogs0oew1vEeZkeh0AT5O/DN1sQV0jYRCRo
        /dloQfzupbPdEjAVJRrR+ImV6qySFSo=
X-Google-Smtp-Source: AB8JxZr45V7MCtDcYAzd3NvuaCR3NXXquVSxp8fXqORngUUK0jFtWQABYYE/IuyGrUjqLMlXJJQO5w==
X-Received: by 2002:a17:902:82c3:: with SMTP id u3-v6mr11919683plz.83.1526346267759;
        Mon, 14 May 2018 18:04:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id s17-v6sm24626872pfi.165.2018.05.14.18.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 18:04:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, ao2@ao2.it, Stefan Beller <sbeller@google.com>
Subject: [PATCH] grep: handle corrupt index files early
Date:   Mon, 14 May 2018 18:04:25 -0700
Message-Id: <20180515010425.149200-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any other caller of 'repo_read_index' dies upon a negative return of
it, so grep should, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Found while reviewing the series
https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/

 builtin/grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6e7bc76785a..69f0743619f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -488,7 +488,8 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 		strbuf_addstr(&name, repo->submodule_prefix);
 	}
 
-	repo_read_index(repo);
+	if (repo_read_index(repo) < 0)
+		die("index file corrupt");
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
-- 
2.17.0.582.gccdcbd54c44.dirty

