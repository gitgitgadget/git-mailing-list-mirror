Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B213EC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 16:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbiCWQYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbiCWQYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 12:24:04 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5AE7C791
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:22:33 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C2AD43F47EE;
        Wed, 23 Mar 2022 12:22:32 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 383C43F4161;
        Wed, 23 Mar 2022 12:22:32 -0400 (EDT)
Subject: Re: [PATCH v7 21/29] t7527: create test for fsmonitor--daemon
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
 <4a920d0b54a25a442bf52efc171139c698d59dc7.1647972010.git.gitgitgadget@gmail.com>
 <220322.86a6dhq1a6.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <56a4a545-37b0-0cee-a8c8-1a019b0201c2@jeffhostetler.com>
Date:   Wed, 23 Mar 2022 12:22:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220322.86a6dhq1a6.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/22 2:35 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 22 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   t/t7527-builtin-fsmonitor.sh | 501 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 501 insertions(+)
>>   create mode 100755 t/t7527-builtin-fsmonitor.sh
>>
>> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
>> new file mode 100755
>> index 00000000000..d79635e7596
[...]
> 
>> +	while test "$#" -ne 0
>> +	do
>> +		case "$1" in
>> +		-C)
>> +			shift;
>> +			test "$#" -ne 0 || BUG "error: -C requires arg"
>> +			r="-C $1"
>> +			shift
>> +			;;
>> +		-tf)
>> +			shift;
>> +			test "$#" -ne 0 || BUG "error: -tf requires arg"
>> +			tf="$1"
>> +			shift
>> +			;;
>> +		-t2)
>> +			shift;
>> +			test "$#" -ne 0 || BUG "error: -t2 requires arg"
>> +			t2="$1"
>> +			shift
>> +			;;
>> +		-tk)
>> +			shift;
>> +			test "$#" -ne 0 || BUG "error: -tk requires arg"
>> +			tk="$1"
>> +			shift
>> +			;;
> 
> But (and IIRC I noted this in a previous iteration) if you &&-chain the
> "shift" here you can lose the more verbose BUG

Yeah, I looked at the test_commit() example that you referenced.
I thought it was too subtle and misleading.

I mean, the "shift" after the "case...esac" will either clobber
the "--key" or the "value" depending on whether the particular
case-arm shifted.  The shift error would only be thrown on a
missing value, since the while loop already tested $# for non-zero,
but at the point of the error, we'll just have a generic error message
and not know which key should have had a value -- without reading
the script in detail.

Also, in the k/v case-arms, it references $2 without confirming
that it exists.  In test_commit(), it just loads up local variables
(in advance of the soon-to-be-thrown shift error, so no big deal)
but if other people copy this as a model, they may do more in their
case-arms that may be more serious.


My version on the other hand, shifts away the key immediately,
tests whether the required value is present and errors with a
detailed message, and then references the value and shifts away
the value.

My way (IMHO) feels more straight-forward and easier for casual
readers to follow.  Yes, it is a bit more wordy, but I think it
is worth it.


FWIW, as I was writing this note I noticed that both test_commit()
and my start_daemon() examples have a bug where they won't detect
a missing value.  For example, if someone changes
    "test_commit -C repo"
to "test_commit -C --no-tag repo"
then $indir will be "--no-tag" and "repo" will be unclaimed and
an error will follow at some point later (when $indir is used
in a Git command).


I think I'll fix my function to handle that error case, but keep
the basic design that I have.


> 
>> +	start_daemon -tf "$PWD/.git/trace" &&
> 
> FWIW having an option parser take -tf to mean --tf is quite unlike our
> common conventions, usually it means both -t and -f.
> 
> In this case every single caller added here does provide -tf
> argument. Perhaps better as as unconditional $1 then?
> 

yes, very old-school of me to use single dashes here.  I'll change
it/them to use double-dashes (or relabel the keys to be single chars).
There are callers that do not pass the -tf key, so I'd rather keep it
as a key/value than assume a fixed $1.

Thanks
Jeff

