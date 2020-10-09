Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1808C43457
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 02:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E30922203
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 02:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UjEVLrXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgJICpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 22:45:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56123 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJICpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 22:45:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85987FA668;
        Thu,  8 Oct 2020 22:45:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=FWmJWZOB4KpzTEZzx60nXV4MIvg=; b=UjEVLrXxqGG6/vJRDayu
        nyFnimIxiJvJnaqpHzRJS2do0tvBXuz94+DecA0tU/79xeTsRcCynUgqxahx+1Om
        e2/dp6t3o7bYix7yp0ZUKdCxAM5fwP3CWT02AZOFEDu7IEXw4IJFFwkEJwhZogVh
        EGuGj2VoayzcIkAuvc7QJDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=whf2XwZVs06ojfq75qw4FHerTgj59QiYlwLWQ/F0g3+Y4K
        6JvFiWJENF6e/jwCCkueu9SaO93q+iX7m2RlbJMVjDY/+Jyf5+2WYTO/4tvBgeY7
        Y7likEWEepqVVClclK+6yVtUsiCvUTW/7/UXpCC3DbZuyBSJlKFFZAspbZAGE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E166FA667;
        Thu,  8 Oct 2020 22:45:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C4A9EFA665;
        Thu,  8 Oct 2020 22:45:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Makefile: create externcheck target
References: <9e5a8625cab217bd6aaba68da081bc801354b903.1602059508.git.liu.denton@gmail.com>
        <1c2ee1c40ccde18a008262aeaf23a17da2064eae.1602142232.git.liu.denton@gmail.com>
Date:   Thu, 08 Oct 2020 19:45:09 -0700
Message-ID: <xmqqy2kgungq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73AD2DE6-09D9-11EB-B2B7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +externcheck: $(filter-out $(THIRD_PARTY_SOURCES),$(filter %.c %.h,$(shell $(FIND_SOURCE_FILES))))
> +	sed -i 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/' $^

I am not enthused by this particular patch for a few reasons, and I
am moderately negative on the whole idea.

 - We don't aim to support "only GNU and some BSD"; let's not do
   "-i" which as far as I know is used only in config.mak.uname for
   vcxproj target (which is OK as we know that is run only on a very
   narrow target, but probably is a bad idea as it would be another
   source of copy-and-paste for those who do not even think why it
   is acceptable there but not in all other places).

 - Same for \s.  If it is easy enough to write [        ]*, why
   risk breaking for somebody you don't even know?

 - The initial [^*] may be an attempt to avoid triggering on a
   global pointer-to-function, but doesn't it also make the pattern
   fail to trigger on a global function whose return type is a
   pointer-to-function?

 - If this is a "check" target, we shouldn't apply a wholesale
   transformation that is potentially buggy to user's files.  Using
   "grep" to just point out the places where your opinion differ
   from user's (and to fail the "make foocheck" operation) would be
   more appropriate.

Quite honestly, I suspect that the "push" that b199d714 (*.[ch]:
remove extern from function declarations using sed, 2019-04-29)
talks about was misguided in the first place.

Sure, we can write these external function declarations without
'extern' in front, because the language allows it and without
'static' in front, it by default is 'extern'.  It however does
not automatically mean we _should_ drop 'extern'.

Sure, for function decls, it may not make a difference to have or
not have "extern" in front, but for decls of data (including
pointers to functions), it makes a whole lot of difference.  Not
standardising to the rule "our external declarations always are
marked with leading 'extern', regardless of the type of the
identifier being declared" forces us to spend our brain cycles to
think if we should or should not write 'extern' in front.  And is
that a good thing to spend our brain cycles on, or just waste of our
effort?  I am moderately in favor of saying that it is a waste.

In addition, seeing these 'extern ' in header files will train our
eyes to spot the same in the source files more easily.  External
decls in the source (as opposed to inclusion of a header that does
the decls) can happen but they ought to be exceptions and it is good
to make them stand out.
