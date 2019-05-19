Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0E11F461
	for <e@80x24.org>; Sun, 19 May 2019 01:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfESB3e (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 21:29:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53777 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfESB3e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 21:29:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B681214181E;
        Sat, 18 May 2019 21:29:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kNh9zxTHsGvs
        qR7pW+/2i+NaiUM=; b=yiaVEN8ANT3ZgKn3QbGaE/c58gCGYvlva6TTrbH2Sd8F
        bPSJWitEVmlwXBstWLIF3SKDwpzemFIH/3amzSb8+2LduM7QNnPkYp+fbJzblxBx
        eUmTOkjiYTRtKpn17GEW8/O3pjXr1MeArlk87wCD/7CYeeCbuzofYeXlq9I8JDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LqL72d
        XpB1MTTneNI/N3d+Pq5LIdmIfAhg9FDUMO1FwLts5OS5kqaTHWkszXxubebMf21W
        Pem/jbOzRGCraOJKi3d2yIc3O2v5EN6BYCs+cws9uLOJqgxXBu8rKIFgBh6nNkJg
        uQm7mXPFvkjPUhrFg7NuZwZC7WHlhhrXt4/IA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC5AA14181D;
        Sat, 18 May 2019 21:29:26 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F75F14181C;
        Sat, 18 May 2019 21:29:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stephen Boyd <swboyd@chromium.org>, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        xypron.glpk@gmx.de, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] send-email: fix regression in sendemail.identity parsing
References: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com>
        <20190517195545.29729-5-avarab@gmail.com>
Date:   Sun, 19 May 2019 10:29:24 +0900
In-Reply-To: <20190517195545.29729-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 17 May 2019 21:55:44 +0200")
Message-ID: <xmqq1s0v2pvv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89FB6774-79D5-11E9-9F87-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a regression in my recent 3494dfd3ee ("send-email: do defaults ->
> config -> getopt in that order", 2019-05-09). I missed that the
> $identity variable needs to be extracted from the command-line before
> we do the config reading, as it determines which config variable we
> should read first. See [1] for the report.
> ...
> Refactor read_config() do what we actually mean here. We don't want to
> set a given sendemail.VAR if a sendemail.$identity.VAR previously set
> it. The old code was conflating this desire with the hardcoded
> defaults for these variables, and as discussed in 3494dfd3ee that was
> never going to work.

I am not sure if the "never going to work" claim is a correct one.
The "no hardcoded default in the variable, read command line, fill
missing ones from the two config files and finally apply the default
for the ones that are still missing" was cumbersome, error-prone
without a table, but did work.

It seems that no matter how we cut it, the cumbersomeness has to
exist, as long as the command line --identity needs to be taken care
of.  Without that complication, I really liked the base series---the
"set var to hardcoded default, overwrite with config and then
overwrite with command line, without having to check if we already
got value in an earlier step" was so much simpler and easy to
explain X-<.

> @@ -371,17 +380,30 @@ sub read_config {
> ...
>  my $help;
>  my $git_completion_helper;
> -my $rc =3D GetOptions("h" =3D> \$help,
> -                    "dump-aliases" =3D> \$dump_aliases);
> ...
> @@ -410,8 +432,6 @@ sub read_config {
> ...
>  		    "smtp-auth=3Ds" =3D> \$smtp_auth,
> -		    "no-smtp-auth" =3D> sub {$smtp_auth =3D 'none'},
> -		    "identity=3Ds" =3D> \$identity,

You seem to be building on top of ab/send-email-transferencoding-fix
and something else, and these two hunks did not apply.  I think I
managed to wiggle the patch in correctly, though.

Thanks.
