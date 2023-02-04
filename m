Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF8FC636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 23:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBDX0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 18:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBDXZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 18:25:59 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0536421A3C
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 15:25:58 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso8425997wms.0
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 15:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZwMB0zbtjYOBsSvcOXNi3OcQ9VOj53le2baoggMEDQ=;
        b=JUKHUaqxNWguBu0oSDkIf70HdY8hH+lgDLFButlsxLznwtt+H7uk7TrQrTN5CdOI0m
         NZdfdQWW0GPalHa3GZiPaGTOlRzps5Vk/pF8KUiEnH8BvmZ+CtsSthVvXoyiSpKCOe85
         AZY3ufxSwaSCAnylWukhbmSHxMC2MRrYc5RtE7ac6Qzd9Wzqx+d+TiXgPO6Vll/kuEVz
         kV7OXZf9zRQdMNSI7/Fe/k9WFuZF7LTVXKcYnRJKSr04Gcd14kyDKweosxbr/m5qb30D
         3e8Lm3iJegSVBT9ggA9MgEwi2e4n2DZVxP9J/reED6TqNwDmPRKIiBFEVfK+K7Fe4rTf
         XX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZwMB0zbtjYOBsSvcOXNi3OcQ9VOj53le2baoggMEDQ=;
        b=RUv60bevTCIQDA0d3BqsfPDFU0T/z35VM/t5uRLxIZeTulrHQ7yzVFzabzkkRkDGfQ
         KlmgsUoWR937JKQHvpoq3+JdVY+qSvneimqry3RdrjLmdBRmUFfRBYn6ByI2yCXO/Omn
         ol4IyaQa5jo78gPwWyTjnP4CIw8wk1tegaQMUyJJCuT1qKKQAaIQp5lov/h8H/rKdYkq
         1K3JcrTr//siWwcRXCPhOPACbMWqWXvApcbVvlvmG9WWtJfQxmD1WAMJ2crQeYj+Gi6U
         uxturxq1tefku+4O817nF5zZNIMI83QdBCsv7IYqL3fIH7C7K8c/SNblk3PsY7BQtVPL
         5o4w==
X-Gm-Message-State: AO0yUKVDJe0CCcpFivcvN9TNTD04pT2I/LS8DRgW4V/OxSpq3+jMS7v3
        phY125zNI68XJiLmsMmJsbo=
X-Google-Smtp-Source: AK7set9y/hMZdjWV4DNl7Vfue/Ny4V8aFY+zGviVGsh3rQBAfvt0gQtaimTipaylLeNVQwH68PfzJw==
X-Received: by 2002:a05:600c:354e:b0:3df:ea09:fcc9 with SMTP id i14-20020a05600c354e00b003dfea09fcc9mr4152140wmq.7.1675553156448;
        Sat, 04 Feb 2023 15:25:56 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b003dc5b59ed7asm7174748wmq.11.2023.02.04.15.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 15:25:56 -0800 (PST)
Subject: [PATCH v3 2/4] branch: fix die_if_checked_out() when
 ignore_current_worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
Message-ID: <8670d6c6-b5cd-a1e3-8fbf-b948cb687388@gmail.com>
Date:   Sun, 5 Feb 2023 00:25:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8d9fdd7 (worktree.c: check whether branch is rebased in another
worktree, 2016-04-22) die_if_checked_out() learned a new option
ignore_current_worktree, to modify the operation from "die() if the
branch is checked out in any worktree" to "die() if the branch is
checked out in any worktree other than the current one".

Unfortunately we implemented it by checking the flag is_current in the
worktree that find_shared_symref() returns.

When the same branch is checked out in several worktrees simultaneously,
find_shared_symref() will return the first matching worktree in the list
composed by get_worktrees().  If one of the worktrees with the checked
out branch is the current worktree, find_shared_symref() may or may not
return it, depending on the order in the list.

Instead of find_shared_symref(), let's do the search using use the
recently introduced API is_shared_symref(), and consider
ignore_current_worktree when necessary.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c   | 14 +++++++++-----
 worktree.c |  3 +--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index e5614b53b3..64b7dbfd17 100644
--- a/branch.c
+++ b/branch.c
@@ -820,12 +820,16 @@ void remove_branch_state(struct repository *r, int verbose)
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
 {
 	struct worktree **worktrees = get_worktrees();
-	const struct worktree *wt;
 
-	wt = find_shared_symref(worktrees, "HEAD", branch);
-	if (wt && (!ignore_current_worktree || !wt->is_current)) {
-		skip_prefix(branch, "refs/heads/", &branch);
-		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
+	for (int i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->is_current && ignore_current_worktree)
+			continue;
+
+		if (is_shared_symref(worktrees[i], "HEAD", branch)) {
+			skip_prefix(branch, "refs/heads/", &branch);
+			die(_("'%s' is already checked out at '%s'"),
+				branch, worktrees[i]->path);
+		}
 	}
 
 	free_worktrees(worktrees);
diff --git a/worktree.c b/worktree.c
index 40cb9874b7..34043d8fe0 100644
--- a/worktree.c
+++ b/worktree.c
@@ -435,10 +435,9 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
 					  const char *target)
 {
 
-	for (int i = 0; worktrees[i]; i++) {
+	for (int i = 0; worktrees[i]; i++)
 		if (is_shared_symref(worktrees[i], symref, target))
 			return worktrees[i];
-	}
 
 	return NULL;
 }
-- 
2.39.0
