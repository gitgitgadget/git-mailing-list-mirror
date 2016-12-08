Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B3D1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbcLHS7g (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:36 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35726 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbcLHS7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:30 -0500
Received: by mail-pg0-f50.google.com with SMTP id p66so176766408pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R764esWWRCe+9eSwpTiA79I9qrVDv5pLe+BR+kzES54=;
        b=SvrXjVt89iAlPZ2fZmAzK2ANuLQk39q9PWgWLfYd68CnPjqj/aHeWcgHx3pRUqvfMW
         GRiu+LBxjSJ1/0REs00/CFHD0oyF5Vorqw//vS+NnoLi/NsojkJzhLgV/YeRXlMifaz1
         +9D4rJhHqvrM2IAi1xjV2RrLO6sd2hYuSl5SlBHpLgbawZNCr/sM3k89hMSDZmbdgMYS
         /ZgoJBnhJyRyGnJxTsgpvBbgH6Wsed/lZUlPMs6PXohvuYLOsyuvBX8ipPO2cFJh1jdy
         D7l0D/ijyCM/A0Yw3iGDTUazcTzZjDWoyWZiCjZdByYf4DGi0ZfGO4zMwb6swZcbuBae
         Pftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R764esWWRCe+9eSwpTiA79I9qrVDv5pLe+BR+kzES54=;
        b=ERJoGDrwQOyuJ5KgdDv/nHW19tCppOtA1Z5cCW51vvjFqVy9bEzfHcKsJLe9JrZuDj
         lzCLNFEez2CTDc/F2rnXiM6eesNSuLXj7QVLEy1C+kwiIv3AkrkH40jZC2D/V+nJC/bY
         M84Z5d8qp+6Gg8A69eqeU5soozRIipX/OBaCWWtjkCsaqzw0KpgR0cdfgpc07ILwbLXu
         mZy0qr+ZnHNYzA0fvmGwhyQDyyhYuMCut4qkMhCe+3O0z3mmPpqWzT6C2nzUIOySVpoy
         FLcw7cYgJBTvkvo1cHOYmEnLIXZh9sdYl4UDnkxdO45lkWJ1tvIYNqz5NcONoARCRx3Q
         AD1A==
X-Gm-Message-State: AKaTC017jpC10Mhi/NyuLTcEelwv+n86R5E7xCJAsdGktQ+N6FIUIj38nx8yxDUzU41s0wjo
X-Received: by 10.99.114.2 with SMTP id n2mr133941190pgc.130.1481223569424;
        Thu, 08 Dec 2016 10:59:29 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:28 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 03/16] dir: convert fill_directory to use the pathspec struct interface
Date:   Thu,  8 Dec 2016 10:58:57 -0800
Message-Id: <1481223550-65277-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'fill_directory()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 7df292b..a50b6f0 100644
--- a/dir.c
+++ b/dir.c
@@ -179,17 +179,21 @@ char *common_prefix(const struct pathspec *pathspec)
 
 int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
 {
-	size_t len;
+	char *prefix;
+	size_t prefix_len;
 
 	/*
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	len = common_prefix_len(pathspec);
+	prefix = common_prefix(pathspec);
+	prefix_len = prefix ? strlen(prefix) : 0;
 
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec->nr ? pathspec->_raw[0] : "", len, pathspec);
-	return len;
+	read_directory(dir, prefix, prefix_len, pathspec);
+
+	free(prefix);
+	return prefix_len;
 }
 
 int within_depth(const char *name, int namelen,
-- 
2.8.0.rc3.226.g39d4020

