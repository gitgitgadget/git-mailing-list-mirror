Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3041F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 17:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbcJKR61 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 13:58:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62687 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932752AbcJKRkp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 13:40:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B86743B23;
        Tue, 11 Oct 2016 13:40:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T7krl6UIvJ+Y937MeOLts533aX0=; b=BgRRxG
        PyW709a90kD1Lw6+YDhY4h/giwUCXEjl7B+yUsrglGqijXzp821XGGsefQPBw2aG
        XiSyKAKSXAz+4cOCwVjXvmCdM5hqu2yZtGhdjxGbtYcfbqNhOGKm4E0wU/cnduhU
        QhG1lAkdJiSHzClCdFWa+3MnJz33TQM5RDpDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xl7o6W/IvclvFElfEu2h/AIfHhZQ6MEH
        mNDJulIC17qe91EI1N+kUkc8nAOV+LPmV7ztQi0yR1VEiaEVBgVHWuntlZWpDHwB
        ZXfKsmdfUimY2bAws/SuRw3hAugiDzCROSn8P1theEIuyB/wfnlovXjA7qqYWZql
        lVFAz21Enzg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 645B943B22;
        Tue, 11 Oct 2016 13:40:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4BCC43B21;
        Tue, 11 Oct 2016 13:40:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com
Subject: Re: [PATCH 28/28] attr: convert to new threadsafe API
References: <20161011002115.23312-1-sbeller@google.com>
        <20161011002115.23312-29-sbeller@google.com>
Date:   Tue, 11 Oct 2016 10:40:41 -0700
In-Reply-To: <20161011002115.23312-29-sbeller@google.com> (Stefan Beller's
        message of "Mon, 10 Oct 2016 17:21:15 -0700")
Message-ID: <xmqqmviaaina.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5BFFE7E-8FD9-11E6-83D2-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This revamps the API of the attr subsystem to be thread safe.
> Before we had the question and its results in one struct type.
> The typical usage of the API was
>
>     static struct git_attr_check;

I think you meant "*check" at the end, perhaps?

>
>     if (!check)
>         check = git_attr_check_initl("text", NULL);
>
>     git_check_attr(path, check);
>     act_on(check->value[0]);
>
> * While the check for attributes to be questioned only need to
>   be initalized once as that part will be read only after its
>   initialisation, the answer may be different for each path.
>   Because of that we need to decouple the check and the answer,
>   such that each thread can obtain an answer for the path it
>   is currently processing.

Yes, it is good to separate questions and answers.  I think answers
should be owned by the caller, though.  I do not think of a good
reason why you want to make it impossible to do something like this:

	struct git_attr_check_result *result_1 = ...allocate...;
	struct git_attr_check_result *result_2 = ...allocate...;

	loop {
                struct strbuf path = next_path();
                git_check_attr(result_1, path.buf, check_1);
                if (strbuf_strip_suffix(&path, ".c")) {
                        strbuf_addstr(&path, ".h");
                        git_check_attr(result_2, path.buf, check_2);
                        do something using result_1[] and result_2[];
                } else {
			do something using result_1[];
		}
	}

Do we already have a design of the "result" thing that is concrete
enough to require us to declare that the result is owned by the
implementation and asking another question has to destroy the answer
to the previous question?  Otherwise, I'd rather not to see us make
the API unnecessarily hard to use.  While I do want us to avoid
overengineering for excessive flexibility, I somehow feel "you
cannot control the lifetime of the result, it is owned by the
subsystem" falls the other side of the line.

> diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
> index 92fc32a..2059aab 100644
> --- a/Documentation/technical/api-gitattributes.txt
> +++ b/Documentation/technical/api-gitattributes.txt
> @@ -8,6 +8,18 @@ attributes to set of paths.
>  Data Structure
>  --------------
>  
> +extern struct git_attr *git_attr(const char *);
> +
> +/*
> + * Return the name of the attribute represented by the argument.  The
> + * return value is a pointer to a null-delimited string that is part
> + * of the internal data structure; it should not be modified or freed.
> + */
> +extern const char *git_attr_name(const struct git_attr *);
> +
> +extern int attr_name_valid(const char *name, size_t namelen);
> +extern void invalid_attr_name_message(struct strbuf *, const char *, int);
> +
>  `struct git_attr`::
>  
>  	An attribute is an opaque object that is identified by its name.
> @@ -16,15 +28,17 @@ Data Structure
>  	of no interest to the calling programs.  The name of the
>  	attribute can be retrieved by calling `git_attr_name()`.
>  
> -`struct git_attr_check_elem`::
> -
> -	This structure represents one attribute and its value.
> -
>  `struct git_attr_check`::
>  
> -	This structure represents a collection of `git_attr_check_elem`.
> +	This structure represents a collection of `struct git_attrs`.
>  	It is passed to `git_check_attr()` function, specifying the
> -	attributes to check, and receives their values.
> +	attributes to check, and receives their values into a corresponding
> +	`struct git_attr_result`.
> +
> +`struct git_attr_result`::
> +
> +	This structure represents a collection of results to its
> +	corresponding `struct git_attr_check`, that has the same order.
>  
>  
>  Attribute Values
> @@ -56,16 +70,22 @@ Querying Specific Attributes
>  * Prepare `struct git_attr_check` using git_attr_check_initl()
>    function, enumerating the names of attributes whose values you are
>    interested in, terminated with a NULL pointer.  Alternatively, an
> -  empty `struct git_attr_check` can be prepared by calling
> -  `git_attr_check_alloc()` function and then attributes you want to
> -  ask about can be added to it with `git_attr_check_append()`
> -  function.
> +  empty `struct git_attr_check` as alloced by git_attr_check_alloc()

"allocated", not "alloced".

> +  can be prepared by calling `git_attr_check_alloc()` function and
> +  then attributes you want to ask about can be added to it with
> +  `git_attr_check_append()` function.
> +  git_attr_check_initl is thread safe, i.e. you can call it

Spell it `git_attr_check_initl()` for consistency.

> +  from different threads at the same time; internally however only one
> +  call at a time is processed. If the calls from different threads have
> +  the same arguments, the returned `git_attr_check` may be the same.

I find this description a bit confusing.  At least the way I
envisioned was that when this piece of code is run by multiple
people at the same time,

	static struct git_attr_check *check = NULL;
	git_attr_check_initl(&check, ...);

we won't waste the "check" by allocated by the first one by
overwriting it with another one allocated by the second one.  So
"the same arguments" does not come into the picture.  A single
variable is either 

 * already allocated and initialised by the an earlier call to
   initl() by somebody else, or

 * originally NULL when you call initl(), and the implementation
   makes sure that other people wait while you allocate, initialise
   and assign it to the variable, or

 * originally NULL when you call initl(), but the implementation
   notices that somebody else is doing the second bullet point
   above, and you wait until that somebody else finishes and then
   you return without doing anything (because by that time, "check"
   is filled by that other party doing the second bullet point
   above).

There is no need to check for "the same arguments".

