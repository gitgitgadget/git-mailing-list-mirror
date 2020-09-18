Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E7C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8279D21741
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mzMF7Ypb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRSGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 14:06:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59055 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRSGk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 14:06:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CE2E72358;
        Fri, 18 Sep 2020 14:06:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o7MDscoqwcrN/n2/QmrBifrg5/M=; b=mzMF7Y
        pblRyPqbKG5MeFj5J8P0Ly9hfA7sKZ4y9vuzY433Yw2hIgGmW1kYRpUp7pvVPs7I
        ktPIYBfG2WGcFUPr3J13z0JRo83NiNaJyiHB1OuSJPBdoldwoYWxURu6DXek4DQn
        8q1ybmqUUL+TWuCuMsQe51g8oPZqk9E0e/4Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QOA9hFwOW0qT7vzNLW5ZqhAJBxpB8QOm
        YS9bLVwN2OGTPpuXuVokMiT4l/Mi1oEpRYREmJvQ5gcK1pkbNyRA9GfSImuuf9eM
        K8V9qQNPOuA/zVXCZbkj4ywSn1t7eQaF7VXTExWJv/UaOXSz5fxDcMtK09Afh/27
        TdEhH9UhdRU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 759E472357;
        Fri, 18 Sep 2020 14:06:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0697A72355;
        Fri, 18 Sep 2020 14:06:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
References: <20200918113256.8699-1-tguyot@gmail.com>
        <20200918113256.8699-2-tguyot@gmail.com>
        <20200918172747.GD183026@coredump.intra.peff.net>
        <CALqVohcZrBcjmonw-peVxUNM1kgEheCr3nAk9ZvajGpbpXsNaQ@mail.gmail.com>
Date:   Fri, 18 Sep 2020 11:06:37 -0700
In-Reply-To: <CALqVohcZrBcjmonw-peVxUNM1kgEheCr3nAk9ZvajGpbpXsNaQ@mail.gmail.com>
        (Thomas Guyot-Sionnest's message of "Fri, 18 Sep 2020 13:52:11 -0400")
Message-ID: <xmqq363fm02a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B22866EA-F9D9-11EA-A5DF-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Guyot-Sionnest <tguyot@gmail.com> writes:

>> > -     same_contents = oideq(&one->oid, &two->oid);
>> > +     if (one->is_stdin && two->is_stdin)
>> > +             same_contents = !strcmp(one->data, two->data);
>> > +     else
>> > +             same_contents = oideq(&one->oid, &two->oid);
>>
>> ...should this actually be checking the oid_valid flag in each filespec?
>> That would presumably cover the is_stdin case, too. I also wonder
>> whether range-diff ought to be using that flag instead of is_stdin.
>
> I considered that, but IIRC when run under a debugger oid_valid was
> set to 0 - it seemed to be used for something different that i'm not
> familiar with, maybe it's an indication the object is in git datastore
> (whereas with --no-index outside files will only be hashed for
> comparison).

If it says !oid_valid, I think you are getting what you do want.
The contents from the outside world, be it what was read from the
standard input or a pipe, a regular file that is not up-to-date with
the index, may not have a usable oid computed for it, and oid_valid
being false signals you that you need byte-for-byte comparison.  As
suggested by Peff in another message, you can take that signal and
compare the size and then the contents with memcmp() to see if they
are the same.

