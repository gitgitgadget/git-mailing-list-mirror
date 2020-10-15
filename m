Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD5EC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39A620725
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jg2lj+vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392192AbgJOUP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:15:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64391 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgJOUP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:15:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45762884EF;
        Thu, 15 Oct 2020 16:15:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J+oJ+NuTMlfFnsTfEJCXDcrUOvY=; b=jg2lj+
        vlteBVInfF1aQaJPqSPbUqfZjBZjI1hPpO3Gi6GoMNXtgLUVmqgjFz8vrBEXA4gp
        gyQtA/tI7uKzZ3+mVaPqYn1K6jAQ+8TPFzZ9HWPZ5BGk8afsF8aBqi5jqaQOLAnT
        +IcQ+QRVKnIa52nxZT0T6ih9eoE+83C9gaftI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gsNciNInw+64tBA0oTz2C/K8V7opC9a9
        hBEjk4dK0swfzJ/AWV05EVxT/Rfw9VFvzBQdyIKXY0mcQR9N5DKUvBvNGhAPLS9w
        nhAKIKbNoUqVL0cXaev1PxxrNYtx71Ppmmou1QEP++KnbbiT1Xnnc8MbZcKcaIyb
        qGNmIQ04PjY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DE88884EE;
        Thu, 15 Oct 2020 16:15:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6FF8884ED;
        Thu, 15 Oct 2020 16:15:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
        <20201015012636.GA387901@coredump.intra.peff.net>
        <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
        <20201015153849.GA551964@coredump.intra.peff.net>
        <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
        <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
        <f3e4f7ccc36dc214201c1838acce4aff@sebres.de>
        <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
        <65f46be7283239e86bb345e94bc5dbda@sebres.de>
Date:   Thu, 15 Oct 2020 13:15:53 -0700
In-Reply-To: <65f46be7283239e86bb345e94bc5dbda@sebres.de> (Dipl. Ing. Sergey
        Brester's message of "Thu, 15 Oct 2020 21:17:58 +0200")
Message-ID: <xmqq362ffdom.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A156068-0F23-11EB-9EE6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dipl. Ing. Sergey Brester" <serg.brester@sebres.de> writes:

> Well, a bug-tracker had some clear benefits:
>
> 1. it has controlling and statistic mechanisms like a road-map,
> milestones etc;
>
> 2. the issues get a priority (so one is able to select bugs with high
> precedence);
>
> 3. they can be labeled or even characterized with other metrics to
> signal seriousness of the issue or
> to emphasize them in order to be flashy in the road-map.
>
> 4. the issues are bound to the participating contributors (reporter,
> devs, tester, etc), so for example there are reports like "open issues
> belonging to me", which could also help to organize work a bit
> ("remember" them).
>
> 5. Transparency of the representation of issue or some lists is not to
> compare with a thread in a mailing list at all.

What is curious in the above list is that their benefits are heavily
dependent on people actually curating them.  No issue tracker
automatically makes random issues "prioritized", no issue tracker
automatically closes a stale and/or irrelevant issue.  And without
curation, it tends to become pile of useless reports.

> I could continue yet, but unsure the arguments will be heard or
> welcome ...

I actually think people already _know_ the benefit of having well
curated tracker, and suspect that what needs to be stressed is *not*
the "arguments" for having one.  It just is that those who bring it
up on this list never seem to be interested in maintaining the
tracker in useful state, and assumes that issue curation magically
happens for free, and that is probably it never materializes.

It would be great if you are volunteering to be one of the issue
managers, of course.  FWIW, I think somebody (jrnieder?) already
runs a tracker for us.  I do not know how much community
participation the instance gets to to keep it relevant.
