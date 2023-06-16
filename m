Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD736EB64DB
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345766AbjFPXeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjFPXeL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:34:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C6C3AB9
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:34:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f845060481so1796449e87.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686958445; x=1689550445;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwPsKY7R0Vwjt6UV+ihATXfK7DdmLjBP90TgwI8Ncyo=;
        b=LR1aBhuo0y4eLKcsVlhN1HGYr/9u6kSIL8x6ytr602Os34Y5+CNkkmMO8o25J5pytk
         RDjRoBMTtfBnm9BQvoo5v2nHM5yFjYvIEA/zV1217YuGTc3pZwQ2V4OxD+FCTwBlKweK
         9T2mBlGjQuUOOQA6/ztj7wSj5VbsPtCIm06ml96feLAK9LWWpIz/Wb/N9Y5e7SC3Cx0q
         HsYclwfWrxEfQikVt0yr/5Py9T0Hsc2u3gxWt5l/MpowHjZwOF17zYek2wPLjOQoZfIF
         wb/ggcuCtJuCh1HmE1UR07XKa+nYOBWUmhV9ooFQYlPgLerGazor7VMNwC+GWyo/Hala
         oKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686958445; x=1689550445;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwPsKY7R0Vwjt6UV+ihATXfK7DdmLjBP90TgwI8Ncyo=;
        b=MrafAKLWZm7pSvuAY0EqiUuUy7NIOvB4OXwMQs4CfUMnoRdjZMrJfIxSE4z78cUhk4
         lI+3dZNDegHDyYmEviaP4ow5Pt5DN0MJf5MykvjbMZY/DEzUqeJytOA7k34vn3OpiCCU
         r5nZKvbFkfIGRnBJezvLWA9JK7D1mAt5QMpUgDCCiWNHZBvH1htwiK3X4GEpGT1MmVfZ
         14xYKkfh2/eMf3tHtF05/19iVlRsNQLLyI/A6gRFUn5C/DNLdFlkuAXUHuF9TDgSFIPu
         /oAxFFon+w0V17pUO/va9j8zTS2iBD1S7uMdzspxq6fA9IGIN/dquDDPMyeLiXSrehG9
         vCwQ==
X-Gm-Message-State: AC+VfDzvAT1w4PLZC61ZZQNcKb/fv+lXjHPDIEwh6nzUwJuLUhWMh+X0
        P8ieiQVQ8VR7jUmTZBl3sFQ=
X-Google-Smtp-Source: ACHHUZ7MSLNJCORT5YjhGsEafGAT/TriB4fp2hB8Y9dIouQywUQTnI6A59VigX39pIkNvfe1A8/sYQ==
X-Received: by 2002:ac2:504b:0:b0:4f1:3d6c:d89b with SMTP id a11-20020ac2504b000000b004f13d6cd89bmr2785426lfm.42.1686958445093;
        Fri, 16 Jun 2023 16:34:05 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id w19-20020a1cf613000000b003f8c5ceeb77sm3355186wmc.21.2023.06.16.16.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 16:34:03 -0700 (PDT)
Subject: [PATCH v2 1/5] rev-parse: fix a leak with --abbrev-ref
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Message-ID: <e097e997-9de9-85cc-4e20-22eb32e98765@gmail.com>
Date:   Sat, 17 Jun 2023 01:34:03 +0200
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
