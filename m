Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F7FEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 03:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGUD6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 23:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUD6f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 23:58:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD17C1982
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 20:58:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668711086f4so1037924b3a.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 20:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689911888; x=1690516688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5w8dE+h2Y55A2x7gs0WT1ggOSxmb5LOWDpE7SPCwCFc=;
        b=aFq6ufez1QHllxotX2U+7HICvtYeKRAtiVuncgU72SIyWAvDlfGBesBN+qZrbcOS9k
         vSHHRWg84k0KW3umNwsFe7QZ8JHAs1Sf/B4W+Xt95q+X6G0TO7FXunr1bP5fJPx7mqiy
         797uAXDAqTd1tr8RKuWP/R0n8siY+iFL+R+4sFwEOWYGIFRuqGcEAyayssU7LIMwpsld
         wXKvljNwG87Z9RVcm3UD09z4ekif1J/I2heNMWlZg9DrEb2fXpT/ek4XI3v0gl3LDMpb
         fI5ej9NiXE9OZqalRTtK/To7W2vu7MdZgWf1Ms8cIMKTJmw9NfTqAiQ9TmVqNecPmEFQ
         yTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689911888; x=1690516688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5w8dE+h2Y55A2x7gs0WT1ggOSxmb5LOWDpE7SPCwCFc=;
        b=RAYN1NZzQ3YrjbZRBCXpBrs/BeFja+LawhrPiLPzMZ2wuByV5kTuDgG3SQ6ZdznsyD
         k3prv4TZdVtzh6z2eNshI3bxebo5sgyFRJ9umdO+NKGRjH/W7rESDzRg/ZOCG4D8yPhk
         HdrdUgSCxbO/wkh6YRkhDEu/VqhXfmYEoYWyDheduQrL7R0k/Y3ZEIfUZWazcqQpzzGQ
         ZuEWQLzyS7Feze1X+2CtbZmSOAl/g8nGOF13Q/kmNz0rtKX9jSMea+azjvVckV1e6ukE
         POh0Y1dHzbGfDwAouvzDE/K3sohccX8mQV6toz41sZ0ytBaV9CtTGYJ8eevFQ+HrOtEi
         L/mA==
X-Gm-Message-State: ABy/qLaCK3fw914QNZedk3gO2xZlmUYcD6QALeLjEH8oxr/VRDk0bK/x
        OwZDpXqhRbv82DPF93splhlKtlMnydVgwrV51w5QQTN+
X-Google-Smtp-Source: APBJJlF7jJ1JwStlFGTRLO3q3WsdaBOWMQgK6K5VhkNAYsLKyYLJSLndnfToXIXT3b5mXWVDbAontw==
X-Received: by 2002:a05:6a00:24c9:b0:668:7292:b2bc with SMTP id d9-20020a056a0024c900b006687292b2bcmr1228819pfv.10.1689911887975;
        Thu, 20 Jul 2023 20:58:07 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00682ba300cd1sm1969400pfu.29.2023.07.20.20.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 20:58:07 -0700 (PDT)
From:   Han Young <hanyang.tony@bytedance.com>
To:     git@vger.kernel.org
Cc:     Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2] blame: allow --contents to work with bare repo
Date:   Fri, 21 Jul 2023 11:57:58 +0800
Message-Id: <20230721035758.61956-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CAG1j3zFps5yKwu=DEgkfmZDrzVoRkdeRFMFbq16ZmyOaTXxWeQ@mail.gmail.com>
References: <CAG1j3zFps5yKwu=DEgkfmZDrzVoRkdeRFMFbq16ZmyOaTXxWeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --contents option can be used with git blame to blame the file as if
it had the contents from the specified file. Since 1a3119ed06c8fbb1c00a6aa3615299252575abab ("blame: allow --contents to work with non-HEAD commit"), the --contents option can work with non-HEAD commit. However, if you try to use --contents in a bare repository, you get the following error:

    fatal: this operation must be run in a work tree

This is because before trying to generate a fake working tree commit, we always call setup_work_tree. But in a bare repo, work tree is not available. The call to setup_work_tree is used to prepare the reading of the blamed file in the work tree, which isn't necessary if we are reading the contents from the specific file instead of the file in the work tree.

Add a check in setup_scoreboard to skip setup_work_tree if we are reading from the file specified in --contents.

This enables us to use --contents in a bare repo. This is a nice addition on top of 1a3119ed06c8fbb1c00a6aa3615299252575abab, having a working tree to use --contents is optional.

Add test for the --contents option with bare repo to the annotate-tests.sh test script.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
Changes since v1:
* Removed unwanted {braces} around a single statement
* Sent the email properly with git-send-email so the tabs are preserved
* Corrected typos in commit message

Before commit 1a3119ed06c8fbb1c00a6aa3615299252575abab using --contents in a bare repo will lead to

	fatal: cannot use --contents with final commit object name

even without specify a revision, this is because in a bare repo, HEAD is seem as a passed revision. After 1a3119ed06c8fbb1c00a6aa3615299252575abab, git will try to setup_work_tree as long as --contents is passed. So we still cannot use --contents on a bare repo.

I was comparing files between a bare repo on the server and my local partial cloned repo. It is convenient for me to be able to use --contents option on a bare repo, because the project is very large and would occupy a lot of disk space if fully cloned on local machine.

With this change I can upload my local file to the server and get the blame result without keeping a full clone of the repo on my local machine.

 blame.c             | 4 +++-
 t/annotate-tests.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/blame.c b/blame.c
index d12bd9f97..141756975 100644
--- a/blame.c
+++ b/blame.c
@@ -2806,7 +2806,9 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 			parent_oid = &head_oid;
 		}
 
-		setup_work_tree();
+		if (!sb->contents_from)
+			setup_work_tree();
+
 		sb->final = fake_working_tree_commit(sb->repo,
 						     &sb->revs->diffopt,
 						     sb->path, sb->contents_from,
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 2ef70235b..5e21e84f3 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -83,6 +83,15 @@ test_expect_success 'blame with --contents' '
 	check_count --contents=file A 2
 '
 
+test_expect_success 'blame with --contents in a bare repo' '
+	git clone --bare . bare-contents.git &&
+	(
+		cd bare-contents.git &&
+		echo "1A quick brown fox jumps over the" >contents &&
+		check_count --contents=contents A 1
+	)
+'
+
 test_expect_success 'blame with --contents changed' '
 	echo "1A quick brown fox jumps over the" >contents &&
 	echo "another lazy dog" >>contents &&
-- 
2.40.0

