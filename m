Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E8820D09
	for <e@80x24.org>; Sat, 15 Apr 2017 09:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbdDOJRb (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 05:17:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56065 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751893AbdDOJR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 05:17:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A03278D15;
        Sat, 15 Apr 2017 05:17:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Abl43A3Lmp19IlmTfqJ3i3OH7s=; b=w1S26L
        ZRM8mkmHLJwAHK7Nq1ZtvsabxHjYVwfuu8wzav0zKAq08pPajytu+uMvd3MbHKkQ
        PRXOgbn3wJI88ybLvhJkK2/f0B5gonawTu2avf2ketc1K4Z6GejKdq614EltAZd6
        qST9e9uG0B43ym4rH4mNP5i9lZwPy7N7E8qc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WszOmSQ5BgO8OwQRafJrPhaFVs3tvhGT
        nHFafp0nQ776O3QOKxPFszO0sqVDMUZcycNNr60UL/bei9DttbGYu8jMrasoQr3e
        ulIBBslaYFyJWKcU8bUbvTgyni0ZDYp7Sg6JoMx+McG0GF9Vt7BmnGcts6uI9Akx
        LpBDFcAOuQA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1192778D14;
        Sat, 15 Apr 2017 05:17:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F40178D13;
        Sat, 15 Apr 2017 05:17:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git ML <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCHv3] rebase: pass --[no-]signoff option to git am
References: <20170414225713.29710-1-giuseppe.bilotta@gmail.com>
Date:   Sat, 15 Apr 2017 02:17:26 -0700
In-Reply-To: <20170414225713.29710-1-giuseppe.bilotta@gmail.com> (Giuseppe
        Bilotta's message of "Sat, 15 Apr 2017 00:57:13 +0200")
Message-ID: <xmqqefwum3mh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5828960E-21BC-11E7-BA2F-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> This makes it easy to sign off a whole patchset before submission.
>
> To make things work, we also fix a design issue in git-am that made it
> ignore the signoff option during rebase (specifically, signoff was
> handled in parse_mail(), but not in parse_mail_rebasing()).

I doubt that the above implementation detail in the code is "a
design issue"; it is a logical consequence of a design whose
"rebase" never passes "--signoff" down to underlying "am", so it is
understandable that whoever wants to pass "--signoff" thru during
the rebase needs to update the implementation, but I do not think it
is fair to call that "an issue".

>  Documentation/git-rebase.txt | 5 +++++
>  builtin/am.c                 | 6 +++---
>  git-rebase.sh                | 3 ++-
>  3 files changed, 10 insertions(+), 4 deletions(-)

We need new tests for "git rebase --signoff" that makes sure this
works as expected and only when it should.

> diff --git a/builtin/am.c b/builtin/am.c
> index f7a7a971fb..d072027b5a 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1321,9 +1321,6 @@ static int parse_mail(struct am_state *state, const char *mail)
>  	strbuf_addbuf(&msg, &mi.log_message);
>  	strbuf_stripspace(&msg, 0);
>  
> -	if (state->signoff)
> -		am_signoff(&msg);
> -
>  	assert(!state->author_name);
>  	state->author_name = strbuf_detach(&author_name, NULL);
>  
> @@ -1848,6 +1845,9 @@ static void am_run(struct am_state *state, int resume)
>  			if (skip)
>  				goto next; /* mail should be skipped */
>  
> +			if (state->signoff)
> +				am_append_signoff(state);
> +
>  			write_author_script(state);
>  			write_commit_msg(state);
>  		}

This removes the last direct caller to am_signoff().  It may be
worth considering to remove the function and move its body to its
only internal caller am_append_signoff().
