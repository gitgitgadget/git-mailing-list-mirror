Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7981E209F6
	for <e@80x24.org>; Wed, 12 Oct 2016 20:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933943AbcJLUIe (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 16:08:34 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:44516 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755983AbcJLUI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 16:08:28 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.104])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3svQ066fS4z5vFV
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 22:08:06 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3svPyw2Jx9z5tl9;
        Wed, 12 Oct 2016 22:07:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 55663519A;
        Wed, 12 Oct 2016 22:07:03 +0200 (CEST)
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
References: <20161011235951.8358-1-sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <44c554b8-7ac1-047d-59f0-b4d5331ed496@kdbg.org>
Date:   Wed, 12 Oct 2016 22:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161011235951.8358-1-sbeller@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.10.2016 um 01:59 schrieb Stefan Beller:
> +void git_attr_check_initl(struct git_attr_check **check_,
> +			  const char *one, ...)
>  {
> -	struct git_attr_check *check;
>  	int cnt;
>  	va_list params;
>  	const char *param;
> +	struct git_attr_check *check;
> +
> +	if (*check_)
> +		return;
> +
> +	attr_lock();
> +	if (*check_) {
> +		attr_unlock();
> +		return;
> +	}
> ...
>  	check = xcalloc(1,
> -			sizeof(*check) + cnt * sizeof(*(check->check)));
> +			sizeof(*check) + cnt * sizeof(*(check->attr)));
> ...
> +	*check_ = check;
> +	attr_unlock();

Sigh. DCLP, the Double Checked Locking Pattern. These days, it should be 
common knowledge among professionals that this naïve version 
_does_not_work_ [1]!

I suggest you go without it, then measure, and only *then* optimize if 
it is a bottleneck. Did I read "we do not expect much contention" somewhere?

[1] http://www.aristeia.com/Papers/DDJ_Jul_Aug_2004_revised.pdf C++ 
centric, but applies to C just as well

-- Hannes

