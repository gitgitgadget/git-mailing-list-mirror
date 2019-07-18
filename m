Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342BD1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 17:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfGRRpJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 13:45:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50005 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfGRRpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 13:45:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 938721721C0;
        Thu, 18 Jul 2019 13:45:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bExevB84fzEbwq9tIwEUQ0ChCqo=; b=mzn8G+
        knqEQ62C+NyFa1oJ4jD5vgNlCRf8iH37AY9p6duKrV/u/JlFKYJhWq6u0gBx6c0/
        e/ilYFkSB41Sb4dqVidK/HNbvyvs9qWRBILZKngT2gm73tpsOeDgnikUxLQZtmTU
        +Y2cgfcrYvaplFy4xcNta9YlyxR9DMuXi7WkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QlkdFekPqxKqNwrDooc1eLW9M8UFm9AY
        onZlQjZSQ1hLanbWuT4eadgG5aMDvx5uO5i2UDU6gtzKJS7/Z8Rk7Le3mjZM5w5l
        N+Lsi8oARqX2bn9pkUzPO6V3epHs2adjk1rG/ambF+x37JV2I9Nb8A1zAgi45aZP
        HdxQSRgYfJE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8830E1721BE;
        Thu, 18 Jul 2019 13:45:06 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD5951721BD;
        Thu, 18 Jul 2019 13:45:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org,
        chriscool@tuxfamily.org, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com
Subject: Re: [PATCH] fetch: add "--parallel", which fetches all remotes in parallel
References: <20190717015903.4384-1-palmer@sifive.com>
Date:   Thu, 18 Jul 2019 10:45:04 -0700
In-Reply-To: <20190717015903.4384-1-palmer@sifive.com> (Palmer Dabbelt's
        message of "Tue, 16 Jul 2019 18:59:03 -0700")
Message-ID: <xmqq5znzz17j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C71E292E-A983-11E9-AA08-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Palmer Dabbelt <palmer@sifive.com> writes:

> * I'm not sure if it's safe to access the .git database from multiple
>   processes at the same time.

It is supposed to, and also you are supposed to keep it that way ;-)

> * As I was writing the documentation I found "fetch --jobs".  It seems
>   like I should use that instead of adding a new argrument, but I wasn't
>   sure.

Why not?  What makes you feel it is a bad idea to follow that
pattern?

Ah, --jobs that is taken already is right now too tied to fetches
that happen in submodules, which arguably was a design mistake.

    -j::
    --jobs=<n>::
            Number of parallel children to be used for fetching
            submodules.  Each will fetch from different submodules,
            such that fetching many submodules will be faster. By
            default submodules will be fetched one at a time.

The simplest endgame would be to replace "submodule" with
"repository" in the above description, perhaps like

	Number of parallel jobs to be used for fetching from
	multiple repositories (both fetching with "--multiple" from
	multiple repositories, and also fetching updated contents
	for submodules).  By default, fetching from multiple
	repositories and submodules is done one at a time.

and nobody would have complained if the system were like so from the
beginning.  Existing users, however, may want extra flexibility, and
would complain loudly if we did the above, in which case, we may
have to

 - introduce --fetch-jobs=<n> for what you are adding;

 - introduce --submodule-fetch-jobs=<n> as a synonym for existing
   --jobs=<n> and deprecate the current use of --jobs=<n>;

 - eventually repurpose --jobs=<n> as a short-hand to give both
   --fetch-jobs and --submoduje-fetch-jobs at the same time.

> +static int parallel = 0;

Don't explicitly "= 0;" initialize file-scope static.  Instead let
BSS take care of it.

>  static int git_fetch_config(const char *k, const char *v, void *cb)
>  {
> @@ -178,6 +179,8 @@ static struct option builtin_fetch_options[] = {
>  			TRANSPORT_FAMILY_IPV6),
>  	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
>  			N_("report that we have only objects reachable from this object")),
> +	OPT_BOOL(0, "parallel", &parallel,
> +		 N_("fetch in parallel from each remote")),
>  	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
>  	OPT_BOOL(0, "auto-gc", &enable_auto_gc,
>  		 N_("run 'gc --auto' after fetching")),
> @@ -1456,12 +1459,15 @@ static void add_options_to_argv(struct argv_array *argv)
>  
>  }
>  
> -static int fetch_multiple(struct string_list *list)
> +static int fetch_multiple(struct string_list *list, int i)
>  {
> -	int i, result = 0;

'i' is perfectly a good name for a local variable that is used for
loop control purposes, but makes a horrible name for a parameter.

Existing 'list' is not any better either---we know it is a list by
its type already, the name should say what the list is about, what
it represents.  But having a horribly named parameter already is not
a good reason to make the code even worse.

And as you said, recursion makes the code structure harder to follow
here.  Keeping an array of --jobs=<n> cmd structures, looping to
fill them by starting, doing wait() to reap any of the started ones
that first exits to refill the slot just opened, etc. would be easier
to see if done in a loop, I think.
