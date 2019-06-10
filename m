Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51BF21F462
	for <e@80x24.org>; Mon, 10 Jun 2019 21:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbfFJVeu (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 17:34:50 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:37455 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389362AbfFJVeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 17:34:50 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45N5y01yk2z5tlC;
        Mon, 10 Jun 2019 23:34:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B160D450;
        Mon, 10 Jun 2019 23:34:47 +0200 (CEST)
Subject: Re: [PATCH 2/3] mergetool: dissect strings with shell variable magic
 instead of `expr`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <cover.1560152205.git.j6t@kdbg.org>
 <2a33ca20af41d68a5bb4e2cf1e5ae32fddf2796c.1560152205.git.j6t@kdbg.org>
 <xmqqblz5nyve.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0a350943-9264-1a40-6452-91a990ec790d@kdbg.org>
Date:   Mon, 10 Jun 2019 23:34:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqblz5nyve.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.06.19 um 19:17 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> git-mergetool spawns an enormous amount of processes. For this reason,
>> the test script, t7610, is exceptionally slow, in particular, on
>> Windows. Most of the processes are invocations of git, but there are
>> also some that can be replaced with shell builtins. Do so with `expr`.
> 
> I see these as improvements independent of whatever test may or may
> not be slow ;-)  s/^.*/but there are/There are/.  Thanks for working
> on it.

Noted.

>> @@ -255,13 +254,16 @@ merge_file () {
>>  		return 1
>>  	fi
>>  
>> -	if BASE=$(expr "$MERGED" : '\(.*\)\.[^/]*$')
>> -	then
>> -		ext=$(expr "$MERGED" : '.*\(\.[^/]*\)$')
>> -	else
>> +	# extract file extension from the last path component
>> +	case "${MERGED##*/}" in
>> +	*.*)
>> +		ext=.${MERGED##*.}
>> +		BASE=${MERGED%"$ext"}
> 
> This rewrite can potentially change the behaviour, when $ext has
> glob metacharacters.  Wouldn't BASE=${MERGED%.*} be more faithful
> conversion?

Since "$ext" is quoted inside the braces of the parameter expansion, the
pattern counts as quoted, so all glob characters in $ext lose their
special meaning. At least that's how I read the spec.

I do see the symmetry in your proposed version. Nevertheless, I have a
slight preference for my version because it specifies exactly what is to
be removed from the end of value.

-- Hannes
