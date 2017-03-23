Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AFD620958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934419AbdCWWen (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:34:43 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37171 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933401AbdCWWem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:34:42 -0400
Received: by mail-it0-f43.google.com with SMTP id 190so313157itm.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pPA9E9Y/t8kVISFvy8C0bKbuPsjC1FqKNF/jerDCU/w=;
        b=jRtYdl0dmBquH4FMxiCdswvHpfXjz477lTsSst9fCWFtTkOsNCTc4cm/Zp/EBmayTR
         f6VFej2gsHwDpRbXTcLf+k9f9Po1rk2bvUdyiVvSeBWll29PTAPbQJC2kuXbyBFwY/vn
         0JB+9+rCiUL+sLZlgH4OT+2EYLBQwpC+J6bBoJK8O4WW2laxKTWjx5lCSVdfUjDIsQG9
         EBu9csFyoIdQ00ogS9lz7dtLhR0xtUSeQU6qUBZWXjIFgVo8r9lwc0M3Y4sgQB9xh2El
         oqzy01F7N7Hf6kuia73bOfrBFnDe/MJk1TKJpiqNsJo18sjHw7L7IdcXjecT+YNspe+T
         cAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pPA9E9Y/t8kVISFvy8C0bKbuPsjC1FqKNF/jerDCU/w=;
        b=kU31Bph70drAn38oHfh64bqc8r20XJtTxXlyfq22MV8o6N5906a8kVQ4ZoNp3a+50s
         i2MsjQL+tSTBAD10q826e1B/uLcQ0JE6JthaHxZ5kSZYTUbQ8E1bNsCHCdlcZ2gL+xLC
         JR7xwD3nfNvK3jREBPHdLGwAAhAn8/8zNpWwb+U+gym+v2lTeNUfSx8SMNe61AyXTxAD
         06hWKsUFQLTGcrrIAxNRhSpYwqzcFi/1UD7H0IThJXN0K3b5MC/wyqZ8T3yOIQx/db/l
         UP8g5oruAzMIaxRY4JSnJDdRzRyAuiC4iP+qMuvpsri1+gjBDRKKitkK84J6GcJ7XZVW
         vRog==
X-Gm-Message-State: AFeK/H3nD+9hQNRyveto23MFXYQQCeD0z+tuPl3piNXehkbBm5x3S3n0St4xPy8DteSsN2HW
X-Received: by 10.36.90.144 with SMTP id v138mr168198ita.24.1490308462140;
        Thu, 23 Mar 2017 15:34:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id u189sm32300itf.5.2017.03.23.15.34.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:34:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/7] submodule.c: correctly handle nested submodules in is_submodule_modified
Date:   Thu, 23 Mar 2017 15:33:38 -0700
Message-Id: <20170323223338.32274-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323223338.32274-1-sbeller@google.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
 <20170323223338.32274-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a nested submodule has untracked files, it would be reported as
"modified submodule" in the superproject, because submodules are not
parsed correctly in is_submodule_modified as they are bucketed into
the modified pile as "they are not an untracked file".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                 | 16 ++++++++++++++--
 t/t3600-rm.sh               |  2 +-
 t/t7506-status-submodule.sh |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index e06e52b993..0f477f3a4e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1075,8 +1075,20 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		/* regular untracked files */
 		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-		else
-			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+
+		/* regular unmerged and renamed files */
+		if (buf.buf[0] == 'u' ||
+		    buf.buf[0] == '1' ||
+		    buf.buf[0] == '2') {
+			if (buf.buf[5] == 'S') {
+				/* nested submodule handling */
+				if (buf.buf[6] == 'C' || buf.buf[7] == 'M')
+					dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+				if (buf.buf[8] == 'U')
+					dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+			} else
+				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+		}
 
 		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
 		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) || ignore_untracked))
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index a6e5c5bd56..b58793448b 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -659,7 +659,7 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect.modified_inside actual &&
+	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index ad46384064..e3cdcede72 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -324,7 +324,7 @@ test_expect_success 'status with untracked file in nested submodule (porcelain)'
 test_expect_success 'status with untracked file in nested submodule (short)' '
 	git -C super status --short >output &&
 	diff output - <<-\EOF
-	 m sub1
+	 ? sub1
 	EOF
 '
 
-- 
2.12.1.438.gb674c4c09c

