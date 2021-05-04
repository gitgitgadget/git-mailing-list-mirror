Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40EC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 03:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0E3611CB
	for <git@archiver.kernel.org>; Tue,  4 May 2021 03:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhEDDrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 23:47:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55123 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhEDDrI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 23:47:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AE2DC3D76;
        Mon,  3 May 2021 23:46:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E3+u4XWWzFuqq8vcpiqIVx5tQjQMa4Fxu25y98
        GEEkY=; b=bO+bLmiXpwN/mpP1ECRYK53lHHWDqemrRqkqtdU5fB2cJZzzEsTLdQ
        Yf2zcRNODMC+sZGaX1Xjv7CaW6N0itNQrhXT2TFtv37FtnAnOY8dOA4DfsT8SEuc
        79K0hBSsvg7DVpXC3C9I+rmHXrZW1pbnZvnnRf/aq5pA9dAihIuyY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52ADFC3D75;
        Mon,  3 May 2021 23:46:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0037C3D74;
        Mon,  3 May 2021 23:46:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Mark Amery <markrobertamery@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
        <YJCABtAGT7s70jl1@camp.crustytoothpaste.net>
Date:   Tue, 04 May 2021 12:46:12 +0900
In-Reply-To: <YJCABtAGT7s70jl1@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 3 May 2021 22:58:14 +0000")
Message-ID: <xmqqfsz36u0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45EFDDD6-AC8B-11EB-B8FC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Yeah, this is because your operating system returns EINVAL in this case.
> POSIX specifies EINVAL when you're trying to make a directory a
> subdirectory of itself.  Which, I mean, I guess is a valid
> interpretation here, but it of course makes renaming the path needlessly
> difficult.
> ...
> I suspect part of the problem here is two fold: on macOS we can't
> distinguish an attempt to rename the path due to it folding or
> canonicalizing to the same thing from a real attempt to move an actual
> directory into itself.  The latter would be a problem we'd want to
> report, and the former is not.  Unfortunately, detecting this is
> difficult because that means we'd have to implement the macOS
> canonicalization algorithm in Git and we don't want to do that.

I agree we'd probably need to resort to macOS specific hack (like we
have NFS or Coda specific hacks), but it may not be too bad.

After seeing EINVAL, we can lstat src 'foo' and dst 'FOO', and
realize that both are directories and have the same st_dev/st_ino,
which should be fairly straightforward, no?

For that, we do not exactly have to depend on any part of macOS-ism;
we do depend on the traditional "within the same device, inum is a
good way to tell if two filesystem entities are the same".

The (mis)design of "git mv a b c d ... DST" that turns the request
into "mv a DST/a && mv b DST/b && ..." too early may make the
fallback behaviour a bit cumbersome to implement (mainly, we need to
strip out the '/foo' part out of the failing dst FOO/foo to get the
real destination directory 'FOO' the user gave us, before checking
with that lstat dance), but since it is an error codepath, we can be
as inefficient as we like, as long as we are correct ;-)

