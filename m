Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA59B20189
	for <e@80x24.org>; Sat, 18 Jun 2016 20:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbcFRU0P (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 16:26:15 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32834 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbcFRU0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 16:26:14 -0400
Received: by mail-pa0-f65.google.com with SMTP id ts6so8065602pac.0
        for <git@vger.kernel.org>; Sat, 18 Jun 2016 13:26:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qy3rd6vWymkTCBIHysWmA1YVBDc7tAz+IuqpA1rjYvY=;
        b=rUrPV2dd0CLKQZMJTMIV/DZLnJj0keX0eQIQWqA8bR64RXyZF+6BOf2z2MGL3FyEgy
         EhNgWDQZQyzVLDPjE2hnl+jGcolbrOuAs0prvsfKI+32/z7fmYYY5kpbeTiXdAKy7hMa
         8dKSAxoR2Ygv3Sf2IHedOLcbjLo81Pd2OlCTBhvupU1l5uiMeZaPPaTrN1l6QJbh/WOw
         Rrkm9XFsdaBQF3ZIDVOtYHuJwXSqK2cTLE6JzEUKAQJ8X8/uB8/Uh8jHtsIN3ry6z/0x
         2FYMYKwRQWbSolhtGSmmVAv3R/AWGUP1xhijQ0Ms33JjdfJyl2k18rVH//qyklZcYlJO
         5zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qy3rd6vWymkTCBIHysWmA1YVBDc7tAz+IuqpA1rjYvY=;
        b=cIkHQepa1p/8JL2/gD/Z1Ah8a/E1EboiBK1W46KlOkICsJxzd+FVI9x4Dca5a+gFwV
         j/9M/NlTr2r9vUeHKqq5wGmqWnpvtzo1Z33QadNPt4PXCMlEEYo/sKTgH7jW9o+/fmjE
         fusgeN6uFf7U87j0xKzTPKICT4AQMHQ4DwW4DQbUdvnQJY0snK10o4a+qtnV3tzRaxsg
         ivLR2G/JTatGCTTtXmsIkVF8jaXDo/WGxI/65vxOBTmal2mhcg/DY7Xw1AF/dfiT2fUm
         YFeZ1qtuPT+pg01PtlFOYHv/pGR4/YxDF+bbegCnFx0ePDJbx1Xda2q+rWV3Ew7rjeD7
         yGMg==
X-Gm-Message-State: ALyK8tKkT8qi/n/iZ65ely7sLw4ZW6uFXHhr/oLEnYiYLqwUxBXrAfXDErdNURcNDY88vA==
X-Received: by 10.66.63.98 with SMTP id f2mr10922245pas.123.1466281573997;
        Sat, 18 Jun 2016 13:26:13 -0700 (PDT)
Received: from localhost.localdomain ([118.71.221.47])
        by smtp.gmail.com with ESMTPSA id v62sm47676301pfv.50.2016.06.18.13.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jun 2016 13:26:12 -0700 (PDT)
From:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
To:	git@vger.kernel.org
Cc:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
Subject: [PATCH] git-sh-setup.sh: fix missing double quotes variables
Date:	Sun, 19 Jun 2016 03:26:03 +0700
Message-Id: <20160618202603.1962-1-cuong.manhle.vn@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160618193710.32265-1-cuong.manhle.vn@gmail.com>
References: <20160618193710.32265-1-cuong.manhle.vn@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Leaving shell variables un-quotes can lead to security vulnerabilities. In:

    : ${x=.}

`$x` is always expanded, cause `glob+split` on its result. There're some
globs is too expensive to expand, like:

    x='/*/*/*/*/../../../../*/*/*/*/../../../../*/*/*/*' sh -c ': ${x=.}'

Run it and our machine will hang/crash (especially in Linux).

`LESS`, `LV` and `GIT_OBJECT_DIRECTORY` variables in `git-sh-setup` are
vulnerable with this case.

Fix this vulnerability  by quoting those variables.

Signed-off-by: LE Manh Cuong <cuong.manhle.vn@gmail.com>
---
 git-sh-setup.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c48139a..85db5f1 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -160,8 +160,8 @@ git_pager() {
 	else
 		GIT_PAGER=cat
 	fi
-	: ${LESS=-FRX}
-	: ${LV=-c}
+	: "${LESS=-FRX}"
+	: "${LV=-c}"
 	export LESS LV
 
 	eval "$GIT_PAGER" '"$@"'
@@ -344,7 +344,7 @@ git_dir_init () {
 		echo >&2 "Unable to determine absolute path of git directory"
 		exit 1
 	}
-	: ${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}
+	: "${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}"
 }
 
 if test -z "$NONGIT_OK"
-- 
2.9.0

