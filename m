Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C45501F453
	for <e@80x24.org>; Wed, 24 Apr 2019 01:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfDXB4n (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 21:56:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64799 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfDXB4n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 21:56:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12A04610E0;
        Tue, 23 Apr 2019 21:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RlFtb1lPeadZNawytBCtK3mjdxo=; b=tFZm6c
        daiW7KsQFlYyRwarV6qIk+HowOWGKtIaT3ruVwD3A8N2wb1zIATeO5xyKNYK2Wze
        HinUb2nzd6QKsMJ7UvMJYVgt34F1NqiS56HyNdIJwsNNlKXsZ47TA+/+ntItLCCC
        LT3Z3Rx1r/kWRYTxPKehOoGNCuwhzk870Vt6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rdpb2WjsPrNK23WitS+AnVkFjI37UqOf
        hdwEfIptMswx+URBEt+OBsmctBxyO3sMykKR5ITLKIshCaSHgo1gFPcH/k4sD7IQ
        4FjY61lLouVEWNwFdbIZnluLr1GzzsZOR2LUNgOmoc393A48zLHLC83FWs3fBlLV
        oFeK46aLftM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A4F6610DD;
        Tue, 23 Apr 2019 21:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3AADD610DB;
        Tue, 23 Apr 2019 21:56:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Honor core.precomposeUnicode in more places
References: <20190423173056.28523-1-newren@gmail.com>
        <20190423182924.r6mkwrl2o7pcwjoa@tb-raspi4>
        <CABPp-BGbDN2DVwJKh3gdQ1wDZmGuevAYRhhfe_MCyunABDsEqg@mail.gmail.com>
Date:   Wed, 24 Apr 2019 10:56:33 +0900
In-Reply-To: <CABPp-BGbDN2DVwJKh3gdQ1wDZmGuevAYRhhfe_MCyunABDsEqg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 23 Apr 2019 12:06:45 -0700")
Message-ID: <xmqq5zr4414e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30AE396C-6634-11E9-B278-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ..., and passing a config-related callback function to
> parse_options seems a little weird to me.

A little?  That's a moderate understatement.

If parse_options API were the ONLY thing that gets affected by
precompose_unicode, having an "if the config has not been read yet,
read only that configuration variable and nothing else" there might
make sense, but that is not the case (i.e. the variable also affects
how readdir() works).  So the alternatives that make sense are 

 (1) we stick to the current "make sure we read that variable
     sufficiently early in the main flow of the program" pattern,
     which this patch does, or

 (2) we switch to "make sure the variable is read before we need it"
     pattern, i.e. add that "read the single config variable from
     the file, if it is not yet read" call to both parse_options()
     and opendir()---if the set of operations affected by the
     precompose_unicode variable grows, we'd need to add the same
     call to the new places, too.

I think (1) is good at least for now.

>> > diff --git a/upload-pack.c b/upload-pack.c
>> > index d098ef5982..159f751ea4 100644
>> > --- a/upload-pack.c
>> > +++ b/upload-pack.c
>> > @@ -1064,6 +1064,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>> >               allow_ref_in_want = git_config_bool(var, value);
>> >       } else if (!strcmp("uploadpack.allowsidebandall", var)) {
>> >               allow_sideband_all = git_config_bool(var, value);
>> > +     } else if (!strcmp("core.precomposeunicode", var)) {
>> > +             precomposed_unicode = git_config_bool(var, value);
>> >       }

What the other hunks wanted to do was quite obvious (i.e. before
calling parse_options(), make sure we know precomposed_unicode is
set appropriately, so that argv[] can be tweaked correctly).  But
this one was a bit less clear.

It turns out that upload-pack deliberately avoids using the default
config callback, but tries to limit itself to the minimally needed
set, so this hunk adds the precomposed_unicode to it.  By doing so,
we trigger another effect of precomposed_unicode, i.e. tweaking the
paths we read out of readdir(), so that the refs we have to offer to
the other side are all normalzied to the precomposed form.

Makes sense.  Thanks.

