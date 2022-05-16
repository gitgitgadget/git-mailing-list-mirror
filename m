Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F257C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 05:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiEPF5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 01:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbiEPF5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 01:57:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173FBF6D
        for <git@vger.kernel.org>; Sun, 15 May 2022 22:57:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94889121DA2;
        Mon, 16 May 2022 01:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=wTYVMN30UNsTFTm1+E0mkKofE
        dEpzGIiXGcRtN3Y+d4=; b=t1x4WgZjSyNxLYUKfKVWRQ/htTHSQQP7JgDY/A8Ny
        qGsVQ6sI7mlnfUZVANz+qdxlXZx9plw0046Xe1AzSVg/Rm9ZNRF6ajuq0/yYPUo/
        1wojZDYlYqJCWCKlHzYgAuIQSXg/GYU9KELOVy3Fpo5GqqQ2bp5NbGOE+AoMM6+k
        /4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 879D9121DA0;
        Mon, 16 May 2022 01:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C411A121D9D;
        Mon, 16 May 2022 01:57:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Carlos L." <00xc@protonmail.com>
Subject: Re: [PATCH] grep: add --max-count command line option
References: <pull.1264.git.git.1652361610103.gitgitgadget@gmail.com>
Date:   Sun, 15 May 2022 22:57:04 -0700
Message-ID: <xmqqilq658b3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03CD9E54-D4DD-11EC-B16F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlos L. via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Carlos=3D20L=3DC3=3DB3pez?=3D <00xc@protonmail.com>

Offtopic, but I wonder why this line is encoded like so?  The
"Signed-off-by:" line is not, and it is safely transmitted, so
it feels like we do not need to encode the in-body header that
is added only for e-mail but not in the original commit...

> This patch adds a command line option analogous to that of GNU
> grep(1)'s -m / --max-count, which users might already be used to.
> This makes it possible to limit the amount of matches shown in the
> output while keeping the functionality of other options such as -C
> (show code context) or -p (show containing function), which would be
> difficult to do with a shell pipeline (e.g. head(1)).
>
> Signed-off-by: Carlos L=C3=B3pez <00xc@protonmail.com>
> ---
> ...
> +-m <num>::
> +--max-count <num>::
> +	Limit the amount of matches per file. When using the -v or
> +	--invert-match option, the search stops after the specified
> +	number of non-matches. Setting this option to 0 has no effect.
> +

Good thing that this is defined as "per-file" limit.  If it were a
global limit, the interaction between this one and "--threads=3D<num>"
would have been interesting.  Perhaps add a test to make sure the
feature continues to work with "--threads=3D2" (I am assuming that you
have already tested this implementation works with the option).

Martin already commented on the wording "no effect"; I agree it is a
poor choice of words from the point of view of "overriding with 0".

It indeed is curious why GNU grep chose to immediately exit with 1
when "-m 0" was given, but that was decision made more than 20 years
ago (http://gnu.ist.utl.pt/software/grep/changes.html and look for
"2000-03-17").  Between "being consistent even with a seemingly
useless design choice made by somebody else" and "choose to be
different in a corner case where nobody should care and allow us to
be more useful", I am slightly in favor in this particular case.

What "git grep -m -1" should do?  IIRC, OPT_INTEGER is for signed
integer but the new .max_count member, as well as the existing
"count" that is compared with it, are of "unsigned" type.  Either
erroring out or treating it as unlimited is probably fine, but
whatever we do, we should document and have a test for it.

Thanks.



