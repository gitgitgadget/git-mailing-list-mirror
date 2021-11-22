Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4956C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbhKVQHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhKVQHW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:07:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49467C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d24so33710237wra.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=numg2sUiYQFFQqn3o7Iy/EI7UgPrvZ2S3arNtaevepE=;
        b=XhoUmsuBWt8gj+SSCjsM0diwxdOJ6dCB8/O29T/pJm9OyAWs/AFN03kA1Qf1e4qwSm
         pbaKBrFwgP12cgyPfK0bwwI2v79E06GrJYLJdXkfgX0MNH+2l7Y7lAoTJoVO5Nw927N4
         ZH31NCUnynW//UyqktUZDPtu1TD5WGupBI7Uzl8aJmeedRrA+RXcPPreX4umoJrggEBO
         DNQLsRxhMLa5jXnx5HHHe376H9tZjBRNCXh/+4iNtHkVwej+EtQAnlueqWoEKRsFaMN0
         eFDU/SnSLi3pxtWsMEw+bSwnhYEQXEU1ekNadWhUrw8I5dYU1NiEvEDAbx0KEydliReB
         Y+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=numg2sUiYQFFQqn3o7Iy/EI7UgPrvZ2S3arNtaevepE=;
        b=LsRtNLIROZYSvd/YSg09ku6S6TBtMBmDFiRGJ5Sj/C1lSWsa0ooN4CeP87w/7oN2GU
         I0HewmNS+Ml06rlUepi8RzGSJSheuqCB1nk+XPce9LzwVpUwSLt3h4JUye6sckRHEPyS
         WJ+yVphWv+r3AKMK3nUCOVnDNx+HNegYj1ZvM9U6r1bbD//DLEIEQUh8nMIBO0+uyx/J
         Zer6EewUXAewq+S0cUVSAt4JcUdYAIqWnMbV3cVqrd9h2h4stH2DSYgFvUtuhCHCkQT9
         68S2L3GoG4v/F3tXC87ABBaKKDCMlj9r5BxUAgc/OPQcbGg1obnWPWtx6H2wwlgaF1vH
         UwIw==
X-Gm-Message-State: AOAM533vokuR0uYdHUuwEoCVkpZlZGuPMb6ppoiWjf8xkhUyFTKCBPtc
        9i7mBS4AsgLrSWU1M8dUgzTGntnO/jaSSg==
X-Google-Smtp-Source: ABdhPJyFwre84enu52/USmU99wcHRlsQxv4YW7svWF7T64cnmUpylhiDIgVng/ocOJhej8Ry8DaQuA==
X-Received: by 2002:a5d:468f:: with SMTP id u15mr38952977wrq.171.1637597053468;
        Mon, 22 Nov 2021 08:04:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm24005953wmc.43.2021.11.22.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:04:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] archive-tar: use our own cmd.buf in error message
Date:   Mon, 22 Nov 2021 17:04:03 +0100
Message-Id: <patch-1.5-1d8cab554bb-20211122T153605Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.822.gf3f912c366d
In-Reply-To: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net> <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "cmd.buf" we just created in this function, instead of the
argv[0], which we assigned "cmd.buf" for. This is in preparation for
getting rid of the use of "argv" in this function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive-tar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 05d2455870d..4154d9a0953 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -447,7 +447,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	filter.in = -1;
 
 	if (start_command(&filter) < 0)
-		die_errno(_("unable to start '%s' filter"), argv[0]);
+		die_errno(_("unable to start '%s' filter"), cmd.buf);
 	close(1);
 	if (dup2(filter.in, 1) < 0)
 		die_errno(_("unable to redirect descriptor"));
@@ -457,7 +457,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 
 	close(1);
 	if (finish_command(&filter) != 0)
-		die(_("'%s' filter reported error"), argv[0]);
+		die(_("'%s' filter reported error"), cmd.buf);
 
 	strbuf_release(&cmd);
 	return r;
-- 
2.34.0.822.gb876f875f1b

