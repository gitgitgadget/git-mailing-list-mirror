Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A58C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiGRQr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGRQr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:47:26 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC81101CF
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:47:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so18853936pjn.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJx/V/nrLUszyemmolNuLCsZ/8Ak6DnplUOHq/zOo0M=;
        b=PGWQjYgpGmEFcrzbin+oDVPkZukX7v6Kcqjwy8mFnPK1XtONDFdhwddbpFeoWTL4tW
         dorVjbhENVj0BITiQgUOr4dD4UXW8FJ/RWO8Z7aiuGvoeIDxb5H2W9sSaTqf+u1EZRy/
         lNHASI3e5ihIuZsTMPdAX0wKw5ijTbvymDnvI8sm3wMFODrR6ekpAi2gKMOGZ3FM2C+X
         VPFKHiQO7++AudjlYMyM/6M3z7ZlRT4SHfvYlHZB7jcKov7Qm1TYamJKgrxZWM7Fo3f3
         8rsGMpo3CjS6aicIVdMoHalcsEEbxak1oDXP+WP5rwu2d6ks0dPOOf+QX6iNsnn09oOm
         3nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJx/V/nrLUszyemmolNuLCsZ/8Ak6DnplUOHq/zOo0M=;
        b=iwFDMLUuObk/K/FA+clI8T4Nn5jUXBTzpv7CB+ptV+XfZnJe94Sl2nSV00Umk/WzNj
         IG5eoB1BzVnF508BIaGVe1OV12bq6uaZvMv7xtJX/i2s217KDSom+K6mNm6PMhNWanaO
         bZlkc8Gzzc9n5hBht7ejunFFW/hikV5kYzlQRxbDcHLeMOmhUlWm4k0/dUP4bs7hQcjV
         wV18FH4M7WaJUu9Z68fTgmznkNBX9+tIuk7hw6WGLByJHwB21oSZbWqqRWJgfPntW33+
         0BigcvULjE7kCZER97meceUSoTzBqI+1uQiCGuLshthBgL3mDMBNIYvTqikGXL+2IFnt
         pkkg==
X-Gm-Message-State: AJIora++zJAU3myRDw4/YYRRGCDWgbv3ebKcyZDWeYfhDplgPzaQQWW0
        nfsJN3aCwawZh1DVwJ1p/+g=
X-Google-Smtp-Source: AGRyM1sex9s/1v6ksiO/DbbR9uPfpthNVu1EPXaQdlZ2oQ4Ihv4a1i9i22zk5ENg9815ssi0aADjEg==
X-Received: by 2002:a17:902:d487:b0:16c:509a:ac16 with SMTP id c7-20020a170902d48700b0016c509aac16mr29429448plg.105.1658162845578;
        Mon, 18 Jul 2022 09:47:25 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id d66-20020a621d45000000b00528669a770esm9671074pfd.90.2022.07.18.09.47.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:47:19 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 4/7] pack-bitmap.c: do not ignore error when opening a bitmap file
Date:   Tue, 19 Jul 2022 00:46:03 +0800
Message-Id: <d11ea092d511f3be4601f65ec54d492474fe821c.1658159746.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
In-Reply-To: <cover.1658159745.git.dyroneteng@gmail.com>
References: <cover.1658159745.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calls to git_open() to open the pack bitmap file and
multi-pack bitmap file do not report any error when they
fail.  These files are optional and it is not an error if
open failed due to ENOENT, but we shouldn't be ignoring
other kinds of errors.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 7d8cc063fc..f8f9937c9e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -317,10 +317,13 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	char *bitmap_name = midx_bitmap_filename(midx);
 	int fd = git_open(bitmap_name);
 
-	free(bitmap_name);
-
-	if (fd < 0)
+	if (fd < 0) {
+		if (errno != ENOENT)
+			warning_errno("cannot open '%s'", bitmap_name);
+		free(bitmap_name);
 		return -1;
+	}
+	free(bitmap_name);
 
 	if (fstat(fd, &st)) {
 		close(fd);
@@ -376,10 +379,14 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	bitmap_name = pack_bitmap_filename(packfile);
 	fd = git_open(bitmap_name);
-	free(bitmap_name);
 
-	if (fd < 0)
+	if (fd < 0) {
+		if (errno != ENOENT)
+			warning_errno("cannot open '%s'", bitmap_name);
+		free(bitmap_name);
 		return -1;
+	}
+	free(bitmap_name);
 
 	if (fstat(fd, &st)) {
 		close(fd);
-- 
2.35.0.rc0.679.gc613175da2

