Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04E45209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946838AbdEZDfr (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35713 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946835AbdEZDfe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so43063295pfd.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=kfX0ZKHhAWOrXC3ZY63K1BBHo9G9DbsnyCbqNnONDn4=;
        b=pRZklROLzHxjIXn8zhmhPrugmn7Kb7TCXT8p69Y5/jsq20K+Ggw1/BMu5KLbjAUBG5
         pwp1jW1beqmfllXUdESc2M8I8pXPgX6s/jVJvfxrlr3t/DaUJ2MYctTRDB4DyO8Ld47P
         RJ68No1WTEU/5bChMwJFj1m5FVcINFx55BnvC0NBJS+KL72DFq/Kg8zuaD3OmfZyl5T8
         Y6BEzlU2sMNGHgCkpdlQfoDhOAlJLdQLbBNVkE1Rs5dTMEpKzMycHfIC7ZwDl/lR+r5K
         QjMm/gMFYiQ/bkheI/KIsZP+/7CeWZIwgdy8hhfSFywEKg7ZxvnlpN8LWCcrGTDAGZOn
         LKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=kfX0ZKHhAWOrXC3ZY63K1BBHo9G9DbsnyCbqNnONDn4=;
        b=QkXUde0PL44rZuCZLsnsODIeKkY+61IAiSx0kPQ/WOpa9VGTR5MGbFUWF4pKiwrHeL
         SzyLQTVV/P9fXOQeCAPZvJKe5Zbjpy1JF1ckAjpSIhei0HYqOBUm2Q2Ky1IYGLxtWbqJ
         imjynjirFc57IkRWJRWyfMchqlfLGCsAeMuPYLuCdGV50E57oA/Jz2JYRqC54tNjMOPd
         LYB6HJm39vxCSdVHVE6C40H2N1u0AihLYV7lAz9B8FPE8IOxZwssuXMOSt98q1tMm5HA
         GXsC3blK+oHYtn85g+zCjPuqK32DFB/6AhHVd8EsXeBO4cQ/8f3Q0nZvGKlXb4Cwgd/W
         McFg==
X-Gm-Message-State: AODbwcDGAewoI6v/1r0xW+08mrN90L3NOHCYH2gCQE8RZ/dTAibb6WsA
        fgfUbKnMmT8AQzYC6Xw=
X-Received: by 10.98.209.65 with SMTP id t1mr48149925pfl.132.1495769728180;
        Thu, 25 May 2017 20:35:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id b72sm17862198pfj.36.2017.05.25.20.35.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 13/13] is_missing_file_error(): work around EINVAL on Windows
Date:   Fri, 26 May 2017 12:35:10 +0900
Message-Id: <20170526033510.1793-14-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When asked to open/fopen a path, e.g. "a/b:/c", which does not exist
on the filesystem, Windows (correctly) fails to open it but sets
EINVAL to errno because the pathname has characters that cannot be
stored in its filesystem.

As this is an expected failure, teach is_missing_file_error() helper
about this case.

This is RFC, as there may be a case where we get EINVAL from
open/fopen for reasons other than "the filesystem does not like this
pathname" that may be worth reporting to the user, and this change
is sweeping such an error under the rug.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wrapper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/wrapper.c b/wrapper.c
index f1c87ec7ea..74aa3b7803 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -434,6 +434,10 @@ static void warn_on_inaccessible(const char *path)
  * see if the errno indicates a missing file that we can safely ignore.
  */
 static int is_missing_file_error(int errno_) {
+#ifdef GIT_WINDOWS_NATIVE
+	if (errno_ == EINVAL)
+		return 1;
+#endif
 	return (errno_ == ENOENT || errno_ == ENOTDIR);
 }
 
-- 
2.13.0-491-g71cfeddc25

