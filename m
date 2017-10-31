Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E57D20281
	for <e@80x24.org>; Tue, 31 Oct 2017 05:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbdJaFCo (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 01:02:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50498 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751273AbdJaFCo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 01:02:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4258EAAB6C;
        Tue, 31 Oct 2017 01:02:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=44lmgcWYPKMrhYmnq4gMNzry7bk=; b=yBm64/
        aMCPUzJg9TG1DvHtDaaAA8PM8xl3tl4ENmlJcCzzTVx8cp2E7kPw+W84mpE37GyT
        +FIyIzomLofX5UMKRjFSJL0bTB8iJ+HWj43SkSeBszEGuvwp2QbeHy2Wo8st4adw
        11NTXZXnfFlxTCyyVzXLJkeLDeGuOyHQvHDAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XEZcgE4BXt/+Za6cJa84JBDDvLL0CSp9
        Pe1QNmT3YzoZ3NPu2htY6dFOvrhpsbKySADZczu/DgVTegxckymrz+SRXZudTNcC
        dDO6CADbAX8s9JXUGmRRWThDQWx27rhq9nBqkZEhTHiCNZ3ghOjPsFUcBd/peQW3
        b106dG+wGRk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 367B3AAB6A;
        Tue, 31 Oct 2017 01:02:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95116AAB68;
        Tue, 31 Oct 2017 01:02:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v2 3/4] diff: add flag to indicate textconv was set via cmdline
References: <20171027222853.180981-1-bmwill@google.com>
        <20171030194646.27473-1-bmwill@google.com>
        <20171030194646.27473-4-bmwill@google.com>
Date:   Tue, 31 Oct 2017 14:02:41 +0900
In-Reply-To: <20171030194646.27473-4-bmwill@google.com> (Brandon Williams's
        message of "Mon, 30 Oct 2017 12:46:45 -0700")
Message-ID: <xmqq4lqf3o5q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9E258FC-BDF8-11E7-9A9F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index dc28d43eb..82131751d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -485,7 +485,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
>  	unsigned long size;
>  
>  	fflush(rev->diffopt.file);
> -	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
> +	if (!DIFF_OPT_TST(&rev->diffopt, TEXTCONV_SET_VIA_CMDLINE) ||
>  	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
>  		return stream_blob_to_fd(1, oid, NULL, 0);

The original is equivalent to 

	if (! (DIFF_OPT_TOUCHED() && DIFF_OPT_TST()))
		return stream_blob_to_fd();

which means that we must have used DIFF_OPT_SET() or DIFF_OPT_CLR()
to touch the ALLOW_TEXTCONV bit, and ALLOW_TEXTCONV bit is currently
set, in order for the flow to skip this "just stream it out".

And the way it implemented it was:

#define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
#define DIFF_OPT_SET(opts, flag)    (((opts)->flags |= DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
#define DIFF_OPT_CLR(opts, flag)    (((opts)->flags &= ~DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))

Notice that touched_flags is SET in both OPT_SET() and OPT_CLR(),
because the point of _TOUCHED() was "did the user made an explicit
request to affect the value of the bit from the command line?".

> diff --git a/diff.c b/diff.c
> index 3ad9c9b31..8b700b1bd 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4762,11 +4762,13 @@ int diff_opt_parse(struct diff_options *options,
>  		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
>  	else if (!strcmp(arg, "--no-ext-diff"))
>  		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
> -	else if (!strcmp(arg, "--textconv"))
> +	else if (!strcmp(arg, "--textconv")) {
>  		DIFF_OPT_SET(options, ALLOW_TEXTCONV);
> -	else if (!strcmp(arg, "--no-textconv"))
> +		DIFF_OPT_SET(options, TEXTCONV_SET_VIA_CMDLINE);
> +	} else if (!strcmp(arg, "--no-textconv")) {
>  		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
> -	else if (!strcmp(arg, "--ignore-submodules")) {
> +		DIFF_OPT_CLR(options, TEXTCONV_SET_VIA_CMDLINE);
> +	} else if (!strcmp(arg, "--ignore-submodules")) {

If we were aiming for faithful conversion, the above must be
DIFF_OPT_SET(options, TEXTCONV_SET_VIA_CMDLINE), not CLR.

HOWEVER, I think it is fine to define TEXTCONV_SET_VIA_CMDLINE bit
differently from what DIFF_OPT_TOUCHED(ALLOW_TEXTCONV) meant in the
old code (i.e. "did the user made an explicit request to affect the
value?").  That is, we can define the new one as "did the user
explicitly SET the bit from the command line?", the conditional in
show_blob_object() is prepared to take either interpretation.  "User
explicitly set the bit to true, and the bit is true" and "User
explicitly set the bit to something, and the bit is true" are pretty
much the same thing.

And that leads me to suggest dropping the last change here, to touch
VIA_CMDLINE in response to "--no-textconv".

Other than that, looks good to me.

Thanks.
