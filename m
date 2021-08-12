Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5334C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 18:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF9F6109D
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 18:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhHLTAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:00:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55928 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhHLTAV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 15:00:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1D6314D723;
        Thu, 12 Aug 2021 14:59:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NetIHWjUyI5Nmy1/bFq2j1OEuGbFozpYb0bmZa
        OI3wE=; b=BR80TnWXRDbtcooK2kzAP+Pzxryykjq6PQJ3AkqQ+dMl2c78oVPLTC
        3d1Cia3UXmG8AOf0DVQAjxCgSERfG9nDfqFKAFzC2vUeD+B5rk6pa2LUt+yYBw9R
        RCw8gW3N8GTjmWzxU4Ni/8YTz+s77JaDfNBIs+qefutCpunzllBHY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E981B14D722;
        Thu, 12 Aug 2021 14:59:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3F6B114D721;
        Thu, 12 Aug 2021 14:59:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/6] hook: introduce "git hook list"
References: <20210812004258.74318-1-emilyshaffer@google.com>
        <20210812004258.74318-4-emilyshaffer@google.com>
Date:   Thu, 12 Aug 2021 11:59:51 -0700
In-Reply-To: <20210812004258.74318-4-emilyshaffer@google.com> (Emily Shaffer's
        message of "Wed, 11 Aug 2021 17:42:55 -0700")
Message-ID: <xmqq5ywa4hg8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A27D820-FB9F-11EB-A82A-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +static int list(int argc, const char **argv, const char *prefix)
> +{
> +	struct list_head *head, *pos;
> +	const char *hookname = NULL;
> +	struct strbuf hookdir_annotation = STRBUF_INIT;
> +
> +	struct option list_options[] = {
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, list_options,
> +			     builtin_hook_list_usage, 0);
> +
> +	if (argc < 1)
> +		usage_msg_opt(_("You must specify a hook event name to list."),
> +			      builtin_hook_list_usage, list_options);
> +
> +	hookname = argv[0];
> +
> +	head = hook_list(hookname);
> +
> +	if (list_empty(head)) {

The same "can't hook_list() signal an error by returning NULL?"
comment applies here.

	head = hook_list(hookname);
	if (!head)
		die(_("no such hook '%s'"), hookname);

or something?

> +		printf(_("no commands configured for hook '%s'\n"),
> +		       hookname);
> +		return 0;

If it is a normally expected state that there is no hook for the
given name, signalling success by returning 0 here may be sensible,
but then the message should at least go to the standard error stream
to leave the standard output empty, so that a caller can reasonably
do something like

	for path in $(git hooks list "$1")
	do
		ls -l "$path"
	done

If we really want to show such a message, perhaps

	if (list_empty(head)) {
        	if (!quiet)
			warning(_("no commands configured"));
		return 0;
	}

The normal display just shows the path without saying "command %s
will run for hook %s"; the warning probably should do the same.

Having said that, if it truly is a normal and expected state that no
hook is defined for the given name, I actually think there should be
no message.

> +	}
> +
> +	list_for_each(pos, head) {
> +		struct hook *item = list_entry(pos, struct hook, list);
> +		item = list_entry(pos, struct hook, list);
> +		if (item)
> +			printf("%s\n", item->hook_path);
> +	}

> diff --git a/hook.c b/hook.c
> index 37f682c6d8..2714b63473 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -96,22 +96,20 @@ int hook_exists(const char *name)
>  struct list_head* hook_list(const char* hookname)
>  {
>  	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> +	const char *hook_path = find_hook(hookname);
> +
>  
>  	INIT_LIST_HEAD(hook_head);
>  
>  	if (!hookname)
>  		return NULL;
>  
> -	if (have_git_dir()) {
> -		const char *hook_path = find_hook(hookname);
> -
> -		/* Add the hook from the hookdir */
> -		if (hook_path) {
> -			struct hook *to_add = xmalloc(sizeof(*to_add));
> -			to_add->hook_path = hook_path;
> -			to_add->feed_pipe_cb_data = NULL;
> -			list_add_tail(&to_add->list, hook_head);
> -		}
> +	/* Add the hook from the hookdir */
> +	if (hook_path) {
> +		struct hook *to_add = xmalloc(sizeof(*to_add));
> +		to_add->hook_path = hook_path;
> +		to_add->feed_pipe_cb_data = NULL;
> +		list_add_tail(&to_add->list, hook_head);
>  	}

I do not think this belongs to the step to add "list" command.  The
log message does not explain or justify why have-git-dir goes away,
either.
