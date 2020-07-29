Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB3DC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365F3206D4
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hN4xATtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgG2Tdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:33:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54068 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Tdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 15:33:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31F7CE48CB;
        Wed, 29 Jul 2020 15:33:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PU9beMKIUWXQnwpeM9ux5DPbXdI=; b=hN4xAT
        tBaK0rV5UVkAsnWhXyhY709Mb/vXExATt2B58sMOgL75K7V7CW0/tDXliaMtO6Ex
        kv+ATtZJzWIB1njSH2SE3mqGFS61CGzWF9LbXr1a/EwQ+wS+VFHVPMFo4dIPJyLL
        d2glrPYCseRS/V0pisMeb3bWrAUAda6Sl5OYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NXy4IspnoEec8NINLVKiE/Dy9LOGJwLd
        j8QSZ9XvjTf1mCe2JAw8/ebMWIEmRJGI2uMW1euI4GY+IfbgDUgXIJH9kNGQMp9l
        zjD8flh0wLYLvhXkBMyePHrQS1WQQTnw8sZnrNdnmcqjxjA9rL/EcFtY3YFxxYjC
        xlf373TNys0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A20AE48CA;
        Wed, 29 Jul 2020 15:33:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 631CFE48C8;
        Wed, 29 Jul 2020 15:33:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v3 5/6] parse-options: parse into argv_array
References: <20200728222455.3023400-1-emilyshaffer@google.com>
        <20200728222455.3023400-6-emilyshaffer@google.com>
Date:   Wed, 29 Jul 2020 12:33:39 -0700
In-Reply-To: <20200728222455.3023400-6-emilyshaffer@google.com> (Emily
        Shaffer's message of "Tue, 28 Jul 2020 15:24:54 -0700")
Message-ID: <xmqqmu3i9kvg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68774C0C-D1D2-11EA-91E9-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> parse-options already knows how to read into a string_list, and it knows
> how to read into an argv_array as a passthrough (that is, including the
> argument as well as its value). string_list and argv_array serve similar
> purposes but are somewhat painful to convert between; so, let's teach
> parse-options to read values of string arguments directly into an
> argv_array without preserving the argument name.
>
> This is useful if collecting generic arguments to pass through to
> another command, for example, 'git hook run --arg "--quiet" --arg
> "--format=pretty" some-hook'. The resulting argv_array would contain
> { "--quiet", "--format=pretty" }.
>
> The implementation is based on that of OPT_STRING_LIST.

Be it argv_array or strvec, I think this is a useful thing to do.

I grepped for the users of OPT_STRING_LIST() to see if some of them
are better served by this, but none of them stood out as candidates
that are particularly good match.

> +int parse_opt_argv_array(const struct option *opt, const char *arg, int unset)
> +{
> +	struct argv_array *v = opt->value;
> +
> +	if (unset) {
> +		argv_array_clear(v);
> +		return 0;
> +	}
> +
> +	if (!arg)
> +		return -1;

I think the calling parse_options() loop would catch this negative
return and raise an error, but is it better for this code to stay
silent or would it be better to say that opt->long_name/short_name 
is not a boolean?

> +	argv_array_push(v, arg);
> +	return 0;
> +}
