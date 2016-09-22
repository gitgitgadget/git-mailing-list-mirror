Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDEB11F935
	for <e@80x24.org>; Thu, 22 Sep 2016 05:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbcIVFGe (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 01:06:34 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:5241 "EHLO bsmtp4.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbcIVFGd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 01:06:33 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3sfkx22zY6z5tlC;
        Thu, 22 Sep 2016 07:06:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A2DE85302;
        Thu, 22 Sep 2016 07:06:29 +0200 (CEST)
Subject: Re: [PATCH tg/add-chmod+x-fix 2/2] t3700-add: protect one --chmod=+x
 test with POSIXPERM
To:     Junio C Hamano <gitster@pobox.com>
References: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
 <5effaf36-d017-3ff1-1de1-d9b303c04f23@kdbg.org> <20160920193444.GG8254@hank>
 <xmqqtwd986ml.fsf@gitster.mtv.corp.google.com>
 <xmqqa8f16kup.fsf@gitster.mtv.corp.google.com>
 <c3aefd9d-b794-21a1-619e-bce6a3c2cf47@kdbg.org>
 <xmqq60pp6jor.fsf@gitster.mtv.corp.google.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e139199f-1542-855e-d473-6a5d068ccdef@kdbg.org>
Date:   Thu, 22 Sep 2016 07:06:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq60pp6jor.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.2016 um 23:12 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> But I came to a different conclusion as I said in a message that
>> crossed yours. I hope Thomas can pick up the baton again.
>
> Yeah, our mails crossed, apparently, and I do agree with your
> reasoning.  How about this, then?
>
> -- >8 --
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Tue, 20 Sep 2016 08:18:25 +0200
> Subject: [PATCH] t3700-add: do not check working tree file mode without POSIXPERM
>
> A recently introduced test checks the result of 'git status' after
> setting the executable bit on a file. This check does not yield the
> expected result when the filesystem does not support the executable
> bit.
>
> What we care about is that a file added with "--chmod=+x" has
> executable bit in the index and that "--chmod=+x" (or any other
> options for that matter) does not muck with working tree files.
> The former is tested by other existing tests, so let's check the
> latter more explicitly and only under POSIXPERM prerequisite.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t3700-add.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 16ab2da..924a266 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -361,13 +361,11 @@ test_expect_success 'git add --chmod=[+-]x changes index with already added file
>  	test_mode_in_index 100644 xfoo3
>  '
>
> -test_expect_success 'file status is changed after git add --chmod=+x' '
> -	echo "AM foo4" >expected &&
> +test_expect_success POSIXPERM 'git add --chmod=[+-]x does not change the working tree' '
>  	echo foo >foo4 &&
>  	git add foo4 &&
>  	git add --chmod=+x foo4 &&
> -	git status -s foo4 >actual &&
> -	test_cmp expected actual
> +	! test -x foo4
>  '
>
>  test_expect_success 'no file status change if no pathspec is given' '
>

That makes a lot of sense. Thank you so much!

-- Hannes

