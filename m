Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2885FC4361A
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E117764E62
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378999AbhCDAYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56479 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhCCX7n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 18:59:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B25110EAF0;
        Wed,  3 Mar 2021 18:21:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U2/erSg8Qp6m9XL8aVF3RDDN2xw=; b=lq87nP
        3idB96h6pZGKOJ2Yxgm0P7S7HwV5h1ebI6v79VFHT60Zq8LUWVecrdeUVEOI5ihy
        JgH7nDSnE9yft3rG4xqpPqhNv3HGMY83h0GgiTJ5z8otB2bbFaJUO1KlmSacoyeT
        S863YEXTVrQtvE6ob+d1NfggjtDsKcsHdexZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bifhk4+RR3UNZW8bNRoSZhJcEPSvxXE4
        F5ZFvAd5NRVRU/iLI3MXqlWNX7YstKm0i6DAAaD06P/+0sYZ/flFcbed6S94KziD
        KwJFocBW8ZHGON9LIEJg18In/ugC9Vrc5cd3UorPJfKJ1z865FtLNv/G3h82qwV+
        kjaig6zCwkQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4506F10EAEF;
        Wed,  3 Mar 2021 18:21:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 872F510EAEE;
        Wed,  3 Mar 2021 18:21:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v5] builtin/clone.c: add --reject-shallow option
References: <pull.865.v4.git.1613891147977.gitgitgadget@gmail.com>
        <pull.865.v5.git.1614535588332.gitgitgadget@gmail.com>
Date:   Wed, 03 Mar 2021 15:21:38 -0800
In-Reply-To: <pull.865.v5.git.1614535588332.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Sun, 28 Feb 2021 18:06:27
        +0000")
Message-ID: <xmqq35xbj01p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35837D84-7C77-11EB-8A40-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
> index 47de36a5fedf..50ebc170bb81 100644
> --- a/Documentation/config/clone.txt
> +++ b/Documentation/config/clone.txt
> @@ -2,3 +2,7 @@ clone.defaultRemoteName::
>  	The name of the remote to create when cloning a repository.  Defaults to
>  	`origin`, and can be overridden by passing the `--origin` command-line
>  	option to linkgit:git-clone[1].
> +
> +clone.rejectshallow::
> +	Reject to clone a repository if it is a shallow one, can be overridden by
> +	passing option `--reject-shallow` in command line. See linkgit:git-clone[1]

Let's camelCase this, i.e. "clone.rejectShallow", as this file would
be a good candidate to be the authoritative record of canonical
spelling of these variables.

cf. https://lore.kernel.org/git/xmqq7dmy389l.fsf@gitster.g/

> +--[no-]reject-shallow::
> +	Fail if the source repository is a shallow repository. The
> +	'clone.rejectshallow' configuration variable can be used to
> +	give the default.

Let's camelCase the reference to the variable, too.  Also, typeset
in monospace, i.e.

	The `clone.rejectShallow` configuration variable ...

> @@ -858,6 +862,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
>  		free(remote_name);
>  		remote_name = xstrdup(v);
>  	}
> +	if (!strcmp(k, "clone.rejectshallow")) {
> +		config_shallow = git_config_bool(k, v);
> +	}

No need to use {} around a single-statement block, especially when
the "if" statement does not have an "else" block.

The use of strcmp() against the variable name in all lowercase is
correct here.

> @@ -1156,6 +1164,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	 */
>  	git_config(git_clone_config, NULL);
>  
> +	/*
> +	 * If option_shallow is specified from CLI option,
> +	 * ignore config_shallow from git_clone_config.
> +	 */
> +	if (config_shallow != -1) {
> +		reject_shallow = config_shallow;
> +	}
> +	if (option_shallow != -1) {
> +		reject_shallow = option_shallow;
> +	}

Needless use of {} around single-statement blocks.

As reject_shallow is initialized to 0, this lets the option to be of
the most priority, then the config (presumably coming from the per-user
or per-system configuration), by without them, defaults to false.  Good.

We'll have an extra git_config() call later, but that one will only
read into config_shallow, never to be looked at because we will use
reject_shallow variable anyway.  OK.

> @@ -1216,6 +1234,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		if (filter_options.choice)
>  			warning(_("--filter is ignored in local clones; use file:// instead."));
>  		if (!access(mkpath("%s/shallow", path), F_OK)) {
> +			if (reject_shallow)
> +				die("source repository is shallow, reject to clone.");

With the local transport, it (hopefully) is trivial to see if the
source is shallow.  OK.

>  			if (option_local > 0)
>  				warning(_("source repository is shallow, ignoring --local"));
>  			is_local = 0;
> @@ -1227,6 +1247,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
>  
> +	if (reject_shallow)
> +		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
>  	if (option_depth)
>  		transport_set_option(transport, TRANS_OPT_DEPTH,
>  				     option_depth);

OK.  What is really interesting will all happen inside the transport
layer; the caller only has to ask for it.

The asymmetry with other options like "--depth" stands out and
puzzles readers, though.

Do we really want to add the clone.rejectShallow configuration?
After all, we do not give "clone.depth = 1" etc., and that is the
reason why we only need "if (option_depth)" here in the near-by
code.

I'd stop here for today, hoping that somebody much more familiar
with the transport layer than I am will review and comment on the
changes there.

Thanks.
