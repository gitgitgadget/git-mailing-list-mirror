Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0949EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 22:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFUWEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 18:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjFUWD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 18:03:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FA8DE
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 15:03:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C22AE28BBA;
        Wed, 21 Jun 2023 18:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VvMGCKk+Hd/qOFlqSJimq+p0Qf+U2k1QGGNv9z
        DKghg=; b=kzJBKEofFJ/twgXZIsjkYODScdQQ32ruAHvM2rOyeTiaTjfLO7D8Iz
        3iG8+q9YTzqflaAFfdT/IV3xeyAc/oqvFtRqH+AyYGPuhLTizZ/rT4PRB1RTYm7e
        g+BITkdPBnbLjMXef0Cwo9OfcXVkouk7tc8R60VX2qtyq/zlUm+s8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA94328BB9;
        Wed, 21 Jun 2023 18:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D83FB28BB8;
        Wed, 21 Jun 2023 18:03:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: bug in en/header-split-cache-h-part-3, was Re: What's cooking
 in git.git (Jun 2023, #05; Tue, 20)
References: <xmqqedm5k7dx.fsf@gitster.g>
        <20230621085526.GA920315@coredump.intra.peff.net>
        <xmqqttv0hhjv.fsf@gitster.g>
        <20230621202642.GA1423@coredump.intra.peff.net>
Date:   Wed, 21 Jun 2023 15:03:52 -0700
In-Reply-To: <20230621202642.GA1423@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 21 Jun 2023 16:26:42 -0400")
Message-ID: <xmqqjzvwfp6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82F50044-107F-11EE-8EDC-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah. I guess the real build problem is actually in the merge of split-2
> (it conflicted with a simultaneous topic, hence the fix coming in the
> merge). So another option to address that here would be to amend the
> 4bd872e0ed (Merge branch 'en/header-split-cache-h-part-2' into
> en/header-split-cache-h-part-3, 2023-05-08) to include that fixup.
>
> As for the others, I'd consider:
>
>   1. (optional) Drop the #ifndef at the very start of the series, before
>      we touch anything, with the rationale that it is not doing anything
>      and masks errors. I don't _think_ this can ever backfire, because
>      we unconditionally set DEFAULT_GIT_TEMPLATE_DIR (unlike some other
>      things like DEFAULT_PAGER, where the Makefile might leave it
>      unset). But we can also leave this out, or do it as a separate
>      topic, if we want to minimize changes / risk of screwing something
>      up.
>
>   2. Squash the Makefile fix into the "adopt shared init-db" patch
>      (currently 0d652b238).
>
> And that would leave the result fully bisectable. But if we prefer to
> keep the history closer to reality, I can prepare the Makefile thing as
> a patch on top.

I've done the messiest, I guess ;-)

 * revert merge of the part-3 topic and Dscho's cmake fix out of 'next'.

 * rebase part-3 on top of the more recent 'master'.

 * squash in the two hunks (including setup.c change) from you into
   the "setup: adopt shared init-db & clone code" step.

 * squash in Dscho's cmake fix into "cache.h: remove this
   no-longer-used header" step.

The result is not in 'next' yet until I hear something from those
who have been involved in the topic, including Elijah and Dscho.

Thanks.
