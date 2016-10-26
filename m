Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495982022A
	for <e@80x24.org>; Wed, 26 Oct 2016 23:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933693AbcJZXOX (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 19:14:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53554 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933418AbcJZXOV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 19:14:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 310154AC62;
        Wed, 26 Oct 2016 19:14:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=spW70ggBX6X4qF0oAaenPZOAj4s=; b=wyCXhY
        2cOtvb80AVskt5Y2S12rJq2pr1z/Xcv2HjTpbvOX9JQHyfECe5rP4m91o1aGs1vX
        Uppy2RNHd2BzCAPCBGBATU3ICPEgI+jw0aI6C8GbmGR+tyRBc0jXPAFH1dDxq9/K
        DYJGySxnVJyU1dI7MIyXUkCfcYMG0XC508/iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KNC0xvAcNo86jO3D01jnFMchn7ZK0EkX
        1MSoqYfMcWX8EVaTuSStmLiofRTGyOoX6aaM9DfRGcIy/6CRi6KhCL/W7kATMU08
        8XX7FCEfxCqMy3V55N5cAILVGnQgGCfIeoKef63VDh4pcqjNFUgZuQEQnzgDyybe
        l5ogU2/BLRA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 271344AC61;
        Wed, 26 Oct 2016 19:14:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7986B4AC60;
        Wed, 26 Oct 2016 19:14:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        j6t@kdbg.org, peff@peff.net, bmwill@google.com, simon@ruderich.org
Subject: Re: [PATCHv2 1/2] attr: convert to new threadsafe API
References: <CAGZ79kYhMVrKHhNGYcf_D9kWEYp+sC+tMGbuE+gnD8AU27dh8g@mail.gmail.com>
        <20161026224104.31844-1-sbeller@google.com>
Date:   Wed, 26 Oct 2016 16:14:17 -0700
In-Reply-To: <20161026224104.31844-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 26 Oct 2016 15:41:04 -0700")
Message-ID: <xmqqoa26aek6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC452A58-9BD1-11E6-850B-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -53,19 +57,32 @@ value of the attribute for the path.
>  Querying Specific Attributes
>  ----------------------------
>  
> -* Prepare `struct git_attr_check` using git_attr_check_initl()
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
> +  can be prepared by calling `git_attr_check_alloc()` function and
> +  then attributes you want to ask about can be added to it with
> +  `git_attr_check_append()` function.

I think that my version that was discarded forbade appending once
you started to use the check for querying, because the check was
meant to be used as a key for an attr-stack and the check-specific
attr-stack was planned to keep only the attrs the check is
interested in (and appending is to change the set of attrs the check
is interested in, invalidating the attr-stack at that point).  

If you lost that restriction, that is good (I didn't check the
implementation, though).  Otherwise we'd need to say something here.

> +  Both ways with `git_attr_check_initl()` as well as the
> +  alloc and append route are thread safe, i.e. you can call it
> +  from different threads at the same time; when check determines
> +  the initialzisation is still needed, the threads will use a

initialization?

> +  single global mutex to perform the initialization just once, the
> +  others will wait on the the thread to actually perform the
> +  initialization.
> +
> +* Allocate an array of `struct git_attr_result` either statically on the
> +  as a variable on the stack or dynamically via `git_attr_result_alloc`

Grammo?  "either on the stack, or dynamically in the heap"?

> +  when the result size is not known at compile time. The call to initialize
> +  the result is not thread safe, because different threads need their
> +  own thread local result anyway.

Having result defined statically is not thread safe for that
reason.  It is not clear what you mean by "The call to initialize
the result"; having it on the stack or have one dynamically on the
heap ought to be thread safe.

> +* Call `git_check_attr()` to check the attributes for the path,
> +  the given `git_attr_result` will be filled with the result.
> +
> +* Inspect each `git_attr_result` structure to see how
> +  each of the attribute in the array is defined for the path.
>  
>  Example
>  -------
> @@ -76,28 +93,23 @@ To see how attributes "crlf" and "ident" are set for different paths.
>    we are checking two attributes):
>  
>  ------------
> -static struct git_attr_check *check;
> -static void setup_check(void)
> -{
> -	if (check)
> -		return; /* already done */
> -	check = git_attr_check_initl("crlf", "ident", NULL);
> -}
> +	static struct git_attr_check *check;
> +	git_attr_check_initl(check, "crlf", "ident", NULL);

I think you are still missing "&" here.

>  ------------
>  
>  . Call `git_check_attr()` with the prepared `struct git_attr_check`:
>  
>  ------------
>  	const char *path;
> +	struct git_attr_result result[2];
>  
> -	setup_check();
> -	git_check_attr(path, check);
> +	git_check_attr(path, check, result);
>  ------------
>  
> -. Act on `.value` member of the result, left in `check->check[]`:
> +. Act on `result.value[]`:
>  
>  ------------
> -	const char *value = check->check[0].value;
> +	const char *value = result.value[0];
>  
>  	if (ATTR_TRUE(value)) {
>  		The attribute is Set, by listing only the name of the
> @@ -123,12 +135,15 @@ the first step in the above would be different.
>  static struct git_attr_check *check;
>  static void setup_check(const char **argv)
>  {
> +	if (check)
> +		return; /* already done */
>  	check = git_attr_check_alloc();

You may want to say that this is thread-unsafe.

>  	while (*argv) {
>  		struct git_attr *attr = git_attr(*argv);
>  		git_attr_check_append(check, attr);
>  		argv++;
>  	}
> +	struct git_attr_result *result = git_attr_result_alloc(check);
>  }
>  ------------
>  
> @@ -138,17 +153,20 @@ Querying All Attributes
>  
>  To get the values of all attributes associated with a file:
>  
> +* Setup a local variables for the question
> +  `struct git_attr_check` as well as a pointer where the result
> +  `struct git_attr_result` will be stored.
> +* Call `git_all_attrs()`.

Hmph, the caller does not know what attribute it is interested in,
and it is unclear "how" the former needs to be set up from this
description.  Should it prepare an empty one that can be appended?

For the same reason, the size of the result is also unknown at the
callsite.

For these reasons, I thought git-all-attrs would need to use a
different calling convention from the usual "query for these
attributes -- get result for them" API.  Even if the same attr_check
and attr_result structures are used, they need to be initialized in
very different way from the normal calls, and this part of the doc
needs to explain how.  Perhaps it is sufficient to say "just declare
two pointer variables that point at these structures and a pair of
newly allocated structures of these types will be stored there" or
something.

It does not even have to use the usual "struct attr_check" "struct
attr_result" pair (I am not suggesting to use different convention
only to be different; I am merely pointing out that you have that
lattitude, as the usage pattern for all-attrs is so different from
the usual query).

