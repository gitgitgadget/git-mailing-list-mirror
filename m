Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA0C61FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbcH2VRy (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:17:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64849 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754167AbcH2VRx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:17:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C5B63A2A9;
        Mon, 29 Aug 2016 17:17:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tTVd4eOiJifDDiexfHj5qfMgrw0=; b=IV1jEK
        ATcs3E+X7x98PQoT+x67QyWCF3uI1Sg9kr67a+htetQZvGTXYTVxEV2cOVciEV6j
        L2KUusYBUx3EfqwHwfGH9q76reSl2cdHfXWlaeTj5XxKG1GZk5yjIR7zSDUbx1hX
        RrNpTWU6L4xwngJeFBs7uGpnaLFcCVVKpZp9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o3dnigmP0SrPazHH7G80knkxwWIinMfe
        Z/SdaDQI8xK6cdJhZYa7hwDZJXhuSdejxU52dwJOBzG6PN+4+7H+e1goan1g2lDf
        s8ttqc9Egb0ossdtdDaPo0Q30Ka+AEIpzM/FYRK6g0jFgGddsjuzhdmwwSO0NKz6
        YKz9pEbufRM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75CAA3A2A8;
        Mon, 29 Aug 2016 17:17:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04B7B3A2A6;
        Mon, 29 Aug 2016 17:17:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Simon Ruderich <simon@ruderich.org>, git@vger.kernel.org,
        Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v2] blame: fix segfault on untracked files
References: <xmqqeg57bfcu.fsf@gitster.mtv.corp.google.com>
        <20160829195019.30876-1-t.gummerer@gmail.com>
Date:   Mon, 29 Aug 2016 14:17:43 -0700
In-Reply-To: <20160829195019.30876-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Mon, 29 Aug 2016 20:50:19 +0100")
Message-ID: <xmqqd1kr8ebs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 073C3E54-6E2E-11E6-B654-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> The point of this fix is not that we show the exact error message,
>> but we fail in a controlled manner.  I think
>>
>> test_expect_success 'blame untracked file in empty repo' '
>>                >untracked &&
>>                test_must_fail git blame untracked
>>        '
>>
>> is sufficient.
>
> Yeah, I agree with that.
>
> Thanks for the review!

Thanks for a quick follow-up fix during -rc period.

>>  builtin/blame.c  | 3 ++-
>  t/t8002-blame.sh | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 7ec7823..a5bbf91 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2244,7 +2244,8 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
>  	pos = cache_name_pos(path, strlen(path));
>  	if (pos >= 0)
>  		; /* path is in the index */
> -	else if (!strcmp(active_cache[-1 - pos]->name, path))
> +	else if (-1 - pos < active_nr &&
> +		 !strcmp(active_cache[-1 - pos]->name, path))
>  		; /* path is in the index, unmerged */
>  	else
>  		die("no such path '%s' in HEAD", path);
> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index ff09ace..ab79de9 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -6,6 +6,11 @@ test_description='git blame'
>  PROG='git blame -c'
>  . "$TEST_DIRECTORY"/annotate-tests.sh
>  
> +test_expect_success 'blame untracked file in empty repo' '
> +	>untracked &&
> +	test_must_fail git blame untracked
> +'
> +
>  PROG='git blame -c -e'
>  test_expect_success 'blame --show-email' '
>  	check_count \
