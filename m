Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6F120193
	for <e@80x24.org>; Thu, 11 Aug 2016 20:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbcHKURi (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 16:17:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932129AbcHKURh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 16:17:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 74AD233DC7;
	Thu, 11 Aug 2016 16:17:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=pX24q+usamkrqWoHC4Zd8o8qCx8=; b=hI8H0y2LNbVXD454qCo8
	MdOfZYovvH1owvn/FVXj2KRTZ5CXfDmfQKeCuJrC1y3sHsXwyfeGnyxj7jr05yok
	wd1ozqOVZD1tp4bg7ur+va+yZQJ4mLVWbpyzV+QfaMabvbfA1mCpjc5q0EI5r0/l
	8ko6DOvQO3hZoggVgUaeVCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Zj/TNj9BcRxXnXJ/VC78VE42Or2tu//fl89S5wweisALwg
	lUMeNJgAVmoi1eMLnaMM6FxgFatAe9oy3qiJY0ibSu9ibkrU57TSJkR6CItLiIYk
	Pjf7ZbXePVX7gWRqOSR5mlg77SKO7UeuWNLS6VTOHEqLglWx/xSqHtVa3F3yk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C82833DC6;
	Thu, 11 Aug 2016 16:17:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D689D33DC5;
	Thu, 11 Aug 2016 16:17:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v12 12/13] apply: learn to use a different index file
References: <20160811184501.384-1-chriscool@tuxfamily.org>
	<20160811184501.384-13-chriscool@tuxfamily.org>
Date:	Thu, 11 Aug 2016 13:17:33 -0700
Message-ID: <xmqqvaz7ys9u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A49F562C-6000-11E6-A8E6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Sometimes we want to apply in a different index file.
>
> Before the apply functionality was libified it was possible to
> use the GIT_INDEX_FILE environment variable, for this purpose.
>
> But now, as the apply functionality has been libified, it should
> be possible to do that in a libified way.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  apply.c | 10 ++++++++--
>  apply.h |  1 +
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 2ec2a8a..7e561a4 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4674,8 +4674,14 @@ static int apply_patch(struct apply_state *state,
>  		state->apply = 0;
>  
>  	state->update_index = state->check_index && state->apply;
> -	if (state->update_index && state->newfd < 0)
> -		state->newfd = hold_locked_index(state->lock_file, 1);
> +	if (state->update_index && state->newfd < 0) {
> +		if (state->index_file)
> +			state->newfd = hold_lock_file_for_update(state->lock_file,
> +								 state->index_file,
> +								 LOCK_DIE_ON_ERROR);
> +		else
> +			state->newfd = hold_locked_index(state->lock_file, 1);
> +	}
>  
>  	if (state->check_index && read_cache() < 0) {
>  		error(_("unable to read index file"));

Here is a call to read_cache() that reads the default index file on
the filesystem into the default in-core index "the_index".

Shouldn't it be reading from state->index_file instead?

If we limit the review only to the context of your series, I think

    fall_back_threeway()
     -> build_fake_ancestor() -- uses index_path to use custom index
     -> discard_cache()
     -> read_cache_from(index_path) -- reads back the fake ancestor
     -> write_index_as_tree() -- writes the fake_ancestor
     -> run_apply(index_path)
        -> apply_all_patches()
           -> apply_patch()

is the only codepath that uses a custom index file, so when the
control reaches this function with a custom index file, the in-core
index is already populated, making read_cache() a no-op, and that is
the only thing that makes the resulting code avoid triggering this
bug, but as part of a general "libified" codepath, I think it should
be made to read from state->index_file using read_cache_from().

I only noticed this call to read_cache(), but there may be others
lurking nearby.
