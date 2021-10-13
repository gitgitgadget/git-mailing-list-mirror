Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4498EC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 17:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F02F6113E
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 17:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhJMRC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:02:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53004 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhJMRC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 13:02:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3AC2107803;
        Wed, 13 Oct 2021 13:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=K1U93prQGP2E
        XJdj3aws9Y2PhnqvedajjON1I39/Fys=; b=R/PjPS1xFRE9pIybkdT4APZPMhD+
        wSijPdF7Brym3lfP2M6c1irP8Ic8qtgedor228RbalJdPntvnfKSfhc/Bdk3d7Du
        nyEqk/GWSiZHOAdlMr5I2GbocO6V5O96Q5J8IWxTHEOjN8aYxTy9Y971Z45doHCK
        kdCX4pKFHoIMfPk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9B97107802;
        Wed, 13 Oct 2021 13:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D3B6107801;
        Wed, 13 Oct 2021 13:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] config: make git_config_include() static
References: <cover.1634077795.git.jonathantanmy@google.com>
        <179df6d6adfe460de7413e1fb1dff6bce185ae0e.1634077795.git.jonathantanmy@google.com>
        <87sfx5ib3h.fsf@evledraar.gmail.com>
Date:   Wed, 13 Oct 2021 10:00:52 -0700
In-Reply-To: <87sfx5ib3h.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 13 Oct 2021 10:26:11 +0200")
Message-ID: <xmqqk0igj1vf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2007F932-2C47-11EC-B651-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Oct 12 2021, Jonathan Tan wrote:
>
>> It is not used from outside the file in which it is declared.
>>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>>  config.c | 12 +++++++++++-
>>  config.h | 37 ++++---------------------------------
>>  2 files changed, 15 insertions(+), 34 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index 2edf835262..365d57833b 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -120,6 +120,16 @@ static long config_buf_ftell(struct config_source=
 *conf)
>>  	return conf->u.buf.pos;
>>  }
>> =20
>> +struct config_include_data {
>> +	int depth;
>> +	config_fn_t fn;
>> +	void *data;
>> +	const struct config_options *opts;
>> +};
>> +#define CONFIG_INCLUDE_INIT { 0 }
>> +
>> +static int git_config_include(const char *var, const char *value, voi=
d *data);
>
> Can't we just move the function here?
>
>>  #define MAX_INCLUDE_DEPTH 10
>>  static const char include_depth_advice[] =3D N_(
>>  "exceeded maximum include depth (%d) while including\n"
>> @@ -306,7 +316,7 @@ static int include_condition_is_true(const struct =
config_options *opts,
>>  	return 0;
>>  }
>> =20
>> -int git_config_include(const char *var, const char *value, void *data=
)
>> +static int git_config_include(const char *var, const char *value, voi=
d *data)
>
> ...and avoid the forward declaration?
>
> I've seen that in a few places, making the diff smaller here doesn't
> seem worth it v.s. maintaining the definition in two places.

Sounds good.  If we are moving things around anyway, it is probably
a good time to do that, too ;-)
