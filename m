Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2858EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjFPXfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjFPXez (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:34:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A33F3AA3
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:34:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f766777605so1793774e87.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686958492; x=1689550492;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VteroWcXg7OjSzSWfZStLWd+ECcjfqX7/t6DwmOoWdQ=;
        b=X+oPHq2vmaLWbVNXXMivax0cEiMS3nKB8C1R4bPtMfC0YajIjPLC4hdV++sfa4v0is
         f4zKlM0wB6uw+mlEUWfuRV3H75A2Sb41VnzGpWAV7bKmTFcVZV2Wt+16iHL73k5diA04
         Njc4dxFVnWkVUe1YxMEjw2hZqx7+Qyah4LU1jXH2TL0Q6bxABZcN6aQqg+exA/uvF4G4
         ynUBzKmqZ6nv/kZhd3DP4tlxE3alBlhMAxeuYJ5ODDHVjw1NAsJNd5//HzCDICcP0qhz
         vWnuwj3ikZe1qdt5IqPTVSeF03lqazv3VT05PTd8TDGmWmiuUwIVpkFamq7w5HQ2DJ5/
         7Owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686958492; x=1689550492;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VteroWcXg7OjSzSWfZStLWd+ECcjfqX7/t6DwmOoWdQ=;
        b=UluZFxU24p9F3J+2y3TqO4O25WoSRbtzDwRXAUIkJohPKoyIR1qCKljokR9Km38BE/
         VeHkkzfqCJtnlKh8HC8+RcbJU+FjKundWnjFM2dxbdWRFe1fH2KIHlShMK8H1NOHKo4C
         JSl7DHIIJhKbUz28OPih26sVz95sXLZfKf6R74Fmdm3Zr4Li2An6C2CaCEs5P+c6D2vc
         3T47gWhY2Ji+tZuT+MiY0DOKWKHyoTM7a4JcoClUry9SZzbzFzkRGgH7UAMVIctfdtI6
         3bZbiefpeigSSqj57jUZFaH1RbBm/bwTPJpYgVLux8CH2Tyo/grtV8OuQF+GK/Rd2Nci
         Sflg==
X-Gm-Message-State: AC+VfDww/UlX8X5pC3OqMBswTWFPDHctn93xzzkK7G2gZ6TYHa/Lwvxq
        EieV1B+lATQoxUP5O70T9SmsiawMs8E=
X-Google-Smtp-Source: ACHHUZ4zlClulfszzJR2WZSArqVSi86NesG66F7AD9VaZxPn0psTNzj0cC+bc1MQXgIuKhKkIlACCQ==
X-Received: by 2002:a19:9118:0:b0:4f8:46a6:958c with SMTP id t24-20020a199118000000b004f846a6958cmr2236556lfd.18.1686958492515;
        Fri, 16 Jun 2023 16:34:52 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id l5-20020a1ced05000000b003f70a7b4537sm3368848wmh.36.2023.06.16.16.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 16:34:51 -0700 (PDT)
Subject: [PATCH v2 4/5] config: fix a leak in
 git_config_copy_or_rename_section_in_file
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Message-ID: <adaa7fa7-befe-ce59-7391-5a4ddd3bb2b8@gmail.com>
Date:   Sat, 17 Jun 2023 01:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A branch can have its configuration spread over several configuration
sections.  This situation was already foreseen in 52d59cc645 (branch:
add a --copy (-c) option to go with --move (-m), 2017-06-18) when
"branch -c" was introduced.

Unfortunately, a leak was also introduced:

   $ git branch foo
   $ cat >> .git/config <<EOF
   [branch "foo"]
   	some-key-a = a value
   [branch "foo"]
   	some-key-b = b value
   [branch "foo"]
   	some-key-c = c value
   EOF
   $ git branch -c foo bar

   Direct leak of 130 byte(s) in 2 object(s) allocated from:
       ... in xrealloc wrapper.c
       ... in strbuf_grow strbuf.c
       ... in strbuf_vaddf strbuf.c
       ... in strbuf_addf strbuf.c
       ... in store_create_section config.c
       ... in git_config_copy_or_rename_section_in_file config.c
       ... in git_config_copy_section_in_file config.c
       ... in git_config_copy_section config.c
       ... in copy_or_rename_branch builtin/branch.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

Let's fix it.

Let's also modify the function store_create_section() so that it stops
returning a strbuf, which is an uncommon pattern in our code base, and
instead, starts receiving the strbuf to use from its caller.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 config.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/config.c b/config.c
index 39a7d7422c..c5f4b59ef3 100644
--- a/config.c
+++ b/config.c
@@ -3140,37 +3140,36 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static struct strbuf store_create_section(const char *key,
-					  const struct config_store_data *store)
+static void store_create_section(const char *key,
+				const struct config_store_data *store,
+				struct strbuf *sb)
 {
 	const char *dot;
 	size_t i;
-	struct strbuf sb = STRBUF_INIT;
 
 	dot = memchr(key, '.', store->baselen);
 	if (dot) {
-		strbuf_addf(&sb, "[%.*s \"", (int)(dot - key), key);
+		strbuf_addf(sb, "[%.*s \"", (int)(dot - key), key);
 		for (i = dot - key + 1; i < store->baselen; i++) {
 			if (key[i] == '"' || key[i] == '\\')
-				strbuf_addch(&sb, '\\');
-			strbuf_addch(&sb, key[i]);
+				strbuf_addch(sb, '\\');
+			strbuf_addch(sb, key[i]);
 		}
-		strbuf_addstr(&sb, "\"]\n");
+		strbuf_addstr(sb, "\"]\n");
 	} else {
-		strbuf_addch(&sb, '[');
-		strbuf_add(&sb, key, store->baselen);
-		strbuf_addstr(&sb, "]\n");
+		strbuf_addch(sb, '[');
+		strbuf_add(sb, key, store->baselen);
+		strbuf_addstr(sb, "]\n");
 	}
-
-	return sb;
 }
 
 static ssize_t write_section(int fd, const char *key,
 			     const struct config_store_data *store)
 {
-	struct strbuf sb = store_create_section(key, store);
+	struct strbuf sb = STRBUF_INIT;
 	ssize_t ret;
 
+	store_create_section(key, store, &sb);
 	ret = write_in_full(fd, sb.buf, sb.len);
 	strbuf_release(&sb);
 
@@ -3833,7 +3832,9 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 						output[0] = '\t';
 					}
 				} else {
-					copystr = store_create_section(new_name, &store);
+					strbuf_reset(&copystr);
+					store_create_section(new_name, &store,
+							     &copystr);
 				}
 			}
 			remove = 0;
-- 
2.40.1

