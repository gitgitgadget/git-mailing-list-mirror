Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24382C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 04:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEDE22226
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 04:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbhALE7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 23:59:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58505 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbhALE7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 23:59:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C08D0F9C8B;
        Mon, 11 Jan 2021 23:59:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cYVLmwVk5vvFFjExFxFSJEd7S2U=; b=S272Fl
        yps5QeGEZxX22yDf9HAGYL/9kJdIzp0j4T8vHxDguBpUIJ8Qw3NIHqLM+jvJRYQ7
        RWO6jOcYmqQ8BkQ71KUAb69+50LksA/TBOwV70yilKmfmSnJ+JNlnyX8tkxUduUB
        lbxDVHns+Ch+trcH/y4i1Ua2NoHIWY2OiZ2Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OE//8/m1gSCo1tjvFMQr95cG8e0kNaxd
        26SJFCKTOdkgQ2sH5fHWXl3o2KmmlQgK9Lsv+RcqcWOwug85reCLqhwG4jM4kfgX
        /WnooegVJO5PofEOmZAYQXiL/JuzMaAT/GkK9pnXmounZWd3usuvXSCG0JtsP6fu
        IXXbX3jyRfw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ACFF2F9C8A;
        Mon, 11 Jan 2021 23:59:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E8985F9C88;
        Mon, 11 Jan 2021 23:58:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] gpg-interface: improve interface for parsing tags
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
        <20210111003740.1319996-3-sandals@crustytoothpaste.net>
Date:   Mon, 11 Jan 2021 20:58:57 -0800
In-Reply-To: <20210111003740.1319996-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 11 Jan 2021 00:37:35 +0000")
Message-ID: <xmqqbldu699q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E178D98E-5492-11EB-A837-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/ref-filter.c b/ref-filter.c
> index aa260bfd09..8d8baec1b5 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1215,7 +1215,13 @@ static void find_subpos(const char *buf,
>  			unsigned long *nonsiglen,
>  			const char **sig, unsigned long *siglen)
>  {
> +	struct strbuf payload = STRBUF_INIT;
> +	struct strbuf signature = STRBUF_INIT;
>  	const char *eol;
> +	const char *end = buf + strlen(buf);
> +	const char *sigstart;
> +
> +
>  	/* skip past header until we hit empty line */
>  	while (*buf && *buf != '\n') {
>  		eol = strchrnul(buf, '\n');
> @@ -1228,14 +1234,15 @@ static void find_subpos(const char *buf,
>  		buf++;
>  
>  	/* parse signature first; we might not even have a subject line */
> -	*sig = buf + parse_signature(buf, strlen(buf));
> -	*siglen = strlen(*sig);
> +	parse_signature(buf, end - buf, &payload, &signature);
> +	*sig = strbuf_detach(&signature, siglen);

"unsigned long *siglen" may not be the same as "size_t *siglen", and
the latter is what strbuf_detach() expects to see.  This breaks
32-bit builds e.g. [*1*].

I suspect that all these ${foo}len, including the parameter to this
function but also the four local variables in its sole caller, would
want to become size_t.

Thanks.


[Reference]

*1* https://github.com/git/git/runs/1685453231?check_suite_focus=true#step:5:519
