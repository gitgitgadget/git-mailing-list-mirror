Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6719C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85746603E7
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhHLTIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:08:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52352 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhHLTIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 15:08:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81304D60AD;
        Thu, 12 Aug 2021 15:08:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fi6btA000/eYyD03ybVkJ3pTVg8qdGTj5pvASQ
        v7cPA=; b=PnqBPsr6bIfUDvGcV8HxKwpkjPPY9mKdTqSTWXyYyrpa1YQ8RHGhxL
        bpHTOcKpEDjPqFoqfoKqJ9ms37zNRQfkuZgkg/fnCqWqYDjGMCUg0Qae0BqWIG8d
        H894rE0pB4plVrQj90715ny+Lwu6UFqOtZmonhM/2NscYOa6PdGXA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7991FD60AC;
        Thu, 12 Aug 2021 15:08:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECFB0D60AB;
        Thu, 12 Aug 2021 15:08:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/6] hook: allow running non-native hooks
References: <20210812004258.74318-1-emilyshaffer@google.com>
        <20210812004258.74318-5-emilyshaffer@google.com>
Date:   Thu, 12 Aug 2021 12:08:10 -0700
In-Reply-To: <20210812004258.74318-5-emilyshaffer@google.com> (Emily Shaffer's
        message of "Wed, 11 Aug 2021 17:42:56 -0700")
Message-ID: <xmqqy29632hx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2D0CB8C-FBA0-11EB-87F0-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/builtin/hook.c b/builtin/hook.c
> index c36b05376c..3aa65dd791 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -46,7 +46,7 @@ static int list(int argc, const char **argv, const char *prefix)
>  
>  	hookname = argv[0];
>  
> -	head = hook_list(hookname);
> +	head = hook_list(hookname, 1);
>  
>  	if (list_empty(head)) {
>  		printf(_("no commands configured for hook '%s'\n"),
> @@ -108,7 +108,7 @@ static int run(int argc, const char **argv, const char *prefix)
>  	git_config(git_default_config, NULL);
>  
>  	hook_name = argv[0];
> -	hooks = hook_list(hook_name);
> +	hooks = hook_list(hook_name, 1);
>  	if (list_empty(hooks)) {
>  		/* ... act like run_hooks_oneshot() under --ignore-missing */
>  		if (ignore_missing)

This is minor, as I expect that the callers of hook_list() will
always confined in builtin/hook.c, but it probably is easier to read
if you gave two functions, just like you have the pair of helpers
find_hook() and find_hook_gently(), as the literal "1" forces the
readers to remember if that means "die if not found", or "ok if it
is a bogus name".

In addition, it may make more sense to keep hook_list() signal
failure by returning NULL and leave the dying to the caller.
In-code callers (as opposed to "git hook run" that can throw any
random string that came from the user at the API) will never throw a
bogus name unless there is a bug, and they'll have to check for an
error return from hook_list() anyway and the error message they
would give may have to be different from the one that is given
against a hook name randomly thrown at us by the user.
