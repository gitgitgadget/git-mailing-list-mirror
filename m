Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0477C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 18:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3BD610E7
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 18:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbhJHSM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:12:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65452 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241740AbhJHSMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 14:12:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F4C4E24D9;
        Fri,  8 Oct 2021 14:10:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SerqkGZCk40lfKC1CEM2Tym7Q2vtZECb0cP5dD
        67TUU=; b=VtHuPHshYl6gsDn2QPqdIEdJhxgv5yRaCPqDXy7Q32yAlxFesifcRc
        pxlS07BSW+o3/tdA/OMPT/npB7v51xUTJgvgCOYW7E3P+JEWk4ioDhQYnJKzljtS
        5sTMKOxyvJOqYxpf0K+xfLhgsBqzas8PwIez+Xqg5Tsz2kKvxza1E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46A04E24D8;
        Fri,  8 Oct 2021 14:10:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96685E24D7;
        Fri,  8 Oct 2021 14:10:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git format-patch --range-diff accepts non-quoted arguments
 (shouldn't it be?)
References: <c2c5f3b0-dfdb-0f3f-4c64-8f44d3e74a07@gmail.com>
Date:   Fri, 08 Oct 2021 11:10:35 -0700
In-Reply-To: <c2c5f3b0-dfdb-0f3f-4c64-8f44d3e74a07@gmail.com> (Bagas Sanjaya's
        message of "Fri, 8 Oct 2021 16:34:15 +0700")
Message-ID: <xmqq7denl750.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09682658-2863-11EC-BC09-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> I think it is rather odd that `git format-patch --range-diff` accepts
> <previous> argument without enclosed in quotes, since it is always 
> multi-word (separated by space). E.g., below works:

What do you mean by "it" in "since it is always"?  If you meant
"<previous>", your may want to re-read "git format-patch --help".

The <previous> will most likely not be a multi-word argument
separated by a space.  It is a way to specify the "previous range",
i.e. one of the two ranges given to the range-diff command to be
compared.  The other range is what the user gave the command to
specify what patches to work on for the latest iteration.

So...

>     $ git format-patch <options> --range-diff=main..previous main..HEAD

This works of course, because <previous> is main..previous (without
any SP anywhere, and needs no quoting), main..HEAD is the range to
take patches from *and* also given to range-diff as the current
range.

> but below returns nothing:
>
>     $ git format-patch <options> --range-diff="main..previous main..HEAD"

This gives an empty range to work on to the command.  The range-diff
argument seems strange, but if we are not emitting a single patch or
cover letter, perhaps there is no place to emit the range-diff so it
may not get any complaint.

> Should the quoted <previous> argument to --range-diff be allowed, and
> forbid the unquoted counterpart?

No, I think the command is fine as-is.

Stepping back a bit, if you have two topics (perhaps related,
perhaps not) forked from the mainline, but you want to present
them as a single unit to the outside world, you may do this:

    $ git format-patch ^master topic-1 topic-2

If two topics share their early commits and their later commits are
independent and do not interact with each other, this command line
should do the right thing to emit shared ones only once.

If these were the second iteration, I would imagine

    $ git format-patch \
	--range-diff='^master@{last.week} topic-1@{last.week} topic-2@{last.week}' \
	^master topic-1 topic-2

would be a good way to include the range-diff for this round
relative to the previous round you sent last week.

So, quoting <previous> may be necessary in a more complex usecase,
but most of the time you should not have to quote.

HTH.
