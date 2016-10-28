Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713932035F
	for <e@80x24.org>; Fri, 28 Oct 2016 17:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964795AbcJ1Ram (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 13:30:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57886 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754677AbcJ1Ral (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 13:30:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32CE14A820;
        Fri, 28 Oct 2016 13:30:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xvuxcfvPNyyH4v36m2Z/Eic71l8=; b=j23nKC
        GA3x/WQBwGAvZVRPo4g7Nd5dBt/lH3dBo9/Rwn7vUjb/vMZgmzpV9cVYHZMnMu6n
        2SAeFDDvXxtHLh25hsBpoKWh0E5255dktkPoUXJTz7y1xU8YX1S7vhrl4sTZoTGt
        nQ79V1cXwc2JtDThvrhWoerVJxLM2LbaAjdWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c2veu7MRXj9o0wxidknjQTQ10ysEwgAo
        FqBsRK8fsNu1Br+matEuNJnUNhTSe8jP/C1PhUnR/b6BQ6EIHfWyz7XwZMNg+R4C
        CQWRrLTbTkXFFKdxch9Ffm0xaqa+fexFJdRlKvZLRNKshXIuWVyPbS6tU2CE49xG
        D03fyxmfidQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A2434A81F;
        Fri, 28 Oct 2016 13:30:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F2634A81D;
        Fri, 28 Oct 2016 13:30:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Johannes.Schindelin@gmx.de, j6t@kdbg.org, peff@peff.net,
        simon@ruderich.org
Subject: Re: [PATCH] attr: convert to new threadsafe API
References: <xmqqy41a8hxj.fsf@gitster.mtv.corp.google.com>
        <20161027221550.14930-1-sbeller@google.com>
        <xmqqinsc1jcg.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 28 Oct 2016 10:30:37 -0700
In-Reply-To: <xmqqinsc1jcg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 28 Oct 2016 10:20:15 -0700")
Message-ID: <xmqqa8do1iv6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EAB9C2E-9D34-11E6-859A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	if (check)
>> +		return; /* already done */
>>  	check = git_attr_check_alloc();
>>  	while (*argv) {
>>  		struct git_attr *attr = git_attr(*argv);
>>  		git_attr_check_append(check, attr);

I thought you made git_attr() constructor unavailable, so
check_append() would just get a "const char *" instead?

>>  		argv++;
>>  	}
>> +	struct git_attr_result *result = git_attr_result_alloc(check);
>
> This does not look like thread-safe.
>
> I could understand it if the calling convention were like this,
> though:
>
> 	if (git_attr_check_alloc(&check)) {
> 		while (*argv) {
> 	        	... append ...
> 		}
> 		git_attr_check_finished_appending(&check);
> 	}
> 	result = result_alloc();
>
> In this variant, git_attr_check_alloc() is responsible for ensuring
> that the "check" is allocated only once just like _initl() is, and
> at the same time, it makes simultanous callers wait until the first
> caller who appends to the singleton check instance declares that it
> finished appending.  The return value signals if you are the first
> caller (who is responsible for populating the check and for
> declaring the check is ready to use at the end of appending).
> Everybody else waits while the first caller is doing the if (...) {
> } thing, and then receives false, at which time everybody (including
> the first caller) goes on and allocating its own result and start
> making queries.

Having said that, how flexible does the "alloc then append" side of
API have to be in the envisioned set of callers?  Is it expected
that it wouldn't be too hard to arrange them so that they have an
array of "const char *"s when they need to initialize/populate a
check?  If that is the case, instead of the "alloc and have others
wait" illustrated above, it may be a lot simpler to give _initv()
variant to them and be done with it, i.e. the above sample caller
would become just:

	git_attr_check_initv(&check, argv);
	result = git_attr_result_alloc(&check);

would that be too limiting?  The use of "alloc then append" pattern
in "git check-attr" done in your patch seems to fit the _initv()
well, and the "pathspec with attr match" that appears later in the
series also has all the attributes it needs to query available by
the time it wants to allocate and append to create an instance of
"check", I would think, so the _initv() might be sufficient as a
public API.
