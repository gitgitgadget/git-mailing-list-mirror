Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05685C32792
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 21:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiHVVPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiHVVPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 17:15:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28D7326DE
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 14:15:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r16so14713592wrm.6
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7mr1Af2DN/k1Hvdv82SbmxwTbpF3iGvPja4pljf4idg=;
        b=W7IvvIS7TdZmj4y/ZGx+EI9re2OWS435rAAiBPphNB5g0nGeUoeXkJop1q2Ip/5Hky
         hWQmWC0455ao1PW9LFJ4gvYLExIH+4DWyhdk1BrTSg9WWKD6wGjn3i8YrpnPdxTkGPi/
         CNWyLfggjBxuEXP39jy/Ff6joL33r6170BGWWeNjoIcwDA7qVKxit5YfnM3JxsJkZhY3
         UL0q50zld9HTUnXjBdPPhq5GHtS+jNXzGQmBxAD6XqvaaWpmT203jrYwUlunsgcwCL6H
         RSHhBfhLDcvEjjjmpZatYJxd50tjDg6Xyt0YVJ5Uq6lP/LeT3pQ7OpaEMvI5Pc0JhTzL
         rMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7mr1Af2DN/k1Hvdv82SbmxwTbpF3iGvPja4pljf4idg=;
        b=IY1SnX0FQl8cs2Xb53TyftbSJdOtjVNzdxAoZG3HLgjEJl80JV1o7GPlbIofctdy9e
         DPD7L7yRqqFhttU6tADbH5qW/PrcLTUCq28etMUCpTD3B/vvMfksxTP0KfRIiZz6KtrE
         +l7rZBcS1SYHSvBwJFC05jMq2K9jeQi1f1ENqNVZQYo7ubI908NGrnCiPyEZBAPYHSRK
         +wYM3awB6RQYLbFas9GqdYujPYRroc9vw1gO1JR4Bbq46+VJDHDqPzn38hYdNRr57Wli
         +lWDOfIjUWJDpUteQq1yRMDn6ogSS5jOnNrVFg1FKy6V0EGffTb6cM0J4MDFz3RfjLCk
         kzSg==
X-Gm-Message-State: ACgBeo2S6AeXFkElNGr0qB/NCrqrpp5qfoUH4DRYnjxxmGADk1Lq7jhA
        IEczw+4YLyoJqVGKB8j0soN5QtVAHTQ=
X-Google-Smtp-Source: AA6agR4/0k+atDNG5OLeC/Y4w+99sa2CHX++hYoFsi/1c/PF/ODnqRjPTmCtIrrKSEc9Z6f/2ET97Q==
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id a8-20020a056000188800b00222ca41dc26mr11095086wri.442.1661202914123;
        Mon, 22 Aug 2022 14:15:14 -0700 (PDT)
Received: from rah.. (2a02-8429-8157-8b01-3203-c8ff-fe28-5999.rev.sfr.net. [2a02:8429:8157:8b01:3203:c8ff:fe28:5999])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c384900b003a35ec4bf4fsm15902928wmr.20.2022.08.22.14.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:15:13 -0700 (PDT)
From:   Anthony Delannoy <anthony.2lannoy@gmail.com>
To:     git@vger.kernel.org
Cc:     Anthony Delannoy <anthony.2lannoy@gmail.com>
Subject: [PATCH v2 1/1] pathspec: fix memleak
Date:   Mon, 22 Aug 2022 23:15:07 +0200
Message-Id: <20220822211507.8693-2-anthony.2lannoy@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220822211507.8693-1-anthony.2lannoy@gmail.com>
References: <20220822211507.8693-1-anthony.2lannoy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak occuring in case of pathspec copy in preload_index.

Direct leak of 8 byte(s) in 8 object(s) allocated from:
    #0 0x7f0a353ead47 in __interceptor_malloc (/usr/lib/gcc/x86_64-pc-linux-gnu/11.3.0/libasan.so.6+0xb5d47)
    #1 0x55750995e840 in do_xmalloc /home/anthony/src/c/git/wrapper.c:51
    #2 0x55750995e840 in xmalloc /home/anthony/src/c/git/wrapper.c:72
    #3 0x55750970f824 in copy_pathspec /home/anthony/src/c/git/pathspec.c:684
    #4 0x557509717278 in preload_index /home/anthony/src/c/git/preload-index.c:135
    #5 0x55750975f21e in refresh_index /home/anthony/src/c/git/read-cache.c:1633
    #6 0x55750915b926 in cmd_status builtin/commit.c:1547
    #7 0x5575090e1680 in run_builtin /home/anthony/src/c/git/git.c:466
    #8 0x5575090e1680 in handle_builtin /home/anthony/src/c/git/git.c:720
    #9 0x5575090e284a in run_argv /home/anthony/src/c/git/git.c:787
    #10 0x5575090e284a in cmd_main /home/anthony/src/c/git/git.c:920
    #11 0x5575090dbf82 in main /home/anthony/src/c/git/common-main.c:56
    #12 0x7f0a348230ab  (/lib64/libc.so.6+0x290ab)

Signed-off-by: Anthony Delannoy <anthony.2lannoy@gmail.com>
---
 preload-index.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/preload-index.c b/preload-index.c
index e5529a5863..100f7a374d 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -151,6 +151,12 @@ void preload_index(struct index_state *index,
 	}
 	stop_progress(&pd.progress);
 
+	if (pathspec) {
+		/* earlier we made deep copies for each thread to work with */
+		for (i = 0; i < threads; i++)
+			clear_pathspec(&data[i].pathspec);
+	}
+
 	trace_performance_leave("preload index");
 
 	trace2_data_intmax("index", NULL, "preload/sum_lstat", t2_sum_lstat);
-- 
2.35.1

