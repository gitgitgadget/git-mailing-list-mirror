Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342A320756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdAQX5j (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:57:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59133 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751817AbdAQX45 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:56:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4FDE61B65;
        Tue, 17 Jan 2017 18:43:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RZrWR3tIWI+K2+gws0oLWfK/Jss=; b=l3eGID
        izSa1GWfBpUBX6X/V8m9ZQ5DO9dzEg6uooOxrAEdTpAxtshOMfd+rX5HvwT73BEy
        cQ/K8aWBkk6rgevKRsL3RpMhqiP8QAl54ZUT3qKS02WcMQFoMLT51MomOn3r2xAb
        a3H+8uKcYBjOdBNOpzuKjE6MSWAIs1mLBKMqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R3uZ8pIxrVsdDIrpqw3/I2g2pPOu64LF
        59r6zeZDXALH30lyrq0lRyMlK2kDZztFgpw2x3v7+t1aVfprKoHM5pC0wySKvBl5
        9eexwlYEpqqd2wQzbbQMrl8gbDAWAvlgBk/vlA2EhIlfD7bxVpCZLgR9HFTy4+J6
        odQnFHBf960=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1C5B61B61;
        Tue, 17 Jan 2017 18:43:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9A9C61B60;
        Tue, 17 Jan 2017 18:43:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, dborowitz@google.com
Subject: Re: [PATCH] transport submodules: correct error message
References: <20170113235427.5768-1-sbeller@google.com>
Date:   Tue, 17 Jan 2017 15:42:59 -0800
In-Reply-To: <20170113235427.5768-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 13 Jan 2017 15:54:27 -0800")
Message-ID: <xmqq8tq9ckxo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE83315A-DD0E-11E6-9C91-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Trying to push with --recurse-submodules=on-demand would run into
> the same problem. To fix this issue
>     1) specifically mention that we looked for branches on the remote.

That makes an incorrect statement ("not found on any remote"---we
did not inspect all of the said remote, only heads and tags) into an
irrelevant statement ("not found on any remote branch"---the end
user would say "so what?  I know it exists there, it's just that not
all remote refs have corresponding tracking ref locally on our side").

Perhaps it may be an improvement.

>     2) advertise pushing without recursing into submodules. ("Use this
>        command to make the error message go away")

Not mentioning "on-demand" may be an improvement for those who do
use set-up like Dave has, where remote tracking information is
incomplete if you only look at heads and refs, in the sense that we
no longer suggest ineffective workaround.  

But would it be an improvement to suggest --no-recurse-submodules?

This issue seems like a property of the particular set-up, as
opposed to being a one-off issue.  The next, subsequent and probably
all future pushes from that repository will have the same issue
because the root cause is not due to the relative position of
commits we have locally vs the tips of remote, but due to the way
remote tracking is set-up, no?

If that is the case, perhaps configuring push.recurseSubmodules to
turn this off (especially because you plan to turn the defaul to
"check") and not giving the command line option would give a more
pleasant end-user experience, I suspect.


>
> While at it, remove some empty lines, as they blow up the error message.
>
> Reported-by: Dave Borowitz <dborowitz@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  transport.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index 3e8799a611..2445bf0dca 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -883,14 +883,14 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
>  	int i;
>  
>  	fprintf(stderr, _("The following submodule paths contain changes that can\n"
> -			"not be found on any remote:\n"));
> +			"not be found on any remote branch:\n"));
>  	for (i = 0; i < needs_pushing->nr; i++)
>  		fprintf(stderr, "  %s\n", needs_pushing->items[i].string);
> -	fprintf(stderr, _("\nPlease try\n\n"
> -			  "	git push --recurse-submodules=on-demand\n\n"
> -			  "or cd to the path and use\n\n"
> -			  "	git push\n\n"
> -			  "to push them to a remote.\n\n"));
> +	fprintf(stderr, _("\nSuppress submodule checks via\n"
> +			  "	git push --no-recurse-submodules\n"
> +			  "or cd to the path and use\n"
> +			  "	git push\n"
> +			  "to push them to a remote.\n"));
>  
>  	string_list_clear(needs_pushing, 0);
