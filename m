Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD33EC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7C561A3A
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhKSRfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:35:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52245 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbhKSRff (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 12:35:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 613631588CB;
        Fri, 19 Nov 2021 12:32:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NoLRR/4PeIGz
        UG7NlL1D/s3Exnu7BFVgCLAjQsSKAos=; b=Fuwz7kuBq0PrAjRBaHCoMDwJyw3E
        HQhV7uWRkPuUsBCsYEal3Q0TTBJowRdR609xJUEAdQSrTD/mPcvor0V3OcoHhCYa
        P3GiWswiWr0rQtKW42Bs/5686lDnalhQHEYhpM931PdOPxvf03LXiwoqqca/2aZL
        6hunNYfO6/BzLrw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59D841588CA;
        Fri, 19 Nov 2021 12:32:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BBEB01588C7;
        Fri, 19 Nov 2021 12:32:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        peff@peff.net, congdanhqx@gmail.com
Subject: Re: [PATCH v2 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
References: <cover.1637321601.git.dyroneteng@gmail.com>
        <8b68568d6cbe379d40c61c48bf446eaa88221df5.1637321601.git.dyroneteng@gmail.com>
        <211119.86wnl42ri2.gmgdl@evledraar.gmail.com>
Date:   Fri, 19 Nov 2021 09:32:29 -0800
In-Reply-To: <211119.86wnl42ri2.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 19 Nov 2021 14:30:52 +0100")
Message-ID: <xmqqy25koxua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC48AF7A-495E-11EC-A921-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

I think that many points you raised in your message are valid, but
there is one thing that is not.

>> +enum {
>> +	MODE_UNSPECIFIED =3D 0,
>> +	MODE_NAME_ONLY,
>> +	MODE_OID_ONLY
>> +};
>> +
>> +static int cmdmode =3D MODE_UNSPECIFIED;
>
> Better:
>
> static enum {
> 	MODE_NAME_ONLY =3D 1,
>         ...
> } cmdmode =3D MODE_NAME_ONLY;
>
> I.e. no need for the MODE_UNSPECIFIED just to skip past "0".

If the original wanted to make the default to be "unspecified", your
suggestion changes the semantics.

"enum" is not necessarily an "int", and because the pointer of
"cmdmode" is given to OPT_CMDMODE(), which expects a pointer to
"int", your suggestion breaks the code there, too.

I wonder if cmdmode cannot be a on-stack variable in cmd_ls_tree()
that is passed as the context pointer to show_tree() via
read_tree(), though.  The enum definition still need to be visible
throughout the file, but such a structure would let us lose a
"global" variable.

Thanks.

