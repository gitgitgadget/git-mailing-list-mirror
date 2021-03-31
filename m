Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF97C433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89548619D9
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhCaAMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 20:12:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57881 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCaALx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 20:11:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ABC3B0EA4;
        Tue, 30 Mar 2021 20:11:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YUn+HjjLjNgr
        vuqavzKBfFRQV54=; b=Sxd/K5sWQ4iylOZ6v4evq6lBLg4DGp2UaPu11JdCHkxK
        8Dn8fA+nrYYga6ms6X1oSfm0+AUfOTKvshIUJ2HKeso7ggdSNfx3TL8AFWLEwrz8
        fFbMmGS6/eK57eY29h0ksojAzEpn1G5f+2VTSjrTO+xmVFRS8zdfO6O9B+BYxiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ukCrqU
        qqhSFLxKR6dlXEHgQbMNQ6MVUp64U3sKcB3vOaCprcjs69FJsAeEmGJEF+rmnjT6
        ZLVt7f0ERqNEGDooc7IFgYOczlgd9s7cBOo0IfkwScmtghuIo94rzOgx0iu+Fklr
        9CPUsv+js8E0vDIRogIjZh8UNU1qN3D1mYhu8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11C43B0EA3;
        Tue, 30 Mar 2021 20:11:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FA28B0EA2;
        Tue, 30 Mar 2021 20:11:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 21/22] pickaxe -G: terminate early on matching lines
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-22-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 17:11:51 -0700
In-Reply-To: <20210216115801.4773-22-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:58:00 +0100")
Message-ID: <xmqq5z189o6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B1FAE8EA-91B5-11EB-BF06-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Solve a long-standing item for "git log -Grx" of us e.g. finding "+
> str" in the diff context and noting that we had a "hit", but xdiff
> diligently continuing to generate and spew the rest of the diff at us.
>

Nice.  "git log -Gpattern" without "-p" has no reason to do the full
diff once it finds out that pattern would have existed if "-p" were
given in the output.

It actually is a bit of shame that "git log -Gpattern -p" still
needs to run two diffs (instead of taking advantage of the diff that
it needs to generate anyway (to show to the user of the "log") and
pattern match in it).

>  	if (data->hit)
> +		BUG("Already matched in diffgrep_consume! Broken xdiff_emit_line_fn?=
");

Hmph, an obvious alternative would be to silently return -1 here,
which probably would not hurt, either.  I do not mind the check to
be stricter, though.

> +	if (!regexec_buf(data->regexp, line + 1, len - 1, 1,
> +			 &regmatch, 0)) {
> +		data->hit =3D 1;
> +		return -1;
> +	}
>  	return 0;
>  }
