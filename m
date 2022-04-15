Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C4FC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 16:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355814AbiDOQZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbiDOQZz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 12:25:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42139E9CC
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 09:23:25 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED09A119BFC;
        Fri, 15 Apr 2022 12:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+lOF68PpofCl
        3xsDFP0vs5I0siGBj3+TP0TJ/+pWsAY=; b=Qd6jQTP5RW08RhJNihT6KkqOh5pC
        l2VNy+RyFm4vH6IV0Z8YiDabAn5RXz9lGI838Vx/hDfQ1vqXgA4WO9EuTEPpdHi4
        mtRtZk2mLeLi0V3FYXzkYTNqCNU5sKWIST73pnhRbmcfeJusacTKS+NJL1vk6JL/
        zfjdgSBF3aM8b3A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E418F119BFB;
        Fri, 15 Apr 2022 12:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46889119BFA;
        Fri, 15 Apr 2022 12:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 2/2] reftable: don't memset() a NULL from failed
 malloc()
References: <20220415083058.29495-1-carenas@gmail.com>
        <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
        <RFC-patch-2.2-364d1194a95-20220415T101740Z-avarab@gmail.com>
        <4321a9dd-bb82-e2fe-5449-395f998378c5@web.de>
        <220415.86fsmebgds.gmgdl@evledraar.gmail.com>
        <23138e2b-436a-0990-cefc-0662674373c3@talktalk.net>
        <220415.86bkx2bb0p.gmgdl@evledraar.gmail.com>
Date:   Fri, 15 Apr 2022 09:23:23 -0700
In-Reply-To: <220415.86bkx2bb0p.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 15 Apr 2022 17:20:53 +0200")
Message-ID: <xmqq1qxyfh8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F8473AC-BCD8-11EC-ADB4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Does it? I just quickly scanned the output of
>>
>> git grep -e 'reftable_[mc]alloc' -e 'reftable_realloc' -A2 origin/mast=
er
>>
>> and I didn't see a single NULL check
>
> I think you're right, I retrieved that information from wetware. Lookin=
g
> again I think I was confusing it with the if (x) free(x) fixes in
> 34230514b83 (Merge branch 'hn/reftable-coverity-fixes', 2022-02-16).

True.  Initially I hoped that these RFC changes gives us a better
solution that comes from stepping back and rethinking the issues
around the original "why are we calling memset() with NULL?", and
if it were only "well, in _return_block() functions, we clear the
block before calling _free()---that shouldn't be necessary, if the
calling custom malloc-free pair cares, they can do the clearing, and
plain vanilla free() certainly doesn't, so let's stop calling
memset()", it certainly would have fallen into that category, but
everything these RFC patches do beyond that seems "oh, it does not
look important to me, so let's rip it out to simplify", without
knowing enough to say if that is sensible.

But ...

>> Isn't it there so the same code can be used by libgit2 and other
>> things that let the caller specify a custom allocator?
>
> I don't think so, but I may be wrong. I think it's a case of
> over-generalization where we'd be better off with something simpler,
> i.e. just using our normal allocation functions.

... many points that was raised on the reftable code in this thread
may deserve response to explain the rationale behind the current
code and design, as nobody can improve, without breaking the
intended way to be used, without knowing what it is.  Thanks for
marking the patches with RFC.  I think the "patch" is a bit too
dense a form to point out the issues in the existing code, but the
discussion that follows by quoting the points in the original code
and suggested changes is a good way to think about the code before
these RFC patches.

Ideally, it would have been much better if these points were raised
during the review before the code was accepted to the code base, but
it is better to have one now, rather than never ;-)

THanks.
