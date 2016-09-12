Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB0C207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbcILTtI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:49:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60752 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753467AbcILTtG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:49:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7E9B3C778;
        Mon, 12 Sep 2016 15:49:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wFWLoAzQlJ70Ji1jN/fMBjKmU2w=; b=bfGlxs
        1u0DBufK065LPfQup4jhaeFcKPFl/XPAKugtpgWoOVQNu88E7Eij0XZufulQCjxx
        QpotAAP9B1em5oB10xbQma/c9fzEbP+33cgh20cGVVfKimFhntvgpEvXFUN7rAuN
        GA7iX76YtWRHhZzeBS4S/e6e4xq7YK7N4sENs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YPksDV0hcnMDAi5vsGnxMKtrtYa7hAqE
        jJ7/kChIEDgfddaOUFb0lAHkA+tZt3nJ95lQHkk903UAQGEtWRUnrft2buBT6Hi3
        ppgEyZkg57EGkkxwgO5UZ6ewwfR72C+PWPxOASIsNMRjaGDihG9ga3j5d69RQ1oK
        POEIzWY2dns=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B10EB3C777;
        Mon, 12 Sep 2016 15:49:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B0693C776;
        Mon, 12 Sep 2016 15:49:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 03/25] sequencer: avoid unnecessary indirection
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <2587881a45d5a81cda4b2eb40e2d7d8d55b7931c.1473590966.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 12:49:03 -0700
In-Reply-To: <2587881a45d5a81cda4b2eb40e2d7d8d55b7931c.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:52:57 +0200
        (CEST)")
Message-ID: <xmqqmvjc291s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F62F3BD0-7921-11E6-B91B-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> -static int read_populate_opts(struct replay_opts **opts)
> +static int read_populate_opts(struct replay_opts *opts)
>  {
>  	if (!file_exists(git_path_opts_file()))
>  		return 0;
> @@ -823,7 +823,7 @@ static int read_populate_opts(struct replay_opts **opts)
>  	 * about this case, though, because we wrote that file ourselves, so we
>  	 * are pretty certain that it is syntactically correct.
>  	 */
> -	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
> +	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
>  		return error(_("Malformed options sheet: %s"),
>  			git_path_opts_file());
>  	return 0;
> @@ -1054,7 +1054,7 @@ static int sequencer_continue(struct replay_opts *opts)
>  
>  	if (!file_exists(git_path_todo_file()))
>  		return continue_single_pick();
> -	if (read_populate_opts(&opts) ||
> +	if (read_populate_opts(opts) ||
>  			read_populate_todo(&todo_list, opts))
>  		return -1;

Good!
