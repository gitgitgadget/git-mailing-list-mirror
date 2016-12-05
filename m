Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480031FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 17:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbcLERpM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 12:45:12 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:38962 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbcLERpK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 12:45:10 -0500
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id E052A20290
        for <git@vger.kernel.org>; Mon,  5 Dec 2016 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1480959909;
        bh=YVistD5K7f9NORiDU4ddnGVePV38vAeD4UDPFO5XnUw=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=QLz4II1I1UkM5gICruIkQwGChknZPbAv1AxVIgPRLVU8WyoDi12PKB5YM7b+777sg
         lsKkmtayhoTKK/zW4eSKJOG8C6QspS5V60+pPVbV+LBBMlhVdqiSacoxhIPlML+5UM
         i80RwEIP69BUB8DHnIGx+YECagK8tnP8i7NpTAKQ=
Received: from [192.168.0.10] (S0106c8fb26402908.ek.shawcable.net [24.66.132.201])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA;
        Mon,  5 Dec 2016 17:45:09 +0000 (UTC)
Subject: Re: [PATCH] diff: fix up SHA-1 abbreviations outside of repository
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20161204194747.7100-1-jack@nottheoilrig.com>
 <xmqqr35m6dwt.fsf@gitster.mtv.corp.google.com>
 <20161205072614.zg6yglqnznna65vf@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Jack Bates <bk874k@nottheoilrig.com>
Message-ID: <66e03fae-d78e-2577-3f27-40e36fdc6ee1@nottheoilrig.com>
Date:   Mon, 5 Dec 2016 10:45:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161205072614.zg6yglqnznna65vf@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/12/16 12:26 AM, Jeff King wrote:
> On Sun, Dec 04, 2016 at 11:19:46PM -0800, Junio C Hamano wrote:
>>> -	if (no_index)
>>> +	if (no_index) {
>>>  		/* If this is a no-index diff, just run it and exit there. */
>>> +		startup_info->have_repository = 0;
>>>  		diff_no_index(&rev, argc, argv);
>>> +	}
>>
>> This kind of change makes me nervous (partly because I am not seeing
>> the whole code but only this part of the patch).
>>
>> Some code may react to "have_repository" being zero and do the right
>> thing (which I think is what you are using from your previous "we
>> did one of the three cases" change here), but the codepath that led
>> to "have_repository" being set to non-zero previously must have done
>> a lot more than just flipping that field to non-zero, and setting
>> zero to this field alone would not "undo" what it did.
>
> I _think_ it's OK because the only substantive change would be the
> chdir() to the top of the working tree. But that information is carried
> through by revs->prefix, which we act on regardless of the value of
> startup_info->have_repository when we call prefix_filename().
>
> I agree that it may be an accident waiting to happen, though, as soon as
> some buried sub-function needs to care about the distinction.
>
>> I wonder if we're better off if we made sure that diff_no_index()
>> works the same way regardless of the value of "have_repository"
>> field?
>
> If you mean adding a diffopt flag like "just abbreviate everything to
> FALLBACK_DEFAULT_ABBREV even if we're in a repository", and then setting
> that in diff_no_index(), I agree that is a lot cleaner.
>
> I'm still not 100% convinced that it's actually the correct behavior,
> but at least doing a more contained version wouldn't take away other
> functionality like reading config.

I don't have a strong reason for wanting these three cases to behave 
identically, I was merely surprised that they don't. I think you 
expected them to behave the same as well? I'll withdraw this patch.

Conceptually I do think of "git diff" as having two separate modes, "in 
repository" and "out of repository", with the --no-index option forcing 
the "out of repository" mode. But maybe there are good reasons why this 
isn't accurate, or maybe it doesn't matter that it's not 100% accurate.

In summary, currently all of the three cases are "no index" but only the 
first case doesn't "have repository".

Thank you for your thoughtful feedback!
