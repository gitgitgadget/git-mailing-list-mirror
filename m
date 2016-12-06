Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16F21FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbcLFVxO (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:14 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35184 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcLFVxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:12 -0500
Received: by mail-pf0-f173.google.com with SMTP id i88so72194411pfk.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mF3kDGXzmWrgsKyGzO05UxRVditc/hGIHlWlQVvHzJs=;
        b=d3kNhlM7nA8+q2YlXMvT8K9DznvEXLcw5ZKGYkb4R6oexZT19psHlavApaGR7m3YjY
         kKsT7etyoJ+k4BqaOwkbxTirc1qFG7N2rZ51m9FZSXJ3PZ77/kql/E7Lpd6bK+7tFy6G
         FsHEW7SQwG3Wyl0rjZFrx7ljiy+rtCTzDNTXXxDByu1QiNOzHdIddrXCkE5B5wQTOpNN
         OkfOjO40/Ojg0e7PZul3Ow7F+OPmZVddYwGG1TMxu5KYPkObT8hRsYdiY7/9Hm1mF2zt
         8QuCrRxO5uIXrwlh5IhBSqfum6ROezFWRvBERFs5I5WSL18ZfAuUIbGgqH+KrpTd0D/y
         boPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mF3kDGXzmWrgsKyGzO05UxRVditc/hGIHlWlQVvHzJs=;
        b=e2GWrmKhik/RzxnTXxcALpF+24Iu2/SlB+v1DBAYpyFiopvxQXRhEZ3GcBJZ7tVwps
         //1NIYcyZbNgM6mzjE1XEK+yIq4yCIJxY+vrGXW2BTiVn68eaQQcanlLMjTDWnKRLTV7
         2sL5HIpkuoVZ3K9hZoohrU9EfMfToZFSs2RQI8+gcfH9lS2yeae5T/y3BsLWYlXf64OD
         6OWGJRxcnA+A7GjBLpru/HabzNYfWoY5Fhjd2Pn588fG5D0fci0UGhCFBZAqZYIncgEZ
         FBJPQXp0OS5Ui7Y2PlM85qHbP7c7conRrgbVUZKhGSyE5R8Qyjg04WG1u6N0baENfKny
         lWYg==
X-Gm-Message-State: AKaTC02mtg86wutxUTxzFo/jDpK881aCxU7WlqRpvoreTd+Z7rDOtoqwauUADzC1GeFSu/5U
X-Received: by 10.98.92.133 with SMTP id q127mr64671283pfb.152.1481061138684;
        Tue, 06 Dec 2016 13:52:18 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:17 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 01/17] mv: convert to using pathspec struct interface
Date:   Tue,  6 Dec 2016 13:51:30 -0800
Message-Id: <1481061106-117775-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the 'internal_copy_pathspec()' function to use the pathspec
struct interface from using the deprecated 'get_pathspec()' interface.

In addition to this, fix a memory leak caused by only duplicating some
of the pathspec elements.  Instead always duplicate all of the the
pathspec elements as an intermediate step (with modificationed based on
the passed in flags).  This way the intermediate strings can then be
freed prior to duplicating the result of parse_pathspec (which contains
each of the elements with the prefix prepended).

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/mv.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2f43877..4df4a12 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2006 Johannes Schindelin
  */
 #include "builtin.h"
+#include "pathspec.h"
 #include "lockfile.h"
 #include "dir.h"
 #include "cache-tree.h"
@@ -25,25 +26,43 @@ static const char **internal_copy_pathspec(const char *prefix,
 {
 	int i;
 	const char **result;
+	struct pathspec ps;
 	ALLOC_ARRAY(result, count + 1);
-	COPY_ARRAY(result, pathspec, count);
-	result[count] = NULL;
+
+	/* Create an intermediate copy of the pathspec based on the flags */
 	for (i = 0; i < count; i++) {
-		int length = strlen(result[i]);
+		int length = strlen(pathspec[i]);
 		int to_copy = length;
+		char *it;
 		while (!(flags & KEEP_TRAILING_SLASH) &&
-		       to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
+		       to_copy > 0 && is_dir_sep(pathspec[i][to_copy - 1]))
 			to_copy--;
-		if (to_copy != length || flags & DUP_BASENAME) {
-			char *it = xmemdupz(result[i], to_copy);
-			if (flags & DUP_BASENAME) {
-				result[i] = xstrdup(basename(it));
-				free(it);
-			} else
-				result[i] = it;
-		}
+
+		it = xmemdupz(pathspec[i], to_copy);
+		if (flags & DUP_BASENAME) {
+			result[i] = xstrdup(basename(it));
+			free(it);
+		} else
+			result[i] = it;
+	}
+	result[count] = NULL;
+
+	parse_pathspec(&ps,
+		       PATHSPEC_ALL_MAGIC &
+		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
+		       PATHSPEC_KEEP_ORDER | PATHSPEC_PREFER_CWD,
+		       prefix, result);
+	assert(count == ps.nr);
+
+	/* Copy the pathspec and free the old intermediate strings */
+	for (i = 0; i < count; i++) {
+		const char *match = xstrdup(ps.items[i].match);
+		free((char *) result[i]);
+		result[i] = match;
 	}
-	return get_pathspec(prefix, result);
+
+	clear_pathspec(&ps);
+	return result;
 }
 
 static const char *add_slash(const char *path)
-- 
2.8.0.rc3.226.g39d4020

