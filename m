Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82201F453
	for <e@80x24.org>; Fri, 26 Apr 2019 23:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfDZXpG (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 19:45:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59631 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfDZXpG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 19:45:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6613B4A72F;
        Fri, 26 Apr 2019 19:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2TFKPmGHNHVFh5W9rzEVlXPpWV8=; b=Qwb8Rj
        pee8EMVJ6ljYEPVs8iQfTKC0/5oQKNpkYfBzYcjEiDTDXeAsaBi02nno2yTLg1vy
        J+MjK2o+RdXYZHo+GHtUAi5Flg0UNZbKN5XH5gOm9C+ZBGFZpEpQUe2sc55YYRZn
        eT4SYTKy1b3AB3434c55uAgfo8txhk9s64HYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iZQkp1Kvo4ZYNQFQR3KINF0Iv1sDBLgc
        j+xETw6TnUV3I9A7e1jkx9h5tm6enYiMOBLq/qLRtEPD2kSLJZPAtF7h/WSAt+3S
        w5F9KDXmV4w4tMPSZnA2iM+SeTHZAhjhQbWZwvFqd2z+AcMCny/HBVJYU7wN40/A
        6MlrGX59HaI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E3804A72E;
        Fri, 26 Apr 2019 19:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06FC34A72C;
        Fri, 26 Apr 2019 19:45:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with write_block_or_die()
References: <pull.145.git.gitgitgadget@gmail.com>
        <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com>
        <20190413013451.GB2040@sigill.intra.peff.net>
        <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1904261028220.45@tvgsbejvaqbjf.bet>
Date:   Sat, 27 Apr 2019 08:44:58 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1904261028220.45@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 26 Apr 2019 10:29:45 -0400 (DST)")
Message-ID: <xmqqd0l8tjph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E9A3D7C-687D-11E9-85BC-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >> +/* writes out the whole block, or dies if fails */
>> >> +static void write_block_or_die(const char *block) {
>> >> +	if (gzip) {
>> >> +		if (gzwrite(gzip, block, (unsigned) BLOCKSIZE) != BLOCKSIZE)
>> >> +			die(_("gzwrite failed"));
>> >> +	} else {
>> >> +		write_or_die(1, block, BLOCKSIZE);
>> >> +	}
>> >> +}
>>
>> I agree everything you said you your two review messages.
>>
>> One thing you did not mention but I found disturbing was that this
>> does not take size argument but hardcodes BLOCKSIZE.
>
> That is very much on purpose, as this code really is specific to the `tar`
> file format, which has a fixed, well-defined block size. It would make it
> easier to introduce a bug if that was a parameter.

I am not so sure for two reasons.

One is that its caller is full of BLOCKSIZE constants passed as
parameters (instead of calling a specialized function that hardcodes
the BLOCKSIZE without taking it as a parameter), and this being a
file-scope static, it does not really matter with respect to an
accidental bug of mistakenly changing BLOCKSIZE either in the caller
or callee.

Another is that I am not sure how your "fixed format" argument
meshes with the "-b blocksize" parameter to affect the tar/pax
output.  The format may be fixed, but it is parameterized.  If
we ever need to grow the ability to take "-b", having the knowledge
that our current code is limited to the fixed BLOCKSIZE in a single
function (i.e. the caller of this function , not the callee) would 
be less error prone.

These two are in addition to the uniformity of the abstraction
concerns I raised in my original review comment.

So, sorry, I do not think your response makes much sense.

Thanks.

