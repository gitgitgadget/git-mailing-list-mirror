Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F92D1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 20:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbcKUU3s (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 15:29:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61950 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753566AbcKUU3r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 15:29:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DB224FF0D;
        Mon, 21 Nov 2016 15:29:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vWtP0xLkedE5/j4qYmPtlyzhF2c=; b=gq/7v4
        8P1VHBES7bPvpLlweLWsm5rSLjMoOIjN1SFeYh5WNnasejdyG8H7brxPIEC/CEiw
        x0Ot3aD5C7j6S4QqbLMxguFUB6SRlPUrDP2AbTa9Hh05BNCoLgvQZKhwOokSrTTi
        OHpmnLB+/QFJIVK85xNLad/wRRE1IDwCXsOmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Agn3ZWbAaQSB5XklkT4E80kmkMdG0wH6
        HzAovMH1SVE9iY9WmAgyHqA3m+o+P/7k1KJJPeZw7nIDYMI7f6/U2oZUdFpkr4w6
        fOyPzXoptLUc0Szd/0j1ya+u87MoObHdaYdwF+CoN2VuBD8pYxJI7hXbWSplnWlU
        xXCY+HdV7sA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1383E4FF0C;
        Mon, 21 Nov 2016 15:29:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DB764FF08;
        Mon, 21 Nov 2016 15:29:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] rebase -i: handle core.commentChar=auto
References: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com>
        <20161121190514.18574-1-gitster@pobox.com>
        <20161121190514.18574-3-gitster@pobox.com>
Date:   Mon, 21 Nov 2016 12:29:44 -0800
In-Reply-To: <20161121190514.18574-3-gitster@pobox.com> (Junio C. Hamano's
        message of "Mon, 21 Nov 2016 11:05:14 -0800")
Message-ID: <xmqqh970ink7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DA86AE8-B029-11E6-B071-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> @@ -93,8 +93,17 @@ eval '
>  GIT_CHERRY_PICK_HELP="$resolvemsg"
>  export GIT_CHERRY_PICK_HELP
>  
> -comment_char=$(git config --get core.commentchar 2>/dev/null | cut -c1)
> -: ${comment_char:=#}
> +comment_char=$(git config --get core.commentchar 2>/dev/null)
> +case "$comment_char" in
> +'' | auto)
> +	comment_char="#"
> +	;;
> +?)
> +	;;
> +*)
> +	comment_char=$(echo "$comment_char" | cut -c1)
> +	;;
> +esac

Amended in is a fix for a typo the other Johannes noticed.

Thanks.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index d941f0a69f..5d0a7dca9d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -983,7 +983,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> -test_expect_failure 'rebase -i respects core.commentchar=auto' '
> +test_expect_success 'rebase -i respects core.commentchar=auto' '
>  	test_config core.commentchar auto &&
>  	write_script copy-edit-script.sh <<-\EOF &&
>  	cp "$1" edit-script
