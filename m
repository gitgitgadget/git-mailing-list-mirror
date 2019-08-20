Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A54701F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfHTSCF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:02:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57294 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTSCF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:02:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7528786B4D;
        Tue, 20 Aug 2019 14:02:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qkk7/YIgkQndq13PQ1o5QOeLo0s=; b=W64DCX
        8+xpPjhNFqTdvrN2LMHQCQZyF6aPBS/6U37zGP44wnRvkPpDodetw1MR8A8vfCWu
        o6o5vistF1LzpTQhLCTk54LBVXZdMIaA+/+GOyuNZFEAGAQ2AAqMr5JseSn1iQ/Q
        Jvuz9A5fwZLUUYWTzU3zbxTjkXlhMWf3UNnZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OAp+E0uzmd7YIMe7vQhdtefEPdf20C9J
        VR2W2VOB9v6uslhlBlHHYg9tBnRw/MGUAp6C4xINwq8QWpBMw9xcXWCwtiihohBg
        ZdT7hsfeEpwU6ujYml+TNaiWwSSyDq3Ny15d3ierqZ3oKYg1pdptZjgY/+2xZmAp
        KCo5Dkqt7cs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C49386B4C;
        Tue, 20 Aug 2019 14:02:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9543386B48;
        Tue, 20 Aug 2019 14:02:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        johannes.schindelin@gmx.de, larsxschneider@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH] t0021: make sure clean filter runs
References: <20190820065625.128130-1-t.gummerer@gmail.com>
Date:   Tue, 20 Aug 2019 11:01:58 -0700
In-Reply-To: <20190820065625.128130-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Tue, 20 Aug 2019 07:56:25 +0100")
Message-ID: <xmqqlfvnvhpl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BA2E568-C374-11E9-BA9B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Fix the test by updating the mtime of test.r, so git is forced to
> check the contents of the file, and the clean filter is run as the
> test expects.

Hmph, depending on the timestamp granularity, with this patch,
test.r would have mtime that is the same or a bit later than that of
the index file.  Is it sufficient to really "force" Git to check the
contents, or does it just make the likelyhood that it would choose
to check a bit bigger (in other words, are we solving the race, or
merely making the race window smaller)?

Thanks.

>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  t/t0021-conversion.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index e10f5f787f..66f75005d5 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -390,6 +390,7 @@ test_expect_success PERL 'required process filter should filter data' '
>  		EOF
>  		test_cmp_exclude_clean expected.log debug.log &&
>  
> +		touch test.r &&
>  		filter_git checkout --quiet --no-progress empty-branch &&
>  		cat >expected.log <<-EOF &&
>  			START
