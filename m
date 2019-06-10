Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07801F609
	for <e@80x24.org>; Mon, 10 Jun 2019 20:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbfFJUN6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 16:13:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57265 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389099AbfFJUN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 16:13:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B855163138;
        Mon, 10 Jun 2019 16:13:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z0NgJPQb3WeeUdYLz85F71Ye9oI=; b=xSCW+C
        CezYIlp6XtNl7cLaHBUrWTg1Gm0DuhLcXK9jyWTEBGJawJzmgFZOk46wEFylLFGf
        sogEFWDnMGibBonrRU4E+FDF4Vi9Cvv5PPhh1vV8eiQJlccCW4gpQqOYGEqHhx+t
        CncpyrvPqkaJWBTTb2ATrJtho6nkNjMeKf0oE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=voiWgAx1ryunB6CvTb0N1bd1DY3cSPLm
        0b2B9BD3fmI72ySd9kmuQmBSLVC6tSfup9gOL7wYgCFQCsjox0ifWgwQhjOF/c9n
        hgxwUrcZV2n1fULZTDJK8xCkt63PSpRW9UUbQCIKwP7nH+oRAriuOQZbeZcAJfyv
        duMxLLnnzuQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 530EC163137;
        Mon, 10 Jun 2019 16:13:56 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1D4B163134;
        Mon, 10 Jun 2019 16:13:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, emilyshaffer@google.com, matvore@comcast.net
Subject: Re: [PATCH v2 6/9] list-objects-filter-options: make filter_spec a strbuf
References: <20190601003603.90794-1-matvore@google.com>
        <20190601003603.90794-7-matvore@google.com>
Date:   Mon, 10 Jun 2019 13:13:54 -0700
In-Reply-To: <20190601003603.90794-7-matvore@google.com> (Matthew DeVore's
        message of "Fri, 31 May 2019 17:36:00 -0700")
Message-ID: <xmqqimtdmc59.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 461641A2-8BBC-11E9-ADD1-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> -	filter_options->filter_spec = strdup(core_partial_clone_filter_default);
> +	if (!filter_options->filter_spec.buf)
> +		strbuf_init(&filter_options->filter_spec, 0);

This part made me go "Huh?" a bit.

Do we document that .buf==NULL means an uninitialized strbuf that is
safe to run strbuf_init() on?  I do not mind that as a general
convention, and it may even be a useful one (i.e. it allows you to
calloc() a structure with an embedded strbuf in it and the "if
.buf==NULL, call strbuf_init() lazily" can become an established
pattern), but at the same time it feels a bit brittle.  

Such a convention forces everybody who might want to use such an
embedded strbuf to first check .buf==NULL and lazily initialize
it---and at some point when the embedded strbuf to be used by enough
codepaths, it would make the code more robust by giving up on the
lazy initialization (iow, when *filter_options is initialized, run
strbuf_init() on its .filter_spec field).
