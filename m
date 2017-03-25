Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C139420966
	for <e@80x24.org>; Sat, 25 Mar 2017 00:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936401AbdCYAgd (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 20:36:33 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33137 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935943AbdCYAg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 20:36:28 -0400
Received: by mail-pf0-f172.google.com with SMTP id o190so2337001pfo.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 17:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Fz/Ik+N3O+0CVGAepImN6OoD9QKSKKZcFMZDB2zD14=;
        b=muimjtOlsW+Goe9HTyJNiycWOM15MmMCaghDkmLWet6Bk+l19lx8qcDFXRebNqH8uI
         sXGcuh8tLSOo4NYbxOkYky3rbARnFRgzKSY9hiSstatvBM6hKHQDMeeIEMPiyvEjpLa6
         zn9ngLAmWrTr0pCeWp7l43LwaA2zOCC6x2e90UGhpddecoVXRGa/u7uCL8T+j3wZos4V
         granJdD2qzWIr4FMGtKqkEonU9jo1eFlcGUa2h2k9bJ9ZSos8zFT925M0OsAfx3G2/Zi
         3FJ+oTOmDE4Gm4CfE0DcjwwaYaNX/iGRpSvfXRqAQtfWemICBY3MrDXK5yFZcHlW/GsZ
         8afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Fz/Ik+N3O+0CVGAepImN6OoD9QKSKKZcFMZDB2zD14=;
        b=csG5T4Hkm/QGg0gGmw5U9L8ypXMgn5YpUni1A3lUl8usLAczk8pyjCeLC0oU+dxKV1
         lPcI+VmsdoeoiaZy5p12O1tQ3VUk6QryAFk7FP/qGvSlbq+2tdGIKwjWOo3BpIGCZzGw
         l+X8CJv8jvrTZD9fUYSpzXSDCuuCsAhhPofSYEZsSr098A0q2mO74v6mjzhJHEcdZ7Nz
         ce950dcEnClih3znEFnq3Oey3Q+e72pLze4OEjHAvOrejbGkXw9Wlr28AXpGx1ExKIea
         ABJCzWotP1t0qVVZLTkVlLz8y1wm+BhGEw33oDXT2cSgKahBPitDV87/8DaNHna/mhK7
         4jrw==
X-Gm-Message-State: AFeK/H23YQ+/mOz06RUH6STBTpNvCR3NyRigorwCNwBelMEYOWgpFLt21UCQslITk2cvm3qr
X-Received: by 10.98.214.156 with SMTP id a28mr12115503pfl.40.1490402187012;
        Fri, 24 Mar 2017 17:36:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id e63sm6761812pfg.40.2017.03.24.17.36.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 17:36:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/7] submodule.c: correctly handle nested submodules in is_submodule_modified
Date:   Fri, 24 Mar 2017 17:36:10 -0700
Message-Id: <20170325003610.15282-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.gdeb397943c.dirty
In-Reply-To: <20170325003610.15282-1-sbeller@google.com>
References: <20170324182902.19280-1-sbeller@google.com>
 <20170325003610.15282-1-sbeller@google.com>
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
 submodule.c                 | 23 +++++++++++++++++++++--
 t/t3600-rm.sh               |  2 +-
 t/t7506-status-submodule.sh |  2 +-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index fa21c7bb72..730cc9513a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1078,8 +1078,27 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		/* regular untracked files */
 		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-		else
-			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+
+		if (buf.buf[0] == 'u' ||
+		    buf.buf[0] == '1' ||
+		    buf.buf[0] == '2') {
+			/*
+			 * T XY SSSS:
+			 * T = line type, XY = status, SSSS = submodule state
+			 */
+			if (buf.len < 1 + 1 + 2 + 1 + 4)
+				die("BUG: invalid status --porcelain=2 line %s",
+				    buf.buf);
+
+			/* regular unmerged and renamed files */
+			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+				/* nested untracked file */
+				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+			if (memcmp(buf.buf + 5, "S..U", 4))
+				/* other change */
+				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+		}
 
 		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
 		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
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
index 6d3acb4a5a..ab822c79e6 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -340,7 +340,7 @@ test_expect_success 'status with untracked file in nested submodule (porcelain)'
 test_expect_success 'status with untracked file in nested submodule (short)' '
 	git -C super status --short >output &&
 	diff output - <<-\EOF
-	 m sub1
+	 ? sub1
 	EOF
 '
 
-- 
2.12.0.rc1.49.gdeb397943c.dirty

