Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BEFC432BE
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A11B610A3
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhHLUsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 16:48:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64349 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhHLUsc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 16:48:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D32613D771;
        Thu, 12 Aug 2021 16:48:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=USh25oLPOsurIvDrzox7UUX4NyQKhB/UijZNsr
        qFXMs=; b=tC9sNZbadRIp/wIhAqgQQuWHQdhshdCxJzNY7+eJRBPCNvAowTMkqZ
        Gs9FqL9H7QxAkqARKqhgD5p/7PR2KrC9PEgM91FcfPtPWeaeCOZoWaRWW1gpa30z
        LPgk85vlLrp2T7D73zFanHfq7uPRMnlcK9lTS78VOA0KtsArYHe60=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 962EA13D76F;
        Thu, 12 Aug 2021 16:48:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D271313D76C;
        Thu, 12 Aug 2021 16:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/6] hook: include hooks from the config
References: <20210812004258.74318-1-emilyshaffer@google.com>
        <20210812004258.74318-6-emilyshaffer@google.com>
Date:   Thu, 12 Aug 2021 13:48:00 -0700
In-Reply-To: <20210812004258.74318-6-emilyshaffer@google.com> (Emily Shaffer's
        message of "Wed, 11 Aug 2021 17:42:57 -0700")
Message-ID: <xmqqsfze1jb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9642553A-FBAE-11EB-9CD3-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Teach the hook.[hc] library to parse configs to populare the list of
> hooks to run for a given event.
>
> Multiple commands can be specified for a given hook by providing
> multiple "hook.<friendly-name>.command = <path-to-hook>" and
> "hook.<friendly-name>.event = <hook-event>" lines. Hooks will be run in
> config order of the "hook.<name>.event" lines.
>
> For example:
>
>   $ git config --list | grep ^hook
>   hook.bar.command=~/bar.sh
>   hook.bar.event=pre-commit

Your answer might be "read the design doc", but it is unclear to me
why "bar" (friendly-name) is needed in this picture at all.  Is it
because you may want to fire more than one command for pre-commit
event?  IOW,

	[hook "bar"]
		command = bar1.sh
		command = bar2.sh
		event = pre-commit

is easier to manage with an extra level of redirection?  I doubt it
as 

	[hook "pre-commit"]
		command = bar1.sh
		command = bar2.sh

would be equally expressive and shorter.  Or would it help use case
for multiple "friendly-name" to refer to the same "event", e.g.

	[hook "xyzzy"]
		event = pre-commit
		command = xyzzy1

	[hook "frotz"]
		event = pre-commit
                command = frotz1
                command = frotz2

or something?  I am not sure if this gives us useful extra
flexibility, and if so, the extra flexibility helps us more than it
confuses us.

And moving the "event" to the second level in the configuration
hierarchy, getting rid of "friendly-name" from the design, would not
make this example unworkable, either:

>   $ git hook run
>   # Runs ~/bar.sh
>   # Runs .git/hooks/pre-commit

Again, this is not an objection wrapped in a rhetorical question.
It just is that I do not see how the extra level of redirection
helps us.

> diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> index 96d3d6572c..a97b980cca 100644
> --- a/Documentation/config/hook.txt
> +++ b/Documentation/config/hook.txt
> @@ -1,3 +1,8 @@
> +hook.<command>.command::
> +	A command to execute during the <command> hook event. This can be an
> +	executable on your device, a oneliner for your shell, or the name of a
> +	hookcmd. See linkgit:git-hook[1].

Please make sure you use the terminology consistently.  If the
second level is "friendly name", hook.<name>.command should be
described, instead of hook.<command>.command.

Also, to help those who are familiar with the current Git from their
use in the past 10 years or so, giving an example name from the
current system may help, e.g. when describing hook.<name>.event,
you may want to say the values are things like "pre-commit",
"receive", etc.

> +This command parses the default configuration files for pairs of configs like
> +so:
> +
> +  [hook "linter"]
> +    event = pre-commit
> +    command = ~/bin/linter --c

The above addition of .command should also have hook.<name>.event
next to it, no?

> +Conmmands are run in the order Git encounters their associated

"Conmmands -> Commands", I would think.

> +`hook.<name>.event` configs during the configuration parse (see
> +linkgit:git-config[1]).

Here you use <name>, which should be matched by the description in
the first hunk of the patch to this file.

> +In general, when instructions suggest adding a script to
> +`.git/hooks/<hook-event>`, you can specify it in the config instead by running
> +`git config --add hook.<some-name>.command <path-to-script> && git config --add
> +hook.<some-name>.event <hook-event>` - this way you can share the script between
> +multiple repos. That is, `cp ~/my-script.sh ~/project/.git/hooks/pre-commit`
> +would become `git config --add hook.my-script.command ~/my-script.sh && git
> +config --add hook.my-script.event pre-commit`.

One repository may use a friendly name "xyzzy" while the other may
use "frotz" to group the hooks that trigger upon "pre-commit" event,
but unless one of the repositories change the friendly name to
match, they cannot share these configurations, no?  It seems that an
extra level of indirection is hindering sharing, rather than
helping.

> diff --git a/builtin/hook.c b/builtin/hook.c
> index 3aa65dd791..ea49dc4ef6 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -49,7 +49,7 @@ static int list(int argc, const char **argv, const char *prefix)
>  	head = hook_list(hookname, 1);
>  
>  	if (list_empty(head)) {
> -		printf(_("no commands configured for hook '%s'\n"),
> +		printf(_("no hooks configured for event '%s'\n"),
>  		       hookname);
> ...
> @@ -58,7 +58,8 @@ static int list(int argc, const char **argv, const char *prefix)
>  		struct hook *item = list_entry(pos, struct hook, list);
>  		item = list_entry(pos, struct hook, list);
>  		if (item)
> -			printf("%s\n", item->hook_path);
> +			printf("%s\n", item->name ? item->name
> +						  : _("hook from hookdir"));
>  	}

I won't comment on this part as my comments on earlier patches would
probably have butchered the preimage already for this change to
survive intact ;-)
