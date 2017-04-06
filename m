Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCAF420966
	for <e@80x24.org>; Thu,  6 Apr 2017 01:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756625AbdDFBj5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 21:39:57 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33794 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756600AbdDFBjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 21:39:52 -0400
Received: by mail-qt0-f195.google.com with SMTP id x35so3927896qtc.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 18:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jD6VVXrjt5uPM58sLLagtdaqsCwVDjlH5P+1AmoTzsI=;
        b=WeLhH/VV06ZpVjc/PotVjvgE8oO/7LTf/KukDZiwcKd0/4mDW47b6fIjgcOFT+fpjK
         I59iUZYQPxcc7u4QJBr8nCO9ioIf5eGZiRZxCAYejTIdRnazci5LoIsOaz4pHFPXdrVB
         DvhdA9FgYPh2wMRbdFvs31kPo53KNnhck1PMLz6c5YjbzfNyNR12A1a27jDC8QIBRTCU
         7Xm96urqn7U/fT1Ow6coCQZ8+IwLUht6PCYxxRP0ckBItrmMKYzyFTXOLEmYxmtjDHxw
         gSS78cDT0st2xQOOH68PK++ALGYsfAQuxPZSBegINKbVHLfKijdC/9EY6SsLeB8O7jMW
         HBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jD6VVXrjt5uPM58sLLagtdaqsCwVDjlH5P+1AmoTzsI=;
        b=mxsM38Ex5HJM+q54L/5TU8B1Mom/M9AVmJjWGaxG8qVz+SFdT0VdW19G1q8JAXczNG
         TTep2PkdNUJnTW+yqnTcdNBextCSg27AF8IRrydUH6K6euMFirqyMW0ji7643flXcjOq
         K2zc3VopbMfbpczRlOOcsl7iEgfFZGCpxDT9fQPQ4DdDtf4uEOTkn4hxR0MmJjiuDxbi
         UnLzFIaeK/8k5o7CnSZUexp/UopSPVjrbP8CoiRYFlCeTMYnD6SDCyHje9mdgQhQuBtZ
         SWpdKoOI7NZnUNFBo+wwdsqu8HZaYD4pJxjWz/iSO/MTieSRytiwEgZr0sJp4Hs68j66
         a2YQ==
X-Gm-Message-State: AFeK/H2ljMYVkA2bpV0ffGhYFAsh6D4hdlZkvGJ1JG6kgvwdlCyoNOUJ/KEJEMTaFN5mxg==
X-Received: by 10.237.50.6 with SMTP id y6mr31967778qtd.115.1491442791052;
        Wed, 05 Apr 2017 18:39:51 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id b78sm58718qkc.50.2017.04.05.18.39.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 18:39:50 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v8 5/5] remove_subtree(): reimplement using iterators
Date:   Wed,  5 Apr 2017 22:39:27 -0300
Message-Id: <1491442767-54068-6-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
References: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use dir_iterator to traverse through remove_subtree()'s directory tree,
avoiding the need for recursive calls to readdir(). Simplify
remove_subtree()'s code.

A conversion similar in purpose was previously done at 46d092a
("for_each_reflog(): reimplement using iterators", 2016-05-21).

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 entry.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/entry.c b/entry.c
index d2b512d..d543ccf 100644
--- a/entry.c
+++ b/entry.c
@@ -3,6 +3,8 @@
 #include "dir.h"
 #include "streaming.h"
 #include "submodule.h"
+#include "iterator.h"
+#include "dir-iterator.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -45,33 +47,18 @@ static void create_directories(const char *path, int path_len,
 	free(buf);
 }
 
-static void remove_subtree(struct strbuf *path)
+static void remove_subtree(const char *path)
 {
-	DIR *dir = opendir(path->buf);
-	struct dirent *de;
-	int origlen = path->len;
-
-	if (!dir)
-		die_errno("cannot opendir '%s'", path->buf);
-	while ((de = readdir(dir)) != NULL) {
-		struct stat st;
-
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
-
-		strbuf_addch(path, '/');
-		strbuf_addstr(path, de->d_name);
-		if (lstat(path->buf, &st))
-			die_errno("cannot lstat '%s'", path->buf);
-		if (S_ISDIR(st.st_mode))
-			remove_subtree(path);
-		else if (unlink(path->buf))
-			die_errno("cannot unlink '%s'", path->buf);
-		strbuf_setlen(path, origlen);
+	struct dir_iterator *diter = dir_iterator_begin(path,
+		DIR_ITERATOR_POST_ORDER_TRAVERSAL | DIR_ITERATOR_LIST_ROOT_DIR);
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (S_ISDIR(diter->st.st_mode)) {
+			if (rmdir(diter->path.buf))
+				die_errno("cannot rmdir '%s'", diter->path.buf);
+		} else if (unlink(diter->path.buf))
+			die_errno("cannot unlink '%s'", diter->path.buf);
 	}
-	closedir(dir);
-	if (rmdir(path->buf))
-		die_errno("cannot rmdir '%s'", path->buf);
 }
 
 static int create_file(const char *path, unsigned int mode)
@@ -312,7 +299,7 @@ int checkout_entry(struct cache_entry *ce,
 				return 0;
 			if (!state->force)
 				return error("%s is a directory", path.buf);
-			remove_subtree(&path);
+			remove_subtree(path.buf);
 		} else if (unlink(path.buf))
 			return error_errno("unable to unlink old '%s'", path.buf);
 	} else if (state->not_new)
-- 
2.7.4 (Apple Git-66)

