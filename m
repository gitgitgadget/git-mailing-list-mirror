Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFCE620958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756726AbdCWVJo (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:09:44 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36409 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935925AbdCWVJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:09:43 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so129054088pge.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffC4T34cJZsLbZm30BdGIWXEbG3ZGj5LvPFl7HzoNP4=;
        b=ov2trfkRcQG5SHFu42H1tY/cPVC4Kh78CaKNnLu+w7hmRde6nQ3IoL1cyDC0pPzj6y
         oX14SnJ6DIZY+kx+OUbUAjqJu69d4rXvalrkHJxYvVCYnNi2gPF12/1NF2pnvBJXxeFn
         gs88UV3Y1RpLjSbk6k2ruFA/MDBT5U0XOQjKdq7Le280FrGAhdViWJBmy6O0eU7ASHRx
         keZXdcOPoN6ia9bJVQDZlyQwwUvrllolpR4jn5ykLk6doOzizeO097kDrmIEPcvWBYle
         Jrf0jOSZUOFx1sKKYBlbdnZXOAeS+E+VxXtUMORh4I/Xd/MpLCacoB/tcJhEZF459Zzn
         PM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ffC4T34cJZsLbZm30BdGIWXEbG3ZGj5LvPFl7HzoNP4=;
        b=iowY14FXcjXzbzng5WicJL1TEcAuyVPsWvCH5BWUbg/8c38eIkygo0WGvrVfVFjkzX
         k/StgkiV9I7nfH9viQRnoDe2kCSVbhnL7Rp8fIJ/wpr8goa3On9olOw6FhFr8EphYwTl
         /Wz+nDnsLWULxS+ZcIHlhwMJzg9ZSJKiadV5ku7UAGwq5WVb8gYxlCOhk3/FKEXGvUm3
         W+jSy05y4M400RAtgS1Ie7zOKzAvDgjibJdJJWaGPRcmu69LTqkEz09xuf9kndW5rRce
         wMpFKPd5M3uLu+otizBhgnZKdtD3WBZ+4dxbuky+oQFXBfjJ0lrKnK5JI3hcoYV+e9IE
         onUw==
X-Gm-Message-State: AFeK/H2cjsUJ3oRm/isKGlNRiWc84xikUxU7wXNyu2zkmPpYhP+gXybrTOexDwdVjojeXIFI
X-Received: by 10.99.171.75 with SMTP id k11mr5120592pgp.204.1490303376529;
        Thu, 23 Mar 2017 14:09:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id v86sm178627pfa.86.2017.03.23.14.09.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 14:09:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 8/8] submodule.c: correctly handle nested submodules in is_submodule_modified
Date:   Thu, 23 Mar 2017 14:09:24 -0700
Message-Id: <20170323210924.26818-9-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323210924.26818-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323210924.26818-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

