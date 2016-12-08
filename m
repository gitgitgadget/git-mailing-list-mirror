Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462E71FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933839AbcLHBqo (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:46:44 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34631 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933153AbcLHBqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:46:42 -0500
Received: by mail-pf0-f181.google.com with SMTP id c4so80393775pfb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yTTf5n6RYdzwt8lSEzyoeuhk8iRl66lhPBAUT7cFIuw=;
        b=nW0wwgHhZjeABS4c1ii12MHo4FpQ03MZGw4ZdGF9fPS1nNxSRWl+e1KGIATU6ctgJe
         KQdlMpjczht2oeiMYu3tUxePb0x7SfS2PYc9Kj4kbX+KvgXwL+C+N65x07w2/c7kfxsf
         4G62McielMH+CN+EaZguxsSnCPYjK46aCyYHaTCQAX21RHgFZKx7PkgT+Y3qR+N4Jhav
         migwpdwAZIh6AedbTF2wFbsOGcNpxo6FoKDxkTkvKFhbgkbzkamDOqAApfF/faXELdIo
         i6LqrjHtBbet+Q6FJH4bovNFGLEbTENEdZRfuOBi6LAwLTMhLGII9Y+S/j8UCDCJpXog
         3nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yTTf5n6RYdzwt8lSEzyoeuhk8iRl66lhPBAUT7cFIuw=;
        b=ZZSgNONmCpNY2teyUN9K0HARNnN19hTLzAiDbppSsMem8/uCF6QLMU/ZtftXGdHF5C
         75USSgCqoNIodROBk42jdtgFHrYyNcnkfnmPD20Vf0PYYTVLoImqTfSeoOPzP2hnaju8
         IsxGK7XSePqWeQeuIA4LNTDZ0I//DTJjpICD+ncNvKnx6NVXI92yc4/jtyoNl+lmN1uO
         uZMH6lL9+ElOAlqNwegHv5eX7Rlvtx3LYoOZ4X5MFFLk1GtAArmG9uV24f4YNcjv2FA3
         0szm+QhfkhD/UO8J3Bvu1KA+xW4Yfalv3UPQaXoEzhG08/g2mtaAuJGfA4oz/IXOLRmd
         sGsg==
X-Gm-Message-State: AKaTC03SIONVW/g7AD4KKQ6YQ16+0sVbhmJxbiUeODq2NnpLlnFRHJWVpCPzXZHbqUsew1Oa
X-Received: by 10.99.184.18 with SMTP id p18mr9466916pge.33.1481161601686;
        Wed, 07 Dec 2016 17:46:41 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id s3sm45361168pfe.27.2016.12.07.17.46.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 17:46:41 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 1/7] submodule: use absolute path for computing relative path connecting
Date:   Wed,  7 Dec 2016 17:46:17 -0800
Message-Id: <20161208014623.7588-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.gc512cbd.dirty
In-Reply-To: <20161208014623.7588-1-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current caller of connect_work_tree_and_git_dir passes
an absolute path for the `git_dir` parameter. In the future patch
we will also pass in relative path for `git_dir`. Extend the functionality
of connect_work_tree_and_git_dir to take relative paths for parameters.

We could work around this in the future patch by computing the absolute
path for the git_dir in the calling site, however accepting relative
paths for either parameter makes the API for this function much harder
to misuse.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7d883de9..66c5ce5a24 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1227,23 +1227,25 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	char *real_git_dir = xstrdup(real_path(git_dir));
+	char *real_work_tree = xstrdup(real_path(work_tree));
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, real_work_tree, &rel_path));
+		   relative_path(real_git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
+	strbuf_addf(&file_name, "%s/config", real_git_dir);
 	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
+			       relative_path(real_work_tree, real_git_dir,
 					     &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-	free((void *)real_work_tree);
+	free(real_work_tree);
+	free(real_git_dir);
 }
 
 int parallel_submodules(void)
-- 
2.11.0.rc2.30.gc512cbd.dirty

