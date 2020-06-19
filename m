Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C49CC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE2520732
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wSW1h0GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbgFSRKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:10:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51419 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbgFSRKT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 13:10:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59CD260509;
        Fri, 19 Jun 2020 13:10:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GxiYQB0WHUWRbN3X2SvWPfzLWGc=; b=wSW1h0
        GNfyv+8LPGVKprwe75OYO3dPdyXZ8txmh25W5bdgF/RY6/pFnGZ20Hjl8Dqxnb6A
        XXJyP9kcsGg4eG06PuARImAoBLpzi5Q3CkSjpH13Mktb5kdYk6SZcgLQZJBWPc0z
        BQEFDo1ZRpwRJTadjfC60fvDJsSSv5EN4IETs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IzqwPTbUPFYoCMhbTqRj1annGps0AiUF
        7RTSuiKTQNgCFsreLl2S2S4s3DdE5DtFOOlhK/1EA8rWDxrflCssoCdO7K4pzQu2
        kwzM/yjf2k0fVQ/bdAFbB2bmwOaG+Sza34KpYXtDLrQwW2Rr07jwVV+lMz++1GXV
        0O4wFl2gn7s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BEE060508;
        Fri, 19 Jun 2020 13:10:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFD4960507;
        Fri, 19 Jun 2020 13:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Subject: Re: Bogus error from git log --full-diff
References: <87h7v7xf1n.fsf@igel.home>
Date:   Fri, 19 Jun 2020 10:10:16 -0700
In-Reply-To: <87h7v7xf1n.fsf@igel.home> (Andreas Schwab's message of "Fri, 19
        Jun 2020 17:15:32 +0200")
Message-ID: <xmqqtuz7hthj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF30A6E4-B24F-11EA-B68B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> If you have log.follow=true, then git log --full-diff doesn't work any
> more, giving a bogus error:

Does "any more" mean it used to work with older version of Git, or
it used to work before log.follow is thrown into the configuration
file?

> $ ./git -c log.follow=true log --full-diff .
> fatal: --follow requires exactly one pathspec

I see one and half possible bogosities in here.

 * "--follow" is about following a single path, so even without
   "--full-diff", i.e. "git log --follow .", should not proceed but
   notice it as an error.  The pathspec should name a single path,
   like "helloworld.py" (and no, git does not track directories, so
   "."  is not a single path.  The pathspec "." matches everything
   under that directory).

 * "--full-diff" wants to make a full comparison between two trees
   (in the case of "git log", the child and its parent(s)), but
   "--follow" wants to make a comparison between just two blobs
   (i.e. the path that it is following in the child, and the
   "corresponding" blob in the parent commit(s)), so they are
   inherently incompatible.

Since neither is flagged as an error, the "--follow" logic is upset
when "--full-diff" widens the input of the "diff" run internally
(the error message comes from the fact that full-diff cleared the
pathspec used to generate this diff that the "--follow" logic uses
to find the corresponding path it is following---it sees zero when
it wants to have one).

I said these are one-and-half, because a reasonable expectation by
the end user could be that the configured log.follow is automatically
turned off when any incompatible option is given from the command
line, i.e.

    git -c log.follow=yes log --full-diff .

should be equivalent to

    git log --full-diff .

and not

    git log --full-diff --follow .

And with that, we should not see the bogus * 1.5 error message.

So, I see 3 potential things that can be improved.  Tightened error
checking for "--follow" itself, tightened error checking for mutual
exclusivity, and turning configured log.follow off automatically.

Thanks.

