Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7465ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 22:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJaWmN convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 31 Oct 2022 18:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJaWmM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 18:42:12 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BD45FE4
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:42:11 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 29VMg7T4069257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 31 Oct 2022 18:42:07 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Mark Hills'" <mark@xwax.org>, "'Taylor Blau'" <me@ttaylorr.com>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "'Matheus Tavares'" <matheus.bernardino@usp.br>
References: <2210311614160.25661@stax.localdomain> <221031.86zgdb68p3.gmgdl@evledraar.gmail.com> <Y2Ax5XOgSOOcgo8J@nand.local> <d4db484f-a525-f6db-1bfb-922f788dacd@xwax.org>
In-Reply-To: <d4db484f-a525-f6db-1bfb-922f788dacd@xwax.org>
Subject: RE: Consist timestamps within a checkout/clone
Date:   Mon, 31 Oct 2022 18:42:02 -0400
Organization: Nexbridge Inc.
Message-ID: <005e01d8ed7a$020589a0$06109ce0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE5LeY8QcVEMy3vCONNDR05zWZotQNAzBDrAUea/T0B/n2Vj680X4pw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 31, 2022 6:31 PM, Mark Hills wrote:
>On Mon, 31 Oct 2022, Taylor Blau wrote:
>> On Mon, Oct 31, 2022 at 09:21:20PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> > I think you're almost certainly running into the parallel checkout,
>> > which is new in that revision range. Try tweaking checkout.workers
>> > and checkout.thresholdForParallelism (see "man git-config").
>> >
>> > I can't say without looking at the code/Makefile (and even then, I
>> > don't have time to dig here:), but if I had to bet I'd say that your
>> > dependencies have probably always been broken with these checked-in
>> > files, but they happend to work out if they were checked out in
>> > sorted order.
>> >
>> > And now with the parallel checkout they're not guaranteed to do
>> > that, as some workers will "race ahead" and finish in an unpredictable order.
>>
>> Doesn't checkout.thresholdForParallelism only matter when
>> checkout.workers != 1?
>>
>> So what you wrote seems like a reasonable explanation, but only if the
>> original reporter set checkout.workers to imply the non-sequential
>> behavior in the first place.
>>
>> That said...
>>
>>   - I also don't know off-hand of a place where we've defined the order
>>     where Git will checkout files in the working copy. So depending on
>>     that behavior isn't a safe thing to do.
>>
>>   - Committing build artifacts into your repository is generally
>>     discouraged.
>
>If it's undefined and never implemented this is reasonable.
>
>But "generally" is a caveat, so while I agree with the statement it also implies
>there's valid cases outside of that. Ones which used to work, too.
>
>Here are some useful cases I have seen for the combination of build rule +
>checked in file:
>
>- part of a build requires licensed software that's not always available
>
>- part of the build requires large memory that other builders generally do
>  not have available
>
>- part of the build process uses a different platform or some other system
>  requirement
>
>- to fetch data eg. from a URL, with a record of the URL/automation but
>  also a copy of the file as a record and for offline use
>
>So it's useful, to retain repeatable automation but not always build from square
>one.
>
>Generally discouraged to check in build results yes, but I've found it very practical.
>
>> So while I'd guess that setting `checkout.workers` back to "1" (if it
>> wasn't already) will probably restore the existing behavior, counting
>> on that behavior in the first place is wrong.
>
>I think perhaps the tail is wagging the dog here, though.
>
>It's 'wrong' because it doesn't work; but I haven't seen anything to make me think
>this is fundamentally or theoretically flawed.
>
>If we had a transactional file system we'd reasonably expect a checkout to be an
>atomic operation -- same timestamp on the files created in that step. A
>discrepancy in timestamps would be considered incorrect; it would imply an 'order'
>to the checkout which, as you say, is order-less.
>
>Sowhat could be the bad outcomes if Git created files stamped with the point in
>time of the "git checkout"?

Timestamps are written based on when git modifies the file in the working directory. This actually ensures that automation does work. If intermediate contents are checked into repositories (I have people who do this for very justifiable regulatory reasons), the build has to make sure that there are appropriate separations of timestamps (a.k.a. 1 second) at a minimum on UNIX-ish systems. On some other boxes that do not even have timestamps for files (you know who you are) this is moot.

However, there is a use case for maintaining timestamps - specifically for debuggers that check timestamps of source files. It is a big pain to make this work in git - but I script around this by setting the timestamps of files to the commit time when doing release builds, and allowing users to set the timestamp to the same for debugging. It helps but should not change the semantics of dev builds.

-Randall

