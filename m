Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5271B20899
	for <e@80x24.org>; Fri, 18 Aug 2017 02:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbdHRCWR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 22:22:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63953 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753857AbdHRCWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 22:22:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C3E49C341;
        Thu, 17 Aug 2017 22:22:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rs4BqLS20vnpuJJ9+BIgTn2KmrU=; b=XhZz+E
        72HLPX5YyIxC4q4zJDE4GF2jgZPcwEZkS2P3ecsZrsMqA7qHErDzxcbhBUHENFjZ
        luI9g0xdk10bnuM8xSNwlGrDMVGW+nRRBPLjYanvGSsJPCvp6TLpMtfquzgyH0Iq
        qJOGtGLqLAwj0dozQqC76a6V6i2laASErUWs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gXnL1evob4wGEVHbZvLQ7QaOaL+awP/5
        6aZ51QdH9SIHt3jScQneh+vkpFVrItjzsbLLW8bHkYL1h0Sfyk6AcEeR7s8FSOw5
        0LaqsOZitlbcPTh20sB6ZQrswqgIG+z0X3/LCiJlsqdaCpcKu3jOewmsa3qoIKKm
        7Jdgrum5aPA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 343AE9C340;
        Thu, 17 Aug 2017 22:22:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98A8B9C33B;
        Thu, 17 Aug 2017 22:22:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] git-grep: correct exit code with --quiet and -L
References: <20170818013851.16753-1-asottile@umich.edu>
Date:   Thu, 17 Aug 2017 19:22:07 -0700
In-Reply-To: <20170818013851.16753-1-asottile@umich.edu> (Anthony Sottile's
        message of "Thu, 17 Aug 2017 18:38:51 -0700")
Message-ID: <xmqq4lt5ehtc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09031B50-83BC-11E7-8AC0-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Sottile <asottile@umich.edu> writes:

> The handling of `status_only` no longer interferes with the handling of
> `unmatch_name_only`.  `--quiet` no longer affects the exit code when using
> `-L`/`--files-without-match`.
>
> Signed-off-by: Anthony Sottile <asottile@umich.edu>
> ---

Thanks, Will queue.

>  grep.c          | 2 +-
>  t/t7810-grep.sh | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index 2efec0e..c9e7cc7 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1821,7 +1821,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>  		return 0;
>  
>  	if (opt->status_only)
> -		return 0;
> +		return opt->unmatch_name_only;
>  	if (opt->unmatch_name_only) {
>  		/* We did not see any hit, so we want to show this */
>  		show_name(opt, gs->name);
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index f106387..2a6679c 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -374,6 +374,11 @@ test_expect_success 'grep -L -C' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'grep --files-without-match --quiet' '
> +	git grep --files-without-match --quiet nonexistent_string >actual &&
> +	test_cmp /dev/null actual
> +'
> +
>  cat >expected <<EOF
>  file:foo mmap bar_mmap
>  EOF
