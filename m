Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92E11FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 00:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932352AbdC2Acr (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 20:32:47 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34757 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932714AbdC2Acn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 20:32:43 -0400
Received: by mail-qk0-f195.google.com with SMTP id 10so125126qkh.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 17:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QzKG2LfcKXimevq67HPxctUh0YKEK9qCf0T7Sd9X8Ps=;
        b=YhE/erNjwiF78NZgl20qki8ojYd+CxuxpaERA9Qkn52cYij2cQxsC/Bjf7gNkhhvve
         vjf6Yv6oq8E5gqwbLfo0/1FSdrGBrpR4YYF4KEZGE8uL10qBgaktNmfJ3RXQSa5zPKP3
         pC/uQxhcPVhBGFoO+Tc0l/ML3haPsQUzAyRG8YP3Gd3jSIskeuFXqjcfh6HrQJ2TBcma
         CznN+NtVQV3YfAVwQhLzOJOue0Iol07nuPbWkawQUyu3svtIkajCmcy30QFPPapqh+hV
         cMbAK3lgTeOJxuptZD1EihaeMCLo07L0L1V+0p5vNPyJfNgxImXZpjoDi7+SPaw00P63
         Qx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QzKG2LfcKXimevq67HPxctUh0YKEK9qCf0T7Sd9X8Ps=;
        b=Fh52eMb4DagfattvhuZoSZI3wU9sKw8C/Z4LmFqsrhlHB3a2/LN7SPGhmdeDstROjx
         CJF+tKakq4KDbd6LOV6GqnyV0KLLsiDGXEsA5GQttD9BBXkRpOSIJITxVtqjezfwplN0
         R2SX/hp5FiH13NLNx4xokVwgG/o2yjGmQdnNPu3osuSiCHloThFehcWwMzKmawiSVi7/
         Xogn3l0l6/FU++G/Xf2TFaRxI8nYucCVvRguUWVPJN52zZEdbaSEYvGJgk3lptkrgxYm
         +He6x41AVNYy6Piv8ab/D74JTpz/LxVEd7Q4ClSpeH0LS5tDz30MXBilRYTsgbH5qloq
         iPTQ==
X-Gm-Message-State: AFeK/H1UN0OMz0516VQY2V6vGaYgwCGtzTVojnPphkGcqHrzXL8auON4pZA4yTYzl0VpoA==
X-Received: by 10.55.163.141 with SMTP id m135mr15604493qke.243.1490747561500;
        Tue, 28 Mar 2017 17:32:41 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id x26sm3819420qtx.47.2017.03.28.17.32.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 17:32:40 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v4 3/5] remove_subtree(): reimplement using iterators
Date:   Tue, 28 Mar 2017 21:32:11 -0300
Message-Id: <1490747533-89143-4-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
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
 entry.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/entry.c b/entry.c
index c6eea24..bbebd16 100644
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
@@ -46,29 +48,16 @@ static void create_directories(const char *path, int path_len,

 static void remove_subtree(struct strbuf *path)
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
+	struct dir_iterator *diter = dir_iterator_begin(path->buf, DIR_ITERATOR_DEPTH_FIRST);
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (S_ISDIR(diter->st.st_mode)) {
+			if (rmdir(diter->path.buf))
+				die_errno("cannot rmdir '%s'", path->buf);
+		} else if (unlink(diter->path.buf))
 			die_errno("cannot unlink '%s'", path->buf);
-		strbuf_setlen(path, origlen);
 	}
-	closedir(dir);
+
 	if (rmdir(path->buf))
 		die_errno("cannot rmdir '%s'", path->buf);
 }
--
2.7.4 (Apple Git-66)

