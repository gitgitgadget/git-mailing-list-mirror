Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11842CCA480
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 12:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiGKMpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiGKMoh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDCF65595
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso5559818pjb.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jAqgnidSDpoMfHQ48ntFpHfwLMi8/zSUgWFTnmNWFcI=;
        b=cGUyTqxES3tCvRYzYeRy2FxmlVKl8rLby3hSgmXI3mi2KMJt+ZhURBPwVfy3PmaGN6
         BuNpsc6dQPkVFz7eacpZJpuusp7lUpty2O33ncZbq0Nr4rWj/u7xQA3sFA5CveC9vu7b
         +TkijtHPJFIKMOKQDbHaXl7xdNKh3KJQlurDKuYBhQrJMnsDNlAwe16Wx5sOaBugE91G
         bxSQociKYH9Z3EsfrjXoSahECrvSpXWN9E636oQoTpDriTU4YqLPSfSYKovFrojRkcw2
         lrPgJNaiUOvg8vfI9wvtIKGJIz16aicvbimN3OvPJ2nErHPAA/Q+Y5hl1XCBBtrvGYLr
         Esqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jAqgnidSDpoMfHQ48ntFpHfwLMi8/zSUgWFTnmNWFcI=;
        b=bIJre9acXHhAU1M+nOL5WAtEDdIUrA7Lo75IgmmZ1guA+i/D6w64WFWrw4kXBFtKMH
         F86QP9Yo58T2HluNQPxDUp4Bxn4hOllfUM26xG4SxU9AnOZnJEFps8Nb0PsoJm9u90oG
         WaDQsxdRLIU2lp3ImKaqaeYU+0053sUXIOFPqUooSjyqcJ7/+J97AUyrNpg4E7562XvG
         qLUC3BFE9FbAi/DdpMbiUPxoMzgBLm7rFd3udcV6ELsLs8DKODjsrsmHZySJdfcMA8wQ
         fSVrWb/VDan4KhHojyAf7gzLWhJwuqpROGtwzf2QlYD16xlQjyMFp9pIiNQp934OKfP1
         dZug==
X-Gm-Message-State: AJIora/1znD74FFMANlWJ9wlnvBTOa6759IxfE/zbRcj30k4HfAn4nRy
        bU+ctmhiUo0WGL5hmAmiSKk=
X-Google-Smtp-Source: AGRyM1vANPfd1BcitbJ37PoDfz7RFZnh06LXuuTeAFKcCK1ncFKOoJzMpetXb9h1IJ6RazQ+uu5BHg==
X-Received: by 2002:a17:902:e54e:b0:16c:33f7:55f7 with SMTP id n14-20020a170902e54e00b0016c33f755f7mr11803460plf.111.1657543467483;
        Mon, 11 Jul 2022 05:44:27 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a02d600b001ef95232570sm6866084pjd.52.2022.07.11.05.44.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:44:27 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v6 4/7] pack-bitmap.c: don't ignore ENOENT silently
Date:   Mon, 11 Jul 2022 20:44:00 +0800
Message-Id: <009cc49a18f2846c24256102e07437894ac16908.1657540174.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <cover.1657540174.git.dyroneteng@gmail.com>
References: <cover.1657540174.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When finished call git_open(), instead of ignoring ENOENT silently
and return error_errno(_("cannot stat...")), it's better to check
the ENOENT before then output the warning.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 7d8cc063fc..319eb721d8 100644
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
+			warning("'%s' cannot open '%s'", strerror(errno), bitmap_name);
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
+			warning("'%s' cannot open '%s'", strerror(errno), bitmap_name);
+		free(bitmap_name);
 		return -1;
+	}
+	free(bitmap_name);
 
 	if (fstat(fd, &st)) {
 		close(fd);
-- 
2.35.0.rc0.676.g60105b7097.dirty

