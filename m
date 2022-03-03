Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA85C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 22:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiCCW0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiCCW0E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 17:26:04 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6746F3EB8D
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 14:25:18 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id gm1so5280347qvb.7
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mBsb2dj4ew7ZZPlAeyIvH7wqWuNyLXInlVJ1SHzSLCg=;
        b=4BQri2u54NeVDRMbl+p3kuymHzcSgwcq8Ex6TXaKYBfytc+UJTDzBvagOkbTqtV4H5
         54q6qn12SNyjRrtwWCHEGOWjAAVee5coCCgZJNV34jPyqRoHmtZhpi2tVeDyVOqW0gNt
         YGeUdqBQ45g9hUpiqQ6RGn0JDp3Sx2OotnrWUSUNxPIcVhsku91URSTu12rwmsMoBzIF
         oyuqB8oX5RvGHPG/HpoSmKlPcnv0UV3K6GBg+ps+EsURibBdWvVA2lXI42vyQIOxMOI9
         Yv525wiOShVrXp0KAhcNzXLn+yPEd6IloVxQqNU8qRx88j1MUq9ozcl8KhoE4uYtd66j
         qycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mBsb2dj4ew7ZZPlAeyIvH7wqWuNyLXInlVJ1SHzSLCg=;
        b=Oe647TF3d8ug2FAasPYL3BAzsL5nsMnaQfw9wf0jwt87GkqktAfLgud6Ka706q/ItF
         H46+Du2PWkWn8XCazYR73NhLwqfd4jY6oy7xzdRoodc+GFKRzn2fEweBENc6Nl2eYH5L
         0DlBJHuBiNPR5gxUmsb2cNAarfDxGCLqk9e29ZlFBQREMxzWLlCyoikF9Ijd+vvRvLWv
         WkHDFHppDMoXeTL7CEhf98lGlsiIZ8aULA4fQnWO69Y3LpxdVcPMrs8nhIsN/tVqgDXN
         lyQ8mcZU/ZpRsReINMccLGphxJbxZZFR2iCRZaVmvptdE6b0MSI6OdypvG+9lbUduwqs
         jMDQ==
X-Gm-Message-State: AOAM531djSIcSHzj2+5TasUx+rPEJoj9pXYs4tn06x1Z0p4MS8UoyQxB
        PybE8UdeiK8Sg68xlM6EGx3TOMaAPZhK02R7
X-Google-Smtp-Source: ABdhPJxhN1sQxoy4I/JBjqA2fheEHM1xyCLPT9Tq1ZZTmQfj7RKabogIavfyDZ0NpNZrKJgxHKSeQg==
X-Received: by 2002:a05:6214:2269:b0:435:1a8b:f98b with SMTP id gs9-20020a056214226900b004351a8bf98bmr8003486qvb.66.1646346317389;
        Thu, 03 Mar 2022 14:25:17 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v14-20020a05622a014e00b002cf75f5b11esm2290224qtw.64.2022.03.03.14.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:25:17 -0800 (PST)
Date:   Thu, 3 Mar 2022 17:25:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, derrickstolee@github.com,
        avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v3 1/2] builtin/remote.c: parse options in 'rename'
Message-ID: <b76da50b549d71b3e61f74c6250fea595ee2b2c1.1646346287.git.me@ttaylorr.com>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <cover.1646346286.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646346286.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'git remote rename' command doesn't currently take any command-line
arguments besides the existing and new name of a remote, and so has no
need to call parse_options().

But the subsequent patch will add a `--[no-]progress` option, in which
case we will need to call parse_options().

Do so now so as to avoid cluttering the following patch with noise, like
adjusting setting `rename.{old,new}_name` to argv[0] and argv[1], since
parse_options handles advancing argv past the name of the sub-command.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/remote.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 6f27ddc47b..824fb8099c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -684,11 +684,14 @@ static int mv(int argc, const char **argv)
 	struct rename_info rename;
 	int i, refspec_updated = 0;
 
-	if (argc != 3)
+	argc = parse_options(argc, argv, NULL, options,
+			     builtin_remote_rename_usage, 0);
+
+	if (argc != 2)
 		usage_with_options(builtin_remote_rename_usage, options);
 
-	rename.old_name = argv[1];
-	rename.new_name = argv[2];
+	rename.old_name = argv[0];
+	rename.new_name = argv[1];
 	rename.remote_branches = &remote_branches;
 
 	oldremote = remote_get(rename.old_name);
-- 
2.35.1.73.gccc5557600

