Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98033C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhLGLei (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhLGLeh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 06:34:37 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A8C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 03:31:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so55987942edv.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 03:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iQIiEfFJ2h3wm4isyefDNM4M2w7n98VzxJzVdCxiSg=;
        b=jY73rk/OkpycYe3QebP+k4rd72ruSxUWicQLG/eYNY9ZD4A05UTheS+vDVdLSjhhg2
         TgfLXvVHtQHrN2kv23XIH5XVvIxik3LGMUZb7/WyBuAUCslfcuiK/CpG4aDALvRlOtKH
         rYdIHEx0oHGWDkwXz7hc59nwnknvK1o1Walle+vwcrhZgoJD5W9QqfbpZwTznlxlSQ8T
         U7VR6Zatpd7AMOAA52lBhNBFU7m+uRkkrvEl9w5ufHqn9ulvLJCZePV3qDTxCBbJFgBh
         dqmc6TWPSpMtZpt59OZ5z7OB2JToxmgPEpXa4wxKaV0tcd6SsJNhAijzkDKDjpqgBIXy
         /siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iQIiEfFJ2h3wm4isyefDNM4M2w7n98VzxJzVdCxiSg=;
        b=Pd24P42p0fT5hrlhq3u105U8ge8GtlZ/9JnjgVF0aExnShxWm6n6CT+Rc0mrduZtrz
         WJfD6NEoyLbzdMt8+mPeLyXqPmm3PHg9ZUyYz7iACRnf6wxlk0OpYpR+rnFqV9vstiDx
         m/MYy/7jF0eD/+1WNZfK/oKnY9RGaDLuFsD2KN6wrgRWS3YNBE62piV+dDG2aj6g5Rn+
         2OF+oTLh7ZSoG+B8xbFWgD95arghaM3cJ/bLAvOD4JAe1XZObmTxcTXCUS05F/7hNnlb
         t0KHbsCmEJ88d3eGaGa44do05OVoO87GvewvVltaPfHu7oNgspqY3HW/3T35tU7FGtA4
         rRZQ==
X-Gm-Message-State: AOAM532VsOFHhFOOOnp9wzRMnbHV1LBs5xFNKdono+vYdHkdD2/96ScP
        rG+Bh8Z8KZ/DvSATOm9lhk+xHkf/cgiREw==
X-Google-Smtp-Source: ABdhPJyEpxDCDcVWtbDMCY+aThKjif/BKMdwanAa7dWyunCTutbpjQ0jglqp7YSA6UTqCOMVXPGZNg==
X-Received: by 2002:a17:906:4e42:: with SMTP id g2mr52264314ejw.230.1638876666162;
        Tue, 07 Dec 2021 03:31:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:29b:3b00:d35d:e3cf:58b5:748b])
        by smtp.gmail.com with ESMTPSA id aq6sm8353670ejc.41.2021.12.07.03.31.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 03:31:05 -0800 (PST)
From:   Alexander Kanavin <alex.kanavin@gmail.com>
To:     git@vger.kernel.org
Subject: Build race observed with git 2.34.1 - hook-list.h wasn't generated yet
Date:   Tue,  7 Dec 2021 12:31:01 +0100
Message-Id: <20211207113101.69686-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specifically:

 builtin/bugreport.c:7:10: fatal error: hook-list.h: No such file or directory
|     7 | #include "hook-list.h"
|       |          ^~~~~~~~~~~~~
| compilation terminated.

Please see here for the full log:
https://autobuilder.yoctoproject.org/typhoon/#/builders/59/builds/4427/steps/14/logs/stdio

Seems like COMPUTE_HEADER_DEPENDENCIES isn't working quite right? I meanwhile have set it to
'no'.

Thanks,
Alexander
