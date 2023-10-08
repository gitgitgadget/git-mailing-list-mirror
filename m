Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BC0E95A8E
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 20:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbjJHUXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 16:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344638AbjJHUXe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 16:23:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E2C6
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 13:23:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso38410955e9.3
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696796610; x=1697401410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmKpAgiUJ17JJ2ylcf4L3FukYW0wVxPVM8m6LFOV3v8=;
        b=GgNY1yIlKdPX+2eOHm14iS7HQz+FmbbI7rz6c/PtzA77odSEqB0lyZ3yyzi4O5/VW+
         vdKAew+dfAUSXwPZVBFeBf0nZ//heyy7REn9io8t52N8GVcHZ51PLoLpFli+EouSWRPd
         Rf4diXlHU5OzrP89u2+7C1sKgdvtdC9sA6LEcCNvLoAg8Qcse1FNgdSdZL3jQ1mAOKie
         SBykIPaGzVG+fwsc8ILq/sg4toaQkJIVUPrLZeYXHMh/UaJi0+qMykErHwXnTdeU7kqw
         Z+JO38ys611hyTe22ktImEXcXimw8pUIryQimQZAu8NZaQW6UGXsWuNZwIV5XFN2D2cS
         fAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696796610; x=1697401410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmKpAgiUJ17JJ2ylcf4L3FukYW0wVxPVM8m6LFOV3v8=;
        b=vz06WKL26w7kfM+Ts0WfUQF8M52kLtd9KRA9UDf21d1zGh89ON7Yl7+IkUlSfjB1Yq
         EM0x5ZP/nfXsYGB5+Zov+PyDynMbFi/ZmFDTP3qcjR+Ig4wvM10ejO4jMeKwmmBW1meM
         kQ75VsSNNO1zL63aGR579NUnwHnqdU7TViuPYKagCZ3xI/8fQLUfPi96cVo+8b6aDrkW
         da/mgcc8C+C7i5cbc5iZR2Cx5ZC3vDJimhlKDdF821sTeQFfzM6BBs2vD4zdCB8xM6vY
         JB3cYxqQ7uWMxHoFdJTRcQ8jrs65SwnDhjgeJbTvbWyY1CUwCz1hA/dP77iSTYIqQhfn
         j9jA==
X-Gm-Message-State: AOJu0Yw7fwWaCKmFWCKhFZNsg8MK+l/U4SG+w0qkjErqUC+vfpXjForl
        lQHMfarUPq7IVvHg37Pp4lGf+AMXBEE=
X-Google-Smtp-Source: AGHT+IFy8JvDSwiCHfuchMlw86gW+8dEAHPZeEnpYmYvk2vp+fmSXSqfeOREhNfhvxQhtcavuBJsAw==
X-Received: by 2002:a05:600c:4709:b0:406:84a0:bc87 with SMTP id v9-20020a05600c470900b0040684a0bc87mr11534351wmo.15.1696796609983;
        Sun, 08 Oct 2023 13:23:29 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c028f00b004065d67c3c9sm9339190wmk.8.2023.10.08.13.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 13:23:29 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] pretty: fix ref filtering for %(decorate) formats
Date:   Sun,  8 Oct 2023 21:23:07 +0100
Message-ID: <20231008202307.1568477-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark pretty formats containing "%(decorate" as requiring decoration in
userformat_find_requirements(), same as "%d" and "%D".

Without this, cmd_log_init_finish() didn't invoke load_ref_decorations()
with the decoration_filter it puts together, and hence filtering options
such as --decorate-refs were quietly ignored.

Amend one of the %(decorate) checks in t4205-log-pretty-formats.sh to
test this.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 pretty.c                      | 4 ++++
 t/t4205-log-pretty-formats.sh | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index 7f3abb676c..cf964b060c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1961,6 +1961,10 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 		case 'D':
 			w->decorate = 1;
 			break;
+		case '(':
+			if (starts_with(fmt + 1, "decorate"))
+				w->decorate = 1;
+			break;
 		}
 	}
 }
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 16626e4fe9..5aabc9f7d8 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -590,9 +590,9 @@ test_expect_success 'pretty format %decorate' '
 	git log --format="%(decorate:prefix=,suffix=)" -1 >actual2 &&
 	test_cmp expect2 actual2 &&
 
-	echo "[ HEAD -> foo; tag: bar; qux ]" >expect3 &&
-	git log --format="%(decorate:prefix=[ ,suffix= ],separator=%x3B )" \
-		-1 >actual3 &&
+	echo "[ bar; qux; foo ]" >expect3 &&
+	git log --format="%(decorate:prefix=[ ,suffix= ],separator=%x3B ,tag=)" \
+		--decorate-refs=refs/ -1 >actual3 &&
 	test_cmp expect3 actual3 &&
 
 	# Try with a typo (in "separator"), in which case the placeholder should
-- 
2.42.GIT

