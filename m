Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF1741F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 03:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbfJWDjH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 23:39:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51065 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbfJWDjG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 23:39:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA03D80412;
        Tue, 22 Oct 2019 23:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WrKYhEC3HWcP
        PagrZU98rsIhAoc=; b=STyBp0Zne9xGQiRsHtgfGTKoDKdrG8cJWGPARuC94sis
        5by8QVwi3Mf7YUKmuMgiDSEpvWwjJ+5SfPjMfSI9uKCEHV26QTSpE/CiorVIolyG
        VHzvvadRQ1hZzm9VSJj0Gf3zfKilAw4fQeYHaUcr5Or+86xbJAjRVmDWvUu3UVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Gg1W0g
        Fb/v964o2Gmib9Opb1dYUjmUc010vVokedfvzo+4/oNJfYfuHKvst5l3kdnrdI9+
        /AJW5uf0IvmvBdkiJt8txB9rmNc+fc0rnCpGS0XVv8COLMf1mG9Ezfy+32Rtcx66
        Qpp56Fv80s0Mcu67zDsC7otlUNiJgJ/trPzNg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1BEC80411;
        Tue, 22 Oct 2019 23:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C7918040D;
        Tue, 22 Oct 2019 23:39:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] git_path(): handle `.lock` files correctly
References: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
        <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
        <8b1f4f089a6d4a2293507a1a77668c828598e84f.1571694882.git.gitgitgadget@gmail.com>
        <20191022160105.GE4348@szeder.dev>
Date:   Wed, 23 Oct 2019 12:38:59 +0900
In-Reply-To: <20191022160105.GE4348@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Tue, 22 Oct 2019 18:01:05 +0200")
Message-ID: <xmqqmudsi10s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A7A57CA0-F546-11E9-9E54-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +	char *base =3D buf->buf + git_dir_len, *base2 =3D NULL;
>> +
>> +	if (ends_with(base, ".lock"))
>> +		base =3D base2 =3D xstrndup(base, strlen(base) - 5);
>
> Hm, this adds the magic number 5 and calls strlen(base) twice, because
> ends_with() calls strip_suffix(), which calls strlen().  Calling
> strip_suffix() directly would allow us to avoid the magic number and
> the second strlen():
>
>   size_t len;
>   if (strip_suffix(base, ".lock", &len))
>           base =3D base2 =3D xstrndup(base, len);

Makes sense, and is easy to squash in.
