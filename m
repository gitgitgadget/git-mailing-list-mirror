Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690B620899
	for <e@80x24.org>; Wed,  2 Aug 2017 20:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbdHBU6s (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 16:58:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752173AbdHBU6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 16:58:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A8BA9FA01;
        Wed,  2 Aug 2017 16:58:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iHnIcaDA2wgV
        qpYG1zG4voT5PSg=; b=C39PpDPgvpkSOQOgPuaFI6bZH5HcKgchJAKYHvvFE3i0
        Jtrw4AqM1HuIYrE2L62Br0W67qWJhEfngvkz5CD2fYenwzBPxRrX4d/STE2DIFMm
        cv3rX7s5Xth9NIAG1rIlRD3jADFz2N8KoPxxO5jFSSKWLunn6rogsY09RU6vT8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LTHSh7
        azKaVlAg1h7nBDaFFKZm1MvbVpKEcQPG72trr4uifA4sNMbvv+un0KoBySAy0odj
        NSxQeIWxet/CX9jOGUTntul3Km7hEygyX+rvOTHHv6hmXS/QPWkWif9zLZ6PZuUA
        CAs4FmRokep8jk+4nVUBgFDXRiFYe0FTLyeTs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81F439FA00;
        Wed,  2 Aug 2017 16:58:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4C599F9FE;
        Wed,  2 Aug 2017 16:58:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: core.autocrlf=true causes `git apply` to fail on patch generated with `git diff-index HEAD --patch`
References: <CA+dzEBmsgUjmf5fUmeiwS=Q81OgpL6K5p=8dBuTjuZ4XE1V5SA@mail.gmail.com>
        <287407ac-b0d0-ef24-4950-0982a2db9bed@web.de>
        <CA+dzEB=3OMw_YM4K_a8dyDG_FwGavU382stXrEOkbYoyM4DSZQ@mail.gmail.com>
        <cceaf377-73e0-e733-20ba-c4e547226382@web.de>
Date:   Wed, 02 Aug 2017 13:58:37 -0700
In-Reply-To: <cceaf377-73e0-e733-20ba-c4e547226382@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 2 Aug 2017 17:44:50
 +0200")
Message-ID: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5BBDB92A-77C5-11E7-A53A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>   My very first investigation shows that a patch like this could fix
> the problem:
>
> diff --git a/apply.c b/apply.c
> index f2d599141d..66b8387360 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2278,6 +2278,8 @@ static int read_old_data(struct stat *st, const
> char *path, struct strbuf *buf)
>         case S_IFREG:
>                 if (strbuf_read_file(buf, path, st->st_size) !=3D
> st->st_size)
>                         return error(_("unable to open or read %s"), pa=
th);
> +               if (would_convert_to_git(&the_index, path))
> +                       read_cache();
>                 convert_to_git(&the_index, path, buf->buf, buf->len,
> buf, 0);

Sorry, but it is unclear why this is a "fix" to me.  We may not even
be doing "git apply --index" or "git apply --cached" that care about
the state recorded in the index, but just the plain vanilla "git apply",
which could even be outside any repository.
