Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58C0C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8749A60E53
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhJMSFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:05:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53990 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSFw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 14:05:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3C2815428C;
        Wed, 13 Oct 2021 14:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ip5XCsOuwotTBS6mIHcBA5bDiUkwRmJXcDRSGG
        BW6AE=; b=Pq4Xz3Fa1FOmgVLESBmW1iFJA7V8pcAASZstmYQhbl3djpHLO2sAeC
        nwZz0PvKbL8ZWeLvJ84W4mP3k3SG0u+3D3iWEpm2UdLW1K+sdNiiDuwAfkG5p08b
        ubHbgl0wkM3hKR/HuXeq99mf+BDQvgmQHBpE8azMlMWVEOETyKeb8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C919D15428B;
        Wed, 13 Oct 2021 14:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 42542154287;
        Wed, 13 Oct 2021 14:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] mergetools/xxdiff: prevent segfaults from stopping
 difftool
References: <20211013024539.49612-1-davvid@gmail.com>
Date:   Wed, 13 Oct 2021 11:03:43 -0700
In-Reply-To: <20211013024539.49612-1-davvid@gmail.com> (David Aguilar's
        message of "Tue, 12 Oct 2021 19:45:39 -0700")
Message-ID: <xmqqlf2whke8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7B1DD2E-2C4F-11EC-B355-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Users often use "git difftool HEAD^" to review their work, and have
> "mergetool.prompt" set to false so that difftool does not prompt them
> before diffing each file.
>
> This is very convenient because users can see all their diffs by
> reviewing the xxdiff windows one at a time.
>
> A problem occurs when xxdiff encounters some binary files.
> It can segfault and return exit code 128, which is special-cased
> by git-difftool-helper as being an extraordinary situation that
> aborts the process.
>
> Suppress the exit code from xxdiff in its diff_cmd() implementation
> when we see exit code 128 so that the GIT_EXTERNAL_DIFF loop continues
> on uninterrupted to the next file rather than aborting when it
> encounters the first binary file.

Sounds like a reasonable workaround, but I wonder if this should be
limited to "when xxdiff segfaults" (in other words, if it is common
for other difftool backends to exit with status 128, perhaps a
better workaround might be to teach difftool-helper that 128 is not
all that special?), and if the answer is yes (in other words, no, it
is not common among other backends and 128 from xxdiff is very
special), if we can easily and cheaply avoid running xxdiff on
binaries---that way, other exists from xxdiff with status 128 can
still be treated as an extraordinary situation.

In any case, the above is a thinking-aloud by somebody who does not
use xxdiff himself, and should not be taken as "I think this patch
is not good enough" at all.

Will queue.  Thanks.

> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  mergetools/xxdiff | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mergetools/xxdiff b/mergetools/xxdiff
> index ce5b8e9f29..d5ce467995 100644
> --- a/mergetools/xxdiff
> +++ b/mergetools/xxdiff
> @@ -3,6 +3,13 @@ diff_cmd () {
>  		-R 'Accel.Search: "Ctrl+F"' \
>  		-R 'Accel.SearchForward: "Ctrl+G"' \
>  		"$LOCAL" "$REMOTE"
> +
> +	# xxdiff can segfault on binary files which are often uninteresting.
> +	# Do not allow segfaults to stop us from continuing on to the next file.
> +	if test $? = 128
> +	then
> +		return 1
> +	fi
>  }
>  
>  merge_cmd () {
