Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642A81F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 18:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbcI1Stg (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 14:49:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52113 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752657AbcI1Ste (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 14:49:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 480BE411F2;
        Wed, 28 Sep 2016 14:49:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ddq1KbRX/g40
        CNVfkhForEFiK8U=; b=I3ed2ub8zfwpBBGg3BY3C7DlGtSEg2HoGKOgzGaQ4tLW
        fBJeVcP0R0azWCMb55JtDsN4gNKg0tl7LI0zrXQ/QN9q+GtUyVu7SuriXn+Z7rzC
        TQhMQH+v+G4zsk2Qcz4O0vKHYBB3j5bdpaiCkks9zWqC7GiwtKBXpM69S4VpzEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Toj1RL
        cHFRMeuo8eY8+6iesWy26xIM4X03tw5By3sduL6VarHoUv4CoBjpwuILPhBu31hX
        supslfubsIbASN8hknFPtjaKXHDXOE8lJKfr58rGhqTqOHW9vWkpcgFb7YGnqJQP
        hPyHlOa9B7Qr2WWPDPq9nQcUQG0PaANUPF+X8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 413E5411F1;
        Wed, 28 Sep 2016 14:49:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD0A9411F0;
        Wed, 28 Sep 2016 14:49:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] diff-lib.c: enable --shift-ita in index_differs_from()
References: <20160928114348.1470-1-pclouds@gmail.com>
        <20160928114348.1470-3-pclouds@gmail.com>
Date:   Wed, 28 Sep 2016 11:49:30 -0700
In-Reply-To: <20160928114348.1470-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 28 Sep 2016 18:43:47 +0700")
Message-ID: <xmqq8tubkgg5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4B79B5A2-85AC-11E6-99D9-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This function is basically "git diff --cached HEAD", It has three
> callers:
>
>  - One in builtin/commit.c, which uses it to determine if the index is
>    different from HEAD and go ahead making a new commit.
>
>  - Two in sequencer.c, which use it to see if the index is dirty.
>
> In the first case, if ita entries are present, index_differs_from() may
> report "dirty". However at tree creation phase, ita entries are dropped
> and the result tree may look exactly the same as HEAD (assuming that
> nothing else is changed in index). This is what we need index_differs_f=
rom()
> for, to catch new empty commits. Enabling shift_ita in index_differs_fr=
om()
> fixes this.
>
> In the second case, the presence of ita entries are enough to say the
> index is dirty and not continue on. Make an explicit check for that
> before comparing index against HEAD (whether --shift-ita is present is
> irrelevant)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---

There are three callers to index_differs_from(), which asks "is the
index different from the HEAD".  Because you want to change the
behaviour of the function for one of these callers while not
exposing its undesirable behaviour for the other two callers, you
guard the call to it with another call to a new helper function,
which needs to scan the entire index one more time.

It somehow sounds like backwards to me.

IOW, I wonder if it makes more sense to add a new interface to tell
the index_differs_from() function "I want you to use shift-ita
semantics" bit, and pass that when calling it from builtin/commit.c
while not toggling that bit on when the other two callers call it,
without introducing the has_ita_entries() helper function.

By the way, I think "shift" is a bit unclear name for the diffopt
field.  The log message of [1/3] is totally unclear (it claims
"smaller and safer" without explaining what it exactly does and why
that is safer); the documentation update in it is slightly better in
that it lets intelligent readers to guess that the option is to
declare that ita entries do not yet exist in the index (hence, "git
diff" would say "that's a new file", while "git diff --cached" says
nothing about it).  From that observation, I think a descriptive
phrase that is suitable for its name than "shift" needs to be found
in a short explanation of what it does: "treat ita as missing in the
index", e.g. "rev.diffopt.ita_is_missing =3D 1", perhaps?

Other than these small implementation details, I think I like the
direction these two patches are taking us (I haven't checked 3/3
yet).

Thanks.

