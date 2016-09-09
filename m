Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254A91F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 18:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbcIIS0k (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 14:26:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63814 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752193AbcIIS0j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 14:26:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95F3F3C19B;
        Fri,  9 Sep 2016 14:26:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Eb2j9fo94nbro8C8Yc0sWG944GM=; b=A+5KE7
        yM3XjA5uumzNk95xq4g1QXMNL+36v13OuIzohsIEACFp2TemWbu7xaOSWQfe4XKf
        D5OYfDV2L9w2+ggCaqbdXq5fyTViWFWSla9sq0ITYt41NNkbnLpfjblAVoX5peAD
        klqMFQJEpavY75wWKBLfD1XgQrhyrzLRnszV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r7IZdo3I9bAjhZA2WuSofgQ3A5KyOWNp
        ivWd8T8lCUpM7IIajIzpFuyxAY9nySPnh6kP55dm2niOLdz6DoASgSmYPd0TACWT
        BU1QUjPOuD8iOGxdH+uKJWy1mzJKnYiVzHfRaEYqmif4O3HKigXp0AmoghpZi8yh
        4Z/QbUDEfpU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EA713C19A;
        Fri,  9 Sep 2016 14:26:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 167313C198;
        Fri,  9 Sep 2016 14:26:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 17/17] sequencer: ensure to release the lock when we could not read the index
References: <cover.1472219214.git.johannes.schindelin@gmx.de>
        <cover.1473431645.git.johannes.schindelin@gmx.de>
        <4c7876d88eac80d9cf05847477d4d468a7c01acc.1473431645.git.johannes.schindelin@gmx.de>
Date:   Fri, 09 Sep 2016 11:26:36 -0700
In-Reply-To: <4c7876d88eac80d9cf05847477d4d468a7c01acc.1473431645.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 9 Sep 2016 16:38:20 +0200
        (CEST)")
Message-ID: <xmqqvay5aq03.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F236C584-76BA-11E6-BEE1-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> A future caller of read_and_refresh_cache() may want to do more than just
> print some helpful advice in case of failure.

I recall commenting on unreleased locks on other parts of the series
but didn't see this.  Looks good.  Thanks for being thorough.

> diff --git a/sequencer.c b/sequencer.c
> index d92a632..eec8a60 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -644,14 +644,18 @@ static int read_and_refresh_cache(struct replay_opts *opts)
>  {
>  	static struct lock_file index_lock;
>  	int index_fd = hold_locked_index(&index_lock, 0);
> -	if (read_index_preload(&the_index, NULL) < 0)
> +	if (read_index_preload(&the_index, NULL) < 0) {
> +		rollback_lock_file(&index_lock);
>  		return error(_("git %s: failed to read the index"),
>  			action_name(opts));
> +	}
>  	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
>  	if (the_index.cache_changed && index_fd >= 0) {
> -		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> +		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK)) {
> +			rollback_lock_file(&index_lock);
>  			return error(_("git %s: failed to refresh the index"),
>  				action_name(opts));
> +		}
>  	}
>  	rollback_lock_file(&index_lock);
>  	return 0;
