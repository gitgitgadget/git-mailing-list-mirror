Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73A51F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 09:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbeKMTlQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 14:41:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53884 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731526AbeKMTlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 14:41:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7B3E115099;
        Tue, 13 Nov 2018 04:43:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eF2jkrpTuq6e
        tuRWYjSKOWDT2jY=; b=NEtMBND+Vp7lf802GtLxAcDjtlpcmOnHNN/bigc30bev
        BpU0QArZzih8kxFUeYMiGzRH1sW2P7I86AjwAxVOlu6UsMEn8RFiWV8bcY4MpfPL
        5HP+VDGXKgy2ODcjRTQ6x6f61Furaa/a0jmjsmMyL2abUlAQ9a8o/S8jeueXCR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ao6pRF
        4ORDJIW0X6Fyb6wewqRz9sMbKkSWknqFduQKQBIb14QFDawWI267kPQ4OYZz991D
        1l1bDQm3fV01tm7QSA+K0aqnS7wT69ndHG6xYazNskadBPIysbZHr1JO5bM0KGFN
        TOwypdRO977/2OAQVgIyOiw4hrYCWZbUJoyd0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8180115096;
        Tue, 13 Nov 2018 04:43:57 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E060115095;
        Tue, 13 Nov 2018 04:43:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: Re: [PATCH 2/2] read-cache: use time_t instead of unsigned long
References: <xmqq7ehi1gpb.fsf@gitster-ct.c.googlers.com>
        <20181113074017.17292-1-carenas@gmail.com>
Date:   Tue, 13 Nov 2018 18:43:56 +0900
In-Reply-To: <20181113074017.17292-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 12 Nov 2018 23:40:17 -0800")
Message-ID: <xmqq36s5wbvn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A406469C-E728-11E8-8347-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> There are still some more possible improvements around this code but
> they are orthogonal to this change :
>
> * migrate to approxidate_careful or parse_expiry_date
> * maybe make sure only approxidate are used for expiration
>
> Changes in v2:
> * improved commit message as suggested by Eric
> * failsafe against time_t truncation as suggested by Junio
>
> -- >8 --
> Subject: [PATCH v2 2/2] read-cache: use time specific types instead of
>  unsigned long
>
> b968372279 ("read-cache: unlink old sharedindex files", 2017-03-06)
> introduced get_shared_index_expire_date using unsigned long to track
> the modification times of a shared index.
>
> dddbad728c ("timestamp_t: a new data type for timestamps", 2017-04-26)
> shows why that might be problematic so move to timestamp_t/time_t.
>
> if time_t can't represent a valid time keep the indexes for failsafe

I am not sure if this "failsafe" is a good idea in the first place.
FWIW, I had a total opposite in mind when I suggested it.

The user gave you a timestamp_t value, telling you that anything
before that time is too old to matter and can be discarded.

And date_overflows() helper tells you that that the given expiry
date is more in the future than _any_ possible timestamp expressed
in time_t. =20

So the result of running stat() on the shared index file _will_ have
a timestamp that is older than the specified expiry.

Which means that the user essentially is telling you that any shared
index that is not referenced can immediately be expired, similar to
saying --expire=3Dnow, no?

I kind of sort of would understand if we (1) read the configured
expiry, (2) checked it with date_overflows(), and (3) told the user
that it is an impossible condition, i.e. an error, to use such a
large timestamp far in the future.  Then the user has a chance to
update the configuration to a more reasonable time---even the most
aggressive one does not need to specify anything more in the future
than "now", and that will not "date_overflows()" for 20 years or so.

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  read-cache.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 7b1354d759..7d322f11c8 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2625,9 +2625,9 @@ static int write_split_index(struct index_state *=
istate,
> =20
>  static const char *shared_index_expire =3D "2.weeks.ago";
> =20
> -static unsigned long get_shared_index_expire_date(void)
> +static timestamp_t get_shared_index_expire_date(void)
>  {
> -	static unsigned long shared_index_expire_date;
> +	static timestamp_t shared_index_expire_date;
>  	static int shared_index_expire_date_prepared;
> =20
>  	if (!shared_index_expire_date_prepared) {
> @@ -2643,12 +2643,12 @@ static unsigned long get_shared_index_expire_da=
te(void)
>  static int should_delete_shared_index(const char *shared_index_path)
>  {
>  	struct stat st;
> -	unsigned long expiration;
> +	time_t expiration;
> +	timestamp_t t =3D get_shared_index_expire_date();
> =20
> -	/* Check timestamp */
> -	expiration =3D get_shared_index_expire_date();
> -	if (!expiration)
> +	if (!t || date_overflows(t))
>  		return 0;
> +	expiration =3D t;
>  	if (stat(shared_index_path, &st))
>  		return error_errno(_("could not stat '%s'"), shared_index_path);
>  	if (st.st_mtime > expiration)
