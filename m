Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A120AC0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 16:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjHKQFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjHKQFx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 12:05:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793BE10DE
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 09:05:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15E043261E;
        Fri, 11 Aug 2023 12:05:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z3vzDRy7Bv2DqgKZiuxizFsbB/rCZunIuU05OP
        P9uUw=; b=G7LKKLH4BRNIMDzYevyV01O5WlPjjZLa2Yne+bj+sLmpE55uQhA/VX
        ClbvwEiUI4g5vfdfuDsrsXsYoVV7RFMB5p3e8yXNuXG1Lg9x5v1XEYfuTFZ16eu7
        K78H8gFkhvKgSfH58EX/rPUrN9wO3j4akviJKAtgg0D/irtdkhcBs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DB843261D;
        Fri, 11 Aug 2023 12:05:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A7B003261C;
        Fri, 11 Aug 2023 12:05:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Wesley <wesleys@opperschaap.net>, git@vger.kernel.org
Subject: Re: [[PATCH v2]] Fix bug when more than one readline instance is used
References: <20230810004956.GA816605@coredump.intra.peff.net>
        <20230810011831.1423208-1-wesleys@opperschaap.net>
        <xmqqcyzupf3b.fsf@gitster.g>
        <8d683835-31d4-41f0-9d4e-90c95acbea28@opperschaap.net>
        <xmqqwmy2no2e.fsf@gitster.g>
        <20230811145121.GB2303200@coredump.intra.peff.net>
Date:   Fri, 11 Aug 2023 09:05:48 -0700
In-Reply-To: <20230811145121.GB2303200@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 11 Aug 2023 10:51:21 -0400")
Message-ID: <xmqqjzu1o97n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0713954-3860-11EE-B7D4-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/git-svn.perl b/git-svn.perl
>> index e919c3f172..6033b97a0c 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -427,7 +427,7 @@ sub ask {
>>  	my $default = $arg{default};
>>  	my $resp;
>>  	my $i = 0;
>> -	term_init() unless $term;
>> +	my $term = term_init();
>>  
>>  	if ( !( defined($term->IN)
>>              && defined( fileno($term->IN) )
>
> Hmm. Isn't that an indication that git-svn is OK as-is?

Yes.  As long as we know they share the same kind of code structure
to use the same library function that wants its callers to stick to
a singleton instance, there is a value in using the same structure
on the side of our callers, but yes, we can rely on the global $term
for it being a singleton.

> It could still benefit from cleaning up FakeTerm, since we lazily init
> the object since 30d45f798d (git-svn: delay term initialization,
> 2014-09-14). But I don't think there's a visible bug here with the new
> version of Term::ReadLine::Gnu.

True.  Let me drop the patch from the 'next down to master
fast-track' candidate status.

Thanks.
