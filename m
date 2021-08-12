Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DC0C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6FA6101E
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 17:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhHLRZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:25:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60105 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhHLRZd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 13:25:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1965613C042;
        Thu, 12 Aug 2021 13:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4DMSZycB17vGPSF7PzIyfcm5q9wdguuCfTnVl+
        /I+fk=; b=EtzhWLtV8TCuwM1Ep6J8z8MKgO41TEOrDmZ+K4sjKGaObDdDwy+FWN
        i1W5qZEPxIOysOvqEBG917gi2wfid997HFSI4dPAZcMFrT4eLzHMrfua55uKcXPp
        BKWTHIJm8tCPCMbzyKIcAkIlnvHPNLLBnVTkiVA7V2nhsp9Mz5Vx8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 11CCB13C041;
        Thu, 12 Aug 2021 13:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 54E6213C040;
        Thu, 12 Aug 2021 13:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/6] hook: run a list of hooks instead
References: <20210812004258.74318-1-emilyshaffer@google.com>
        <20210812004258.74318-2-emilyshaffer@google.com>
Date:   Thu, 12 Aug 2021 10:25:03 -0700
In-Reply-To: <20210812004258.74318-2-emilyshaffer@google.com> (Emily Shaffer's
        message of "Wed, 11 Aug 2021 17:42:53 -0700")
Message-ID: <xmqqbl6260eo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BE57548-FB92-11EB-AFDB-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> To prepare for multihook support, teach hook.[hc] to take a list of
> hooks at run_hooks and run_found_hooks. Right now the list is always one
> entry, but in the future we will allow users to supply more than one
> executable for a single hook event.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  builtin/hook.c |  14 ++++---
>  hook.c         | 103 +++++++++++++++++++++++++++++++++++--------------
>  hook.h         |  16 +++++++-
>  3 files changed, 96 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/hook.c b/builtin/hook.c
> index 5eb7cf73a4..4d39c9e75e 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -25,7 +25,8 @@ static int run(int argc, const char **argv, const char *prefix)
>  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>  	int ignore_missing = 0;
>  	const char *hook_name;
> -	const char *hook_path;
> +	struct list_head *hooks;
> +

Natural.  We used to use the path to the hook because we were
expecting only one. We now use the name to find a list of hooks.

All the caller sees is just list_head without any direct visibility
into it, which feels like a great abstraction.  Presumably everything
will go through the API functions taking this opaque "list of hooks"
thing (or "the first one in the list" if the API function does not
iterate over it, perhaps?).

>  	struct option run_options[] = {
>  		OPT_BOOL(0, "ignore-missing", &ignore_missing,
>  			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
> @@ -58,15 +59,16 @@ static int run(int argc, const char **argv, const char *prefix)
>  	git_config(git_default_config, NULL);
>  
>  	hook_name = argv[0];
> -	if (ignore_missing)
> -		return run_hooks_oneshot(hook_name, &opt);
> -	hook_path = find_hook(hook_name);
> -	if (!hook_path) {
> +	hooks = hook_list(hook_name);

OK.

> +	if (list_empty(hooks)) {
> +		/* ... act like run_hooks_oneshot() under --ignore-missing */
> +		if (ignore_missing)
> +			return 0;

OK.

>  		error("cannot find a hook named %s", hook_name);
>  		return 1;
>  	}

> diff --git a/hook.c b/hook.c
> index ee20b2e365..80e150548c 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -4,6 +4,28 @@
>  #include "hook-list.h"
>  #include "config.h"
>  
> +static void free_hook(struct hook *ptr)
> +{
> +	if (ptr) {
> +		free(ptr->feed_pipe_cb_data);
> +	}

Lose the extra {}, as we do not do more than the above free() even
at the end of the series?

> +	free(ptr);
> +}
> +
> +static void remove_hook(struct list_head *to_remove)
> +{
> +	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
> +	list_del(to_remove);
> +	free_hook(hook_to_remove);
> +}
> +
> +void clear_hook_list(struct list_head *head)
> +{
> +	struct list_head *pos, *tmp;
> +	list_for_each_safe(pos, tmp, head)
> +		remove_hook(pos);
> +}

OK.

> +struct list_head* hook_list(const char* hookname)

Shift both of the asterisks; our asterisks do not stick to the type
but to the identifier.

> +{
> +	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> +
> +	INIT_LIST_HEAD(hook_head);
> +
> +	if (!hookname)
> +		return NULL;

Checking for invalid hookname first would avoid leaking hook_head,
no?  The caller of hook_list() we saw earlier immediately calls
list_empty() which will segfault.  The caller need to be tightened,
but I wonder if it would be a programmer's error to pass a NULL
hookname to this function.  If so, this can simply be a BUG() and
the earlier allocation and initialization of hook_head can stay
where they are.  Otherwise, the caller should see if this returns a
NULL.

> +	if (have_git_dir()) {
> +		const char *hook_path = find_hook(hookname);
> +
> +		/* Add the hook from the hookdir */
> +		if (hook_path) {
> +			struct hook *to_add = xmalloc(sizeof(*to_add));
> +			to_add->hook_path = hook_path;
> +			to_add->feed_pipe_cb_data = NULL;
> +			list_add_tail(&to_add->list, hook_head);
> +		}
> +	}

Calling this function to grab a list of hooks when we are not in any
repository is not an error but just we get "there is nothing to
run".  Does the design give us a more useful behaviour, compared to
alternatives like "you have to be in a repository or calling this
function is an error"?

Not an objection wrapped in a rhetorical question, but a genuine
question.  "It would help this and that usecase" would be an ideal
answer, "We could do either way, but we happened to have written the
code this way first, and at the end of the series we did not see any
practical downsides" would also be a great answer.

> +	return hook_head;
> +}
> +

> +/*
> + * Provides a linked list of 'struct hook' detailing commands which should run
> + * in response to the 'hookname' event, in execution order.
> + */
> +struct list_head* hook_list(const char *hookname);

struct list_head *hook_list(const char *hookname);
