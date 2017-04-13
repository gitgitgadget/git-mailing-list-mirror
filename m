Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B96920960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755455AbdDMS5Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:57:16 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36276 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbdDMS5O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:57:14 -0400
Received: by mail-pg0-f53.google.com with SMTP id g2so34256491pge.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Br/8Qhsewp4WKIc50ej+0q3W92bzeoxarO+/jBhtH3A=;
        b=YpAIajE9hHnUyf0InLmhwEJ+gqVlHQXyGh12XH7XibZJXJ9Hr4+HqAQOohCcMCio9U
         DwZztbAIQP/7521c6FxIoFK+rjkr/ufKd8qVqqo/oqhmUyP3ZHZyRjiI2KQY7xI+LKK5
         3S3NDE/QcApO6tTyQUlPUeUvxz+pK0LhZN+v4TOLPg+rm3jL3w+NxkN35gMkuSAiDb7M
         IXWSuK3Lv9PyvTxemGtI3e+mxwQaJgdXy9Gkb+jNsWt2IH4GFZxCWczxCUbvWcrfCOI6
         7ESNtjGRY+P0wZMfbXtFyKTjIqP979kZT/odHbsvl+YXQ8hFLuMIY4pbmjPinDeOA3tT
         9YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Br/8Qhsewp4WKIc50ej+0q3W92bzeoxarO+/jBhtH3A=;
        b=dgjwlnv89K4Mh/HLvx3WTzB+SzKb+yRu77NFd/gKDZAj1cXBaM3pWWytmQoGLZELog
         CdifBrvE5GmtlQxaMuiTeFykWa5w0JE+YHEAuWFI/FcXAKJ1dpICByInbGm8tmHLEZeM
         e9QbJb801LNXC/1bclGPP+Hbe0l6qpuSornrwZ9oVJJmWW7N+6gi8dtTJLD9uI+vG5nw
         ymzKxxVDO0sXkXAqGESgpjU62tHbhWIbM67q1pWXVO1duzIX7kGxTaCHfQs8Tc7CqUuY
         UBE5X4RKaRfRY1XNn2NFGNvCYwvHsNVZ2SUINvc0IeB6TvfI/la0cm7d29kx3ihinnqk
         mobg==
X-Gm-Message-State: AN3rC/5bWNS9lTUcCQsuUPDfxlM2DJ78QIzKxaf+CcOST3iKQNVHJQuv
        kecFXbN/kN3qeULa
X-Received: by 10.84.133.100 with SMTP id 91mr5316394plf.161.1492109834149;
        Thu, 13 Apr 2017 11:57:14 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm17557872pgj.23.2017.04.13.11.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:57:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, jacob.keller@gmail.com
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/2] ls-files: only recurse on active submodules
Date:   Thu, 13 Apr 2017 11:57:07 -0700
Message-Id: <20170413185707.97746-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170413171224.3537-1-jacob.e.keller@intel.com>
References: <20170413171224.3537-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add in a check to see if a submodule is active before attempting to
recurse.  This prevents 'ls-files' from trying to operate on a submodule
which may not exist in the working directory.

Signed-off-by: Brandon Williams <bmwill@google.com>
---

After you mentioned possibly needing to check if a submodule is initialized, I
went back and noticed that there was indeed no check for it...So this patch
adds in the necessary check to see if a submodule is active or not before
attempting to recurse.

 builtin/ls-files.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d449e46db..10ddc0306 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -15,6 +15,7 @@
 #include "string-list.h"
 #include "pathspec.h"
 #include "run-command.h"
+#include "submodule.h"
 
 static int abbrev;
 static int show_deleted;
@@ -235,7 +236,8 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
 	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
-	    submodule_path_match(&pathspec, name.buf, ps_matched)) {
+	    submodule_path_match(&pathspec, name.buf, ps_matched) &&
+	    is_submodule_initialized(ce->name)) {
 		show_gitlink(ce);
 	} else if (match_pathspec(&pathspec, name.buf, name.len,
 				  len, ps_matched,
@@ -604,8 +606,10 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	if (recurse_submodules)
+	if (recurse_submodules) {
+		gitmodules_config();
 		compile_submodule_options(argv, &dir, show_tag);
+	}
 
 	if (recurse_submodules &&
 	    (show_stage || show_deleted || show_others || show_unmerged ||
-- 
2.12.2.762.g0e3151a226-goog

