Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20E9C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCA624641
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y2fPUV0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899205AbgJVRSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 13:18:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57493 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899074AbgJVRSz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 13:18:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A609ED99E;
        Thu, 22 Oct 2020 13:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OHFzBH17tsqk
        Hfc5IJ1fVm7GFt4=; b=Y2fPUV0OPRzYWi10wd38h0Z9AbMpg4j0Z8lkRutNofZM
        ZuksKD127JfYgmuPY6co0SXgARx+lK9xMzZpOceDwPGrKeH+tE/vx9ZZO9cBSyVO
        akYs1mlV4S+kT0RhJW2zE1QFl2L7qE1AhE1XxvbtYDNNpICIH6ZzWVR8sn47sYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P7K2zN
        aXINmq7IYiJ7lUXp/HlyTE93grxx/bn1HrUFU2aWPV0gNzUZUgBslGLxeYZQADT2
        +xrbwAj4GhB71hBDAmPnBZO0n2JavTfx6xIKqAH3Eu/ucsPNInw6RXrhFs17DaWE
        66czyLaZRBzAGu4/g7QMn/5Qs7xBbyUKxFATc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8321AED99D;
        Thu, 22 Oct 2020 13:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE3E1ED99C;
        Thu, 22 Oct 2020 13:18:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bisect: loosen halfway() check for a large number of
 commits
References: <20201022103806.26680-1-szeder.dev@gmail.com>
Date:   Thu, 22 Oct 2020 10:18:46 -0700
In-Reply-To: <20201022103806.26680-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 22 Oct 2020 12:38:06 +0200")
Message-ID: <xmqqv9f2mb61.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A608FD54-148A-11EB-9797-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> However, when we have thousands of commits it's not all that important
> to find the _exact_ halfway point, a few commits more or less doesn't
> make any real difference for the bisection.

Cute idea.

> So I ran some tests to see how often that happens: picked random good
> and bad starting revisions at least 50k commits apart and a random
> first bad commit in between in git.git, and used 'git bisect run git
> merge-base --is-ancestor HEAD $first_bad_commit' to check the number
> of necessary bisection steps.  After repeating all this 1000 times
> both with and without this patch I found that:
>
>   - 146 cases needed one more bisection step than before, 149 cases
>     needed one less step, while in the remaining 705 cases the number
>     of steps didn't change.  So the number of bisection steps does
>     indeed change in a non-negligible number of cases, but it seems
>     that the average number of steps doesn't change in the long run.

It somehow is a bit surprising that there are cases that need fewer
steps, but I guess that is how rounding-error cuts both ways?

>   - The first 'git bisect start' command got over 3x faster in 456
>     cases, so this "no commit at the exact halfway point" case seems
>     to be common enough to care about.

In any case, I like the re-realization that the counting reachable
commits in a mergy history is costly (see comments before the
count_distance() function that we already knew it from the
beginning, though), and the general idea of speeding up the entire
thing by avoiding the cost we need to pay in the count_distance()
function, which my earlier 1c4fea3a (git-rev-list --bisect:
optimization, 2007-03-21) also did.

    Side note.  I've been waiting for all these years to see
    somebody new comes up and makes a fundamental change to
    count_distance() such that it no longer is costly---alas,
    that hasn't happened yet.

Mildly (only because such a bisection session over a long span is
rarer) excited to see this RFC completed ;-)





