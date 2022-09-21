Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53867ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 11:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIULWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIULWk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 07:22:40 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2993271707
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 04:22:36 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3DB96CA1251;
        Wed, 21 Sep 2022 07:22:35 -0400 (EDT)
Received: from jeffhost-mbp.local (addr-66.249.231.194.nptpop-cmts01-cable-sub.rdns-bnin.net [66.249.231.194])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 471A8CC8314;
        Wed, 21 Sep 2022 07:22:16 -0400 (EDT)
Subject: Re: [PATCH v10 5/6] fsmonitor: check for compatability before
 communicating with fsmonitor
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
References: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
 <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
 <8f6c1fbacbfd3df67d1a7591788d98f1af0e26f4.1663705986.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <28d36af9-f493-f4a5-4aaf-18758e1c46db@jeffhostetler.com>
Date:   Wed, 21 Sep 2022 07:22:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8f6c1fbacbfd3df67d1a7591788d98f1af0e26f4.1663705986.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/20/22 4:33 PM, Eric DeCosta via GitGitGadget wrote:
> From: Eric DeCosta <edecosta@mathworks.com>
> 
> If fsmonitor is not in a compatible state, die with an appropriate error
> messge.
[...]
> diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
> index 531a1b6f956..24480b9806d 100644
> --- a/fsmonitor-settings.c
> +++ b/fsmonitor-settings.c
[...]
> +char *fsm_settings__get_incompatible_msg(struct repository *r,
>   					 enum fsmonitor_reason reason)
>   {
>   	struct strbuf msg = STRBUF_INIT;
> +	const char *socket_dir;
>   
>   	switch (reason) {
>   	case FSMONITOR_REASON_UNTESTED:
> @@ -281,9 +283,11 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
>   		goto done;
>   
>   	case FSMONITOR_REASON_NOSOCKETS:
> +		socket_dir = dirname((char *)fsmonitor_ipc__get_path(r));
>   		strbuf_addf(&msg,
> -			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
> -			    r->worktree);
> +			    _("socket directory '%s' is incompatible with fsmonitor due"),
> +			    socket_dir);
> +		strbuf_add(&msg, _(" to lack of Unix sockets support"), 32);
>   		goto done;

I don't think we should split the error message between two
calls to strbuf_add().  I realize that this was probably done
because of line length concerns.  But this makes assumptions
on language word order during translations.

Instead, we can use C string literal joining before passing
it to the translation macro.  Something like:

	strbuf_addf(&msg,
		_("socket directory '%s' is incompatible with "
		  "fsmonitor due to lack of Unix sockets support"),
		socket_dir);

[...]
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 57d6a483bee..43d580132fb 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -305,6 +305,10 @@ void refresh_fsmonitor(struct index_state *istate)
>   	int is_trivial = 0;
>   	struct repository *r = istate->repo ? istate->repo : the_repository;
>   	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
> +	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
> +
> +	if (reason > FSMONITOR_REASON_OK)
> +		die("%s", fsm_settings__get_incompatible_msg(r, reason));

We don't want to call die() here.  Maybe just silently return
without doing anything or issue a warning() and return.  (But
I'm favoring a silent return here.)

 From the clients' (`git status`, `git diff`, etc.) point of view,
they just want a speed-up, if possible, but we shouldn't kill them;
we should just let them do the normal scan that would have done
if the feature were turned off.

Jeff
