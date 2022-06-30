Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208BBC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiF3SAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbiF3SAd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEADB2A712
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o4so24504536wrh.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tODHKQvb/FVDFItrqEbu70gJbbFXjzSBPN/X+YCwv6Q=;
        b=bdiYSDVC9WT53UjQip+Cgc4w/RuYVkygPmjUhrPBkXeFP7UW0Gn+enBm7NkfTCkwlo
         lrTewchJk88YXaxGm3s9+0ytIn22Me1CqkkiU4ubRMcZbN64nV/naBSfxOCafg7AHGix
         D5klwHjyVThyTHZAOLfTWMlVHRrylQ2WAHQ1NneQp3zX6F/3mVj65Y+MKMTk3U0CO21c
         VH/GnuSRvnDofAe4j5pfruBuIVdyqJgfVKl+V18joBMw+yDG40TsXADSM5Vd4JrUiXz2
         5h+JoDMUpIJe4FinjHkYOhc/bkIRK0sYK1sRnWOftOWwBdo42GuXb1tohLMPsXFacsDl
         Nqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tODHKQvb/FVDFItrqEbu70gJbbFXjzSBPN/X+YCwv6Q=;
        b=7Jx2Qsbsa3kYGro4t6b89urutQpLcrC96NbKxsbsOLr8Qs5Qy6ItCbvNCCnmC5cWrN
         ESFP+2AIlMxvTNV9mhcpjB9KIkGxnkDH4V6a4SW1IjBtC1mQhw5DokmgFXSv7MNrpXLz
         QcqEgpZIfWUzvjLBF6zzY4xp7vRRXE71nSd0b4XPHgJCMx/35gbwum4Lpuf2wzMtz1n+
         caY7jRwX28iQHDbO5kClqXKBSyS/pgh7pTU4r5yfkYR0B8VjDgi7Kz5Qahh4YZpKb5ai
         AyrDXnv4tIoqrhBUkTuqK8+LxEmd03ZgxPSrGLNYkY6dZLA+2THY6ArQS6ZU0+MeYc/B
         nAVw==
X-Gm-Message-State: AJIora9Gnia3nEV0Vh3T2cx9N3CQc6e4xD82gmidH/uPnNrac0MqDMkd
        xKwqAEyc8JErSkPE0tXsBIMJ91qlu6l04w==
X-Google-Smtp-Source: AGRyM1vzup9K5mIqbCvFyXkDF2cnwQjhe0367dLgpkFL424DMDbfGaWyttmyEQvbvkjtgLsGi8P97g==
X-Received: by 2002:a05:6000:1449:b0:21b:b171:5eb8 with SMTP id v9-20020a056000144900b0021bb1715eb8mr9837785wrx.634.1656612030119;
        Thu, 30 Jun 2022 11:00:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/11] merge-file: refactor for subsequent memory leak fix
Date:   Thu, 30 Jun 2022 20:00:16 +0200
Message-Id: <patch-06.11-17e66130b94-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the code in builtin/merge-file.c to:

 * Use the initializer to zero out "mmfs", and use modern C syntax for
   the rest.

 * Refactor the the inner loop to use a variable and "if/else if"
   pattern followed by "return". This will make a change to change it to
   a "goto cleanup" pattern smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-file.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index e695867ee54..793817f3cb9 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -25,10 +25,10 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
-	const char *names[3] = { NULL, NULL, NULL };
-	mmfile_t mmfs[3];
-	mmbuffer_t result = {NULL, 0};
-	xmparam_t xmp = {{0}};
+	const char *names[3] = { 0 };
+	mmfile_t mmfs[3] = { 0 };
+	mmbuffer_t result = { 0 };
+	xmparam_t xmp = { 0 };
 	int ret = 0, i = 0, to_stdout = 0;
 	int quiet = 0;
 	struct option options[] = {
@@ -71,21 +71,23 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < 3; i++) {
 		char *fname;
-		int ret;
+		mmfile_t *mmf = mmfs + i;
 
 		if (!names[i])
 			names[i] = argv[i];
 
 		fname = prefix_filename(prefix, argv[i]);
-		ret = read_mmfile(mmfs + i, fname);
+
+		if (read_mmfile(mmf, fname))
+			ret = -1;
+		else if (mmf->size > MAX_XDIFF_SIZE ||
+			 buffer_is_binary(mmf->ptr, mmf->size))
+			ret = error("Cannot merge binary files: %s",
+				    argv[i]);
+
 		free(fname);
 		if (ret)
-			return -1;
-
-		if (mmfs[i].size > MAX_XDIFF_SIZE ||
-		    buffer_is_binary(mmfs[i].ptr, mmfs[i].size))
-			return error("Cannot merge binary files: %s",
-					argv[i]);
+			return ret;
 	}
 
 	xmp.ancestor = names[1];
-- 
2.37.0.874.g7d3439f13c4

