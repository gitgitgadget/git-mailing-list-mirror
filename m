Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5391F461
	for <e@80x24.org>; Mon, 19 Aug 2019 17:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfHSRzR (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 13:55:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55187 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSRzR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 13:55:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A28A116AAB5;
        Mon, 19 Aug 2019 13:55:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SUs+9K5ntJ/kK8agQ/ChZsS4PAk=; b=ssjdOu
        W4lK5d4goAJzBbcW+uylNEF/CfGMjgWdZICNEoMH3VzXkZSD5sAs7EBMyUPrzj45
        BFIhiADBqzYJe2f9ZrViU7b4wjljD3CIhJ+6JjMLrRuS5RyOBWo93Xs6mOleCc2O
        rJXY6+8dEBxSwm1Mkw0HMXORyRL5gCjznB1l4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o+pvzbLzZCr3TXIW/h4R4Tc7mdJ6kjVF
        OvPhDJmEBa4JVd1gO5O9jKcq3jm8ybe4GnV2AJtx3A7q9zJ1eGf5IXds/shXl2ep
        thqyWDJBlhbodsOXo3kKkDErLDiW6BGJgmUhxEnq1fHqzZ+5m2h7e8dbvJS5KbPl
        fx+mc8iA8+U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9987516AAB4;
        Mon, 19 Aug 2019 13:55:15 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0D5C16AAB3;
        Mon, 19 Aug 2019 13:55:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mischa POSLAWSKY <git@shiar.nl>
Cc:     git@vger.kernel.org,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH] ref-filter: initialize empty name or email fields
References: <20190817215107.13733-1-git@shiar.nl>
Date:   Mon, 19 Aug 2019 10:55:13 -0700
In-Reply-To: <20190817215107.13733-1-git@shiar.nl> (Mischa POSLAWSKY's message
        of "Sat, 17 Aug 2019 23:51:07 +0200")
Message-ID: <xmqqimqtxcou.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F5F2350-C2AA-11E9-A13B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mischa POSLAWSKY <git@shiar.nl> writes:

> Formatting $(taggername) on headerless tags such as v0.99 in Git
> causes a SIGABRT with error "munmap_chunk(): invalid pointer",
> because of an oversight in commit f0062d3b74 (ref-filter: free
> item->value and item->value->s, 2018-10-19).
>
> Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
> ---
> If I understand correctly, such tags cannot be produced normally anymore.
> Therefore I'm unsure how to make tests, and if that is even warranted.

Thanks for spotting.

I am not sure if the approach taken by this patch is the right one,
though.  I didn't follow the call/dataflow thoroughly, but if we
replace unfree-able "" with NULL in these places, wouldn't
fill_missing_values() take care of them?

>  ref-filter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index f27cfc8c3e..7338cfc671 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1028,7 +1028,7 @@ static const char *copy_name(const char *buf)
>  		if (!strncmp(cp, " <", 2))
>  			return xmemdupz(buf, cp - buf);
>  	}
> -	return "";
> +	return xstrdup("");
>  }
>  
>  static const char *copy_email(const char *buf)
> @@ -1036,10 +1036,10 @@ static const char *copy_email(const char *buf)
>  	const char *email = strchr(buf, '<');
>  	const char *eoemail;
>  	if (!email)
> -		return "";
> +		return xstrdup("");
>  	eoemail = strchr(email, '>');
>  	if (!eoemail)
> -		return "";
> +		return xstrdup("");
>  	return xmemdupz(email, eoemail + 1 - email);
>  }
