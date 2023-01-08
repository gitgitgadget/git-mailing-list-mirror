Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B89BC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 06:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjAHGZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 01:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjAHGZA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 01:25:00 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D2A27199
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 22:24:59 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v23so1241049plo.1
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 22:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMA05UlF9ER51m5ZtVyHeDW7DSWz0Um+7ejRazix8Zw=;
        b=pqoloDrK/7OFaU1t0Ryrpos2CFxogvp8ttR8iOEy0bVhY8bYPR9So855Gu/B5HsCEW
         9pHVbsWu04PGA9QHBkRuvd5XCR1RE9lIl5i7me74D2kD992u/NzSArHEPDUZyvsXMPZZ
         VqhN4SqES5kQHh7m9LToDrWw+Svn37jBer0laGsbm246bhzLr1QSb/eDodNe5bQKGQqF
         BRAH2vZ5/yRfmQE6S+AmdVbhwz6oAKblgC+k0+Fdm/ewcHgqJXlVb31FlT+5/RDlMQSY
         HgP0AeLUbkBOXUqtVwgJws2jbLLL6/mYhcBmVwsn4qX9RHXtPmmfksclyDAIYHB7eOWS
         q9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMA05UlF9ER51m5ZtVyHeDW7DSWz0Um+7ejRazix8Zw=;
        b=ZR61646060WN7g1P5fW32WVmZBVbyZdETxyNJvGv0n6ePrVNQwIOwlPbV3WMKYjIA0
         4wJ8YwhTEQfaOQxQhlWzyWCZj0jCue7Zbq4+Kp3CULlwaB/GW48MfeWKZWYcbbQ6/QeW
         wVxQ9VKjfJnCMlAFwvSWoRAGNYURCsmXKmz+N/ZqGui3KM9lLyrYRQHx9qKsGSz5YK1N
         KFN8dSfgyrDl/hyMCR307nNU87t0pSAlaDamkb3Yc4p3o5SlbttEp4f9xVOvvrUoUKdG
         ZAlG7nNPod/IG+D/dwGw4xmFFGNQyI4ZDz7NItsQim+iiqC9HXMPIAGXEzcSgbk409Tm
         j3VA==
X-Gm-Message-State: AFqh2koDRH1RaTlvQ73ApNIZa5U4ptT7zd6YMzUM6P2kgT3KVn6eXG/n
        N2VqKnUPsSNfK8EF1ibRZjDhzUf0gRA=
X-Google-Smtp-Source: AMrXdXtLe+U9wP1lifbuxEffGu1XtQwwQ74MqIFm2lOC35HVvysZY7nPSWC4HEJYrIXX36oKbG8IdQ==
X-Received: by 2002:a17:903:2c2:b0:189:c8d9:ed30 with SMTP id s2-20020a17090302c200b00189c8d9ed30mr57714660plk.24.1673159098562;
        Sat, 07 Jan 2023 22:24:58 -0800 (PST)
Received: from localhost.localdomain (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b00189618fc2d8sm3578788plh.242.2023.01.07.22.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 22:24:57 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] grep: correctly identify utf-8 characters with \{b,w} in -P
Date:   Sat,  7 Jan 2023 22:23:35 -0800
Message-Id: <20230108062335.72114-1-carenas@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When UTF is enabled for a PCRE match, the corresponding flags are
added to the pcre2_compile() call, but PCRE2_UCP wasn't included.

This prevents extending the meaning of the character classes to
include those new valid characters and therefore result in failed
matches for expressions that rely on that extention, for ex:

  $ git grep -P '\bÆvar'

Add PCRE2_UCP so that \w will include Æ and therefore \b could
correctly match the beginning of that word.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 06eed69493..1687f65b64 100644
--- a/grep.c
+++ b/grep.c
@@ -293,7 +293,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		options |= PCRE2_CASELESS;
 	}
 	if (!opt->ignore_locale && is_utf8_locale() && !literal)
-		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
+		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
 
 #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
-- 
2.37.1 (Apple Git-137.1)

