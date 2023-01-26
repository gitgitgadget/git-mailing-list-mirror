Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED6DC05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 09:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbjAZJJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 04:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjAZJJV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 04:09:21 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674C3E60B
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 01:09:20 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id h8-20020a170902f54800b00194b9e80861so818989plf.9
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 01:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKLpbSIlaEySh0WTKjjZ3Wp2eVMHbtX7Yf6YpPSqWOc=;
        b=mQ6ldA1iULdRXw8uMvvuNLSCK5TNdHHQ5rNuUbgbRxHHWVuT700SVH1ya31eYlEJZc
         rofiaU+N+bibgLTTBzUYJd/w4W56h7Dzphsq/LSUYxLAshc8JAXWeDW67/4Z0clVPLNJ
         U12dURd/92nPa8n50TWkW1NKjCQUrL7d89eFFKZNrHe/8pOfMZmy2TbtjETWwAiiohDl
         AflxdVDdUj0+Wn2fdg/2N2rWa1Xcuw0/1ze6oPL9L56oje/9bL12NYk0ukobrbqjdLmN
         aN1YS4aDgV5NwLDgJBFqMvRmpKREqdIXcYLVDR/0OClQRbZl8wPxPYIIiiXAo07vf35G
         6PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKLpbSIlaEySh0WTKjjZ3Wp2eVMHbtX7Yf6YpPSqWOc=;
        b=xFQEbm/gYAr3JYD7qCj2yLHbdztF+1sVW5PdCgKbcc6h33byO4J7qSHIyOwMqbbldy
         /K7KtHw3KMOCKpU4M/cLfGQuRv0CGotWCNz9BdrEZDKxOqWFFWltZygpho8ZxdkdXUZf
         Hc2JFXd6AEv4UWT7JjaT5FszBO0LIjBUF1HQQz6oQ6BUDQ/VV/jRpqZCspQ9KHxUoB2A
         uuGBJIvZEpcmesgBC/Mv3mnA54tmJaIgQpuuFC+emu8cBQMW0NnTH82zMm2fgUIRhLmJ
         beLKj9OS4GZJTTXGY2vVOf3Go2WBQYUA+i80yhXTc8L5man4XXHOdyxgedtyfYQbotcr
         wlgg==
X-Gm-Message-State: AFqh2krENm1j05Y2OF938wt435KAlaeIG6fDqUWi2w68GvsXDXmUjxQi
        wUfEiax12ylFNR9jeLlIXCf9FRyQ7M6Y5w==
X-Google-Smtp-Source: AMrXdXt0/Jc0pjLsk1yo8mfDxkAUODIresBad+3Nu+DdPhP0fu/k8HsUST6OSqQuAbXCgBD+a486im16MwAtUQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:cccf:b0:194:8e9a:a523 with SMTP
 id z15-20020a170902cccf00b001948e9aa523mr3829134ple.22.1674724159394; Thu, 26
 Jan 2023 01:09:19 -0800 (PST)
Date:   Thu, 26 Jan 2023 17:09:17 +0800
In-Reply-To: <20230117193041.708692-6-calvinwan@google.com>
Mime-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com> <20230117193041.708692-6-calvinwan@google.com>
Message-ID: <kl6llelpvf0i.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 5/6] diff-lib: parallelize run_diff_files for submodules
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Jonathan mentioned in [1], I think we should refactor functions out
from the serial implementation in a preparatory patch, then use those
functions to implement the parallel version in this patch. In its
current form, there is a fair amount of duplicated code, which makes it
tricky to review because of the additional overhead of checking what the
duplicated code does and whether we've copied it correcly.

For cleanliness, I'll only point out the duplicated code in this email;
I'll comment on other things I spotted in another one.

[1] https://lore.kernel.org/git/20221128210125.2751300-1-jonathantanmy@google.com/

Calvin Wan <calvinwan@google.com> writes:

> +		for (size_t i = 0; i < submodules.nr; i++) {
> +			struct submodule_status_util *util = submodules.items[i].util;
> +			struct cache_entry *ce = util->ce;
> +			unsigned int oldmode;
> +			const struct object_id *old_oid, *new_oid;
> +
> +			if (!util->changed && !util->dirty_submodule) {
> +				ce_mark_uptodate(ce);
> +				mark_fsmonitor_valid(istate, ce);
> +				if (!revs->diffopt.flags.find_copies_harder)
> +					continue;
> +			}
> +			oldmode = ce->ce_mode;
> +			old_oid = &ce->oid;
> +			new_oid = util->changed ? null_oid() : &ce->oid;
> +			diff_change(&revs->diffopt, oldmode, util->newmode,
> +				    old_oid, new_oid,
> +				    !is_null_oid(old_oid),
> +				    !is_null_oid(new_oid),
> +				    ce->name, 0, util->dirty_submodule);
> +		}
> +	}

The lines from "if (!util->changed && !util->dirty_submodule)" onwards
are copied from earlier in run_diff_files(). This might be refactored
into something like diff_submodule_change().

> +static struct status_task *
> +get_status_task_from_index(struct submodule_parallel_status *sps,
> +			   struct strbuf *err)
> +{
> +	for (; sps->index_count < sps->submodule_names->nr; sps->index_count++) {
> +		struct submodule_status_util *util = sps->submodule_names->items[sps->index_count].util;
> +		struct status_task *task;
> +		struct strbuf buf = STRBUF_INIT;
> +		const char *git_dir;
> +
> +		strbuf_addf(&buf, "%s/.git", util->path);
> +		git_dir = read_gitfile(buf.buf);

This...

> +static int get_next_submodule_status(struct child_process *cp,
> +				     struct strbuf *err, void *data,
> +				     void **task_cb)
> +{
> +	struct submodule_parallel_status *sps = data;
> +	struct status_task *task = get_status_task_from_index(sps, err);
> +
> +	if (!task)
> +		return 0;
> +
> +	child_process_init(cp);
> +	prepare_submodule_repo_env_in_gitdir(&cp->env);
> +
> +	strvec_init(&cp->args);
> +	strvec_pushl(&cp->args, "status", "--porcelain=2", NULL);
> +	if (task->ignore_untracked)
> +		strvec_push(&cp->args, "-uno");
> +
> +	prepare_submodule_repo_env(&cp->env);
> +	cp->git_cmd = 1;

this...

> +static int status_start_failure(struct strbuf *err,
> +				void *cb, void *task_cb)
> +{
> +	struct submodule_parallel_status *sps = cb;
> +	struct status_task *task = task_cb;
> +
> +	sps->result = 1;
> +	strbuf_addf(err,
> +	    _("could not run 'git status --porcelain=2' in submodule %s"),
> +	    task->path);
> +	return 0;
> +}

this...

> +static int status_finish(int retvalue, struct strbuf *err,
> +			 void *cb, void *task_cb)
> +{
> +	struct submodule_parallel_status *sps = cb;
> +	struct status_task *task = task_cb;
> +	struct string_list_item *it =
> +		string_list_lookup(sps->submodule_names, task->path);
> +	struct submodule_status_util *util = it->util;
> +
> +	if (retvalue) {
> +		sps->result = 1;
> +		strbuf_addf(err,
> +		    _("'git status --porcelain=2' failed in submodule %s"),
> +		    task->path);
> +	}

and this are all copied from different parts of is_submodule_modified().
To refactor them out, I think we could combine the first two into
"setup_submodule_status()". The last one could be moved into
"process_submodule_status_result()" or perhaps we could find a way to
combine it into parse_status_porcelain().
