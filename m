Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B9A1F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946391AbeCBKsz (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:48:55 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:45685 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946382AbeCBKsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:48:47 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id riF3erV0BXdHHriF3eFkFd; Fri, 02 Mar 2018 10:48:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519987726;
        bh=e5QsAU9JpYDpVbBjUUT2M4f/KAkUMCNUn6Eq++yhf0o=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SUw6GKceydE7qhCJVXGE7O88wTvuoPbaVYuBCi4w72jyzMKNkzcsomHxF80Up8tS7
         sv05lmXNKr1EmB4IjUq+LvATyGgh8Zez7AsadPJ6lGYNFFb8Ma8++F/w23r/+2AWm/
         ihTjFqS6a9EAH7MnTf+bujDGUIYzojQSFzvTfDfg=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JaySU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=7t9S2b2KNLOXVdy-_kYA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 8/9] add -p: fix counting when splitting and coalescing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180301105103.24268-1-phillip.wood@talktalk.net>
 <20180301105103.24268-9-phillip.wood@talktalk.net>
 <xmqqsh9jfsjd.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b094e133-75bb-04ee-64b1-af7019a436f0@talktalk.net>
Date:   Fri, 2 Mar 2018 10:48:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqsh9jfsjd.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAlcBpitO4+Ow70mlTLczMEofJTAFV61v/csv3mGXZSO8orVfNO2UUGDpk+lMs9Cf62OXAyidLspiyTCShntn2QucjOYoG6blvRNFVHN4Faps1u/3vuR
 JzVqCA8cq7WUs/iAOggXwo8an9qscbe003VpGI6e5ELLyE6nOc/40m6U8FwTlIRvkWQf2LrU85B2hlmtdVZiYGLBAIFvlatU4GMaEKU16hK1akFBJYlPHTVH
 na00Wrzb6DlGJyfz9mUP8foq3WxE3Gb2tUoLSlzMO94KUMBmutyXbYbXXeHirTU0LmZmkBjYJ2loP6RsXgRcr6t1EUDwJKtfsUFaXV6ZcRY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03/18 20:29, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> @@ -887,8 +892,8 @@ sub merge_hunk {
>>  	$o_cnt = $n_cnt = 0;
>>  	for ($i = 1; $i < @{$prev->{TEXT}}; $i++) {
>>  		my $line = $prev->{TEXT}[$i];
>> -		if ($line =~ /^\+/) {
>> -			$n_cnt++;
>> +		if ($line =~ /^[+\\]/) {
>> +			$n_cnt++ if ($line =~ /^\+/);
>>  			push @line, $line;
>>  			next;
>>  		}
> 
> Hmmmm, the logic may be correct, but this looks like a result of
> attempting to minimize the number of changed lines and ending up
> with a less-than-readble code.  "If the line begins with a plus or
> backslash, do these things, the first of which is done only when
> the line begins with a plus."  The same comment for the other hunk
> that counts the $this side.
> 
Right, I'll re-roll with a separate clause for the "\ No new line .." lines.
