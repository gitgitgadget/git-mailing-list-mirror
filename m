Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C0A920451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbcLMXQc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:16:32 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33761 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752301AbcLMXQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:16:31 -0500
Received: by mail-pg0-f46.google.com with SMTP id 3so796684pgd.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sR0jqQKPMWGaqkCJCLEQI1zJE6Q+vMYxLrg6A9Y1TGE=;
        b=AmMDNWnOZE3ySHCwCdrw1FAS50xlvwOMdVc+qvyDUWCEs81sHE6v97fgrTEKHa04Wr
         Sy1rIOldA1HvdW9XiquQRhTBOAsg/vRyNWn4TrPqMsrVQl/H3OkeuA1nNiJyCupjZPU9
         Q/DZ7JywThWV7Pjm4GfIimUzWPj4YsUfBrFjB2/nAzHY85rHylHGtETdPTLIzuaPkCR1
         pz2KvzsfFn+TvLQhtVNHc6xNmLqjVVI0qNUC/38FEEDDgkzJ9+rqsET9/ZdfEXBUFV/z
         0+nGu7DQiBgQOJIjM59fWw6wT1DQXS6cXKeV/6UWhxxM/hJenJn7dDUgzucx/yR/Jx+J
         JcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sR0jqQKPMWGaqkCJCLEQI1zJE6Q+vMYxLrg6A9Y1TGE=;
        b=jgYLt5Gz76R2P3bbSAnVA86x1Jy/jCOyZgpEHaotItZALgD/Is5niOwXV3CE0hAeBr
         0Rmjkge9M9nQT4tbkkrlv6lS89Zgmuphx+55LXoKCUb8Qc0GiND95GJjjEFsBppchOh4
         enwgQ8bVW6fhF8WAhuObU2S5CUakFF5qN6EWvne4y40IYXNwjZdK8SZrrqcfuZqqPHiR
         Kk7ofwnq9jb0V3uMtzOOzXUiFy9Ho81li7fUPd8ZowBgB34SJ0sSw+V/PI8ms7xDdZxy
         3t4iYUbP/IEDfiCYemST4GbEuh7CaLH0gfAi9x9ItSxV71ebgyJdjotRR+uBW3FcUXm3
         YIow==
X-Gm-Message-State: AKaTC01pxGKFDhZay/yxDCA/xsCZQBZsgj1Oc0rDOrSD9138SQ4dcy2j8m5rpkG+AmoSNYDX
X-Received: by 10.99.136.194 with SMTP id l185mr181858633pgd.106.1481670884195;
        Tue, 13 Dec 2016 15:14:44 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:43 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 03/16] dir: convert fill_directory to use the pathspec struct interface
Date:   Tue, 13 Dec 2016 15:14:17 -0800
Message-Id: <1481670870-66754-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
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
index aadf073..15f7c99 100644
--- a/dir.c
+++ b/dir.c
@@ -174,17 +174,21 @@ char *common_prefix(const struct pathspec *pathspec)
 
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

