Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB808C4320A
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C383E60EE4
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhH0VEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:04:31 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:49274 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231570AbhH0VEa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:04:30 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:9445:15b5:7384:b79b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id D39D44EB41C;
        Fri, 27 Aug 2021 23:03:34 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1630098215; bh=WQHSQg8XzWGAFoH0M9uSSpQwnYvz9k/G7UkX3v9vMOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DnP4RuhopDwnc3ur505PknwPueHsKwIj18S1VvSa9z6Na6NUVFnP2ntJACoDlhnnP
         zI0Sls02Qsi7mTNUydtQH247uT5nmhnC6eeVvONRQSBVPgqi3sgnX2hPqpGTqlM8On
         ijIRQGaI7QtDKeSmfC1wSh/GamZMn3HBomWNysWU=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v9 1/3] =?UTF-8?q?cache.h:=20Introduce=20a=20generic=20"xd?= =?UTF-8?q?g=5Fconfig=5Fhome=5Ffor(=E2=80=A6)"=20function?=
Date:   Fri, 27 Aug 2021 23:02:53 +0200
Message-Id: <20210827210255.12565-2-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210827210255.12565-1-lenaic@lhuard.fr>
References: <20210823204011.87023-1-lenaic@lhuard.fr>
 <20210827210255.12565-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current implementation of `xdg_config_home(filename)` returns
`$XDG_CONFIG_HOME/git/$filename`, with the `git` subdirectory inserted
between the `XDG_CONFIG_HOME` environment variable and the parameter.

This patch introduces a `xdg_config_home_for(subdir, filename)` function
which is more generic. It only concatenates "$XDG_CONFIG_HOME", or
"$HOME/.config" if the former isn’t defined, with the parameters,
without adding `git` in between.

`xdg_config_home(filename)` is now implemented by calling
`xdg_config_home_for("git", filename)` but this new generic function can
be used to compute the configuration directory of other programs.

Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
---
 cache.h |  7 +++++++
 path.c  | 13 ++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index bd4869beee..79c4e17ea4 100644
--- a/cache.h
+++ b/cache.h
@@ -1295,6 +1295,13 @@ int is_ntfs_dotmailmap(const char *name);
  */
 int looks_like_command_line_option(const char *str);
 
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CONFIG_HOME/$subdir/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
+ * "$HOME/.config/$subdir/$filename". Return NULL upon error.
+ */
+char *xdg_config_home_for(const char *subdir, const char *filename);
+
 /**
  * Return a newly allocated string with the evaluation of
  * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
diff --git a/path.c b/path.c
index 7bccd830e9..1b1de3be09 100644
--- a/path.c
+++ b/path.c
@@ -1503,21 +1503,28 @@ int looks_like_command_line_option(const char *str)
 	return str && str[0] == '-';
 }
 
-char *xdg_config_home(const char *filename)
+char *xdg_config_home_for(const char *subdir, const char *filename)
 {
 	const char *home, *config_home;
 
+	assert(subdir);
 	assert(filename);
 	config_home = getenv("XDG_CONFIG_HOME");
 	if (config_home && *config_home)
-		return mkpathdup("%s/git/%s", config_home, filename);
+		return mkpathdup("%s/%s/%s", config_home, subdir, filename);
 
 	home = getenv("HOME");
 	if (home)
-		return mkpathdup("%s/.config/git/%s", home, filename);
+		return mkpathdup("%s/.config/%s/%s", home, subdir, filename);
+
 	return NULL;
 }
 
+char *xdg_config_home(const char *filename)
+{
+	return xdg_config_home_for("git", filename);
+}
+
 char *xdg_cache_home(const char *filename)
 {
 	const char *home, *cache_home;
-- 
2.33.0

