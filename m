Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22D0C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbiEIR7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbiEIR7M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:59:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F212D9EC7
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y21so17213012edo.2
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruH9NNE3oDZ1dsHc50WuV5gmLtqd2ibCcqbf8xbbPU8=;
        b=ZKGi3NN/M2xc8AG5Ou4W+rwsL1jAEfQK+5FIbKDnie5Bc9Gc0X0XHQ7EpaxLQQ00L9
         hO5BbnfjAorWZVe+bYDDk86GgoqVuumZGq4cZsEPtjrlTO+cuq/Cavs0wH1sat1m3xma
         4SaTj2WrmQYtFe2abDteqM05lq5dEhoPlzscXx6rrS+spwSaTV0dBdPGCcD5FZbe39qg
         Sbt0mKOSUu7saXNnReW32C3ctvw8YqPzjblva5BQThhZHGvh1KhdfvoyngfBe/3xEDSK
         yvIPrF8Eylc+BBKHvkz06XF25N3d42c+fO+1BlblpOEEWrMrxa7oOkhSlKjpMApLbQtf
         IZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruH9NNE3oDZ1dsHc50WuV5gmLtqd2ibCcqbf8xbbPU8=;
        b=cs9xQsvHnfPoFM/CjrRBxdiNqgJuRTubP7k0qcXo5Q3/9B7Q6s1saT4ovwdr5XFjeO
         Q8+Oy8MJjFTyzUFiv8amK2jCpgppRFHQMFNCMvC9/bonz3alKcBZJQSNBokt5XwiKiDR
         K463PM1pgBOzCFR95gAPBMzmjBKQbMM6kt7AzcjKhT26m8T6cnnCd0+S2int71TUZwtR
         ofqv0aTWyolc8RzjMYXJe63VZ73qi+JSzdy20b4BSO41InDQlh5ybzQoz//X7cGbidlD
         FC/P91GYavXiogSWFaZuYhchD8L+uXc3tXEQM0MkwOF3Goojt9UKmRZvPxtYzlhOGXqB
         BAWA==
X-Gm-Message-State: AOAM530wWnGi7afBx3XOGX4iZPODDhmiIL4SPG4RJJSmhwx1+GUZIz3w
        CwcNEU9q22vbju/MdbPnEAtty5FqJlc=
X-Google-Smtp-Source: ABdhPJx6li/Y6diPs6/RojftQPfc5phvYSy8L0r6v30slMaALavsf2jCZAkqZQnxtaRJTnfatNBP4g==
X-Received: by 2002:a05:6402:34d3:b0:428:2dd3:162e with SMTP id w19-20020a05640234d300b004282dd3162emr18939940edc.260.1652118916782;
        Mon, 09 May 2022 10:55:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:16 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 15/15] entry.c: use dir-iterator to avoid explicit dir traversal
Date:   Mon,  9 May 2022 20:51:59 +0300
Message-Id: <20220509175159.2948802-16-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace usage of opendir/readdir/closedir API to traverse directories
recursively, at remove_subtree() function, by the dir-iterator API. This
simplifies the code and avoids recursive calls to remove_subtree().

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 entry.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/entry.c b/entry.c
index 1c9df62b30..46ef145f97 100644
--- a/entry.c
+++ b/entry.c
@@ -8,6 +8,8 @@
 #include "fsmonitor.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "iterator.h"
+#include "dir-iterator.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -52,26 +54,24 @@ static void create_directories(const char *path, int path_len,
 
 static void remove_subtree(struct strbuf *path)
 {
-	DIR *dir = opendir(path->buf);
-	struct dirent *de;
-	int origlen = path->len;
-
-	if (!dir)
-		die_errno("cannot opendir '%s'", path->buf);
-	while ((de = readdir_skip_dot_and_dotdot(dir)) != NULL) {
-		struct stat st;
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
+	unsigned int flags = DIR_ITERATOR_DIRS_AFTER;
+	struct dir_iterator *iter = NULL;
+	int ok;
+
+	if (!(iter = dir_iterator_begin(path->buf, flags)))
+		die_errno("cannot open directory '%s'", path->buf);
+
+	while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
+		if (S_ISDIR(iter->st.st_mode) && rmdir(iter->path.buf))
+			die_errno("cannot rmdir '%s'", iter->path.buf);
+
+		if (!S_ISDIR(iter->st.st_mode) && unlink(iter->path.buf))
+			die_errno("cannot unlink '%s'", iter->path.buf);
 	}
-	closedir(dir);
+
+	if (ok != ITER_DONE)
+		die_errno("failed to iterate over directory '%s'", path->buf);
+
 	if (rmdir(path->buf))
 		die_errno("cannot rmdir '%s'", path->buf);
 }
-- 
2.36.1

