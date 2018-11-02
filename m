Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0581F453
	for <e@80x24.org>; Fri,  2 Nov 2018 13:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeKBWiL (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 18:38:11 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46334 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBWiL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 18:38:11 -0400
Received: by mail-qk1-f176.google.com with SMTP id q1so2928868qkf.13
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rvwbkjUm5uw1S+93Gs+B5ND50M0Tj6i3uG4psYMeH9o=;
        b=YqSocV9v7/BcZ5/ndfCe/ItcWX4JpcAlPrK08480NVyydb2vm604jHsLQdFmleb/pn
         N8oMQaAzgUbWrMd8TQ3kiJeOkaWT/BORVvNml+4tai9ljg3otPSpBfKd6hLEon3VKOBJ
         Z13pxQd+gcnzQtc51IUFI3AMx34zbyMnpyDsvrACeeMcbfPFgfYndqS+tXz0PEKPwYNJ
         qdfs3bgv0EqVeJJXDmSVEDwMoyHyr853E2B3eovH8n040YkzAkCw4vW/0LOwOxSuZbkq
         21THtD4O+Z6UTo0K2ZFaH42DjUR0EGwX47iIfq3kYtDR+qJx0/iZh03GiqmGO3Ta0Uum
         Pneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rvwbkjUm5uw1S+93Gs+B5ND50M0Tj6i3uG4psYMeH9o=;
        b=qw14IXiJz2idLY/D0Nc/Da0yy1X6fFe84OVvxA8ymL574UTgqmRJSQsF8NxYmUE5c/
         q1HKLeHgdjx1te6hE+SEfYoHFTGvoRN1YGFgcO6gvqacv9hr6W1O5ORps8ErLFXKPoNJ
         zBDIEOVjLcYpZNd18bYdtM0Y23BYtoMXtEfXcHuMXphHfMu4iG+IDvHTnbpqRuiBJhf+
         eAawhYtY65teeKbK4A+2r2qftnSRgprlhp5iBlgKexQkyrjhvxSEooV/hPZpEHvgnzvh
         9delX4U9KuGv5pG1ac4SpwZ2VxaSXsiVd8Wx8tB5uGuhFXmT9BgWMNMcLs2MzKR6iUA4
         rzIg==
X-Gm-Message-State: AGRZ1gIyGUoSlwpzsaYo8Oh0onTv9AixtpLkm7PVTBbD+uJgqWA5bhoT
        hOiXK9iyXYb80DVgCV6WNouJPOWu
X-Google-Smtp-Source: AJdET5dtqXCYDI2D/YuK+3McJ/X4gyiaTfCjX298xcWH+//Eu2LxmQ3YTycOPklXEXyDzZAUhegdhg==
X-Received: by 2002:aed:23d8:: with SMTP id k24-v6mr10944345qtc.39.1541165460738;
        Fri, 02 Nov 2018 06:31:00 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id t36-v6sm21421010qth.83.2018.11.02.06.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 06:30:59 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     benpeart@microsoft.com, git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v1] add: speed up cmd_add() by utilizing read_cache_preload()
Date:   Fri,  2 Nov 2018 09:30:50 -0400
Message-Id: <20181102133050.10756-1-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

During an "add", a call is made to run_diff_files() which calls
check_remove() for each index-entry.  The preload_index() code distributes
some of the costs across multiple threads.

Because the files checked are restricted to pathspec, adding individual
files makes no measurable impact but on a Windows repo with ~200K files,
'git add .' drops from 6.3 seconds to 3.3 seconds for a 47% savings.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/fc4830b545
    Checkout: git fetch https://github.com/benpeart/git add-preload-index-v1 && git checkout fc4830b545

 builtin/add.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ad49806ebf..f65c172299 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -445,11 +445,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
-
-	die_in_unpopulated_submodule(&the_index, prefix);
-
 	/*
 	 * Check the "pathspec '%s' did not match any files" block
 	 * below before enabling new magic.
@@ -459,6 +454,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
 
+	if (read_cache_preload(&pathspec) < 0)
+		die(_("index file corrupt"));
+
+	die_in_unpopulated_submodule(&the_index, prefix);
 	die_path_inside_submodule(&the_index, &pathspec);
 
 	if (add_new_files) {

base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
-- 
2.18.0.windows.1

