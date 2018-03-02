Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9A31F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946214AbeCBKhC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:37:02 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:32628 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946350AbeCBKgr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:36:47 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id ri3PerTFfXdHHri3PeFjcd; Fri, 02 Mar 2018 10:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519987004;
        bh=Uw8xVokoSWB8Ec8pFzJfXsfiw1lm2LWMBUxPihxlilk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nUALB9TECp60SNzFUTa0BBKsAtq9Odn7PTZa6ovO9ZujmJryKfNbAbqpQZg1wtS2C
         eSPWnuSOI9CzWrFWr6OaUBAXxtHgE2Uyt4ac47++h2m8wqzk3Buet/YqgeF6MTkmB1
         EjuU+6PgJrd5R2jzH2BzYz+XnNizb4xzG9WbKan0=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JaySU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=U7_WuDcnf4z7swmNgo0A:9 a=bibIAgN_vWhG4D8J:21
 a=xnWogB01bwhiudcD:21 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 7/9] add -p: calculate offset delta for edited patches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180301105103.24268-1-phillip.wood@talktalk.net>
 <20180301105103.24268-8-phillip.wood@talktalk.net>
 <xmqqwoyvft92.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6fcd21f7-b7f7-4196-6404-463e867443cd@talktalk.net>
Date:   Fri, 2 Mar 2018 10:36:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqwoyvft92.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFE0WlCOozcIRrZjUT8a3z5AdG8xTWN1t1QGd1dudxxcMj6ztoxzLP7+WOPJX0bHFkQBZNhuIuxxf49sKcDhkqA55HtaV3kYwdWLQG9GnRuvjLu+Y6Mw
 r0/kHSumgGXNp+rGxEdFo/3Y8beJl3lgnVFTG59ndeYYvl+xdLwo0Hh/QE2J/w1siNZbGQ7VYaZezkgXkb/XgY/xJ3pehUFgxSjIJPhj/EN+Ch6xa3Ei5vX0
 uNDWn3JXpyWlilBh5H3HJBmbWrZiZCSJrcoyAirfFYFKKd5Rk3qzH8YVE3BOQ4m8rWAP4IuBF0XK2Oy8LhWn4uRmBYNm/qFEox9Ga8fOj2I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03/18 20:14, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Recount the number of preimage and postimage lines in a hunk after it
>> has been edited so any change in the number of insertions or deletions
>> can be used to adjust the offsets of subsequent hunks. If an edited
>> hunk is subsequently split then the offset correction will be lost. It
>> would be possible to fix this if it is a problem, however the code
>> here is still an improvement on the status quo for the common case
>> where an edited hunk is applied without being split.
>>
>> This is also a necessary step to removing '--recount' and
>> '--allow-overlap' from the invocation of 'git apply'. Before
>> '--recount' can be removed the splitting and coalescing counting needs
>> to be fixed to handle a missing newline at the end of a file. In order
>> to remove '--allow-overlap' there needs to be i) some way of verifying
>> the offset data in the edited hunk (probably by correlating the
>> preimage (or postimage if the patch is going to be applied in reverse)
>> lines of the edited and unedited versions to see if they are offset or
>> if any leading/trailing context lines have been removed) and ii) a way of
>> dealing with edited hunks that change context lines that are shared
>> with neighbouring hunks.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
> 
> Thanks for clear description of what is going on in the series.
> 
>> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
>> index 7a0a5896bb..0df0c2aa06 100755
>> --- a/git-add--interactive.perl
>> +++ b/git-add--interactive.perl
>> @@ -938,13 +938,19 @@ sub coalesce_overlapping_hunks {
>>  						parse_hunk_header($text->[0]);
>>  		unless ($_->{USE}) {
>>  			$ofs_delta += $o_cnt - $n_cnt;
>> +			# If this hunk has been edited then subtract
>> +			# the delta that is due to the edit.
>> +			$_->{OFS_DELTA} and $ofs_delta -= $_->{OFS_DELTA};
> 
> The pattern
> 
> 	<<conditional>> and <<statement with side effect>>;
> 
> is something you are newly introducing to this script.  I am not
> sure if we want to see them.  I somehow find them harder to read
> than the more straight-forward and naïve
> 
> 	if (<<conditional>>) {
> 		<<statement with side effect>>;
> 	}
> 

Fair enough, I think I was suffering from brace fatigue when I wrote it,
if you can hold off merging this into next I'll re-roll with "if's"
instead of "and's".

>> +		# If this hunk was edited then adjust the offset delta
>> +		# to reflect the edit.
>> +		$_->{OFS_DELTA} and $ofs_delta += $_->{OFS_DELTA};
> 
> Likewise.
> 
>> +sub recount_edited_hunk {
>> +	local $_;
>> +	my ($oldtext, $newtext) = @_;
>> +	my ($o_cnt, $n_cnt) = (0, 0);
>> +	for (@{$newtext}[1..$#{$newtext}]) {
>> +		my $mode = substr($_, 0, 1);
>> +		if ($mode eq '-') {
>> +			$o_cnt++;
>> +		} elsif ($mode eq '+') {
>> +			$n_cnt++;
>> +		} elsif ($mode eq ' ') {
>> +			$o_cnt++;
>> +			$n_cnt++;
>> +		}
>> +	}
>> +	my ($o_ofs, undef, $n_ofs, undef) =
>> +					parse_hunk_header($newtext->[0]);
>> +	$newtext->[0] = format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
>> +	my (undef, $orig_o_cnt, undef, $orig_n_cnt) =
>> +					parse_hunk_header($oldtext->[0]);
>> +	# Return the change in the number of lines inserted by this hunk
>> +	return $orig_o_cnt - $orig_n_cnt - $o_cnt + $n_cnt;
>> +}
> 
> OK.
> 
>> @@ -1114,25 +1144,32 @@ sub prompt_yesno {
>>  }
>>  
>>  sub edit_hunk_loop {
>> -	my ($head, $hunk, $ix) = @_;
>> -	my $text = $hunk->[$ix]->{TEXT};
>> +	my ($head, $hunks, $ix) = @_;
>> +	my $hunk = $hunks->[$ix];
>> +	my $text = $hunk->{TEXT};
>> ...
>> +		$newhunk->{OFS_DELTA} = recount_edited_hunk($text, $newtext);
>> +		# If this hunk has already been edited then add the
>> +		# offset delta of the previous edit to get the real
>> +		# delta from the original unedited hunk.
>> +		$hunk->{OFS_DELTA} and
>> +				$newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
> 
> Ahh, good point.
> 

