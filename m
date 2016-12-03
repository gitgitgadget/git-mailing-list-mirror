Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD881FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756918AbcLCAa5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:30:57 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33673 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755479AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pf0-f176.google.com with SMTP id d2so55122044pfd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GFYxxAFaTjGPIwSuwdu8sQLm7Qu2iwZpWD1sBFSflAU=;
        b=nGhWlvU+93fWSB7Dr8rGFFmEe47mvm4glKF1GmXZP6KTmiheC4gW6X6KXF1zwR1oHw
         IVMyvi+xYfiNoFvAoTd32cb/QvjP7+eRu7KeunBPEmeiggOcwYW/Y4OVpMduuQNfdQxT
         KFUmIpsEtuwT9acBeNkILkbf0ngjBiiPVP5vZvkaRLR7X7RCBoYlNlDHhBDQzNuxWsG4
         JJedEgx4milWakU2vvgxjQnjN0D5nEgmQrkuZx29W7NzyhMTJssUIbBKxUWGo2Yheu1o
         YSZm1LXXkV3QkER4iDCn8WsdPVnr9SKdYfRaCzUu6fdZbUWg2zHPRCBMHUHyywKqlIQK
         GrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GFYxxAFaTjGPIwSuwdu8sQLm7Qu2iwZpWD1sBFSflAU=;
        b=I4345cfEYQgZYlWXL3R2rSNA4lPpwdZjo1AE9augrZXYDC82S8OaZkEmew7U2uz2h9
         T+gkebO8lrQrVzfXVRyAaetatORqvYLhFRmcRdFWqcNdgIqGDMm2/qDG0/QIt/L8LSYE
         5F2TqiFeXb7WIfxGaG6ro2jSPpIu4CmorZHS6FP5H1yReg5M2D6tZThOrGd8rawPN/0x
         eFQWA7Ejb6T4or6wuU5/HMjFzREqmJ1PMyNAPxnuRtOI44kAXbu34puq0+cdja5dkfj/
         b4SAoEJTlXdiERpLm/o3e1SoyI8uVe/wmB3qpIvmmjraL6CMoxs3mE8MVVyKj33mi2z0
         JQEQ==
X-Gm-Message-State: AKaTC02KRpo1PYUIJaZu53vF4ck1kO9JmJ9Xj3eCpskiG0lSj+G6AOLOuflb/xPxYooCHJ4Z
X-Received: by 10.99.123.87 with SMTP id k23mr85089001pgn.101.1480725046524;
        Fri, 02 Dec 2016 16:30:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id w125sm10323342pfb.8.2016.12.02.16.30.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 11/17] unpack-trees: teach verify_clean_submodule to inspect submodules
Date:   Fri,  2 Dec 2016 16:30:16 -0800
Message-Id: <20161203003022.29797-12-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a later patch will modify submodules, if they are interesting
we need to see if the submodule is clean in case they are
interesting.

If they are not interesting, then we do not care about the submodule
keeping historic behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ea6bdd20e0..22e32eca96 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -9,6 +9,7 @@
 #include "refs.h"
 #include "attr.h"
 #include "split-index.h"
+#include "submodule.h"
 #include "dir.h"
 
 /*
@@ -1361,15 +1362,15 @@ static void invalidate_ce_path(const struct cache_entry *ce,
 /*
  * Check that checking out ce->sha1 in subdir ce->name is not
  * going to overwrite any working files.
- *
- * Currently, git does not checkout subprojects during a superproject
- * checkout, so it is not going to overwrite anything.
  */
 static int verify_clean_submodule(const struct cache_entry *ce,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
-	return 0;
+	if (!submodule_is_interesting(ce->name))
+		return 0;
+
+	return !is_submodule_modified(ce->name, 0);
 }
 
 static int verify_clean_subdirectory(const struct cache_entry *ce,
-- 
2.11.0.rc2.28.g2673dad

