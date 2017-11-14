Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D813201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 04:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbdKNE6V (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 23:58:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61096 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751372AbdKNE6U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 23:58:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBFDDAD7BB;
        Mon, 13 Nov 2017 23:58:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5yYdGIYWZAgZ6ln93hBC7QXf3eA=; b=ZRe3+t
        dapxYy7uCwunKgwM2mU1qAcWTZjGi1fCRHLX6i7gScL+9QjUf4lMufWGaqYaEETs
        Ce3zV0kB0mHdxRrX5beqBE2v5dGMdWWzipNHdSwX5S6Y9m5q7BuFI1jLeoe3NOGZ
        W5KTJmH2wNU5ajjqhUOE/O2U+CRcpapdyrgeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fIAVqtsgqQ1hZH+/bYRF14XvUGn5IwpO
        a60TTgzpijbiZlXjrM0JTHz6nuYxf9yS/i2w5RduVqrJyFxzbFCJnfsBL/RgPIyt
        XCiHdUpyQYO5Pae8VF31Ogj0YUu9uzR2fWkuXjeMnJmeom2fn9P7u0IZ/+ShdENZ
        7Eb6/Nx67j4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1FD8AD7BA;
        Mon, 13 Nov 2017 23:58:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3EDB0AD7B9;
        Mon, 13 Nov 2017 23:58:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 17/30] merge-recursive: Fix leaks of allocated renames and diff_filepairs
References: <20171110190550.27059-1-newren@gmail.com>
        <20171110190550.27059-18-newren@gmail.com>
Date:   Tue, 14 Nov 2017 13:58:18 +0900
In-Reply-To: <20171110190550.27059-18-newren@gmail.com> (Elijah Newren's
        message of "Fri, 10 Nov 2017 11:05:37 -0800")
Message-ID: <xmqq60ad5udx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EB2B3D0-C8F8-11E7-9356-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> get_renames() has always zero'ed out diff_queued_diff.nr while only
> manually free'ing diff_filepairs that did not correspond to renames.
> Further, it allocated struct renames that were tucked away in the
> return string_list.  Make sure all of these are deallocated when we
> are done with them.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 49710c0964..7a3402e50c 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1661,10 +1661,21 @@ static struct rename_info *handle_renames(struct merge_options *o,
>  
>  static void cleanup_renames(struct rename_info *re_info)
>  {
> -	string_list_clear(re_info->head_renames, 0);
> -	string_list_clear(re_info->merge_renames, 0);
> +	const struct rename *re;
> +	int i;
>  
> +	for (i = 0; i < re_info->head_renames->nr; i++) {
> +		re = re_info->head_renames->items[i].util;
> +		diff_free_filepair(re->pair);
> +	}
> +	string_list_clear(re_info->head_renames, 1);
>  	free(re_info->head_renames);
> +
> +	for (i = 0; i < re_info->merge_renames->nr; i++) {
> +		re = re_info->merge_renames->items[i].util;
> +		diff_free_filepair(re->pair);
> +	}
> +	string_list_clear(re_info->merge_renames, 1);

And this obviously will be helped by having another helper "cleanup_rename()"
that does one of them, and call it twice from here.
