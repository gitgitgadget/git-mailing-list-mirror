Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8CAC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99AD460EE5
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhH1Boy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 21:44:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51807 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhH1Box (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 21:44:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42E7DD069A;
        Fri, 27 Aug 2021 21:44:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Pq4n+i2qO2Eb
        xKqSf9tq4F8Qu2VhzOXyv28ezIZ1G2Y=; b=Yd8jwwXf0bekm0pK6wNk9p1FbR/j
        LGLe2/pgGf6agSPxDWRr4QR7hYsQdVOGY+EfDfOlGNhFewqTp3Pu38gHd39uVY4r
        2zlejXKvo3cjypQukVSbvQOY3HKO+88mhk8MRqcaB/99QHBE8EQfxP/rMkRb7oZ1
        3Z64v7YUrKlW3KM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38F8CD0699;
        Fri, 27 Aug 2021 21:44:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2448D0698;
        Fri, 27 Aug 2021 21:44:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 3/5] bundle API: change "flags" to be
 "extra_index_pack_args"
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
        <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
        <patch-v3-3.5-637039634e7-20210826T140414Z-avarab@gmail.com>
Date:   Fri, 27 Aug 2021 18:44:01 -0700
In-Reply-To: <patch-v3-3.5-637039634e7-20210826T140414Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 26 Aug
 2021 16:05:49
        +0200")
Message-ID: <xmqqy28m8hsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6C2003C0-07A1-11EC-BDFA-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Since the "flags" parameter was added in be042aff24c (Teach progress
> eye-candy to fetch_refs_from_bundle(), 2011-09-18) there's never been
> more than the one flag: BUNDLE_VERBOSE.
>
> Let's have the only caller who cares about that pass "-v" itself
> instead through new "extra_index_pack_args" parameter. The flexibility
> of being able to pass arbitrary arguments to "unbundle" will be used
> in a subsequent commit.

As bundle API has been stable over a long period of time, I do not
think the loss of flexibility is too bad (i.e. we no longer can cary
any extra information that cannot be expressed as a textual argument
given to the index-pack process), compared to gained flexibility of
the index-pack command line we can use.

>  int unbundle(struct repository *r, struct bundle_header *header,
> -	     int bundle_fd, int flags)
> +	     int bundle_fd, struct strvec *extra_index_pack_args)
>  {
> -	const char *argv_index_pack[] =3D {"index-pack",
> -					 "--fix-thin", "--stdin", NULL, NULL};
>  	struct child_process ip =3D CHILD_PROCESS_INIT;
> =20
> -	if (flags & BUNDLE_VERBOSE)
> -		argv_index_pack[3] =3D "-v";
> +	strvec_push(&ip.args, "index-pack");
> +	strvec_push(&ip.args, "--fix-thin");
> +	strvec_push(&ip.args, "--stdin");

I would have expected you'd use pushl() here.

> +	if (extra_index_pack_args) {
> +		strvec_pushvec(&ip.args, extra_index_pack_args);
> +		strvec_clear(extra_index_pack_args);
> +	}
> =20
>  	if (verify_bundle(r, header, 0))
>  		return -1;
> -	ip.argv =3D argv_index_pack;
>  	ip.in =3D bundle_fd;
>  	ip.no_stdout =3D 1;
>  	ip.git_cmd =3D 1;
> diff --git a/bundle.h b/bundle.h
> index 84a6df1b65d..d47a7a3c69c 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -26,16 +26,20 @@ int create_bundle(struct repository *r, const char =
*path,
>  		  int argc, const char **argv, struct strvec *pack_options,
>  		  int version);
>  int verify_bundle(struct repository *r, struct bundle_header *header, =
int verbose);
> -#define BUNDLE_VERBOSE 1
> =20
>  /**
>   * Unbundle after reading the header with read_bundle_header().
>   *
>   * We'll invoke "git index-pack --stdin --fix-thin" for you on the
>   * provided `bundle_fd` from read_bundle_header().
> + *
> + * Provide extra_index_pack_args to pass any extra arguments
> + * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
> + * extra_index_pack_args (if any) will be strvec_clear()'d for you

Good to comment on this.  I found it a bit surprising that the in
argument "extra_index_pack_args" is eaten by the consumer, instead
of leaving it up to the caller when to clear (or reuse before clear)
it.

> + * (like the run-command.h API itself does).

This is not even run-command.h, so the mention of "run-command.h API
itself" sounded strange to me.  Without "itself", perhaps I would
have slightly less puzzled.  IIRC, run_command() only clears upon
success and does not clear if start_command() fails, so it is not a
very good comparison.  I think the comment reads better without this
last parenthesized note.

>   */
>  int unbundle(struct repository *r, struct bundle_header *header,
> -	     int bundle_fd, int flags);
> +	     int bundle_fd, struct strvec *extra_index_pack_args);
>  int list_bundle_refs(struct bundle_header *header,
>  		int argc, const char **argv);
> =20
> diff --git a/transport.c b/transport.c
> index 17e9629710a..99b2498e5dd 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -162,12 +162,16 @@ static int fetch_refs_from_bundle(struct transpor=
t *transport,
>  			       int nr_heads, struct ref **to_fetch)
>  {
>  	struct bundle_transport_data *data =3D transport->data;
> +	struct strvec extra_index_pack_args =3D STRVEC_INIT;
>  	int ret;
> =20
> +	if (transport->progress)
> +		strvec_push(&extra_index_pack_args, "-v");
> +
>  	if (!data->get_refs_from_bundle_called)
>  		get_refs_from_bundle(transport, 0, NULL);
>  	ret =3D unbundle(the_repository, &data->header, data->fd,
> -			   transport->progress ? BUNDLE_VERBOSE : 0);
> +		       transport->progress ? &extra_index_pack_args : NULL);

Why conditional?

If transport->progress is false, extra_index_pack_args is a strvec
that has 0 elements in it, and the strvec_pushvec() code knows how
to handle it correctly and efficiently anyway. =20

I do not see a reason why we want to make the caller harder to read
with the same conditional twice (i.e. if we pass NULL in non-verbose
case, we can unconditionally put "-v" in the array, and clear the
array on the side of this caller, and that would allow us lose the
clear from the unbundle() function).

Other than that, looks very simple.  Nicely done.

Thanks.
