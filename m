Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 113C8208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 23:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754252AbdHUXC4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 19:02:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50103 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753600AbdHUXC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 19:02:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A58EC933BA;
        Mon, 21 Aug 2017 19:02:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XzE3qF83onaTk9Pqz2THIYAfnpI=; b=g32+cf
        /Dwd6zvP2X1l3qQ3t4Dx0M5Dkwv19hjZyA5cG5MPLFNQ88TxMBEe6h3vp2cWsTbo
        N2imLBbwbdoqA9wKrNJ4wQn4TCPej7LdVeBzyedVUuMOYouFItYH7sUJy+bYaGh+
        97WARw7NUcP4eeEUpjfjC1EAgr/sz+DgPvUoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kyrVOoUiQsmwB/AU5cSHncIGCF+Qpd6z
        +uFsC8HYy+8m1fwUf8/OL2OiOcgqR57URz72c9Bz35/qLlnOdg8cYehwr61sm1Go
        zEr+SVL1vsW1In4R8kHD0T877C4CVEb2HKdoqFaTfNuN3PeYx56g+p8lfl+9IO4n
        P+eV1I9vPFI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E253933B9;
        Mon, 21 Aug 2017 19:02:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BA10933B8;
        Mon, 21 Aug 2017 19:02:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net, peartben@gmail.com
Subject: Re: [PATCH 2/3] read-cache: fix memory leak in do_write_index
References: <20170821212432.47364-1-kewillf@microsoft.com>
        <20170821212432.47364-3-kewillf@microsoft.com>
Date:   Mon, 21 Aug 2017 16:02:53 -0700
In-Reply-To: <20170821212432.47364-3-kewillf@microsoft.com> (Kevin Willford's
        message of "Mon, 21 Aug 2017 15:24:31 -0600")
Message-ID: <xmqq1so45xsy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDC6FC2A-86C4-11E7-8FAF-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kewillf@microsoft.com> writes:

> The previous_name_buf was never getting released when there
> was an error in ce_write_entry or allow was false and execution
> was returned to the caller.
>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---

Thanks for spotting an old error that dates back to at least 2013
this month.  The patch looks sensible.



>  read-cache.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index acfb028f48..47220cc30d 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2192,7 +2192,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  	int newfd = tempfile->fd;
>  	git_SHA_CTX c;
>  	struct cache_header hdr;
> -	int i, err, removed, extended, hdr_version;
> +	int i, err = 0, removed, extended, hdr_version;
>  	struct cache_entry **cache = istate->cache;
>  	int entries = istate->cache_nr;
>  	struct stat st;
> @@ -2247,15 +2247,21 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  			if (allow)
>  				warning(msg, ce->name);
>  			else
> -				return error(msg, ce->name);
> +				err = error(msg, ce->name);
>  
>  			drop_cache_tree = 1;
>  		}
>  		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
> -			return -1;
> +			err = -1;
> +
> +		if (err)
> +			break;
>  	}
>  	strbuf_release(&previous_name_buf);
>  
> +	if (err)
> +		return err;
> +
>  	/* Write extension data here */
>  	if (!strip_extensions && istate->split_index) {
>  		struct strbuf sb = STRBUF_INIT;
