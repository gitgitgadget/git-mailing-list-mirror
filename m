Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CCFC433FE
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 17:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242490AbiBORYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:24:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242483AbiBORYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 12:24:11 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341C3DB4BF
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:24:01 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j1-20020a170903028100b0014b1f9e0068so8606827plr.8
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GP+Mv/TRHvKvjamtcE5/3+xbsFKEIoYI48WaTdBeIyY=;
        b=DE2fqP8BGIvwEsbOSpKnGPQG/KKhf/ZShrslU1b4P81M/rIlUX7ll1NPhYAB5JDnn5
         KS2DV8zJK6wwpQxEXmwxpWe6WeWGnf3jJN+l6PgrHKTy7BcaeIKCKUIaRLqTZLKauBcY
         K38+xGXaPm1bDZ/X4w9FBgQckpH4zyklVtWQQ4+kVuR/orWQH6ijtrHxTNCo08jKsn4b
         p8r8K/1Poa790YDNvDKiToHCCAKXuzpivFwRAvPzoCOSVw/gZOCXrq7POE1cWSNihmlr
         bavcxiOLDP9c90YuiYtznyLvhrj1ZO+IWsIgloPATzn9MdVb9UNjW7xYGnYmWCLxB8se
         rfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GP+Mv/TRHvKvjamtcE5/3+xbsFKEIoYI48WaTdBeIyY=;
        b=kE6D4okZwpPGM0+Pyjj/KGnV19plH9m4uGXolXEuOpsjZrKApKr96OgLhHecNNE+Wr
         4jKkZjQMDr0Nw4Rkk5ajLTpVo/As0z3bVOc8vqXmcVO5EJc0lSo79p4b8mdjN4bXrm+/
         8VXLuHUtkuM6ZM3Bs64yAmSldfB/IPvYhrs2wQxJDxJj9OdaEm9LHCUqtt3YV7brkcss
         h4WgRZBBDwHVyuBe+LyYiXMfQgx2noUKjdcwrQKL2lWbnzHTc0jtPPA2cEX3Od1pc9AI
         D8eawfkiEg8fEr/+smfs2pVhcxRbvNgNlWBlJ6u97MQGf9++thTf/7FxCxDk0ZTjYrPV
         WRkw==
X-Gm-Message-State: AOAM530i9+yDtr3GprIIlxl42RLh0yB/JeSytsj80QMSjRaAixUIWF+6
        2GAL3qPQzXIBx72a3cUSVLqgYwo0FPUeIz7PipdPHwaLTCKf89dnB8s8pmfvUaGdK/z6yLY7sqB
        9zqqr/SbK01d67YGzP060oHybu1fE4b4PTZPXXXqCapdZi17bU2PEeaWy/+/fKOQ=
X-Google-Smtp-Source: ABdhPJwvIdctAFyUyDx7cF+A1ww++4E0n83mguQVVYhiJJnTYFVvUhTtXbrAtMlhjrN1bH1c6Bba/o/noPgopg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:841:: with SMTP id
 q1mr5387472pfk.21.1644945840571; Tue, 15 Feb 2022 09:24:00 -0800 (PST)
Date:   Wed, 16 Feb 2022 01:23:15 +0800
In-Reply-To: <20220215172318.73533-1-chooglen@google.com>
Message-Id: <20220215172318.73533-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 6/9] submodule: extract get_fetch_task()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_next_submodule() configures the parallel submodule fetch by
performing two functions:

* iterate the index to find submodules
* configure the child processes to fetch the submodules found in the
  previous step

Extract the index iterating code into an iterator function,
get_fetch_task(), so that get_next_submodule() is agnostic of how
to find submodules. This prepares for a subsequent commit will teach the
fetch machinery to also iterate through the list of changed
submodules (in addition to the index).

Signed-off-by: Glen Choo <chooglen@google.com>
---
Jonathan: I'm really happy with the formatting changes that you
suggested because this diff is a lot easier to read, so thanks again!
Going forward, I'd appreciate any and all formatting suggestions - if
they seem possibly excessive, you can mark them as nits.

 submodule.c | 62 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5b1aa3fbe8..22d8a1ca12 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1461,14 +1461,12 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 	return ret;
 }
 
-static int get_next_submodule(struct child_process *cp,
-			      struct strbuf *err, void *data, void **task_cb)
+static struct fetch_task *
+get_fetch_task(struct submodule_parallel_fetch *spf,
+	       const char **default_argv, struct strbuf *err)
 {
-	struct submodule_parallel_fetch *spf = data;
-
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
-		const char *default_argv;
 		struct fetch_task *task;
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -1488,10 +1486,10 @@ static int get_next_submodule(struct child_process *cp,
 					&spf->changed_submodule_names,
 					task->sub->name))
 				continue;
-			default_argv = "on-demand";
+			*default_argv = "on-demand";
 			break;
 		case RECURSE_SUBMODULES_ON:
-			default_argv = "yes";
+			*default_argv = "yes";
 			break;
 		case RECURSE_SUBMODULES_OFF:
 			continue;
@@ -1499,29 +1497,12 @@ static int get_next_submodule(struct child_process *cp,
 
 		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
 		if (task->repo) {
-			struct strbuf submodule_prefix = STRBUF_INIT;
-			child_process_init(cp);
-			cp->dir = task->repo->gitdir;
-			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
-			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
-			strvec_init(&cp->args);
-			strvec_pushv(&cp->args, spf->args.v);
-			strvec_push(&cp->args, default_argv);
-			strvec_push(&cp->args, "--submodule-prefix");
-
-			strbuf_addf(&submodule_prefix, "%s%s/",
-						       spf->prefix,
-						       task->sub->path);
-			strvec_push(&cp->args, submodule_prefix.buf);
 
 			spf->count++;
-			*task_cb = task;
-
-			strbuf_release(&submodule_prefix);
-			return 1;
+			return task;
 		} else {
 			struct strbuf empty_submodule_path = STRBUF_INIT;
 
@@ -1545,6 +1526,37 @@ static int get_next_submodule(struct child_process *cp,
 			strbuf_release(&empty_submodule_path);
 		}
 	}
+	return NULL;
+}
+
+static int get_next_submodule(struct child_process *cp, struct strbuf *err,
+			      void *data, void **task_cb)
+{
+	struct submodule_parallel_fetch *spf = data;
+	const char *default_argv = NULL;
+	struct fetch_task *task = get_fetch_task(spf, &default_argv, err);
+
+	if (task) {
+		struct strbuf submodule_prefix = STRBUF_INIT;
+
+		child_process_init(cp);
+		cp->dir = task->repo->gitdir;
+		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		cp->git_cmd = 1;
+		strvec_init(&cp->args);
+		strvec_pushv(&cp->args, spf->args.v);
+		strvec_push(&cp->args, default_argv);
+		strvec_push(&cp->args, "--submodule-prefix");
+
+		strbuf_addf(&submodule_prefix, "%s%s/",
+						spf->prefix,
+						task->sub->path);
+		strvec_push(&cp->args, submodule_prefix.buf);
+		*task_cb = task;
+
+		strbuf_release(&submodule_prefix);
+		return 1;
+	}
 
 	if (spf->oid_fetch_tasks_nr) {
 		struct fetch_task *task =
-- 
2.33.GIT

