Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49162C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E1F61153
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhEXHZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:25:06 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:42844 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232128AbhEXHZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:25:05 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:cea:a9d0:f3e1:f159])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 63F3347424D;
        Mon, 24 May 2021 09:16:34 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1621840594; bh=z7oA1Uspo3XW5e9wGtD8hGngk9B8g1NsQVwWyQbGFV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Cu1r2q3IkXbxKoW31mbZaH8D4gxNiMSqxnHE3MvQe25hxKIFaPi1tsZBrS8Vzg09e
         xv9qRI7ARXlmWcUvtjWwAYA9B4bqS9PZMAofeo3fds8YBDbEJpPqhvVxHif/jpQ7OP
         GKLiyKwT92+z23NBhjlnBH5VmHQcg+uE3OkXbHaQ=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
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
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v4 1/4] =?UTF-8?q?cache.h:=20Introduce=20a=20generic=20"xd?= =?UTF-8?q?g=5Fconfig=5Fhome=5Ffor(=E2=80=A6)"=20function?=
Date:   Mon, 24 May 2021 09:15:35 +0200
Message-Id: <20210524071538.46862-2-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524071538.46862-1-lenaic@lhuard.fr>
References: <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210524071538.46862-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current implementation of `xdg_config_home(filename)` returns
`$XDG_CONFIG_HOME/git/$filename`, with the `git` subdirectory inserted
between the `XDG_CONFIG_HOME` environment variable and the parameter.

This patch introduces a `xdg_config_home_for(prog, filename)` function
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
index 148d9ab5f1..8a2969414a 100644
--- a/cache.h
+++ b/cache.h
@@ -1263,6 +1263,13 @@ int is_ntfs_dotgitattributes(const char *name);
  */
 int looks_like_command_line_option(const char *str);
 
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CONFIG_HOME/$prog/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
+ * "$HOME/.config/$prog/$filename". Return NULL upon error.
+ */
+char *xdg_config_home_for(const char *prog, const char *filename);
+
 /**
  * Return a newly allocated string with the evaluation of
  * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
diff --git a/path.c b/path.c
index 7b385e5eb2..3641d4c456 100644
--- a/path.c
+++ b/path.c
@@ -1498,21 +1498,28 @@ int looks_like_command_line_option(const char *str)
 	return str && str[0] == '-';
 }
 
-char *xdg_config_home(const char *filename)
+char *xdg_config_home_for(const char *prog, const char *filename)
 {
 	const char *home, *config_home;
 
+	assert(prog);
 	assert(filename);
 	config_home = getenv("XDG_CONFIG_HOME");
 	if (config_home && *config_home)
-		return mkpathdup("%s/git/%s", config_home, filename);
+		return mkpathdup("%s/%s/%s", config_home, prog, filename);
 
 	home = getenv("HOME");
 	if (home)
-		return mkpathdup("%s/.config/git/%s", home, filename);
+		return mkpathdup("%s/.config/%s/%s", home, prog, filename);
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
2.31.1

