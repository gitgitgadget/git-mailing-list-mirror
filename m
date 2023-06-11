Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26453C77B7A
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjFKStY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFKStW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:49:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B08D9
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:49:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso25940155e9.0
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509358; x=1689101358;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqfV/yI+rQCqCP70IhiZY98Juk3QM9QJsjHdmg+ibEY=;
        b=FXbOFonSulOvEv38KL+OEKFQ31NX1+5o9LyCqDq9EeDAdPrKm/gJV/SiiK46pHUAFo
         4xjkk+8n5SFZsytzofMKciWyuP327ARWGnOnrECwXQI9BC5PLjM3fkuS0lrgSkB/O8Dh
         P8ePZugWdn9c0IEIlmrgpi216gaQRCGMeRxqTV3P7NEI1CYqdmEkXuSCg5wXtS+OPC2l
         /jfnU7z9abmosNF9TgDRuWK+7NkkG91e695FZ59ksVuQCBO7f2U3KY2N+ftrqMAjjE6N
         J6W6UHgGdurmwB4vX0uBnHOD0fnM35zB4YNwU+RNwtDq67itfvX/dOktHXwKFavMhIJ2
         oalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509358; x=1689101358;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqfV/yI+rQCqCP70IhiZY98Juk3QM9QJsjHdmg+ibEY=;
        b=MOwFjzGbHCX9kOUJc67nT10ctIdut9s38N/2+uAmmJYygM4BEpLgXZcGQ/kB8o2JA/
         gt/mKjZQz4TB34UVwnO8KCTSEv+ge6TkFoYfdA+wqtkvbaG9nspWLXvG/g0Qr6j6FMt+
         yco082gUhNYUVioK0oqAPqPDOZKCYonbj5guT457HpzRPiURFyw9Euq/CnTgqjre1YlI
         rUld95ZD4SG+G40cOvZ0lVBFPMkE0sWORZMvZl6lXU8xNK1z4hQXa+jU/hrrCj4c/HjK
         qUljI/D03xH8R7eOfWFZyfLfisknZ4404uxFATGA5Bsa6cNJcPu47waeRssMOg+3Ka+a
         NX6Q==
X-Gm-Message-State: AC+VfDwJrSFgxwFTWLzIz60euPYztSmvxhPJusFRBDvCuQrCnVoOUpzC
        gpKFx6SET/Rmvv/msSDSTLiFY0iwPMI=
X-Google-Smtp-Source: ACHHUZ6tQr6XoZ9fLcYvBt5SFdwOHSXDw9zPc9NlLv6eeSpX5VOPDcFeNMffWZ0HraCzBzZOdiwKXg==
X-Received: by 2002:a05:600c:218:b0:3f7:367a:bd28 with SMTP id 24-20020a05600c021800b003f7367abd28mr5956004wmi.4.1686509358447;
        Sun, 11 Jun 2023 11:49:18 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id t11-20020a7bc3cb000000b003f7ed463954sm9077868wmj.25.2023.06.11.11.49.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:49:18 -0700 (PDT)
Subject: [PATCH 01/11] rev-parse: fix a leak with --abbrev-ref
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <dc821efb-bf2a-10bb-4547-98d4ba11dbb3@gmail.com>
Date:   Sun, 11 Jun 2023 20:49:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
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
 builtin/rev-parse.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 852e49e340..9fd7095431 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -141,7 +141,7 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
 	if ((symbolic || abbrev_ref) && name) {
 		if (symbolic == SHOW_SYMBOLIC_FULL || abbrev_ref) {
 			struct object_id discard;
-			char *full;
+			char *full, *to_free = NULL;
 
 			switch (repo_dwim_ref(the_repository, name,
 					      strlen(name), &discard, &full,
@@ -156,9 +156,11 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
 				 */
 				break;
 			case 1: /* happy */
-				if (abbrev_ref)
+				if (abbrev_ref) {
+					to_free = full;
 					full = shorten_unambiguous_ref(full,
 						abbrev_ref_strict);
+				}
 				show_with_type(type, full);
 				break;
 			default: /* ambiguous */
@@ -166,6 +168,7 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
 				break;
 			}
 			free(full);
+			free(to_free);
 		} else {
 			show_with_type(type, name);
 		}
-- 
2.40.1
