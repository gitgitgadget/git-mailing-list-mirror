Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 014DB2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 17:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030424AbcJ1RUU (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 13:20:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52275 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933416AbcJ1RUT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 13:20:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E7DD48DEF;
        Fri, 28 Oct 2016 13:20:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XMVnCgg3yByDVKCHeb9b3fXaRxQ=; b=aW15rS
        sjcFLRCyu1RABf5K4wID8morDupJpJmfOiXh9LvGZuAG22PPkpJ6TZbl40xsh7ME
        Rr0WjRj7lpmB4z7HlN3ahMD5nLuzuBxaw2oeauvx+T193U65P7xdGEnhECSXuikn
        IJ3JZM6I5Is2G1mDswVCD3hC1S6OSLzA+uIQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bDH6BzBUh2wMCz09vtFojSAV9vFh4jzr
        GyvLUEPnXzTQFdIblam02J28IVTdsOfobl2XkmcaONtRu6UmCOI3w2J56N6ZBi/E
        t/lUC1JQIH4/40vZCRpn676Y+3GXkBmTlFI/60hiVmnHt/YXDtLOjE3O4GorzGmK
        eRUi1D/Uj04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1682A48DEE;
        Fri, 28 Oct 2016 13:20:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89AFB48DED;
        Fri, 28 Oct 2016 13:20:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Johannes.Schindelin@gmx.de, j6t@kdbg.org, peff@peff.net,
        simon@ruderich.org
Subject: Re: [PATCH] attr: convert to new threadsafe API
References: <xmqqy41a8hxj.fsf@gitster.mtv.corp.google.com>
        <20161027221550.14930-1-sbeller@google.com>
Date:   Fri, 28 Oct 2016 10:20:15 -0700
In-Reply-To: <20161027221550.14930-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 27 Oct 2016 15:15:50 -0700")
Message-ID: <xmqqinsc1jcg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBEA1CAC-9D32-11E6-96B5-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +* Prepare a `struct git_attr_check` using `git_attr_check_initl()`
>    function, enumerating the names of attributes whose values you are
>    interested in, terminated with a NULL pointer.  Alternatively, an
> -  empty `struct git_attr_check` can be prepared by calling
> -  `git_attr_check_alloc()` function and then attributes you want to
> -  ask about can be added to it with `git_attr_check_append()`
> -  function.
> -
> -* Call `git_check_attr()` to check the attributes for the path.
> -
> -* Inspect `git_attr_check` structure to see how each of the
> -  attribute in the array is defined for the path.
> -
> +  empty `struct git_attr_check` as allocated by git_attr_check_alloc()

Need to drop "as allocated by git_attr_check_alloc()" here.

> +  can be prepared by calling `git_attr_check_alloc()` function and
> +  then attributes you want to ask about can be added to it with
> +  `git_attr_check_append()` function.
> +  Both ways with `git_attr_check_initl()` as well as the
> +  alloc and append route are thread safe, i.e. you can call it
> +  from different threads at the same time; when check determines
> +  the initialization is still needed, the threads will use a
> +  single global mutex to perform the initialization just once, the
> +  others will wait on the the thread to actually perform the
> +  initialization.

I have some comments on the example in the doc on the "alloc-append"
side.  _initl() side looks OK.

> +	static struct git_attr_check *check;
> +	git_attr_check_initl(&check, "crlf", "ident", NULL);

OK.

>  	const char *path;
> +	struct git_attr_result result[2];
>  
> +	git_check_attr(path, check, result);

OK.  The above two may be easier to understand if they were a single
example, though.

> +. Act on `result.value[]`:
>  
>  ------------
> -	const char *value = check->check[0].value;
> +	const char *value = result.value[0];

OK.

> @@ -123,12 +135,15 @@ the first step in the above would be different.
>  static struct git_attr_check *check;
>  static void setup_check(const char **argv)
>  {
> +	if (check)
> +		return; /* already done */
>  	check = git_attr_check_alloc();
>  	while (*argv) {
>  		struct git_attr *attr = git_attr(*argv);
>  		git_attr_check_append(check, attr);
>  		argv++;
>  	}
> +	struct git_attr_result *result = git_attr_result_alloc(check);

This does not look like thread-safe.

I could understand it if the calling convention were like this,
though:

	if (git_attr_check_alloc(&check)) {
		while (*argv) {
	        	... append ...
		}
		git_attr_check_finished_appending(&check);
	}
	result = result_alloc();

In this variant, git_attr_check_alloc() is responsible for ensuring
that the "check" is allocated only once just like _initl() is, and
at the same time, it makes simultanous callers wait until the first
caller who appends to the singleton check instance declares that it
finished appending.  The return value signals if you are the first
caller (who is responsible for populating the check and for
declaring the check is ready to use at the end of appending).
Everybody else waits while the first caller is doing the if (...) {
} thing, and then receives false, at which time everybody (including
the first caller) goes on and allocating its own result and start
making queries.

> +* Setup a local variables for the question
> +  `struct git_attr_check` as well as a pointer where the result
> +  `struct git_attr_result` will be stored. Both should be initialized
> +  to NULL.
> +
> +------------
> +  struct git_attr_check *check = NULL;
> +  struct git_attr_result *result = NULL;
> +------------
> +
> +* Call `git_all_attrs()`.
>  
> +------------
> +  git_all_attrs(full_path, &check, &result);
> +------------

OK.

Thanks.
