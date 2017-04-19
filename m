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
	by dcvr.yhbt.net (Postfix) with ESMTP id 983351FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 13:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763553AbdDSNQA (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 09:16:00 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35365 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763550AbdDSNP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 09:15:58 -0400
Received: by mail-qt0-f195.google.com with SMTP id o36so3099805qtb.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X7n7O2LUOye/IS48t/JDNEPA8KDu0lOI1UQ9/OoRNrU=;
        b=QG8FNLSmM50D3hBVr+lUbOPeQ2RBeYZJ32DUZWwII7zf2qpqd26BBXPPtPYEc7SLna
         xNZ6LmynUDo0dyjQ4r4iZOWIlL1LEdMnxQdTkWulCgMrjk4QILS0sKk5GE1L4dw6DpNX
         pykZjOfhRpAP+S/4BP5X6qKKQGjDox0ysQl9PnoHiehi6OiF5oOOnz8HRcsiJ2UkOXDT
         0VNZ5z44y9WPqsxLrTj8+URKsp173TBj5MWdAk89E0Mp0vBVW8GbmGY/ayWog+2aANBT
         I4n/WGXiRlC+tTTy8kmou0bAXur+RAM/jEZid4NWJa03FEtTJVBl79IRJRlwqhc1GgXw
         plGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X7n7O2LUOye/IS48t/JDNEPA8KDu0lOI1UQ9/OoRNrU=;
        b=uipU7IrCmzmzAseFBZ8mAIsFX0P67XAliwEKae662qq8/LAP2VydwAEgYYLlomr1Bf
         IkHeZpajhGtMtQnutxmAw0d0UbkjqYN7ns3JldwGgZfF5a2COM8hExAT+WrrMoqutZVw
         MFnHuki6TtDKzCeH9lPmeX5p+iRsgEteXejTyO2D5RbOZMea/2k+/3kY27fSlKBadP4F
         /Sw9bZk5FrCryMiaVJaV6GF4tW+HYbmq7WWyHrKAocTUnryNcXGJG5mWTczcMRZqfIKr
         /kRu3TJishiuIIlcf/HhrSYtNQrjeoAWl57DOPKGX5wFBlZ8kNXvpGg/DSGf7ldnY4ds
         z01w==
X-Gm-Message-State: AN3rC/4uB0T8XYVHmJbeNvPT7aqCfaEeVZfMV/zvTo7YZI+EWp/+Ka1U
        FssQkH4NStbzqw==
X-Received: by 10.200.51.215 with SMTP id d23mr2706501qtb.55.1492607757895;
        Wed, 19 Apr 2017 06:15:57 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id k133sm1835587qke.25.2017.04.19.06.15.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 06:15:56 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v10 5/5] remove_subtree(): reimplement using iterators
Date:   Wed, 19 Apr 2017 10:14:12 -0300
Message-Id: <1492607652-36341-6-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
References: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
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
 entry.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/entry.c b/entry.c
index d2b512d..a939432 100644
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
@@ -45,33 +47,21 @@ static void create_directories(const char *path, int path_len,
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
+	if (!diter) {
+		die_errno("cannot remove path '%s'", path);
+	}
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
@@ -312,7 +302,7 @@ int checkout_entry(struct cache_entry *ce,
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

