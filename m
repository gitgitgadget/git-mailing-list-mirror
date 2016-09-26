Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56955207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422943AbcIZRKv (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:10:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52510 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964931AbcIZRKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:10:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4F0840C45;
        Mon, 26 Sep 2016 13:10:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3tpYm1EbEtTDtrsRNQQ3KUCwlCs=; b=IeMDjY
        pCYyh8v4gTyvqRdgBIhI2DDMHkI3h1gIuLFUVnVcbXTtOmt3Uoca4SI8/1hnO9lt
        RVSkIDri3N6D9EzrBVMffdBkGcu4SvCXeWp/cUtXatRlSv+wonnT6WKom19NTHWR
        XbphJ/F9PwLE5ihG1+FbUar/H30fdvDWqaqSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sICuGhPWOrZht0QkC66MyiF3UcGfKBMI
        ISfQ/mCt4yuI5Ox8bVVWWoBYr9A7bkgCO9QeiZ3aUryEgQilm+SnQ2PVgPtzaSZD
        Pnm0O+gEeggAJcCgLzEwA187t6zI9I7trRlYxKjX4WFOrDhTU8MfnHwKNfygOoew
        a/RheY12lwY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AEC240C44;
        Mon, 26 Sep 2016 13:10:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21A8B40C43;
        Mon, 26 Sep 2016 13:10:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 06/10] get_short_sha1: NUL-terminate hex prefix
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
        <20160926120007.eswpfrzs2ed66d2o@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 10:10:46 -0700
In-Reply-To: <20160926120007.eswpfrzs2ed66d2o@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 26 Sep 2016 08:00:07 -0400")
Message-ID: <xmqq37kmvb6x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B40E89C-840C-11E6-9419-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We store the hex prefix in a 40-byte buffer with the prefix
> itself followed by 40-minus-len "x" characters. These x's
> serve no purpose, and the lack of NUL termination makes the
> prefix string annoying to use. Let's just terminate it.

> Note that this is in contrast to the binary prefix, which
> _must_ be zero-padded, because we look at the whole thing
> during a binary search to find the first potential match in
> each pack index. 

Makes sense.

> The loose-object hex search cannot use the
> same trick because it has to do a linear walk through the
> unsorted results of readdir() (and even if it could, you'd
> want zeroes instead of x's).

OK.

>  struct disambiguate_state {
>  	int len; /* length of prefix in hex chars */
> -	char hex_pfx[GIT_SHA1_HEXSZ];
> +	char hex_pfx[GIT_SHA1_HEXSZ + 1];
>  	unsigned char bin_pfx[GIT_SHA1_RAWSZ];
>  
>  	disambiguate_hint_fn fn;
> @@ -291,7 +291,6 @@ static int init_object_disambiguation(const char *name, int len,
>  		return -1;
>  
>  	memset(ds, 0, sizeof(*ds));
> -	memset(ds->hex_pfx, 'x', GIT_SHA1_HEXSZ);

As the whole thing is cleared here...

>  
>  	for (i = 0; i < len ;i++) {
>  		unsigned char c = name[i];
> @@ -313,6 +312,7 @@ static int init_object_disambiguation(const char *name, int len,
>  	}
>  
>  	ds->len = len;
> +	ds->hex_pfx[len] = '\0';

... do we even need this one?  It would not hurt, though.

> @@ -351,7 +351,7 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
>  	status = finish_object_disambiguation(&ds, sha1);
>  
>  	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
> -		return error("short SHA1 %.*s is ambiguous.", ds.len, ds.hex_pfx);
> +		return error("short SHA1 %s is ambiguous.", ds.hex_pfx);

Makes sense.

Thanks.
