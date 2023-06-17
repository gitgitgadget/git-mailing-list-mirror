Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA655EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 06:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbjFQGmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 02:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346068AbjFQGln (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 02:41:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A693B2D63
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:40:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso11090895e9.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686984044; x=1689576044;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwPsKY7R0Vwjt6UV+ihATXfK7DdmLjBP90TgwI8Ncyo=;
        b=Z6hKgTOldMKZBgtU5R+Fe2KQ0vpAoEZ44ZpNZC004EtGCQQsgCfRImetfmhzR1Ovud
         zv8llEj652Evn7TJN9C8HowT3U+TVRNQeApqT70Dy4HrtZCmYQb8AmwP+EEUOv+hlicR
         65PZiJGPRUZgpELg9euCZUtiniZmCIy4KJ1ye8JgUXOsegPLOX1P3xAUITQL5+a1MzYf
         WQTuEcb6EnjJx3BfXqnOI4WWZBsod3cxj0j2rmXPBb8ZnWvpTboSwzdXGgbHYoZeAdRf
         MO6xvwOi0NtNMSnb1wp58ryhOXcxmlhX6i60CR6YdYgVkbdSoWkESUoZDRLYPKh4k6Qq
         76Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686984044; x=1689576044;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwPsKY7R0Vwjt6UV+ihATXfK7DdmLjBP90TgwI8Ncyo=;
        b=C+2r+fIaFd9LZantb06iR4RVJWY2FRvkyjz/c6jj4EmQRf/e5xXAFQB6epNwknVjWI
         LkBQbGYB80xsZ0TlRDe6yzWGDU1Bq69rPV6wW+mt1UtTpS55caOmpkXV0VsNtJ57qS4a
         JmoypEVuI6TLUJz+mCSL2gecE5/1XZi61XPk+NSEewCmeiojQaCBkJ035zfI7ytBSu1z
         a9aP1JhoDG+JiN0DNmQBAHtCLqE5s9rR0mZBNZPBUsI6rkRsuH5tK5a81zeohSSfBvdr
         G5ljaFg5sDjOsM1scEfV9Ht0hLV2noI3hdm1cJ+W5qO28dqvK2cwVErERcvsE9HAuZyP
         hOww==
X-Gm-Message-State: AC+VfDzEKCya9NntDOykoeAo/cFhYp/hwE37hAXwaPk8bwTHBGabYiQU
        yYdvcKAg2/lGhGjHMTTV1MQ=
X-Google-Smtp-Source: ACHHUZ5sPLEWP5QFWlf/xu5OjioIKM2jlY34vznlcA5YnTdgMbfPVyqym6O+n85BN1nHPBMxh3QiuQ==
X-Received: by 2002:a7b:ce8a:0:b0:3f7:e7d5:6123 with SMTP id q10-20020a7bce8a000000b003f7e7d56123mr2806843wmj.41.1686984044462;
        Fri, 16 Jun 2023 23:40:44 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c024100b003f60e143d38sm4088811wmj.11.2023.06.16.23.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 23:40:44 -0700 (PDT)
Subject: [PATCH v3 1/5] rev-parse: fix a leak with --abbrev-ref
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
 <71b49be1-eeef-2f60-38f1-cfcbe4c8252f@gmail.com>
Message-ID: <38534e6c-f245-38ad-1468-742b5756ab42@gmail.com>
Date:   Sat, 17 Jun 2023 08:40:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <71b49be1-eeef-2f60-38f1-cfcbe4c8252f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To handle "--abbrev-ref" we use shorten_unambiguous_ref().  This
function takes a refname and returns a shortened refname, which is a
newly allocated string that needs to be freed.

Unfortunately, the refname variable is reused to receive the shortened
one.  Therefore, we lose the original refname, which needs to be freed
as well, producing a leak.

This leak can be reviewed with:

   $ for a in {1..10}; do git branch foo_${a}; done
   $ git rev-parse --abbrev-ref refs/heads/foo_{1..10}

   Direct leak of 171 byte(s) in 10 object(s) allocated from:
       ... in xstrdup wrapper.c
       ... in expand_ref refs.c
       ... in repo_dwim_ref refs.c
       ... in show_rev builtin/rev-parse.c
       ... in cmd_rev_parse builtin/rev-parse.c
       ... in run_builtin git.c

We have this leak since a45d34691e (rev-parse: --abbrev-ref option to
shorten ref name, 2009-04-13) when "--abbrev-ref" was introduced.

Let's fix it.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/rev-parse.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 852e49e340..d2eb239a08 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -156,9 +156,12 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
 				 */
 				break;
 			case 1: /* happy */
-				if (abbrev_ref)
+				if (abbrev_ref) {
+					char *old = full;
 					full = shorten_unambiguous_ref(full,
 						abbrev_ref_strict);
+					free(old);
+				}
 				show_with_type(type, full);
 				break;
 			default: /* ambiguous */
-- 
2.40.1
