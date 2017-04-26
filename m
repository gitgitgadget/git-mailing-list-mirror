Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4E0207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 13:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1955032AbdDZNGk (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 09:06:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:13490 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034001AbdDZNGi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 09:06:38 -0400
Received: from [10.181.8.102] (cpe-76-182-13-114.nc.res.rr.com [76.182.13.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 87AF4844F2;
        Wed, 26 Apr 2017 09:06:37 -0400 (EDT)
Subject: Re: [PATCH v8] read-cache: call verify_hdr() in a background thread
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20170425184109.46168-1-git@jeffhostetler.com>
 <xmqqd1bzst95.fsf@gitster.mtv.corp.google.com>
 <xmqq8tmnss66.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5a97967d-5cf2-dc62-7f84-524556a9ca4c@jeffhostetler.com>
Date:   Wed, 26 Apr 2017 09:06:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <xmqq8tmnss66.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/2017 12:34 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> git@jeffhostetler.com writes:
>>
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Version 8 of this patch converts the unit test to use
>>> perl to corrupt the index checksum (rather than altering
>>> a filename) and also verifies the fsck error message as
>>> suggested in response to v7 on the mailing list.
>>>
>>> If there are no other suggestions, I think this version
>>> should be considered final.
>> Oops.  The earlier one has already been in 'master' for a few days.
>> Let's make this an incremental update.
>>
>> Is the description in the following something you are OK with (so
>> that I can add your sign-off)?
>>
>> Thanks.
> By the way, I said I am fine with the two-liner version in Dscho's
> message, but I am also OK with this version that does not use a
> separate dd and instead does everything in a single invocation of
> Perl.  As long as you've tested this version, there is no point
> replacing it with yet another one.

Either version is fine.  I'd say use my perl version as I have tested it and
it is simple enough and already in the tree.  I don't think it's worth the
bother to switch it to the dd version.

Thanks
Jeff

> Thanks.
>
>> -- >8 --
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> Date: Tue, 25 Apr 2017 18:41:09 +0000
>> Subject: t1450: avoid use of "sed" on the index, which is a binary file
>>
>> The previous step added a path zzzzzzzz to the index, and then used
>> "sed" to replace this string to yyyyyyyy to create a test case where
>> the checksum at the end of the file does not match the contents.
>>
>> Unfortunately, use of "sed" on a non-text file is not portable.
>> Instead, use a Perl script that seeks to the end and modifies the
>> last byte of the file (where we _know_ stores the trailing
>> checksum).
>>
>>
>> ---
>>   t/t1450-fsck.sh | 33 ++++++++++++++++++++++++++-------
>>   1 file changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> index 677e15a7a4..eff1cd68e9 100755
>> --- a/t/t1450-fsck.sh
>> +++ b/t/t1450-fsck.sh
>> @@ -689,16 +689,35 @@ test_expect_success 'bogus head does not fallback to all heads' '
>>   	! grep $blob out
>>   '
>>   
>> +# Corrupt the checksum on the index.
>> +# Add 1 to the last byte in the SHA.
>> +corrupt_index_checksum () {
>> +    perl -w -e '
>> +	use Fcntl ":seek";
>> +	open my $fh, "+<", ".git/index" or die "open: $!";
>> +	binmode $fh;
>> +	seek $fh, -1, SEEK_END or die "seek: $!";
>> +	read $fh, my $in_byte, 1 or die "read: $!";
>> +
>> +	$in_value = unpack("C", $in_byte);
>> +	$out_value = ($in_value + 1) & 255;
>> +
>> +	$out_byte = pack("C", $out_value);
>> +
>> +	seek $fh, -1, SEEK_END or die "seek: $!";
>> +	print $fh $out_byte;
>> +	close $fh or die "close: $!";
>> +    '
>> +}
>> +
>> +# Corrupt the checksum on the index and then
>> +# verify that only fsck notices.
>>   test_expect_success 'detect corrupt index file in fsck' '
>>   	cp .git/index .git/index.backup &&
>>   	test_when_finished "mv .git/index.backup .git/index" &&
>> -	echo zzzzzzzz >zzzzzzzz &&
>> -	git add zzzzzzzz &&
>> -	sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
>> -	mv .git/index.yyy .git/index &&
>> -	# Confirm that fsck detects invalid checksum
>> -	test_must_fail git fsck --cache &&
>> -	# Confirm that status no longer complains about invalid checksum
>> +	corrupt_index_checksum &&
>> +	test_must_fail git fsck --cache 2>expect &&
>> +	grep "bad index file" expect &&
>>   	git status
>>   '
>>   

