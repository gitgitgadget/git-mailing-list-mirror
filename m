Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51508202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 01:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbdJXBoc (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 21:44:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56766 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751220AbdJXBo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 21:44:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4E54963B1;
        Mon, 23 Oct 2017 21:44:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YpXHYHqMW0sXXoSpGBmuwmoJhEA=; b=wGIBw9
        Ko1GLcSDZEId9UNcLkQksQG4IbaMC12rpmOrLEKOOxl5q2ZhvjbuVId5XzOMlil/
        HW0fadloY0o5qYgAGtPtsgC7FBtuM0amnjq7VWP0Uk7BWuzeUMZAoApjKqbVqJmq
        ZuzWcn4ml8kA6eQcAJRTbh+9q62NcuHmU68Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v89zbDV659cH6/rqWokiUgUOmytxbTk0
        /X5iWEHU/frL1bJXzOfpVtd2Ket0rfdMtJMrvFmlFDxMyxMmJa1E+43TtmI8ZxGc
        8tKd5b7jWeQGJSuMPqFHZuj69idR57epCOfY5R/6egZH09qM01XwejhCnUhJ+m2h
        uEKLQkgU1Xo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBCD6963B0;
        Mon, 23 Oct 2017 21:44:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3724D963AF;
        Mon, 23 Oct 2017 21:44:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, William Yan <wyan@google.com>
Subject: Re: [PATCH 1/5] connect: split git:// setup into a separate function
References: <20171003201507.3589-11-bmwill@google.com>
        <20171003214206.GY19555@aiede.mtv.corp.google.com>
        <20171016171812.GA4487@google.com>
        <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
        <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
        <20171023151929.67165aea67353e5c24a15229@google.com>
        <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
        <20171023225106.GA73667@google.com>
        <20171023155713.5055125d7467d8daaee42e32@google.com>
        <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
        <20171023231703.f457jp43dh7fddpv@aiede.mtv.corp.google.com>
Date:   Tue, 24 Oct 2017 10:44:25 +0900
In-Reply-To: <20171023231703.f457jp43dh7fddpv@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 23 Oct 2017 16:17:03 -0700")
Message-ID: <xmqqpo9d9v5y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE3B8076-B85C-11E7-92EE-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The git_connect function is growing long.  Split the
> PROTO_GIT-specific portion to a separate function to make it easier to
> read.
>
> No functional change intended.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> ---
> As before, except with sbeller's Reviewed-by.

I found this quite nice, except for one thing.

> +/*
> + * Open a connection using Git's native protocol.
> + *
> + * The caller is responsible for freeing hostandport, but this function may
> + * modify it (for example, to truncate it to remove the port part).
> + */
> +static struct child_process *git_connect_git(int fd[2], char *hostandport,
> +					     const char *path, const char *prog,
> +					     int flags)
> +{
> +	struct child_process *conn = &no_fork;
> +	struct strbuf request = STRBUF_INIT;

As this one decides what "conn" to return, including the fallback
&no_fork instance,...

> +	...
> +	return conn;
> +}
> +
>  /*
>   * This returns a dummy child_process if the transport protocol does not
>   * need fork(2), or a struct child_process object if it does.  Once done,
> @@ -881,50 +939,7 @@ struct child_process *git_connect(int fd[2], const char *url,

Each of the if/elseif/ cascade, one of which calls the new helper,
now makes an explicit assignment to "conn" declared in
git_connect().

Which means the defaulting of git_connect::conn to &no_fork is now
unneeded.  One of the things that made the original cascade a bit
harder to follow than necessary, aside from the physical length of
the PROTO_GIT part, was that the case where conn remains to point at
no_fork looked very special and it was buried in that long PROTO_GIT
part.  Now the main source of that issue is fixed, it would make it
clear to leave conn uninitialized (or initialize to NULL---but leaving
it uninitialized would make the intention of the code more clear, I
would think, that each of the if/elseif/ cascade must assign to it).

>  		printf("Diag: path=%s\n", path ? path : "NULL");
>  		conn = NULL;
>  	} else if (protocol == PROTO_GIT) {
> -		struct strbuf request = STRBUF_INIT;
> -...
> +		conn = git_connect_git(fd, hostandport, path, prog, flags);
>  	} else {
>  		struct strbuf cmd = STRBUF_INIT;
>  		const char *const *var;
