Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6D71FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 19:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbcLHThC (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 14:37:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55289 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752445AbcLHThA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 14:37:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B8FD56C65;
        Thu,  8 Dec 2016 14:36:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EDctex/i3/EQ
        CCxuksSjAzbe8n8=; b=HDt6hEbjPnMcZElIqnhR3mvk6ZK8fUq36/RozHpbGFu3
        nSa2fKeRJs3b+G31n9+pR7PMOeY5ul4K/dAsGTcXF3kphFLhyS4YbLlscnSEzo55
        xI4/TYVPZlw5j/siPBSWE2j1gPV5WfAgv4W0iCgZCjp8UDxT/UdZeG95WJ5VoXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WYht8g
        DTjR6pZu+yGrZ1ZZv3U0cRqthyFg2v2RbYWqkp60BlscX/J9u8DYxRmqBJRBuKB3
        cJBC1zLGtCVxFnGiZf5cRhsia/EeA0NEdu9JzUPsbbTgqbOsXfAKENmVhiJO7cvE
        tQgmbFdSQboqdukI1uQKPXnc2EKjDQ9FImCuk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7399056C64;
        Thu,  8 Dec 2016 14:36:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6CB956C63;
        Thu,  8 Dec 2016 14:36:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Leho Kraav <leho@conversionready.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 7/7] versioncmp: generalize version sort suffix reordering
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
        <20161208142401.1329-1-szeder.dev@gmail.com>
        <20161208142401.1329-8-szeder.dev@gmail.com>
Date:   Thu, 08 Dec 2016 11:36:57 -0800
In-Reply-To: <20161208142401.1329-8-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 8 Dec 2016 15:24:01 +0100")
Message-ID: <xmqq60mutdpi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AF2E0BA8-BD7D-11E6-ACF2-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The 'versionsort.prereleaseSuffix' configuration variable, as its name
> suggests, is supposed to only deal with tagnames with prerelease
> suffixes, and allows sorting those prerelease tags in a user-defined
> order before the suffixless main release tag, instead of sorting them
> simply lexicographically.
>
> However, the previous changes in this series resulted in an
> interesting and useful property of version sort:
>
>   - The empty string as a configured suffix matches all tagnames,
>     including tagnames without any suffix, but
>
>   - tagnames containing a "real" configured suffix are still ordered
>     according to that real suffix, because any longer suffix takes
>     precedence over the empty string.
>
> Exploiting this property we can easily generalize suffix reordering
> and specify the order of tags with given suffixes not only before but
> even after a main release tag by using the empty suffix to denote the
> position of the main release tag, without any algorithm changes:
>
>   $ git -c versionsort.prereleaseSuffix=3D-alpha \
>         -c versionsort.prereleaseSuffix=3D-beta \
>         -c versionsort.prereleaseSuffix=3D"" \
>         -c versionsort.prereleaseSuffix=3D-gamma \
>         -c versionsort.prereleaseSuffix=3D-delta \
>         tag -l --sort=3Dversion:refname 'v3.0*'
>   v3.0-alpha1
>   v3.0-beta1
>   v3.0
>   v3.0-gamma1
>   v3.0-delta1
>
> Since 'versionsort.prereleaseSuffix' is not a fitting name for a
> configuration variable to control this more general suffix reordering,
> introduce the new variable 'versionsort.suffix'.  Still keep the old
> configuration variable name as a deprecated alias, though, to avoid
> suddenly breaking setups already using it.  Ignore the old variable if
> both old and new configuration variables are set, but emit a warning
> so users will be aware of it and can fix their configuration.  Extend
> the documentation to describe and add a test to check this more
> general behavior.
>
> Note: since the empty suffix matches all tagnames, tagnames with
> suffixes not included in the configuration are listed together with
> the suffixless main release tag, ordered lexicographically right after
> that, i.e. before tags with suffixes listed in the configuration
> following the empty suffix.

Thanks.  Will comment on the individual patches later, but the end
result looks very nice.
