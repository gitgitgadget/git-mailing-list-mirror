Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACCDC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 21:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3874664DA3
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhBYVE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 16:04:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52175 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhBYVBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 16:01:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D93211C530;
        Thu, 25 Feb 2021 16:00:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=kBv9HEODT5DKYEjHzkBlW8d0dXk=; b=De6dKcdOf0olN/tv6P7C
        4QeoQ5vkLIchQQI5IdZbyFCAK8ce7ed+mYhfWPWuqfz+Jz7gZeifWyEl9w41kGFj
        ggWzkhR4kuqTjhJyPt7P5MFFMbr7ABQh88+8re3Yav7hmReikQXUnZbKinJmogLF
        fsuiWJ6dFrkcPp4tc2GX5JY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=lDqxtAsEwiSgcw9j8gH++2Lddyv799fdGCJZYAUSqyUITv
        20d9ADjjoLYRU8Yifcc8tExZwaEJwrCzg16fHQjfYmeDiuDHuGZsaJDG74uPoKgv
        PUbeG3Ef8kDZByLu7TCcAPYKWfcLOVYh6rBfacGR4K9tWDn/V3sN1fsKqUo5Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 057B411C52F;
        Thu, 25 Feb 2021 16:00:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1FC8211C52B;
        Thu, 25 Feb 2021 16:00:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210225100855.25530-3-charvi077@gmail.com>
Date:   Thu, 25 Feb 2021 13:00:34 -0800
Message-ID: <xmqqwnuvsw0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81D8A38C-77AC-11EB-9B16-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> `git commit --fixup=amend:<commit>` will create an "amend!" commit.
> The resulting commit message subject will be "amend! ..." where
> "..." is the subject line of <commit> and the initial message
> body will be <commit>'s message. -m can be used to override the
> message body.
>
> The "amend!" commit when rebased with --autosquash will fixup the
> contents and replace the commit message of <commit> with the
> "amend!" commit's message body.
>
> Inorder to prevent rebase from creating commits with an empty

In order to prevent ...

> message we refuse to create an "amend!" commit if commit message
> body is empty.
> ...
> +static int prepare_amend_commit(struct commit *commit, struct strbuf *sb,
> +								struct pretty_print_context *ctx) {

Don't indent the second line unnecessarily too deep.

> +	/*
> +	 * If we amend the 'amend!' commit then we don't want to
> +	 * duplicate the subject line.
> +	 */
> +	const char *format = NULL;
> +	if (starts_with(sb->buf, "amend! amend!"))
> +		format = "%b";
> +	else
> +		format = "%B";

I am not sure how well this strategy of special case only two amend!
scales.  What would happen when we --fixup another "fixup!"commit?

Shouldn't the caller, when it called format_commit_message() to
prepare sb it passed to us, have stripped out existing prefix, if
any, so that we can always use the same %B format, or something like
that?

> ...
> +		format_commit_message(commit, fmt, &sb, &ctx);
> +		free(fmt);
>  		hook_arg1 = "message";
> +
> +		if ((have_option_m) && !strcmp(fixup_prefix,"fixup"))

Unnecessary () around have_option_m, and missing SP after ",".

> +			strbuf_addbuf(&sb, &message);
> +
> +		if (!strcmp(fixup_prefix,"amend")) {

Missing SP after "," (I won't repeat---please re-check the whole
patch series before rerolling).

> +			if (have_option_m)
> +				die(_("cannot combine -m with --fixup:%s"), fixup_message);
> +			else
> +				prepare_amend_commit(commit, &sb, &ctx);

Hmph, why is -m so special?  Should we allow --fixup=amend:<cmd>
with -F (or -c/-C for that matter), or are these other options
caught at a lot higher layer already and we do not have to check
them here?

>  	if (also + only + all + interactive > 1)
>  		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
> +
> +	if (fixup_message) {
> +		/*
> +		 * As `amend` suboption contains only alpha
> +		 * character. So check if first non alpha
> +		 * character in fixup_message is ':'.
> +		 */
> +		size_t len = get_alpha_len(fixup_message);
> +		if (len && fixup_message[len] == ':') {
> +			fixup_message[len] = '\0';
> +			fixup_commit = fixup_message + ++len;

It would be easier to follow to write it this way, no?

			fixup_message[len++] = '\0';
			fixup_commit = fixup_message + len;

> +			if (starts_with("amend", fixup_message))
> +				fixup_prefix = "amend";
> +			else
> +				die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
> +		} else {
> +			fixup_commit = fixup_message;
> +			fixup_prefix = "fixup";
> +			use_editor = 0;
> +		}
> +	}
