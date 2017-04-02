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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9344320964
	for <e@80x24.org>; Sun,  2 Apr 2017 04:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbdDBEgK (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 00:36:10 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36728 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdDBEgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 00:36:09 -0400
Received: by mail-qk0-f195.google.com with SMTP id r140so4225244qke.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 21:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=guL2fvyf3q2zDsUXtKPyU/lSXKuSIOGO0FpvKrAdRSY=;
        b=ahRj7Z9ZQTmwQlQ+gbZD7JjhDfYourd6qo6ZMcls6nrJaqvKoB/C2AbGkuzA7jZcfL
         b7TkL7wyHLmD6sh8vQA4YSsuJ8pb0hqrzAzhCjDCA4nLiiLhF6sTea3LfaByeeox8w/v
         pvqLyZebgysjoXQuTQgOhb6ULusmS4nug+7U7Os2eWtoxkq+M306CgtnEfFy81XIJ4KA
         RM9toMHUl/Hs0JskdmCKMN4qPKCytDYUfAMZx4KqNVd48xZ7bedjB2b595JqtoWfstah
         5VchFQWV+3xEmLdq7K+nIGXAErewOS8YQdrZKU14CcUF9AOMbN64fxWYFql3CVHZG24A
         mtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=guL2fvyf3q2zDsUXtKPyU/lSXKuSIOGO0FpvKrAdRSY=;
        b=dUhOk7qz7QZuwkSU7hHU2PF38rbcdrlufXDwBFFWBTIOueQSy4nnTCLmRpOGqFtqub
         scNx1Mcal0QW65LX4OEMb7sWdmD7jUXerLASzS5934oraIMlOG+cNO243Eho6wjXpG4O
         T8GZ0n4NJRJq8+ayeitPM9h2ACoORReeRVLYv4dbyFTtu6D9elLLIr7AejAG4WHmlkmx
         /OJxtgeoBRPUMWDdNJtwNZNJe4COryYN9dZ2bRT+IQ902okQCsiQ6PIZGMBtNklObq4P
         L+Qwycao5TeqYtmwpKs32prhS1E0xj9uCdDwYpgIHY4iHqdH1SZlNZe3rQdS4QeKhr38
         e/CQ==
X-Gm-Message-State: AFeK/H3V0afeU6LiBEQ1ufJifBmrb+aOJ/hDAz6NolPUW39lkizXkhmtvczsCiSrpGb08A==
X-Received: by 10.55.70.20 with SMTP id t20mr10729797qka.166.1491107768813;
        Sat, 01 Apr 2017 21:36:08 -0700 (PDT)
Received: from localhost.localdomain ([189.103.231.223])
        by smtp.gmail.com with ESMTPSA id t23sm6907383qka.37.2017.04.01.21.36.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Apr 2017 21:36:07 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, peff@peff.net,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v6 5/5] remove_subtree(): reimplement using iterators
Date:   Sun,  2 Apr 2017 01:35:26 -0300
Message-Id: <1491107726-21504-6-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
References: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
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
 entry.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/entry.c b/entry.c
index c6eea24..309b9ad 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,8 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "iterator.h"
+#include "dir-iterator.h"

 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -44,33 +46,17 @@ static void create_directories(const char *path, int path_len,
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
+	struct dir_iterator *diter = dir_iterator_begin(path, DIR_ITERATOR_POST_ORDER_TRAVERSAL | DIR_ITERATOR_LIST_ROOT_DIR);
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
@@ -282,7 +268,7 @@ int checkout_entry(struct cache_entry *ce,
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

