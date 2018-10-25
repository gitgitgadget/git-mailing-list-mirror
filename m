Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42AED1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeJZIHf (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:07:35 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:39839 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeJZIHf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:35 -0400
Received: by mail-qt1-f202.google.com with SMTP id f3-v6so2738304qtq.6
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dWhsO3RuVHErbUQo8a8xEXnIEU+fJGorsgZzYVqZ9F0=;
        b=YP2V7QipIU1wETMqFVyxF/10idI4mV+27U/6Z0HDGAyNoeypBAX8z7s8P48b6OsYMc
         2jc2bw6wiV793+HBl5FtQZqNrIPLl3TgeNpIMIgfakgTOOIg8EsMO7/9prHiNOVzV/2P
         G6g9LF6LO50dy9evJ51HDKHD1lNYf6v2U/5anhQJurVJ/bslXg2WjD2mUFVya4WtQQuV
         IZSBx59ZYvXX6UrKKy2jSu5tJ6nROg2haLeEYdHfMDFPBHtUww82PwaLL5l1BaPCQTY6
         hlq3kcdcSmIE2Xm/LoFf8UKMsbUx8+70aghQyyPuhKKZwjUvfrK33P9g4I8/X0Ax2XL6
         y2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dWhsO3RuVHErbUQo8a8xEXnIEU+fJGorsgZzYVqZ9F0=;
        b=CBJN29yAriTAI1CNyM0NMPoso1xaGeamFKh8ajJd+QsgbBowSCJxQUs/TsfYyJ7a80
         ITm2j5ZjKOHgumZ8rSD2PC3CqNG1zg5+Vp0SlmQMLEqK7OopHOjsoHAoSazPfHCjXwgp
         cL36cJKUber/uogxD6+PYlq1sgNKHwaswqrWc5sUK9kQUSe5pbTlrWB5/HfuAUxFL5U2
         OKffpn1wAOKDjp6aqmM5LYrdavpE3Rf/QXHBJbsUSGMLC9mcNymHx4bsYXredxal6+OB
         d1gCKYfzOIgawgo/StTU3Bv9S12LuRHjYngr916OpwZogn2pRj4xQvCwzB1jpBt6KSRn
         rBiQ==
X-Gm-Message-State: AGRZ1gIi/d22MQNWqd8+C59XJ0THfFKSGFC/rY2Q2fcpcjnLvTTXeSoa
        Y45sF41e8Qku8X/8OhYA+l5mrQ0JcEAc
X-Google-Smtp-Source: AJdET5dgFq3F0112ZGMXm9yIVNTugXzPgk2jLcYRi+k+v+/cFib7IQPPdGYg9GFb3HZ+G9Yu0GdGZb+h9bVJ
X-Received: by 2002:a37:4bd2:: with SMTP id y201mr1142596qka.53.1540510377031;
 Thu, 25 Oct 2018 16:32:57 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:32:29 -0700
In-Reply-To: <20181025233231.102245-1-sbeller@google.com>
Message-Id: <20181025233231.102245-9-sbeller@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 08/10] submodule.c: fetch in submodules git directory instead
 of in worktree
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the properties introduced in  10f5c52656 (submodule: avoid
auto-discovery in prepare_submodule_repo_env(), 2016-09-01), by fixating
the git directory of the submodule.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index a1a32cab7d..67813fbe78 100644
--- a/submodule.c
+++ b/submodule.c
@@ -494,6 +494,12 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
+static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
+{
+	prepare_submodule_repo_env_no_git_dir(out);
+	argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
@@ -1313,8 +1319,8 @@ static int get_next_submodule(struct child_process *cp,
 		repo = get_submodule_repo_for(spf->r, submodule);
 		if (repo) {
 			child_process_init(cp);
-			prepare_submodule_repo_env(&cp->env_array);
-			cp->dir = xstrdup(repo->worktree);
+			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+			cp->dir = xstrdup(repo->gitdir);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
-- 
2.19.0

