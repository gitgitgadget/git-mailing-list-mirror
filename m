Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE7120756
	for <e@80x24.org>; Sun,  8 Jan 2017 03:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934195AbdAHD0f (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 22:26:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64098 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932382AbdAHD0e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 22:26:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB3895DFD3;
        Sat,  7 Jan 2017 22:26:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yNWPqlUuBBe+/cqgQL62fSOh1EY=; b=hF9kFA
        zQnR5l4PQTtmran53KR5rLVzWu14Wk0QKRoGbNl7n0rYf1MGKveKnetE45vC+0z+
        tJ+aL/6jwtDVmJztyLVNlSZeNrLWwOkP056QI4BpUkGkllfGPTPoRo5YwtPKTiis
        sB2/NKj1ughjRBD5E28X2fAnyefroZOMtJIjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hrlwhUWYbaqd7K71LQf65X05pTT9Crla
        Y7KkYx50us64DVheAYi6ACw7hNen9xD22En8ac/Utj2gNAMCR+nfIYrqMd4VtDem
        UZpYh7zhZ91oe/q+Baq0ilrLtK4NOC850vWNleu3r6PjpqyoHoOrGRBSJAi4ne8I
        QBmQ0D0I3HA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B10715DFD2;
        Sat,  7 Jan 2017 22:26:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 228FC5DFD1;
        Sat,  7 Jan 2017 22:26:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Tolsch <btolsch@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org
Subject: Re: [PATCH] rebase--interactive: count squash commits above 10 correctly
References: <CAMWRQeRaQQQcJ-R8eHc7f0KqZF2eEkYJOyTb9n7ds78pTqV-AA@mail.gmail.com>
        <20170107082318.jj3izthx2ylscrns@sigill.intra.peff.net>
Date:   Sat, 07 Jan 2017 19:26:30 -0800
In-Reply-To: <20170107082318.jj3izthx2ylscrns@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 7 Jan 2017 03:23:19 -0500")
Message-ID: <xmqqlgum1bbt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4024AEC8-D552-11E6-BC04-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index b0a6f2b7ba..4734094a3f 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -425,7 +425,7 @@ update_squash_messages () {
>  	if test -f "$squash_msg"; then
>  		mv "$squash_msg" "$squash_msg".bak || exit
>  		count=$(($(sed -n \
> -			-e "1s/^$comment_char.*\([0-9][0-9]*\).*/\1/p" \
> +			-e "1s/^$comment_char[^0-9]*\([0-9][0-9]*\).*/\1/p" \

I would have written it to match ".*[^1-9]\([1-9][0-9]*\)", though.
Even if a foreign language expresses all its words as digits (or has
a digit as the last letter of the last word before the number), a
translation into it must have a non-digit before the number to
disambiguate---but I guess I am being ultra-pedantic, and I think
what you wrote would be sufficient in practice.

As you guys discussed, this code will hopefully disappear in a cycle
or two anyway ;-)  Let's queue this as-is.

Thanks.

>  			-e "q" < "$squash_msg".bak)+1))
>  		{
>  			printf '%s\n' "$comment_char $(eval_ngettext \
