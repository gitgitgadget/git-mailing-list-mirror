Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9343DC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiBJEmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:42:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiBJEmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:42:14 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB91D3
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:42:08 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 2-20020aa79202000000b004cef2fc59f0so3433012pfo.12
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dOajazY+Gj0/m5pzttBLZDN1NUigsAJN3WdzJ3SzqTk=;
        b=sig+6pg8n/GdoTxJMdpMcoFQFKG6nIHSbwXy6WmVB+iJ9GSRnbHIny5Ju5fe8jxPXz
         qppHhSyf8/VMbfhE2TFHoCTzHOOQSoHgkJih44uvduSGvUXurxyfcXfbvl42Lb/gk0DW
         tnizT/oyhQpIUyNX8BYVOAba3sIs94yYBtosVLmg5h7rcyD8miBaXiOEQEHeyUTi5/CU
         86pqFK4qScg1r3LO+utHcKbQuXIF1CHkucFqsyxlFF9IAkziTD1ebwVZM3uwrnygw8dO
         AsX0dtPwiVfQ5wzSaPG55TMSYE3ebRtPB9sr9mSrJGey9BwwRhrYZTQO2wg6i6nVSIJw
         8qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dOajazY+Gj0/m5pzttBLZDN1NUigsAJN3WdzJ3SzqTk=;
        b=LWW5aostl5uoAChTx89A5QvdLUQz1T2Y9fOzzuQ1xvTb7zEpINR+Xg2DX6J8K6ig7d
         Zm4BxYBkDAYHIkYGI9HPGtLLZ4Y++KKuPl09IFaJqyKvm6AQxYdQs7DRVveZt2f0IkE8
         KOKGDKLqtQ+IOP+LNGUAhSCDh9fLiVG59T+kLWbzqtnfNFeWTBt6K/C2JHVudzNhKvnw
         PhC93gmyr+78o3hkhij9KzhykBvuVEzGQVMoyMLSXxOY7YHOk+N/1JAAPdsmx/Ydns5S
         AMPv5IQOe2zU3G1a/xfRcdDOURlNxybF3tBMjG4QkjBBP+zBZ/CRJfPsgs0WPUkw28f/
         sToA==
X-Gm-Message-State: AOAM533Ib4HVxOLISdeCouDPjthnxBTr5UO3Tj/eOmKWD2FOrUZx4YkH
        FQ0tanVvmOpDYOvfMaIUv9DN3xnHhrW1+i2jtvSeraSF15FQ5yuP6E0vtBacKSh5T18k2tqFvRO
        ZSfRfW8L13PDgUxnCsq1UkghNu+Xb72TdEYPXZYbUOqprJrEc101q+wcVkkMNYbk=
X-Google-Smtp-Source: ABdhPJwPA57IBXgjpLYQ/jEUUThrhmUs2pUuvZUYFR4EYGdZRJL/66mpt0P1YFOc9dUGtqCX8ywS7qngAwNzGg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:681a:: with SMTP id
 l26mr4669876pgt.365.1644468128361; Wed, 09 Feb 2022 20:42:08 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:41:50 +0800
In-Reply-To: <20220210044152.78352-1-chooglen@google.com>
Message-Id: <20220210044152.78352-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 6/8] submodule: extract get_fetch_task()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
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
 submodule.c | 75 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/submodule.c b/submodule.c
index d4227ac22d..d695dcadf4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1480,14 +1480,12 @@ static struct repository *get_submodule_repo_for(struct repository *r,
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
@@ -1507,41 +1505,17 @@ static int get_next_submodule(struct child_process *cp,
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
 		}
 
 		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
-		if (task->repo) {
-			struct strbuf submodule_prefix = STRBUF_INIT;
-			child_process_init(cp);
-			cp->dir = task->repo->gitdir;
-			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
-			cp->git_cmd = 1;
-			if (!spf->quiet)
-				strbuf_addf(err, _("Fetching submodule %s%s\n"),
-					    spf->prefix, ce->name);
-			strvec_init(&cp->args);
-			strvec_pushv(&cp->args, spf->args.v);
-			strvec_push(&cp->args, default_argv);
-			strvec_push(&cp->args, "--submodule-prefix");
-
-			strbuf_addf(&submodule_prefix, "%s%s/",
-						       spf->prefix,
-						       task->sub->path);
-			strvec_push(&cp->args, submodule_prefix.buf);
-
-			spf->count++;
-			*task_cb = task;
-
-			strbuf_release(&submodule_prefix);
-			return 1;
-		} else {
+		if (!task->repo) {
 			struct strbuf empty_submodule_path = STRBUF_INIT;
 
 			fetch_task_release(task);
@@ -1562,7 +1536,44 @@ static int get_next_submodule(struct child_process *cp,
 					    ce->name);
 			}
 			strbuf_release(&empty_submodule_path);
+			continue;
 		}
+		if (!spf->quiet)
+			strbuf_addf(err, _("Fetching submodule %s%s\n"),
+				    spf->prefix, ce->name);
+
+		spf->count++;
+		return task;
+	}
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
+		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix,
+			    task->sub->path);
+		strvec_push(&cp->args, submodule_prefix.buf);
+		*task_cb = task;
+
+		strbuf_release(&submodule_prefix);
+		return 1;
 	}
 
 	if (spf->oid_fetch_tasks_nr) {
-- 
2.33.GIT

