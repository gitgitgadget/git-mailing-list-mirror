Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F174C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418B264E3F
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhBVX0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:26:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64512 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhBVX0F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 18:26:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D05F6B5DDF;
        Mon, 22 Feb 2021 18:25:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zri9MQ22S8RQ4Wrw/BWO8PIxfHI=; b=e1jXwL
        +R3vktLIMI7DOIKFnMbRhicsfco/f3yy7vleikQTZJYRuRvUJZgS2EmLdvniwS/r
        IsY7bhtgnXkcOS69X2z52WG1Qeubk3lNeUi/oP2OAS2josGpIqGDyi8GP60QYx4z
        TXHHIiKuk8NHQKwkUpGvA5qROyoZ6mdkUzxSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j9WtJQjRnNk74pYUadTh2N9e/A2uTxCc
        2q2cVI6EQEw6JYksqBLnr+Ny+rlUwYpy2Yus2gEBu7909i+AmeQBzayyq2evmcUE
        iqX/IZGGD0RFYwJYR5+NqndQ9RrVzaeWPy5NwdLJPiQPJdHV0cMA7mK4Q53u9o19
        gWs2glwUQac=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C73D3B5DDE;
        Mon, 22 Feb 2021 18:25:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48728B5DDD;
        Mon, 22 Feb 2021 18:25:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, git@vger.kernel.org
Subject: Re: git format-patch lost the last part when branch merge
References: <20210222211621.0C5D.409509F4@e16-tech.com>
        <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
Date:   Mon, 22 Feb 2021 15:25:21 -0800
In-Reply-To: <YDQ27qbbblPfLCpU@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 22 Feb 2021 17:57:50 -0500")
Message-ID: <xmqqzgzv65y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BF78980-7565-11EB-8D5E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is expected. Format-patch omits merge commits entirely, as they
> can't be formatted as a simple diff that can be applied.
>
> There are lots of ways to look at the diff of a merge. By default, `git
> show` will show a combined diff, which omits hunks where one side was
> taken verbatim, but otherwise shows what each side did.
>
> The diff shown in the link above is a diff against the first-parent
> (which you can also get locally with `git show --first-parent 582cd91`).
> One _could_ apply that diff onto the first parent to achieve the same
> tree as the merge plus all of the commits that got merged in. But it
> wouldn't make any sense to apply that (aside from conflict resolution,
> it would be redundant with all of the commits that format-patch just
> output!).

Yes, a first-parent diff is something you could call "a simple diff
that can be applied to represent a merge", and it is consistent with
the expectations of those who are used to do a squash (pseudo-)merge.

I agree with you that it does not make sense to apply such a patch
as a patch, of course.  In addition to be redundant, it would be an
equivalent of doing a squash (psuedo-)merge, and loses the "up to
this point the side branch has been merged, so future merges won't
have to look beyond this point in the past" (sort of going back to
the prehistoric subversion days that did not keep track of which
changes have been merged).
