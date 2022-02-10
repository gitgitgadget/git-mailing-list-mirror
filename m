Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F61C4332F
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 22:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345247AbiBJWtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:49:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345244AbiBJWtf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 17:49:35 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0CEB6F
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:49:34 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6566E11AFD6;
        Thu, 10 Feb 2022 17:49:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gcil80UikCiPNdD/dT6qwlJuklEP7cUpw/WwGt
        +FM5M=; b=V8PVRvaLDpoa/6D0oq3IQXC4jmYcvRnGjEuAY2/z7aO+RvYXgwPziT
        AAkIALOWO19laUa6m1fWX8wxTXaMYlyKaFXVzA0z8LsGocl3mvjfGz92IWH81vh+
        eWEzlgh5nKMdp6mfq6/aANMHSzkGVYAZ3PutxnMEGUveEQ1kdWiAU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CABD11AFD5;
        Thu, 10 Feb 2022 17:49:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C45E511AFD3;
        Thu, 10 Feb 2022 17:49:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 7/8] fetch: fetch unpopulated, changed submodules
References: <20220210044152.78352-1-chooglen@google.com>
        <20220210044152.78352-8-chooglen@google.com>
Date:   Thu, 10 Feb 2022 14:49:31 -0800
In-Reply-To: <20220210044152.78352-8-chooglen@google.com> (Glen Choo's message
        of "Thu, 10 Feb 2022 12:41:51 +0800")
Message-ID: <xmqqtud6e3r8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B696305A-8AC3-11EC-B7B5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> @@ -1273,10 +1277,6 @@ static void calculate_changed_submodule_paths(struct repository *r,
>  	struct strvec argv = STRVEC_INIT;
>  	struct string_list_item *name;
>  
> -	/* No need to check if there are no submodules configured */
> -	if (!submodule_from_path(r, NULL, NULL))
> -		return;
> -

It looks to me that this hunk reverts 18322bad (fetch: skip
on-demand checking when no submodules are configured, 2011-09-09),
which tried to avoid high cost computation when we know there is no
submodule.  Intended?  Perhaps it should be replaced with an
equivalent check that (1) still says "we do care about submodules"
even if the current checkout has no submodules (i.e. ls-files shows
no gitlinks), but (2) says "no, there is nothing interesting" when
$GIT_COMMON_DIR/modules/ is empty or some other cheap check we can
use?

> +get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
> +			  const char **default_argv, struct strbuf *err)
>  {
> -	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
> -		const struct cache_entry *ce = spf->r->index->cache[spf->count];
> +	for (; spf->index_count < spf->r->index->cache_nr; spf->index_count++) {
> +		const struct cache_entry *ce =
> +			spf->r->index->cache[spf->index_count];
>  		struct fetch_task *task;
>  
>  		if (!S_ISGITLINK(ce->ce_mode))
> @@ -1495,6 +1499,15 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
>  		if (!task)
>  			continue;
>  
> +		/*
> +		 * We might have already considered this submodule
> +		 * because we saw it when iterating the changed
> +		 * submodule names.
> +		 */
> +		if (string_list_lookup(&spf->seen_submodule_names,
> +				       task->sub->name))
> +			continue;
> +
>  		switch (get_fetch_recurse_config(task->sub, spf))
>  		{
>  		default:
> @@ -1542,7 +1555,69 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
>  			strbuf_addf(err, _("Fetching submodule %s%s\n"),
>  				    spf->prefix, ce->name);
>  
> -		spf->count++;
> +		spf->index_count++;
> +		return task;
> +	}
> +	return NULL;
> +}

Sorry, but I am confused.  If we are gathering which submodules to
fetch from the changes to gitlinks in the range of superproject
changes, why do we even need to scan the index (i.e. the current
checkout in the superproject) to begin with?  If it was changed,
we'd know get_fetch_task_from_changed() would take care of it, and
if there was no change to the submodule between the superproject's
commits before and after the fetch, there is nothing gained from
fetching in the submodules, no?

> +static struct fetch_task *
> +get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
> +			    const char **default_argv, struct strbuf *err)
> +{

> @@ -1553,7 +1628,10 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
>  {
>  	struct submodule_parallel_fetch *spf = data;
>  	const char *default_argv = NULL;
> -	struct fetch_task *task = get_fetch_task(spf, &default_argv, err);
> +	struct fetch_task *task =
> +		get_fetch_task_from_index(spf, &default_argv, err);
> +	if (!task)
> +		task = get_fetch_task_from_changed(spf, &default_argv, err);

Hmph, intersting.  So if "from index" grabbed some submodules
already, then the "from the changes in the superproject, we know
these submodules need refreshing" is not happen at all?  I am afraid
that I am still not following this...
