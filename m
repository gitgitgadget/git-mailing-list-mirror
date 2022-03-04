Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA255C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 03:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbiCDDwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 22:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiCDDwK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 22:52:10 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233A97664F
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 19:51:23 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D0D418E867;
        Thu,  3 Mar 2022 22:51:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=f6GyhwYInDU19VNskZomS7Wm3jkkq6BrNIMJMl+lZDc=; b=sxdg
        zxMRqY9qEheZqW7kJwxsV9kA0qnZnu+u7K4dfVLiPUa5CV1idsjhxYmakYKFFH3X
        egVTJa8N1SmqOm0hJ3YxLqsGm6f8K58x18j7OyrXj/euvsFP3zZ2ccwUivEQAlgx
        pXpWS16bSraJrtOEgg3mwnFDJMJtvhxoEYgavus=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55F3B18E866;
        Thu,  3 Mar 2022 22:51:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C76B218E865;
        Thu,  3 Mar 2022 22:51:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git List Mailing <git@vger.kernel.org>
Subject: Re: Silly 'git am' UI issue
References: <CAHk-=wi2HkQ648sYe3BusCEh5tBYjJbQ9c5T-DrykfEdgRbi=g@mail.gmail.com>
        <xmqqlexq8zqo.fsf@gitster.g>
        <CAHk-=wjQP8PwYZMYUhKu3s9wMhE2yDqdAO_OKagqXuvPrHRyAQ@mail.gmail.com>
Date:   Thu, 03 Mar 2022 19:51:19 -0800
Message-ID: <xmqq1qzi4bpk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A7A80A8-9B6E-11EC-84D2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Mar 3, 2022 at 1:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I wonder if something like this would have helped.
>
> That would certainly have helped, yes.
>
> But I think we can do better.
>
> How about just parsing the "--whitespace" option in 'git am' before
> passing it through?
>
> Something like the attached patch seems to work for me.
>
> With this one, I simply get
>
>     $ git am --whitespace 0001-Dummy.patch
>     error: unrecognized whitespace option '0001-Dummy.patch'
>
> when I make the mistake of not giving that whitespace argument.
>
> I'm not claiming this is extensively tested, but I did *some* testing
> on it, and it's not a complicated patch.
>
>              Linus

Yup, reusing what apply.c already uses gives reviewers a solid
assurance.  It already is named appropriately for a global
namespace, so the patch text, as far as I can see, looks good
enough.

> +static int parse_opt_whitespace(const struct option *opt, const char *arg, int unset)
> +{
> +	struct apply_state dummy = { };

It is rare to see a completely empty initializer in this codebase, I
think.

> +	if (parse_whitespace_option(&dummy, arg))
> +		return -1;
> +
> +	return parse_opt_passthru_argv(opt, arg, unset);
> +}

Looks good.

>  static int git_am_config(const char *k, const char *v, void *cb)
>  {
>  	int status;
> @@ -2355,9 +2365,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>  		OPT_CALLBACK_F(0, "quoted-cr", &state.quoted_cr, N_("action"),
>  			       N_("pass it through git-mailinfo"),
>  			       PARSE_OPT_NONEG, am_option_parse_quoted_cr),
> -		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
> +		OPT_CALLBACK(0, "whitespace", &state.git_apply_opts, N_("action"),
>  			N_("pass it through git-apply"),
> -			0),
> +			parse_opt_whitespace),
>  		OPT_PASSTHRU_ARGV(0, "ignore-space-change", &state.git_apply_opts, NULL,
>  			N_("pass it through git-apply"),
>  			PARSE_OPT_NOARG),
