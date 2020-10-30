Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A46C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 19:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35AE720729
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 19:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gUXC3C+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgJ3TuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 15:50:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51370 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgJ3TuE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 15:50:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FD2DECE1C;
        Fri, 30 Oct 2020 15:50:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XodB0831q0AJ
        wjGy/+Bta4gZ9mQ=; b=gUXC3C+kJHQCum9SQ5ygIN3td5TWgnbaAbk1Qi2n94Lu
        B0vVe/lhb1+ixxPoZ9aaz55aFS3MHVVhWimf4iuaTqCY3dhU+txOgXwFVc+E+NZ1
        ssmHdWVMNdhVSHuSJmQdBFcfLV9YiNF0YiEqMYP4wJf0iuig2Xox47duWcaD8YY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bF5K20
        wST3CSHSkPeQk16gcedcRzcSBI74EYKs2DDWNkSqxyiVIgL4mAsUC+t8X8AT+jh5
        gemZIBer628Kp7e9oqsHq38NqKnmYgKEjh228q6+FlwOG4uL+Jb7GiOJFFPUPeAj
        kpu7alaNIm8XgQJ1VlFvqyskQ4JkmO1sfD87I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 533FBECE1B;
        Fri, 30 Oct 2020 15:50:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 78847ECE17;
        Fri, 30 Oct 2020 15:49:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Sim=C3=A3o?= Afonso <simao.afonso@powertools-tech.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential-store: use timeout when locking file
References: <20201030180718.4i7txqkgye7r6pkb@safonso-t430>
Date:   Fri, 30 Oct 2020 12:49:56 -0700
In-Reply-To: <20201030180718.4i7txqkgye7r6pkb@safonso-t430> (=?utf-8?Q?=22?=
 =?utf-8?Q?Sim=C3=A3o?= Afonso"'s
        message of "Fri, 30 Oct 2020 18:07:18 +0000")
Message-ID: <xmqq361v334r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 17460D86-1AE9-11EB-8637-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sim=C3=A3o Afonso <simao.afonso@powertools-tech.com> writes:

> When holding the lock for rewriting the credential file, use a timeout
> to avoid race conditions when the credentials file needs to be updated
> in parallel.
>
> An example would be doing `fetch --all` on a repository with several
> remotes that need credentials, using parallel fetching.

OK.

> The timeout is hardcoded to 1 second, since this is just to solve a rac=
e
> condition.

It is unclear what this sentence wants to explain.  How does "this
is to solve a race" justifies the choice of "1 second" (as opposed
to say 10 seconds or 0.5 second)?  Or is this trying to justify why
there is no configurability?  If so, why is it OK to hardcode it if
it is done to solve a race?  Are we assuming certain maximum rate
of operation that is "reasonable"?

> This was reported here:
> https://lore.kernel.org/git/20201029192020.mcri76ylbdure2o7@safonso-t43=
0/
> ---

Missing sign-off.

cf. https://git-scm.com/docs/SubmittingPatches.html#sign-off

>  builtin/credential-store.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> index 5331ab151..acff4abae 100644
> --- a/builtin/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -58,8 +58,9 @@ static void print_line(struct strbuf *buf)
>  static void rewrite_credential_file(const char *fn, struct credential =
*c,
>  				    struct strbuf *extra)
>  {
> -	if (hold_lock_file_for_update(&credential_lock, fn, 0) < 0)
> -		die_errno("unable to get credential storage lock");
> +	static long timeout =3D 1000;

Why "static"?  It would make your code easier to follow if you limit
use of "static" to only cases where you want to take advantage of
the fact that the value previously left by the earlier call is seen
by the next call, and/or the address of the variable must be valid
even after the control returns to the caller.

I would understand if this were "const long timeout =3D 1000".

If this were an identifier with longer lifespan, I would have
suggested to include some scale in the variable name (e.g.
timeout_ms to clarify that it is counted in milliseconds), but it is
just for this short function, so let's say "timeout" is just fine.

> +	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeou=
t) < 0)
> +		die_errno("unable to get credential storage lock in %ld ms", timeout=
);
>  	if (extra)
>  		print_line(extra);
>  	parse_credential_file(fn, c, NULL, print_line);

Thanks.
