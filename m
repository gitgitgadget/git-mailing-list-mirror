Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1107EC433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 05:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB30B60EBB
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 05:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhJXFSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 01:18:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59564 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJXFSU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 01:18:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 685B5100A59;
        Sun, 24 Oct 2021 01:15:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7zKsnOUM1vMX/Va/fZcElSVMbugtPycEKlG4nf
        zzz2M=; b=kAGVrBCASt59RH+GRorp9n/9IvfIZ9uQm8fseUFhPuynRmWa/n/tyn
        WBvHckcy1llb3epZjO8vGN29VdGqBFC3qcjRCURoYIYA4Z6jRGjdDoAdgLpzGNLl
        woJ+x6E8l6jyC6rsP6S0DMToRhtDQWoxKyeEIKrximKUC2T/Ndi1U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FA69100A58;
        Sun, 24 Oct 2021 01:15:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8705100A57;
        Sun, 24 Oct 2021 01:15:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 3/3] pretty: add abbrev option to %(describe)
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
        <20211024014256.3569322-4-eschwartz@archlinux.org>
Date:   Sat, 23 Oct 2021 22:15:55 -0700
In-Reply-To: <20211024014256.3569322-4-eschwartz@archlinux.org> (Eli
        Schwartz's message of "Sat, 23 Oct 2021 21:42:56 -0400")
Message-ID: <xmqqv91n57g4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77E5CE3C-3489-11EC-8B07-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Schwartz <eschwartz@archlinux.org> writes:

> The %(describe) placeholder by default, like `git describe`, uses a
> seven-character abbreviated commit hash. This may not be sufficient to

"hash" -> "object name".

> fully describe all git repos, resulting in a placeholder replacement

"all git repos" -> "all commits in a given repository" (there may be
other valid way to clarify, but the point is that 'describe' does
not describe 'git repos' in the sense that my repository gets
description X while your repository gets description Y).

> changing its length because the repository grew in size. This could
> cause the output of git-archive to change.
>
> Add the --abbrev option to `git describe` to the placeholder interface
> in order to provide tools to the user for fine-tuning project defaults
> and ensure reproducible archives.

Note that it is sad that --abbrev=<n> does not necessarily ensure
reproducibility.  To be more precise, I do not think it sacrifices
uniqueness to make the output reproducible.  You can get more than N
hex-digits in the output if N is too small to ensure uniquness.

So it indeed is that this line of thought ...

> One alternative would be to just always specify --abbrev=40 but this may
> be a bit too biased...

... to use --abbrev=999 (because 40 is not the length of a full
object name in the SHA-2 world) is the only reasonable way, if what
you care about is the reproducibility.

    Side note.  I think "git describe --no-abbrev" is buggy in that
    it does not give a full object name; I didn't check the code,
    but it appears to be behaving the same way as "git describe
    --abbrev=0" (show no hexdigits).  Fixing this bug may possibly
    be a low-hanging fruit.

But even if the feature cannot be used to guarantee a full
reproducibility, it is a good thing that we can now add this feature
with minimum effort thanks to the previous two steps.

The refactoring I suggested in my review for the previous step will
shine, if we want to do a good job parsing the --abbrev=<n> option,
since such a code organization would make it a fairly easy addition
to introduce "integer" type that calls match_placeholder_arg_value()
to read the option value (like "string" does) and validate that the
value is indeed an integer.

Would we want to support "--contains" as another boolean type?  How
about "--all" and "--long"?  All three sound plausible candidates.

Thanks.
