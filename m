Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DF5208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 21:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbdHJVlm (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 17:41:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57727 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751455AbdHJVlm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 17:41:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ACEEA03FC;
        Thu, 10 Aug 2017 17:41:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Qx1vCqBSgWpA
        v/raqMCIkMuhHhs=; b=XnCx/uGasZQljnlhj3DJWWSEo3umbYtlno1lVO2KR384
        4pdOcfgtYstaAmXFQyUtQJTU9iqFTLBCG3XKhdyci8VmpwrYWlxJfMtojvqmiSbF
        m3SQaOGOI8m2qOuXrXlJiB690Kf5WtLcsG7QPMqVzdhPC7UzOhLYgU+5EJT585c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eMGz+W
        aYzWt7lj3XCq/+W9oOGPhm+bebZ2oq+NqDyiTpAdVi40KrFqy+0gugK8ok1E+T+1
        gJlNHInGHiCiCRZtX91nQkOruhTqTLDU44vnNKukkZH09fHxxOwNDXwc5gNmyVVc
        paQLBY15OsNsqBchnzPJVwBTMiU4A+dXXBNj4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90667A03FB;
        Thu, 10 Aug 2017 17:41:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1E09A03FA;
        Thu, 10 Aug 2017 17:41:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: [PATCH] strbuf: clear errno before calling getdelim(3)
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
        <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
        <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
        <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
        <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
        <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
Date:   Thu, 10 Aug 2017 14:41:32 -0700
In-Reply-To: <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 10 Aug 2017 22:56:40 +0200")
Message-ID: <xmqq378z2j8z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ADE605B8-7E14-11E7-B41F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> getdelim(3) returns -1 at the end of the file and if it encounters an
> error, but sets errno only in the latter case.  Set errno to zero befor=
e
> calling it to avoid misdiagnosing an out-of-memory condition due to a
> left-over value from some other function call.
>
> Reported-by: Yaroslav Halchenko <yoh@onerussian.com>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

Heh.  I mumble something vague then people more capable than me jump
in to take it to the conclusion, and still I get the credit.  I wish
all the debugging sessions were this easy ;-)

> ---
> Do we need to save and restore the original value of errno?  I doubt it=
,
> but didn't think deeply about it, yet.

We probably don't need to---a caller who knows it got an error
before calling this function and wants to use errno after doing so
should be stashing it away; after all, this function will clobber
errno when any of the library calls it makes fails and this is on
the I/O codepath, so anything can go wrong.

Thanks.

>
>  strbuf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index 89d22e3b09..323c49ceb3 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -476,6 +476,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp=
, int term)
>  	/* Translate slopbuf to NULL, as we cannot call realloc on it */
>  	if (!sb->alloc)
>  		sb->buf =3D NULL;
> +	errno =3D 0;
>  	r =3D getdelim(&sb->buf, &sb->alloc, term, fp);
> =20
>  	if (r > 0) {
