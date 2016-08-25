Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0231F859
	for <e@80x24.org>; Thu, 25 Aug 2016 22:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756618AbcHYWxO (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 18:53:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53150 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756158AbcHYWxM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 18:53:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C78E380B6;
        Thu, 25 Aug 2016 18:51:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3ZFZBkz2XqAYtnJh8AMwB0L0890=; b=sE1kAF
        rwihBdv+8NnKQ36xZWTZwhc82iIVB03MFj8n+/Fnm/oufRvxc53OMLja5LWRLHWO
        ffcgozdng/g6pkoexzrfi6QCChDgQjTtxQhWOSg2+Z7k2RmQqBXYBLqjmiJPrn6h
        pZh+9gH0B7GHzYM8eg8FmYJAK273LiP2rSST8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XTQuI8Ybcv68YYohGNZa8izUKgxenNw9
        uBpccd2o/brNOm0HoTEEq3i5imvSflR5ZqcRf9d1oUagLnt85EzebJH8+34V+HAe
        ulOYF+0jUwC+r34Tu13Jk/IQ8PSEkBXsJEObrciWwSd6qGkas5iZONKA0t7HCvRX
        uWEtM0E2W3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02B62380B4;
        Thu, 25 Aug 2016 18:51:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90CCB380B3;
        Thu, 25 Aug 2016 18:51:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/15] sequencer: lib'ify prepare_revs()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <ce6a7cac9f0bd53e44129c8f72818adc4bb4a934.1471968378.git.johannes.schindelin@gmx.de>
Date:   Thu, 25 Aug 2016 15:51:55 -0700
In-Reply-To: <ce6a7cac9f0bd53e44129c8f72818adc4bb4a934.1471968378.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 23 Aug 2016 18:06:50 +0200
        (CEST)")
Message-ID: <xmqqinuojwc4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86C76CB8-6B16-11E6-942C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

I am still looking at sequencer.c in 'master', but I do not think
that the sole caller of this function, walk_revs_populate_todo(),
is prepared to act on an error return from this function and instead
it expects this to die() when in trouble.  And I do not think I saw
the function touched in the steps so far.

So this step smells like a fishy conversion to me.

>  sequencer.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 6ac2187..b90294f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -621,7 +621,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  	return res;
>  }
>  
> -static void prepare_revs(struct replay_opts *opts)
> +static int prepare_revs(struct replay_opts *opts)
>  {
>  	/*
>  	 * picking (but not reverting) ranges (but not individual revisions)
> @@ -631,10 +631,11 @@ static void prepare_revs(struct replay_opts *opts)
>  		opts->revs->reverse ^= 1;
>  
>  	if (prepare_revision_walk(opts->revs))
> -		die(_("revision walk setup failed"));
> +		return error(_("revision walk setup failed"));
>  
>  	if (!opts->revs->commits)
> -		die(_("empty commit set passed"));
> +		return error(_("empty commit set passed"));
> +	return 0;
>  }
>  
>  static void read_and_refresh_cache(struct replay_opts *opts)
