Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C81EC4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F82F2311A
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TtMGLe90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgIXGlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 02:41:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57384 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgIXGlG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 02:41:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39668E3F95;
        Thu, 24 Sep 2020 02:41:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AEIaKlOo00ZxrK1am1c0TDYyoQ8=; b=TtMGLe
        907sWTiqV2AH8nYqOkuswPUvVCYwUdoX59Ox4HagRz0IxuS7isIWA3cuDrLxWYCX
        qxxrkHVnglKP+VtuNzP+cwEwggFXeR9xBJ0lI+OnsXkZu9K1US1FJF6xQPJD7Awx
        VFQkDaMiGKUhFElBg0FiRUvrwNOuFOhtC90pI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pt3DjPnatscwcsxF4P3fWl8zrRLzjrUx
        U3CqGyFxIwyj8WeGwITOVpMpbJYd2VTfoPkVCr1ZlRx1fNX1bDlg3wkkyLXXwPqX
        dEY5Wakfge1ZA1uARoGgZrMwrdV8P12ZVqGezZhHf9D7a7//8xtO1E+mskhLAgtM
        GqUqqq68C4Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 332FEE3F94;
        Thu, 24 Sep 2020 02:41:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6A06DE3F90;
        Thu, 24 Sep 2020 02:41:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Guyot <tguyot@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
References: <20200918113256.8699-1-tguyot@gmail.com>
        <20200918113256.8699-2-tguyot@gmail.com>
        <20200918172747.GD183026@coredump.intra.peff.net>
        <CALqVohcZrBcjmonw-peVxUNM1kgEheCr3nAk9ZvajGpbpXsNaQ@mail.gmail.com>
        <xmqq363fm02a.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009231709340.5061@tvgsbejvaqbjf.bet>
        <xmqqk0wki9fh.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009232244000.5061@tvgsbejvaqbjf.bet>
        <1d0a60c3-d15e-bcbb-f042-2f8ae06f0de1@gmail.com>
Date:   Wed, 23 Sep 2020 23:40:58 -0700
In-Reply-To: <1d0a60c3-d15e-bcbb-f042-2f8ae06f0de1@gmail.com> (Thomas Guyot's
        message of "Thu, 24 Sep 2020 00:49:05 -0400")
Message-ID: <xmqq4knnisn9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8B87E56-FE30-11EA-8E5E-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Guyot <tguyot@gmail.com> writes:

> My next patch simplifies the test down to:
>
>     same_contents = one->oid_valid && two->oid_valid &&
>         oideq(&one->oid, &two->oid);
>
> My understanding is that oid_valid will never be true for a modified
> (even mode change) or out of tree file so it's a valid assumption.
>
> I'll also rename that variable to "same_oid" - the current name is
> misleading both ways (true doesn't means there will be diffs, false
> doesn't mean contents differs).

It is not "both ways", I think.  The idea is that when this variable
is true, we know with certainty that these two are the same, but
even when the variable is false, they still can be the same.  So
true does mean there will not be diff.  False indeed is fuzzy.

And as long as one side gives a 100% correct answer cheaply, we can
use it as an optimization (and 'true' being that side in this case).

I have a mild suspicion that the name same_anything conveys a wrong
impression, no matter what word you use for <anything>.  It does not
capture that we are saying the "true" side has no false positive.

And that is why I alluded to "may_differ" earlier (with opposite
polarity).  The flow would become:

    may_differ = !one->oid_valid || !two->oid_valid || !oideq(...);

    if (binary) {
        if (!may_differ) {
            added = deleted = 0;
            ...
        } else {
            ... count added and deleted ...
        }
    } else if (rewrite) {
	...
    } else if (may_differ) {
	... use xdl ...
    }

and it would become quite straight-forward to follow.  When there is
no chance that they may be different, we short-cut and otherwise we
compute without cheating.  Only when they can be different, we do
the expensive xdl thing.

Thanks.



