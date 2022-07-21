Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD98C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 20:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiGUUB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 16:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUUBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 16:01:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E614664EF
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 13:01:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D4541AADF4;
        Thu, 21 Jul 2022 16:01:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bjWRCATwcEA/egh8+Y5/HCd6ZnDMOsGaXcwYGM
        WLiZ8=; b=H3ehc0bLcC3EPGsTvCtALN0Buu/V7zOQfEzcjgJPq69pM/uZAS3WC6
        Z40PMk59hhn2RGGqeYTsuQ1dZvagULUt6IDVsrd+4Bn73eoLiEzeh689vrI0WjpG
        f9DscFbUZqxbFktu2NHDl3SEOet1olLG//BmQEqmBCWUrrg5A6ChE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95C5A1AADF3;
        Thu, 21 Jul 2022 16:01:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07BF91AADF0;
        Thu, 21 Jul 2022 16:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: On-branch topic description support?
References: <xmqqilnr1hff.fsf@gitster.g>
        <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
        <xmqqwnc6idxr.fsf@gitster.g>
        <220721.86a692tkva.gmgdl@evledraar.gmail.com>
        <xmqqy1wmgx8t.fsf@gitster.g>
        <20220721182645.45xrwf2buohibcaw@meerkat.local>
        <20220721191349.kf3zx4tpwrjhzudt@nitro.local>
Date:   Thu, 21 Jul 2022 13:01:16 -0700
In-Reply-To: <20220721191349.kf3zx4tpwrjhzudt@nitro.local> (Konstantin
        Ryabitsev's message of "Thu, 21 Jul 2022 15:13:49 -0400")
Message-ID: <xmqqa692grqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E223E510-092F-11ED-B0E4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> Hmm... well, it works great as long as you remember to always use
> --rebase-merges. The moment you forget to pass -r to "git rebase", your cover
> letter commit disappears, and I'm not sure this is going to work for what I am
> trying to do (which is to make the process of submitting patch series
> simpler). I know it's possible to configure git so that "git pull --rebase"
> preserves merges, but there doesn't appear to be a way to force "git rebase
> -i" to do the same without the -r flag. Also, "rebase -ir" looks really
> different when there is a tip merge commit, which will probably also be
> confusing to newbies just starting out with rebase workflows.
>
> So, I'm not sure that at this time this is objectively "better" than keeping
> the cover letter in an empty commit at the start of the series. :-/

Now you are discussing this on the git mailing list, you do not
necessarily have to take the existing behaviour of Git as given.  

For example, I do not think it is unreasonable to teach "git rebase
[-i]" to special case a certain merge commit in the rebased range
without any extra option, as long as the criteria to pick such a
special "merge" is specific and narrow enough (a two-parent merge M
whose tree matches that of one parent's tree (say M^1^{tree}), the
other parent (say M^2) is an immediate ancestor of the bottommost
commit of the range being rebased, or something like that).  And the
way you "special case" it does not have to be tied to the way the
"-r" option handles it, either.  

A possible design could go like this:

 * we recognize such a special merge commit;

 * we rebase the rest of the range, pretending as if that merge
   commit did not exist and instead its children are all direct
   child of one of its parent (say M^1), using the options given (so
   "-r" would affect how other merges in the rebased range is
   handled).

 * after everything is done, we create a new empty merge commit at
   the top, merging the bottom of the range and the tip of the range
   as its parents, using the log message from original M.  This can
   be done totally outside of the regular "rebase" machinery.

Such a change to existing behaviour is well within the scope of
"On-branch topic description support", I would think.
