Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9942FC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 15:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiG0PK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiG0PK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 11:10:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F625FA5
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 08:10:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 644651BDC32;
        Wed, 27 Jul 2022 11:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=sSr7Y4+MadOMFa/z15ToAWsA48w7MPBQw/Wjd6Yjvvs=; b=l9a3
        MS3XXn+RZgRffSMoUrmYTNWaRw12k3itygvzOYkE23jtkEpe/IqUyU5LeHRV/8wB
        mPuJuh/uQ6xZBNs0ZXk+1no7WxJqNcyUyK6WxNp86+GGErQuqe1UQko5XjefIPtj
        BRqeLrRzeC+IEn3WC25V8Zx9SR4aP517tKp+LlU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CD461BDC31;
        Wed, 27 Jul 2022 11:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 123391BDC30;
        Wed, 27 Jul 2022 11:10:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <junio@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: ds/midx-with-less-memory
References: <xmqqh738bq21.fsf@gitster.g>
        <YuBlD3o5bYMg8f6i@coredump.intra.peff.net>
Date:   Wed, 27 Jul 2022 08:10:51 -0700
Message-ID: <xmqqv8risi9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E891E86-0DBE-11ED-AB2A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 22, 2022 at 06:01:10PM -0700, Junio C Hamano wrote:
>
>> * ds/midx-with-less-memory (2022-07-19) 3 commits
>>   (merged to 'next' on 2022-07-20 at 250d257c3e)
>>  + midx: reduce memory pressure while writing bitmaps
>>  + midx: extract bitmap write setup
>>  + pack-bitmap-write: use const for hashes
>> 
>>  The codepath to write multi-pack index has been taught to release a
>>  large chunk of memory that holds an array of objects in the packs,
>>  as soon as it is done with the array, to reduce memory consumption.
>> 
>>  Will merge to 'master'.
>>  source: <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>
>
> This topic looks very nice, but I think we might want this additional
> cleanup on top:
>
> -- >8 --
> Subject: [PATCH] write_midx_bitmap(): drop unused refs_snapshot parameter
>
> The refactoring in 90b2bb710d (midx: extract bitmap write setup,
> 2022-07-19) hoisted our call to find_commits_for_midx_bitmap() into the
> caller, which means we no longer need to see the refs_snapshot at all.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  midx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Nice.  Is this -Wunused-parameter at work?

Thanks, will queue.

> diff --git a/midx.c b/midx.c
> index 772ab7d294..4e956cacb7 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1059,7 +1059,6 @@ static int write_midx_bitmap(const char *midx_name,
>  			     struct commit **commits,
>  			     uint32_t commits_nr,
>  			     uint32_t *pack_order,
> -			     const char *refs_snapshot,
>  			     unsigned flags)
>  {
>  	int ret, i;
> @@ -1462,7 +1461,7 @@ static int write_midx_internal(const char *object_dir,
>  
>  		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
>  				      commits, commits_nr, ctx.pack_order,
> -				      refs_snapshot, flags) < 0) {
> +				      flags) < 0) {
>  			error(_("could not write multi-pack bitmap"));
>  			result = 1;
>  			goto cleanup;
