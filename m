Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C2DC433EF
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 00:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiC0At3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 20:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiC0At2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 20:49:28 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEE85D5C8
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 17:47:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CADED124CF1;
        Sat, 26 Mar 2022 20:47:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o8XnB5TwO9yeVNDpsvtM083HVA/2BvAlVIABmW
        jFeYc=; b=XVLEIxMB/egf66G9/B9w5UdqAIo8XGdwJY2xLiCOIorqtpEjfdmmiB
        jO9MI6MWDMeJGmVswavB8WkFfkNXvvMCvOpHgm1wDYAJuGu8ncMnh/gzUwnnoBW4
        uXkryBhGltSaZcoxqEw25VNY2RpJpfiCEAYOPJitfv/cjb5z4rJxk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2934124CF0;
        Sat, 26 Mar 2022 20:47:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36967124CEF;
        Sat, 26 Mar 2022 20:47:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tone Kastlunger <users.giulietta@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Path differences between git status & git status --porcelain
References: <CAHCc5YXmegAV-sSpLLpY19rXhnxYEgM+RzZHJ=saG8nD5HsGKg@mail.gmail.com>
Date:   Sat, 26 Mar 2022 17:47:47 -0700
In-Reply-To: <CAHCc5YXmegAV-sSpLLpY19rXhnxYEgM+RzZHJ=saG8nD5HsGKg@mail.gmail.com>
        (Tone Kastlunger's message of "Sat, 26 Mar 2022 11:25:30 +0200")
Message-ID: <xmqqzglc5ih8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85F687A8-AD67-11EC-AD8A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tone Kastlunger <users.giulietta@gmail.com> writes:

> "git status --porcelain"  output from the same location:
>
>     ....cutted stuff to keep things clean...
>        M src/api/db.py   <---- Notice the missing ".." in front of the
> (modified) file path.
>
> Is this intentional/expected behaviour; and if not, we were wondering
> if this is a known issue?

Yes, this is working as designed and any future versions of Git will
not change it.  Scripts can forever rely on the fact that it can get
paths relative to the root of the working tree regardless of where
in the working tree they start.

You can add this:

    [status]
	relativepaths=no

to your ~/.gitconfig and "git status" (without --porcelain option)
will also show paths relative to the root of the working tree
(i.e. without ugly ../ prefix).

We made --porcelain=v2 to get affected by the status.relativepaths
configuration, which may probably have been a mistake, but that is
also too late to fix now.  It defaults to show paths relative to the
directory the command happened to be run, and in order to get a
reliable output, the calling script must override status.relativepaths
configuration variable the end-user may have, e.g.

    git -c status.relativepaths=no status --porcelain=v2





