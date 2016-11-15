Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F092021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935017AbcKOXHK (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:07:10 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33826 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbcKOXHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:07:08 -0500
Received: by mail-pf0-f176.google.com with SMTP id c4so26603071pfb.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OqDnPezYuIoMWcYqpic+hZqu8CPmOAY0N2pIU06EDFc=;
        b=mnfQme4w2bUopSkQh6A2MBur1AolwTG2rBwoO78Bo5irGGBo/dHuJoyeBsD7fyRu1X
         qlDplHw62lWj9B3A5V9z2dw5RZ4YTyoTnAfTelfaL9X+S8GCTrVooAmnCWHTDEHw+rE4
         cMCBO2yq/yk+6OK1qdOoJXmljlUHTuPKFyRv0L4Fm6fW9wgyVHz1UFok9yU+9wnB7l8X
         TriI6wxevpGHtB+QZeiFtsr1tIy7y/XJ/RpNYwKufY852TNCyoHVnXnfkszWvcqvks3y
         QGSOATg6xHlpsNC1WuR7faunrxH59SWqXAlrfmu5epOaP7bvHeUCHGJaJy0phP9aS//3
         TQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OqDnPezYuIoMWcYqpic+hZqu8CPmOAY0N2pIU06EDFc=;
        b=gOULChVvv963IVzgrnFXgPnBb6XGSBb+DAvm9HJ/F085EeFW43/cUZ6uNMijkTvtgh
         28eirn4xb+dYW2grRHBf0zX3m+2JEgEbEH++zh1p7PZGZzi1Ho8YkdtRs5m6PpmfICF0
         FvnckoI24ytjTmw3LnxkkAsmjoCePK206POaFu0B4hlB7fuTr6gouKMegXJw1xO9+03B
         acaXfBNGhGiUDCMv+VUs/2gw28P5kQwsrJ4Iqz+2vkJsUJq7b3DExlgaMqpy5grFSeys
         kBiAC8Fo8ndCVPyI9B9WvAWF2T2NPEdngB9EJcJg2ykE/G3LpFFvXZnmPYt+9Zb6axfA
         Q68g==
X-Gm-Message-State: ABUngvedw3W2mvYRE5CI+7HosL4hQpds2NMc8AUwkW7zJ9erwG9+GqTNNnMw9sNW34BntriD
X-Received: by 10.99.204.5 with SMTP id x5mr1150550pgf.71.1479251227695;
        Tue, 15 Nov 2016 15:07:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id q145sm23870902pfq.22.2016.11.15.15.07.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/16] teach unpack_trees() to remove submodule contents
Date:   Tue, 15 Nov 2016 15:06:46 -0800
Message-Id: <20161115230651.23953-12-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend rmdir_or_warn() to remove the directories of those submodules which
are scheduled for removal. Also teach verify_clean_submodule() to check
that a submodule configured to be removed is not modified before scheduling
it for removal.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 6 ++----
 wrapper.c      | 4 ++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ea6bdd2..576e1d5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -9,6 +9,7 @@
 #include "refs.h"
 #include "attr.h"
 #include "split-index.h"
+#include "submodule.h"
 #include "dir.h"
 
 /*
@@ -1361,15 +1362,12 @@ static void invalidate_ce_path(const struct cache_entry *ce,
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
+	return submodule_is_interesting(ce->name, null_sha1) && is_submodule_modified(ce->name, 0);
 }
 
 static int verify_clean_subdirectory(const struct cache_entry *ce,
diff --git a/wrapper.c b/wrapper.c
index e7f1979..17c08de 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -2,6 +2,7 @@
  * Various trivial helper wrappers around standard functions
  */
 #include "cache.h"
+#include "submodule.h"
 
 static void do_nothing(size_t size)
 {
@@ -592,6 +593,9 @@ int unlink_or_warn(const char *file)
 
 int rmdir_or_warn(const char *file)
 {
+	if (submodule_is_interesting(file, null_sha1)
+	    && depopulate_submodule(file))
+		return -1;
 	return warn_if_unremovable("rmdir", file, rmdir(file));
 }
 
-- 
2.10.1.469.g00a8914

