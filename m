Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BA0C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028ED61027
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbhJHVsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243510AbhJHVsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:48:37 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55BCC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:46:41 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t2so10907163qtx.8
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zCctGPyQyu5tmeL7GcQhm1RAugrwDDNTLhgQBy8IzWg=;
        b=ryKzYQvff7UqpDeu1ZYuYCONAcr3U56U6b/5YiKyshvH3PWSMZgvlt1vH4A7OTyHFB
         MJq1Fhno1yu+tev/Zsgwvy+9WiJgGmlVgR4jhWcTOHnEGJDOpcpHpT608ViJM0eqGW3D
         A62TFsjeI86MPAgS2FhLc4/LDS9eQ8Ew1fjP+jx7XdCIogM/GUYY7J1vsrk1sP7M5E2V
         XNANar2mr8rmQEA5o78EDDdk/RZ5rtRCOfE/FD5+QiNJJ9wB45bvQk4sLBNOP9EXyfOC
         F1ttaFWVEM53Wu+iA2qvVer+MK8WYDT5WNg0XfgXp2oEB1qjmAEHaZRX5Yl5BLEPcuZ2
         Gxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zCctGPyQyu5tmeL7GcQhm1RAugrwDDNTLhgQBy8IzWg=;
        b=7OBMwdMemu57OMSEkaT/XiIbvLAWsAQsydGlsMZYZYELbtyRC1kQawz2rFr5HCHfJC
         4TMJSTbIMUs3I8AZ+kwXx9JM3w+Qja1mz5Nd0wXIeV0uGs09c9429bTQMumLwJtNtXtO
         +vMCsOsMJYw4TM1TVGZTQwTUCtlkGF82NQ883YVqGALSgpZsqjU6OxW0FgHfH05yzIJB
         Le3S+pbd0UAvYQLGSWkzJqcWJ6f+TJ5Roi3wVZbdB0HZgG5GfNzMB4XMqt11VqeITQio
         0t/kld1txxWc80BuTkjQeoZssuH6T/gm0Qhlsp3C8Ia09SrqtWCW5xtKDHu5Ss3kKRDn
         Nq3g==
X-Gm-Message-State: AOAM530vYujhtITZT6g1b19wOIuhopW52iTZnGIur8rIHLi157JkniXu
        JJRxJ9HClGXFuoJtlaN144l38F7lgFSD4A==
X-Google-Smtp-Source: ABdhPJwCHeyxb9gkeTc2Jmja9ZVvMxfCOlfjYevLPn5iRhU/OvVfrSMzFSEc9NW0S3dE3AoOrtdtuA==
X-Received: by 2002:aed:27c1:: with SMTP id m1mr802118qtg.241.1633729600039;
        Fri, 08 Oct 2021 14:46:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h125sm478719qkc.29.2021.10.08.14.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:46:39 -0700 (PDT)
Date:   Fri, 8 Oct 2021 17:46:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, dstolee@microsoft.com,
        jeffhost@microsoft.com, peff@peff.net
Subject: [PATCH 4/4] midx.c: guard against commit_lock_file() failures
Message-ID: <ed7407cefa89b973d1085973f4ddb39397597036.1633729502.git.me@ttaylorr.com>
References: <cover.1633729502.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1633729502.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a MIDX, we atomically move the new MIDX into place via
commit_lock_file(), but do not check to see if that call was successful.

Make sure that we do check in order to prevent us from incorrectly
reporting that we wrote a new MIDX if we actually encountered an error.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 137af3fc67..e79fb4427d 100644
--- a/midx.c
+++ b/midx.c
@@ -1434,7 +1434,8 @@ static int write_midx_internal(const char *object_dir,
 	if (ctx.m)
 		close_object_store(the_repository->objects);
 
-	commit_lock_file(&lk);
+	if (commit_lock_file(&lk) < 0)
+		die_errno(_("could not write multi-pack-index"));
 
 	clear_midx_files_ext(object_dir, ".bitmap", midx_hash);
 	clear_midx_files_ext(object_dir, ".rev", midx_hash);
-- 
2.33.0.96.g73915697e6
