Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DDBB207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 21:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755996AbcILV7s (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 17:59:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51231 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755738AbcILV7r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 17:59:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD01D3E445;
        Mon, 12 Sep 2016 17:59:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XjL8lp5NRYrk5xRtpa+H/BoC7CM=; b=iKRdks
        VIVeA6fW4MEZidHJEIwdrm2LM+xpRS4O5k2swkA7kXwYfi1BP5EU6LhVIPdD2Q1E
        1Ic2aMxGMJqAbjDDQYwh1cBt+vLyxYHdel0MldAuSwvsjm5ITQwvKbESjzvaBYdm
        hA4hkq9nhEEOWa+KVqMNFcMCp0U/1J8FjauFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JfEJA+nhRUXQUP235sGt2raC0Y2BeODa
        6BItcFhswoj1hnv3INikGKIXaKBk+RlE1FkrbXDr6z5xZ1UOcTUs1ow5kl1tA9lM
        lp/X9POqxNvSMMnOnp+qYMiq+1t5c1khaceV7jRlLrv5jP0dfcCXukCwWzqzzZyj
        xg2M9pFKjkE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5CA23E444;
        Mon, 12 Sep 2016 17:59:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AD493E441;
        Mon, 12 Sep 2016 17:59:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v3 2/4] update-index: use the same structure for chmod as add
References: <20160911103028.5492-1-t.gummerer@gmail.com>
        <20160912210818.26282-1-t.gummerer@gmail.com>
        <20160912210818.26282-3-t.gummerer@gmail.com>
Date:   Mon, 12 Sep 2016 14:59:43 -0700
In-Reply-To: <20160912210818.26282-3-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Mon, 12 Sep 2016 22:08:16 +0100")
Message-ID: <xmqq37l4zsmo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 374DBFA8-7934-11E6-9AFA-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +	char flip = force_mode == 0777 ? '+' : '-';
>  
>  	pos = cache_name_pos(path, strlen(path));
>  	if (pos < 0)
> @@ -432,17 +433,11 @@ static void chmod_path(int flip, const char *path)
>  	mode = ce->ce_mode;
>  	if (!S_ISREG(mode))
>  		goto fail;
> -	switch (flip) {
> -	case '+':
> -		ce->ce_mode |= 0111; break;
> -	case '-':
> -		ce->ce_mode &= ~0111; break;
> -	default:
> -		goto fail;
> -	}
> +	ce->ce_mode = create_ce_mode(force_mode);

create_ce_mode() is supposed to take the st_mode taken from a
"struct stat", but here force_mode is 0777 or something else.  The
above to feed only 0777 or 0666 may happen to work with the way how
create_ce_mode() is implemented now, but it is a time-bomb waiting
to go off.

Instead of using force_mode that is unsigned, keep the 'flip' as
argument, and do:

	if (!S_ISREG(mode))
        	goto fail;
+	if (flip == '+')
+		mode |= 0111;
+	else
+		mode &= ~0111;
	ce->ce_mode = create_ce_mode(mode);

perhaps, as you do not need and are not using the full 9 bits in
force_mode anyway.

That would mean chmod_index_entry() introduced in 3/4 and its user
in 4/4 need to be updated to pass '+' or '-' down the callchain, but
I think that is a good change for the same reason.  We do not allow
you to set full 9 bits; let's not pretend as if we do so by passing
just a single bit '+' or '-' around.

I think 3/4 needs to be fixed where it calls create_ce_mode() with
only the 0666/0777 in chmod_index_entry() anyway, regardless of the
above suggested change.

> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
> index dfe02f4..32ac6e0 100755
> --- a/t/t2107-update-index-basic.sh
> +++ b/t/t2107-update-index-basic.sh
> @@ -80,4 +80,17 @@ test_expect_success '.lock files cleaned up' '
>  	)
>  '
>  
> +test_expect_success '--chmod=+x and chmod=-x in the same argument list' '
> +	>A &&
> +	>B &&
> +	git add A B &&
> +	git update-index --chmod=+x A --chmod=-x B &&
> +	cat >expect <<-\EOF &&
> +	100755 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	A
> +	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	B
> +	EOF
> +	git ls-files --stage A B >actual &&
> +	test_cmp expect actual
> +'

Thanks for adding this test.  We may want to cross the b/c bridge in
a later version bump, but until then it is good to make sure we know
what the currently expected behaviour is.
