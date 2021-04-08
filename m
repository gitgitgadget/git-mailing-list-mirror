Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F20C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 07:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8111861157
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 07:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhDHHHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 03:07:04 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:38550 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhDHHGz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 03:06:55 -0400
Received: by mail-lf1-f47.google.com with SMTP id j18so2215765lfg.5
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 00:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kj+H1Z8T95RvdkWJH/B6ZHG0RdKqgGpxrd1TnKgtr8o=;
        b=FxcFbzyVsgsw4M7GFlXy1Qvh5xBJ0l1gZ3kGRGho2kkpsd+kzTepXEWNf8k1XRQxZd
         51gLSrzeCdO8a4LcKp0/AW2fcTtAZELtDq/Fzt3iZVHTxYgOu6zjwJ/2SoXUEHE4uFdz
         jVn0QNb+olvzTrytC1cvwZJGsVKcGKuLpj5aJEiPY6xY9GACLpAZYMrmVwDCY+sQE4RZ
         CxqaUafsZvUY8/24D1ldh7FNHb+DEzPi+pKpm3oIhMco4PzBh0ZnDDculV6u191JaocQ
         6vZYxB6L2NdptIiZN1Gof6P8dwvQrXWOUNkOLpjZ0MgX9mIFiy4ULJ5U1fcpNBkC/0RR
         EjXg==
X-Gm-Message-State: AOAM532F6Yu1JSL9tFALT+wFSeQRcIY05VmAmmSSiKt62K/Q8zRejByw
        xbl05bx4CUzCCHU4xFLglix9QkAqTyYUgg==
X-Google-Smtp-Source: ABdhPJy/+oXylAdnjtA5BLkhVvdN8RcrcvJCOeQQNjP2yfzxsMeEdpDQj8FAu9EBBR/VWZgdeIJBRA==
X-Received: by 2002:a05:6512:3301:: with SMTP id k1mr5214506lfe.327.1617865603545;
        Thu, 08 Apr 2021 00:06:43 -0700 (PDT)
Received: from uncleman.upcloud.com (dygkyxjmrrj79l4kgmcyy-4.rev.dnainternet.fi. [2001:14bb:150:99d:4e71:f7d4:e105:5080])
        by smtp.gmail.com with ESMTPSA id d10sm2756875ljg.112.2021.04.08.00.06.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 00:06:43 -0700 (PDT)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] completion: audit and guard $GIT_* against unset use
Date:   Thu,  8 Apr 2021 10:06:41 +0300
Message-Id: <20210408070641.360431-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$GIT_COMPLETION_SHOW_ALL and $GIT_TESTING_ALL_COMMAND_LIST were used
without guarding against them being unset, causing errors in nounset
(set -u) mode.

No other nounset-unsafe $GIT_* usages were found.

While at it, remove a superfluous (duplicate) unset guard from $GIT_DIR
in __git_find_repo_path.

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e1a66954fe..29b859a0b8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -77,7 +77,7 @@ __git_find_repo_path ()
 		test -d "$__git_dir" &&
 		__git_repo_path="$__git_dir"
 	elif [ -n "${GIT_DIR-}" ]; then
-		test -d "${GIT_DIR-}" &&
+		test -d "$GIT_DIR" &&
 		__git_repo_path="$GIT_DIR"
 	elif [ -d .git ]; then
 		__git_repo_path=.git
@@ -427,7 +427,7 @@ __gitcomp_builtin ()
 
 	if [ -z "$options" ]; then
 		local completion_helper
-		if [ "$GIT_COMPLETION_SHOW_ALL" = "1" ]; then
+		if [ "${GIT_COMPLETION_SHOW_ALL-}" = "1" ]; then
 			completion_helper="--git-completion-helper-all"
 		else
 			completion_helper="--git-completion-helper"
@@ -1910,7 +1910,7 @@ _git_help ()
 		return
 		;;
 	esac
-	if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
+	if test -n "${GIT_TESTING_ALL_COMMAND_LIST-}"
 	then
 		__gitcomp "$GIT_TESTING_ALL_COMMAND_LIST $(__git --list-cmds=alias,list-guide) gitk"
 	else
-- 
2.25.1

