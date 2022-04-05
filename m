Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A089C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiDEFW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiDEFWb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D3CCE
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso1533703pjj.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PkvWYg7cTCPFuIf6ND5K/lWsJqv50XTk33QWTYlcXB0=;
        b=M/1iHLxC3VCGb/zJwwWe3cIRBFh0/mBG6fdIeUTsNxDjNDAtFsmc4GDZM39Y6CmqTO
         2DQze/E0HZOO+1TiJUq+z0bvlv+WHNM8S2uEgeO4RijrCiZmncTeXJ/gsye4mQ/A1jN2
         ijuWKJcZQ3pRAJAbC7AQsPbjCWpNiV1+tH6KLR7Zwl9PnXecloxV1FuSg6h+HznbHeW6
         4wXb1Nq2NMLFVbskwzOMCwyUN4CbBQEE4Dvbq5Gbw5ZROllYqYOz0BjzjpW/ycXVckHL
         yytGEmqV63deG941fh97i3PJ8E1SebH8EaygG+lZljTITZY2+tH+p1ttEoP/9WKVk9Yh
         AS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PkvWYg7cTCPFuIf6ND5K/lWsJqv50XTk33QWTYlcXB0=;
        b=Ex3O/rirvDRmtuoTh4Ki8mL4Eqy2aWKTzy2ygzFqLiS0o1ZlnwTdMlRZgTXrYZN0DS
         dXkEPhG98ERkW39538j8OYcD18/mOR6uxB94XjSkcE0HTbtnN1cfAPhhAmyUTthjIikC
         ei8LRhWVCnKBT1EIkbAOnGSdvhc2geTC6KaMEAFh6TFeZlX2bfFSHoh2iZL+wcqCN4TZ
         OJ1eUrM8MhkvyvhrCPJhGu1KuetdWSMUdbUgVPSmU6/OsVionIOLNn0DdXWsOT6Kaixz
         ImrdKd2AbtN/+1EB11lsAnX1p9XRaUH9wC3rmvbKhi4ntjgvrHU+l3I7nfViiylcnmfk
         yNMg==
X-Gm-Message-State: AOAM532+rb3PrRgNUc7c0xk/tMhIdJP1KJgitrO8idDX0K5mjejcm74r
        v91ispSeBwbzGe1bCXLmjeM=
X-Google-Smtp-Source: ABdhPJxRP1NbzIVbC17xiaGNRvOi9SKYJCTz3AeA4PiyS6zTY28uJ9oqqZVQ7XYhTJ2PmF9m6I8Brw==
X-Received: by 2002:a17:902:d2c8:b0:154:2b02:a499 with SMTP id n8-20020a170902d2c800b001542b02a499mr1617292plc.168.1649136032857;
        Mon, 04 Apr 2022 22:20:32 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:32 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 08/12] core.fsync: use batch mode and sync loose objects by default on Windows
Date:   Mon,  4 Apr 2022 22:20:14 -0700
Message-Id: <20220405052018.11247-9-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Git for Windows has defaulted to core.fsyncObjectFiles=true since
September 2017. We turn on syncing of loose object files with batch mode
in upstream Git so that we can get broad coverage of the new code
upstream.

We don't actually do fsyncs in the most of the test suite, since
GIT_TEST_FSYNC is set to 0. However, we do exercise all of the
surrounding batch mode code since GIT_TEST_FSYNC merely makes the
maybe_fsync wrapper always appear to succeed.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 cache.h           | 4 ++++
 compat/mingw.h    | 3 +++
 config.c          | 2 +-
 git-compat-util.h | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index ea1466340d7..600375f786a 100644
--- a/cache.h
+++ b/cache.h
@@ -1031,6 +1031,10 @@ enum fsync_component {
 			      FSYNC_COMPONENT_INDEX | \
 			      FSYNC_COMPONENT_REFERENCE)
 
+#ifndef FSYNC_COMPONENTS_PLATFORM_DEFAULT
+#define FSYNC_COMPONENTS_PLATFORM_DEFAULT FSYNC_COMPONENTS_DEFAULT
+#endif
+
 /*
  * A bitmask indicating which components of the repo should be fsynced.
  */
diff --git a/compat/mingw.h b/compat/mingw.h
index 6074a3d3ced..afe30868c04 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -332,6 +332,9 @@ int mingw_getpagesize(void);
 int win32_fsync_no_flush(int fd);
 #define fsync_no_flush win32_fsync_no_flush
 
+#define FSYNC_COMPONENTS_PLATFORM_DEFAULT (FSYNC_COMPONENTS_DEFAULT | FSYNC_COMPONENT_LOOSE_OBJECT)
+#define FSYNC_METHOD_DEFAULT (FSYNC_METHOD_BATCH)
+
 struct rlimit {
 	unsigned int rlim_cur;
 };
diff --git a/config.c b/config.c
index 8ff25642906..027210a739c 100644
--- a/config.c
+++ b/config.c
@@ -1342,7 +1342,7 @@ static const struct fsync_component_name {
 
 static enum fsync_component parse_fsync_components(const char *var, const char *string)
 {
-	enum fsync_component current = FSYNC_COMPONENTS_DEFAULT;
+	enum fsync_component current = FSYNC_COMPONENTS_PLATFORM_DEFAULT;
 	enum fsync_component positive = 0, negative = 0;
 
 	while (string) {
diff --git a/git-compat-util.h b/git-compat-util.h
index 4d444dca274..aaefd5b60c3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1257,11 +1257,13 @@ __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
 
+#ifndef FSYNC_METHOD_DEFAULT
 #ifdef __APPLE__
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
 #else
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_FSYNC
 #endif
+#endif
 
 enum fsync_action {
 	FSYNC_WRITEOUT_ONLY,
-- 
2.34.1.78.g86e39b8f8d

