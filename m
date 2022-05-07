Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631B0C433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 18:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446768AbiEGTDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 15:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiEGTDK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 15:03:10 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0613262E2
        for <git@vger.kernel.org>; Sat,  7 May 2022 11:59:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h85so11329772iof.12
        for <git@vger.kernel.org>; Sat, 07 May 2022 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vEI7pgg/gF3PL9IO1Js05EWm7fSvY8qQEZ/f5cg+BM=;
        b=mI1YoEVbja9KnMvCA9nOuYvIlp6fgGfFPGLCFRg9Dl0F6J3HazBivU1F5PoNcbDoeD
         GRJXqu7i9tC9yqd1cvp+GEV0+9wtjLu27VW4e3pNWFfCRHlTnzvh4moUrBvR7U2pw8PZ
         DY9W1QRJeqoGuoM5eJ5JQ0kIRBy4wU0lKzXc50J7pVZv6Ei9WHeOi3TWh7qAj3Uf6KJl
         fcb2nJQFO0LrDp6c32aRyzR03vBWb/MKwLRMrkqmICsgirr4LTQv4CmrlKHWRn2nKYZg
         QYoGE4gm9+GD/8KiUnZsnpTMXof8G3v6qiOsQXp1Roih/FCDe2tlC2/mFbZ/DhP/A400
         uI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vEI7pgg/gF3PL9IO1Js05EWm7fSvY8qQEZ/f5cg+BM=;
        b=pVQ2ZegFakMcIo1nTBTmXaA+5EKsewQ7+CCXQnu6jRHF2gc0cBdIOuPIBBK5oRPLOo
         NJNnk75Ajc6xePTU8SGc3DL9gIMVumkSs/1XN8hBVexKzKWmKwSJ1zjPd9A0vUMQbeUp
         CFLNWIjUSMdlJt7rpmJ5dxauoQ0BqOsLMbfDOq+u2s7Ee9eQ9uHf9gzMOy+A7ywlMJNd
         /zOFzs1bAbkMW/uJJNgYnBcwW2l2VtPUU7jlbPxTzoAmgJPH6GdTTsFEY/wZnRfuQ2H3
         vnUeSN4F9kPHqUj4WOKVGEKoF0jtNKi3jSbtKi3kwGWugklwT02PycVC2GjEbLX5SBFN
         ijPA==
X-Gm-Message-State: AOAM5325FFo1cz4pxSuiFTZQCPUtLanBGKIicGkGqBATRg3GAOYhSlQ9
        goYm/7tfBWyPZszYosEKvm0=
X-Google-Smtp-Source: ABdhPJxglQBSCgvlTQUafj9ctgergEgZDCyRLUreSSW6K4JpETeNNdU4IUEvpthzR+EPb1xdT/9Uzw==
X-Received: by 2002:a6b:ee12:0:b0:64d:2f8f:15bb with SMTP id i18-20020a6bee12000000b0064d2f8f15bbmr3555248ioh.16.1651949962383;
        Sat, 07 May 2022 11:59:22 -0700 (PDT)
Received: from jason-ubuntu.localdomain (str-bb-cable-south2-static-6-55.dsl.airstreamcomm.net. [68.65.52.56])
        by smtp.gmail.com with ESMTPSA id z8-20020a029f08000000b0032b3a7817e6sm2256574jal.170.2022.05.07.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 11:59:21 -0700 (PDT)
From:   "Jason D. Hatton" <jason.hatton@gmail.com>
X-Google-Original-From: "Jason D. Hatton" <jhatton@globalfinishing.com>
To:     jhatton@globalfinishing.com
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de
Subject: [PATCH] Prevent git from rehashing 4GBi files
Date:   Sat,  7 May 2022 13:58:14 -0500
Message-Id: <20220507185813.1403802-1-jhatton@globalfinishing.com>
X-Mailer: git-send-email 2.36.0.4
In-Reply-To: <philipoakley@iee.email>
References: <philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git cache stores file sizes using uint32_t. This causes any file
that is a multiple of 2^32 to have a cached file size of zero.
Zero is a special value used by racily clean. This causes git to
rehash every file that is a multiple of 2^32 every time git status
or git commit is run.

This patch mitigates the problem by making all files that are a
multiple of 2^32 appear to have a size of 1 instead of zero.

Signed-off-by: Jason D. Hatton <jhatton@globalfinishing.com>
---
 read-cache.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4df97e185e..d80c80ef90 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -163,6 +163,22 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 		add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
+/*
+ * stat_data only stores file sizes as an unsigned int. Any file that is an
+ * exact multiple of 4GiB will get a cached file size of zero. Unfortunately,
+ * this is a special flag used by the racy update logic. Substitute a new file
+ * size if a non-zero sized file would would be cached as zero. 1U<<31 is used
+ * as the substitute because it is the furthest away from 0 and 4GiB.
+ */
+static inline unsigned int munge_st_size(off_t st_size) {
+	unsigned int sd_size = (unsigned int) st_size;
+
+	if (!sd_size && st_size)
+		return 1U<<31;
+	else
+		return sd_size;
+}
+
 void fill_stat_data(struct stat_data *sd, struct stat *st)
 {
 	sd->sd_ctime.sec = (unsigned int)st->st_ctime;
@@ -173,7 +189,7 @@ void fill_stat_data(struct stat_data *sd, struct stat *st)
 	sd->sd_ino = st->st_ino;
 	sd->sd_uid = st->st_uid;
 	sd->sd_gid = st->st_gid;
-	sd->sd_size = st->st_size;
+	sd->sd_size = munge_st_size(st->st_size);
 }
 
 int match_stat_data(const struct stat_data *sd, struct stat *st)
@@ -212,7 +228,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 			changed |= INODE_CHANGED;
 #endif
 
-	if (sd->sd_size != (unsigned int) st->st_size)
+	if (sd->sd_size != munge_st_size(st->st_size))
 		changed |= DATA_CHANGED;
 
 	return changed;
-- 
2.36.0.3

