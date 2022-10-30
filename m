Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A87AECAAA1
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 22:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJ3WBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 18:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ3WBu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 18:01:50 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255986171
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 15:01:49 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1opGNH-0004Js-DL;
        Sun, 30 Oct 2022 22:01:47 +0000
Message-ID: <85f56b56-74c5-ffe5-703f-ef0c1e6d3b45@iee.email>
Date:   Sun, 30 Oct 2022 22:01:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/1] pretty-formats: add hard truncation, without
 ellipsis, options
Content-Language: en-GB
To:     Taylor Blau <me@ttaylorr.com>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
References: <20221030185614.3842-1-philipoakley@iee.email>
 <20221030185614.3842-2-philipoakley@iee.email> <Y17PS/2LgRIJKGoo@nand.local>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <Y17PS/2LgRIJKGoo@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/10/2022 19:23, Taylor Blau wrote:
> On Sun, Oct 30, 2022 at 06:56:14PM +0000, Philip Oakley wrote:
>> Instead of replacing with "..", replace with the empty string "",
>> having adjusted the padding length calculation.
>>
>> Needswork:
>> There are no tests for these pretty formats, before or after
>> this change.
> Hmmph. I see some when searching for l?trunc in
> t4205-log-pretty-formats.sh. Is that coverage not sufficient for the
> existing feature?
>
> If so, it would be nice to see it bulked up to add coverage where we
> are missing some. Either way, we should make sure the new code is
> covered before continuing.

No idea how I missed them. Maybe I'd filtered, by accident, the search
by a too narrow list of file types.

Thanks for that pointer.

>> @@ -1743,6 +1749,16 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
>>  					    padding - 2, len - (padding - 2),
>>  					    "..");
>>  			break;
>> +		case trunc_left_hard:
>> +			strbuf_utf8_replace(&local_sb,
>> +					    0, len - (padding),
>> +					    "");
>> +			break;
>> +		case trunc_right_hard:
>> +			strbuf_utf8_replace(&local_sb,
>> +					    padding, len - (padding),
>> +					    "");
>> +			break;
> If I remember correctly, strbuf_utf8_replace() supports taking NULL as
> its last argument, though upon searching I couldn't find any callers
> that behave that way. Can we use that instead of supplying the empty
> string? If not, should we drop support for the NULL-as-last-argument?

I wasalso  concerned about zero length strings but my brief look at the
code indicated it could cope with a zero length string.
The last param is `const char *subst`.

I've just relooked at the code and it does have a

     if (subst)
        subst_len = strlen(subst);

so it does look safe to pass NULL, though it would probably cause a
pause for thought for readers, and isn't likely to be that much faster
in these format scenarios.
>
> Thanks,
> Taylor
--
Philip
