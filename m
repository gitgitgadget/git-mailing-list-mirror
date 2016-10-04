Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEDCD20986
	for <e@80x24.org>; Tue,  4 Oct 2016 23:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbcJDXOC (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 19:14:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50246 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752877AbcJDXOB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 19:14:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1960643144;
        Tue,  4 Oct 2016 19:14:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BiCNp7XVFY1RYRHyf1F3eSqnsaU=; b=vzJCXj
        V/L4vaIFu/72oLAzm5I13EGGdBCY3hU1levajHQAXhw9K7Dn8XNZRDWzOrK6nOdm
        xMS3osl+Uqr9VAskimKrQyyodgKw7vOAYZ5Fi3VlVg6tOEXf7KbqpsrawAmAazrt
        BolhWJurEi6cWy3emzJ0SqN+Y9ZGkJeeksMqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nuFlD6XP1oW6cEvmTvPGHp5CJLMoZxQu
        9BJMCNI3xk8NFOO6VDErCA6ZuYybgzp7I7pWwex8OetMIVC3N2GjP0nYxpoxrOY0
        CuDJQZe9IETJDdLgw0dohhJIupoqFRY5NPlyDgoT9FYlQHbOCHlsqAB0RkLU52G3
        HYCvfQt4ceg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1047343143;
        Tue,  4 Oct 2016 19:14:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8556143142;
        Tue,  4 Oct 2016 19:13:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [RFC/PATCH] attr: Document a new possible thread safe API
References: <20161004221433.23747-1-sbeller@google.com>
Date:   Tue, 04 Oct 2016 16:13:57 -0700
In-Reply-To: <20161004221433.23747-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 4 Oct 2016 15:14:33 -0700")
Message-ID: <xmqqtwcrr9l6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B3FC1D2-8A88-11E6-913C-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
> index 92fc32a..940617e 100644
> --- a/Documentation/technical/api-gitattributes.txt
> +++ b/Documentation/technical/api-gitattributes.txt
> @@ -59,7 +59,10 @@ Querying Specific Attributes
>    empty `struct git_attr_check` can be prepared by calling
>    `git_attr_check_alloc()` function and then attributes you want to
>    ask about can be added to it with `git_attr_check_append()`
> -  function.
> +  function. git_attr_check_initl is thread safe, i.e. you can call it
> +  from different threads at the same time; internally however only one
> +  call at a time is processed. If the calls from different threads have
> +  the same arguments, the returned `git_attr_check` may be the same.

I do not think this is enough.  Look at the example for _initl() and
notice that it keeps the "singleton static check that is initialized
by the very first caller if the caller notices it is NULL" pattern.

One way to hide that may be to pass the address of that singleton
pointer to _initl(), so that it can do the "has it been initialized?
If not, let's prepare the thing" under lock.

> @@ -89,15 +92,21 @@ static void setup_check(void)
>  
>  ------------
>  	const char *path;
> +	struct git_attr_check *result;
>  
>  	setup_check();
> -	git_check_attr(path, check);
> +	result = git_check_attr(path, check);

I haven't formed a firm opinion, but I suspect your thinking might
be clouded by too much staring at the current implementation that
has <attr>,<value> pairs inside git_attr_check.  Traditionally, the
attr subsystem used the same type for the query question and the
query answer the same type, but it does not have to stay to be the
case at all.  Have you considered that we are allowed to make these
two types distinct?  A caller can share the same question instance
(i.e. the set of interned <attr>, in git_attr_check) with other
threads as that is a read-only thing, but each of the callers would
want to have the result array on its own stack if possible
(e.g. when asking for a known set of attributes, which is the
majority of the case) to avoid allocation cost.  I'd expect the most
typical caller to be

	static struct git_attr_check *check;
	struct git_attr_result result[2]; /* we want two */
	
	git_attr_check_initl(&check, "crlf", "ident", NULL);
	git_check_attr(path, check, result);
	/* result[0] has "crlf", result[1] has "ident" */

or something like that.
