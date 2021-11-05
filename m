Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9937FC433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 19:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725A66120D
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 19:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhKETOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 15:14:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54665 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhKETOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 15:14:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE7EC14FE77;
        Fri,  5 Nov 2021 15:11:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+OcHo833ZLYbgXbf+LDoMTish65EqUV9mXbyUH
        Xfw80=; b=qZSCIkRSKCd2W+9YgM+FJ8oE8QKj+sZ7oHeSwLx/A3be1UvLGdbzrK
        hX96PJ6xvnzCP84/sfql55+8VqsQCSroDsRXfAbPx9BlMM4Ty45jSB0TGMvU044e
        XGE8sHzenLeYzdun92ymUbpwKn3H5VA7hO6+szSgiVHLkkEYGFzCc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6B5E14FE73;
        Fri,  5 Nov 2021 15:11:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 439E514FE70;
        Fri,  5 Nov 2021 15:11:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <xmqq7ddn3dlt.fsf@gitster.g> <20211105112525.GA25887@dinwoodie.org>
        <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
        <xmqqk0hmxyw0.fsf@gitster.g>
        <CA+kUOa=vqFNXe2QKc8K31OLL0zkEsK7wAk6hPMxjQJNVM7PsGQ@mail.gmail.com>
Date:   Fri, 05 Nov 2021 12:11:18 -0700
In-Reply-To: <CA+kUOa=vqFNXe2QKc8K31OLL0zkEsK7wAk6hPMxjQJNVM7PsGQ@mail.gmail.com>
        (Adam Dinwoodie's message of "Fri, 5 Nov 2021 18:49:14 +0000")
Message-ID: <xmqqv916wh7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28C369A8-3E6C-11EC-A23B-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> This is probably a much broader conversation. I remember when I first
> started packaging Git for Cygwin, I produced a release that didn't
> have support for HTTPS URLs due to a missing dependency in my build
> environment. The build and test suite all passed -- it assumed I just
> wanted to build a release that didn't have HTTPS support -- so some
> relatively critical function was silently skipped. I don't know how to
> avoid that sort of issue other than relying on (a) user bug (or at
> least missing function) reports and (b) folk building Git for
> themselves/others periodically going through the output of the
> configure scripts and the skipped subtests to make sure only expected
> things get missed; neither of those options seem great to me.

I agree with you that there needs a good way to enumerate what the
unsatisfied prerequisites for a particular build are.  That would
have helped in your HTTPS situation.

But that is a separate issue how we should determine a lazy
prerequisite for any feature is satisified.

"We have this feature that our code utilizes. If it is not working
correctly, then we can expect our code that depends on it would not
work, and it is no use testing" is what the test prerequisite system
tries to achieve.  That is quite different from "the frotz feature
could work here as we see a binary /usr/bin/frotz installed, so
let's go test our code that depends on it---we'll find out if the
installed frotz is not what we expect, or way too old to help our
code, as the test will break and let us notice."
