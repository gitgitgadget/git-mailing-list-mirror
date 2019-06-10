Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8CA1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 22:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfFJWBG (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 18:01:06 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:29797 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbfFJWBG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 18:01:06 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45N6XJ4YGrz5tlN;
        Tue, 11 Jun 2019 00:01:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 676BA2118;
        Tue, 11 Jun 2019 00:01:03 +0200 (CEST)
Subject: Re: [PATCH 3/3] mergetool: use shell variable magic instead of `awk`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <cover.1560152205.git.j6t@kdbg.org>
 <d6675b02918364736ec74db937481127ab7d8990.1560152205.git.j6t@kdbg.org>
 <xmqq7e9tnyp0.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a80b9f58-5aa1-f7fa-7f64-f9cc1024c248@kdbg.org>
Date:   Tue, 11 Jun 2019 00:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqq7e9tnyp0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.06.19 um 19:21 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> +	# here, $IFS is just a LF
>> +	for line in $f
>> +	do
>> +		mode=${line%% *}		# 1st word
>> +		sha1=${line#"$mode "}
>> +		sha1=${sha1%% *}		# 2nd word
>> +		case "${line#$mode $sha1 }" in	# remainder
>> +		'1	'*)
>> +			base_mode=$mode
>> +			;;
>> +		'2	'*)
>> +			local_mode=$mode local_sha1=$sha1
>> +			;;
>> +		'3	'*)
>> +			remote_mode=$mode remote_sha1=$sha1
>> +			;;
>> +		esac
>> +	done
> 
> OK.  $mode won't have any glob metacharacter, and there is only one
> invocation of "ls-files -u", which is now two fewer processes ;-)

I think it's better than that: there're about 9 fewer from the context
that you didn't quote:

-	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
-	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
-	remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')

and sometimes the 6 from below on top of that. But I won't insist in
having counted correctly ;-)

>>  
>>  	if is_submodule "$local_mode" || is_submodule "$remote_mode"
>>  	then
>>  		echo "Submodule merge conflict for '$MERGED':"
>> -		local_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
>> -		remote_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
>>  		describe_file "$local_mode" "local" "$local_sha1"
>>  		describe_file "$remote_mode" "remote" "$remote_sha1"
>>  		resolve_submodule_merge
