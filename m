Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2F020A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbdJBAzu (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:55:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62547 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750943AbdJBAzt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:55:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70E7DA130D;
        Sun,  1 Oct 2017 20:55:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L4IFYP2THZUdGvF6NcuhjQZuNH8=; b=kxizeq
        3kq6yTv8UPDjS7cAn3RSV/PiIgaMH2gDLygFpayhD2c7xtDJ8a936cnACKt8Fyq/
        2AYbGwba7WgnuPvZZi1jqogQAt+p+9GU2LdULTY4caVP5ATVMcMrwSHorkHZSRca
        CFLD1OXpzHMi8YAjKyjZ1Pyk1FIIoscAKfWzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PiGN1kFL6QNCPioalDqgo+6P4QSWxyWi
        BJbquDqxbm8713woC3rEeuZTHzRo3Qor/Bmv8Kge3KwYnUMpF2VWk2sUUZsWpwrU
        fdMKZUctVo4tAzpJgqKzF4OYGDZbkyWcSKUwZpLlGotF+P9rSxJVRIl9r6w++/bg
        M968yKl2JWg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68771A130C;
        Sun,  1 Oct 2017 20:55:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9238A130B;
        Sun,  1 Oct 2017 20:55:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sbeller@google.com
Subject: Re: [PATCH v6 2/3] submodule--helper: introduce for_each_listed_submodule()
References: <xmqq4lrrfjt9.fsf@gitster.mtv.corp.google.com>
        <20170929094453.4499-1-pc44800@gmail.com>
        <20170929094453.4499-3-pc44800@gmail.com>
Date:   Mon, 02 Oct 2017 09:55:47 +0900
In-Reply-To: <20170929094453.4499-3-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Fri, 29 Sep 2017 15:14:52 +0530")
Message-ID: <xmqq8tgus6zw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E3300D0-A70C-11E7-9E50-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Introduce function for_each_listed_submodule() and replace a loop
> in module_init() with a call to it.
>
> The new function will also be used in other parts of the
> system in later patches.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index cdae54426..20a1ef868 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -14,6 +14,11 @@
>  #include "refs.h"
>  #include "connect.h"
>  
> +#define CB_OPT_QUIET		(1<<0)

Is the purpose of this bit to make the callback quiet?  I do not
think so.  Is there a reason why we cannot call it just OPT_QUIET or
something instead?

When the set of functions that pay attention to these flags include
both ones that are callable for a single submodule and ones meant as
callbacks for for-each interface, having to flip bit whose name
screams "CallBack!" in a caller of a single-short version feels very
wrong.

"make style" tells me to format the above like so:

	#define OPT_QUIET (1 << 0)

and I think I agree.

> @@ -349,7 +354,22 @@ static int module_list(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -static void init_submodule(const char *path, const char *prefix, int quiet)
> +static void for_each_listed_submodule(const struct module_list *list,
> +				      each_submodule_fn fn, void *cb_data)
> +{
> +	int i;
> +	for (i = 0; i < list->nr; i++)
> +		fn(list->entries[i], cb_data);
> +}

Good.

> +struct init_cb {

I take it is a short-hand for "submodule init callback"?  As long as
the name stays inside this file, I think we are OK.

> +	const char *prefix;
> +	unsigned int cb_flags;

Call this just "flags"; call-back ness is plenty clear from the fact
that it lives in a structure meant as a callback interface already.

> +};

Blank line here?

> +#define INIT_CB_INIT { NULL, 0 }
> +
> +static void init_submodule(const char *path, const char *prefix,
> +			   unsigned int cb_flags)

Call this also "flags"; a direct caller of this function that wants
to initialize a single submodule without going thru the for-each
callback interface would not be passing "callback flags"--they are
just passing a set of flags.
