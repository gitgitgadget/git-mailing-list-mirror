Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4795AC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 08:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiHLIR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 04:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiHLIRv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 04:17:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE3A5C47
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 01:17:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b6so222528wmq.5
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=D9IihiJFmsK7+3MZvceMBslsmAZ0pWNmy3y3wVHdf8w=;
        b=T946jzwCZL08+7qNDEov9ZmWGTC4gLKK3Hd/8vJT5no1EoQ4m3r3SYqZjvhcM9qBw5
         s2n55Olrk+QLg0lGsXHastvI+yEnITWh7V2kJ4N26Is4fnevG5QduzxHCdSISiEYFqov
         Tx9HIE3kRXWvDXLouHGpItf8XcFbWmAoQazNyCpolq4WjUEmhV2ag8cTrqi9EghvR2Qz
         sO9zAKuqunhr97eGhp+N6vZl3RBKW6MgDF4E+/dNT3enDA2D4aN8/zppoMDg0Tv2wdH+
         WapQsImhrFnDFIQkAsxS+tv1KlfWSOSu8GaWuUdkK1Wa0WSBBFSbDhfYc2/rqjmmsIyp
         MQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=D9IihiJFmsK7+3MZvceMBslsmAZ0pWNmy3y3wVHdf8w=;
        b=fuhgvFxgawoCpkq0/a+CYdzDoAWXy1BTWu41LW6DQdtmoqnya3wzioZgyiD9hQ2f1L
         652o9YQlnSOwQ/CQaebib0MC6pFhCcPGLWyhWSR3m/PbAb2e58m5DmzI0/0k6g/ZTFv1
         7+Ynvayo1IPITiVsQWYx0bfm4GZcA/siViiR/cL3y0Y/SEz/NzeKnnS1E1a/oWzvYGA5
         Xp+ObHcbU/75Q9epq+ktzoTZvxYCqCDLjbvgFkEEzTcrDf2bOkz2oR8CJD2R8pgfQiLr
         7F2FYUp+FFjxlWqsEEsMme8zaU/gbdVG993acfmiUw8gI4+rczRCCmPH3QkaBmxWliVQ
         F3WQ==
X-Gm-Message-State: ACgBeo3aAOOJ2wGiWgf+g4e7kOBoVH6w281YTJiyl0yBXayFnpnHoLa8
        GqXaJxo/R0Py3bFxOV9FS+i7mf1ZBAA=
X-Google-Smtp-Source: AA6agR6FGC2vM62GdkvBVrIQYX0w6WltDBDFpeR+ivm75iu5LWf5Wo4O0UDtaUGd4r6xGS/2lz8ODA==
X-Received: by 2002:a1c:f709:0:b0:3a0:3b29:5eb2 with SMTP id v9-20020a1cf709000000b003a03b295eb2mr8158590wmh.133.1660292269051;
        Fri, 12 Aug 2022 01:17:49 -0700 (PDT)
Received: from rah.. (2a02-8429-8157-8b01-3203-c8ff-fe28-5999.rev.sfr.net. [2a02:8429:8157:8b01:3203:c8ff:fe28:5999])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d494d000000b0021e4f595590sm1270501wrs.28.2022.08.12.01.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 01:17:48 -0700 (PDT)
From:   Anthony Delannoy <anthony.2lannoy@gmail.com>
To:     git@vger.kernel.org
Cc:     Anthony Delannoy <anthony.2lannoy@gmail.com>
Subject: [PATCH 1/1] pathspec: fix memleak
Date:   Fri, 12 Aug 2022 10:17:44 +0200
Message-Id: <20220812081744.456280-2-anthony.2lannoy@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812081744.456280-1-anthony.2lannoy@gmail.com>
References: <20220812081744.456280-1-anthony.2lannoy@gmail.com>
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
 preload-index.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/preload-index.c b/preload-index.c
index e5529a5863..a05f4d1390 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -148,6 +148,9 @@ void preload_index(struct index_state *index,
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join threaded lstat");
 		t2_sum_lstat += p->t2_nr_lstat;
+
+		if (pathspec)
+			free(p->pathspec.items);
 	}
 	stop_progress(&pd.progress);
 
-- 
2.35.1

