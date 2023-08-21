Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13315EE4993
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 15:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjHUP4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjHUP4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 11:56:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABE7A1
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 08:56:28 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36D391B9912;
        Mon, 21 Aug 2023 11:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I3ZxrYUmcyIcS257b3e1nkovzJdh1TLOTQhyrL
        X117Y=; b=gcRKdztyjmMT8RPn6Mj1Iqe5iXOWON5cwlb1KOXspw5nKs6poy7FXX
        fvCYS6yCTKkth4CTJub4CKHXKFgc2JoSmlm/CihDJX+FzppPsJc7ElSpPzJZbFbS
        qVKRJvQoBDEku/5yRUzWaBx4LVjLHusr013iBqqmB6c4KwvYukflA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F45F1B9911;
        Mon, 21 Aug 2023 11:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8EF141B9910;
        Mon, 21 Aug 2023 11:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: handle negative status in diff_result_code()
References: <CAHxTZ4AUxow1p7mNG0fuRtfhkaOu=Wpc7cYvM8wRaB80hPNf9Q@mail.gmail.com>
        <20230821003532.GA1113755@coredump.intra.peff.net>
Date:   Mon, 21 Aug 2023 08:56:26 -0700
In-Reply-To: <20230821003532.GA1113755@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 20 Aug 2023 20:35:32 -0400")
Message-ID: <xmqqlee4s82d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49894BEE-403B-11EE-8320-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks for your report. And I'm impressed you managed to find such an
> ancient bug. :)

Indeed.  Thanks, both.

> Most programs which run a diff (porcelain git-diff, diff-tree, etc) run
> their result through diff_result_code() before presenting it to the user
> as a program return code. That result generally comes from a library
> function like builtin_diff_files(), etc, and may be "-1" if the function
> bailed with an error.
>
>
> There are two problems here:
>
>   - if --exit-code is not in use, then we pass the code along as-is.
>     Even though Unix exit codes are unsigned, this usually works OK
>     because the integer representation, and "-1" ends up as "255". But
>     it's not something we should rely on, and we've tried to avoid it
>     elsewhere. E.g. in 5391e94813 (branch: remove negative exit code,
>     2022-03-29) and 246f0edec0 (execv_dashed_external: stop exiting with
>     negative code, 2017-01-06) and probably others.
>
>   - when --exit-code is in use, we ignore the incoming "status" variable
>     entirely, and rely on the "has_changes" field. But if we saw an
>     error, this field is almost certainly invalid, and means we'd likely
>     just say "no changes", which is completely bogus. Likewise for
>     the "--check" format.

Inspecting some callers of diff_result_code() further finds
curiosities.  wt-status.c for example feeds results form
run_diff_index() and run_diff_files() to the function, neither of
which returns anything other than 0. They die or exit(128)
themselves, though, so they are OK without this fix.
builtin/describe.c is also in the same boat with its use of
run_diff_index().

But of course the presense of such codepaths does not invalidate the
fix in your patch.

> So let's intercept the negative value here and return an appropriate
> code before even considering --exit-code, etc. And while doing so, we
> can swap out the negative value for a more normal exit code.

Good.  As you said, this is not an ungent regression fix, but I'd
prefer to see us look at all the current callers, as I wonder if
there are positive non-zero numbers coming from some callers, and
possibly design how this code should react to such "result" coming
in.

Again, thanks, both.
