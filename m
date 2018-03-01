Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C02BE1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 16:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033226AbeCAQoZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 11:44:25 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40032 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033029AbeCAQoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 11:44:23 -0500
Received: by mail-wr0-f193.google.com with SMTP id o76so7251552wrb.7
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 08:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=nmVKiIKjoAza3ubX/U2YEryX/mwgMnHEQ0XTVmBXdxQ=;
        b=IZ5e26rIpNSUQse8EmXWCG34T3ZwJxzZ1wC7fdnvrw+l1krl8XNW5bhCxgkTiSEUVZ
         bNgvT+SDgm7ESJD1R9GOEGKfNeD26bW1+RU+2pOBvDiPMvPY0aHpPf9oFOWJrmjhK8Ci
         TSjolCTEe2SFNTTcGvVfYOmXdtsgsda1egksjH4otIh6WrVtfGch3uqmQdsN1T79D9fQ
         4pPliEK/wcF/LGkeQnozIiFLFiaBjaJBYYGfB/x32O8YBazSExOzTMIQP2UwDngUPL7P
         axoOF6pvRKx7KEHJ/J2LZharjHGp8+Ab/1Yrk62q7J0dZ436qpi3fBK40Me4SkOdM9mK
         PuUg==
X-Gm-Message-State: APf1xPByC7V7l+hcanVky9QqUy9s8Xs2s5QeI0qUWxQHAbNiM6GsLMgV
        E//U7GSXmP/f5iUI0rWHl1YseA==
X-Google-Smtp-Source: AG47ELuvWfh0TibHSXB73FIJXZjutS6ahvO0IgSb8GBQkNAIKJ3GYLXdJyV9l2ATJdrwcLNtekXHfw==
X-Received: by 10.223.163.93 with SMTP id d29mr2510447wrb.187.1519922662324;
        Thu, 01 Mar 2018 08:44:22 -0800 (PST)
Received: from juno.home.vuxu.org ([2001:4ca0:0:f224:a288:b4ff:fea1:ce50])
        by smtp.gmail.com with ESMTPSA id h1sm3666096wre.16.2018.03.01.08.44.20
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 08:44:21 -0800 (PST)
Received: from localhost (juno.home.vuxu.org [local])
        by juno.home.vuxu.org (OpenSMTPD) with ESMTPA id d1ac4333
        for <git@vger.kernel.org>;
        Thu, 1 Mar 2018 16:44:20 +0000 (UTC)
From:   Leah Neukirchen <leah@vuxu.org>
To:     git@vger.kernel.org
Subject: [RFC PATCH] color: respect the $NO_COLOR convention
Date:   Thu, 01 Mar 2018 17:44:20 +0100
Message-ID: <87zi3reoez.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the NO_COLOR environment variable is set to any value, default to
disabling color, i.e. resolve 'auto' to false.

NO_COLOR (http://no-color.org/) is a comprehensive approach to disable
colors by default for all tools:
> All command-line software which outputs text with ANSI color added
> should check for the presence of a NO_COLOR environment variable that,
> when present (regardless of its value), prevents the addition of ANSI
> color.

Signed-off-by: Leah Neukirchen <leah@vuxu.org>
---

This is a first stab at implementing NO_COLOR for git, effectively
making it then behave like before colors were enabled by default.

I feel this should be documented somewhere, but I'm not sure where the
best place is.  Perhaps in config.ui, or the Git environment variables
(but they all start with GIT_).

 color.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/color.c b/color.c
index d48dd947c..59e9c2459 100644
--- a/color.c
+++ b/color.c
@@ -326,6 +326,8 @@ int git_config_colorbool(const char *var, const char *value)
 
 static int check_auto_color(void)
 {
+	if (getenv("NO_COLOR"))
+		return 0;
 	if (color_stdout_is_tty < 0)
 		color_stdout_is_tty = isatty(1);
 	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
-- 
2.16.2
