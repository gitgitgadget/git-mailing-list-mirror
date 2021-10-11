Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9CEC433FE
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A4360C4B
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbhJKPzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 11:55:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54617 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhJKPzR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 11:55:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64F1E161A73;
        Mon, 11 Oct 2021 11:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=99jzrUASHet35kg120bI4DNGUCH7Gj/RD15ThX
        kn4rk=; b=lcjFs+CPAE3oIFdBJJOFBRkHN6BcaaLyEpVtzPuzIbnj2U/yLuVnbc
        ob/94Os4A+E6xiaY+OG8yOWCfEB8qIJM0WQF6yJtLMT8jdorn9oI0ejHNzdszMRU
        AjMjYgIAM7GW7Q+y8c0P660Ob3oW0pMkeYWZPLA+ZYI0CfQ+M64g0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D587161A72;
        Mon, 11 Oct 2021 11:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B409C161A71;
        Mon, 11 Oct 2021 11:53:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: add test testing MIME for created archive
 through compression filter
References: <20211011112712.475306-1-bagasdotme@gmail.com>
Date:   Mon, 11 Oct 2021 08:53:11 -0700
In-Reply-To: <20211011112712.475306-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Mon, 11 Oct 2021 18:27:13 +0700")
Message-ID: <xmqqlf2zd0d4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56E92568-2AAB-11EC-9AB7-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> +test_expect_success GZIP,BZIP2,XZ 'git archive with gzip, bzip2, and xz filters creates compressed tar archive with proper MIME type' '
> +	git config tar.tar.bz2.command "bzip2 -c" &&
> +	git config tar.tar.xz.command "xz -c" &&
> +	git archive --output HEAD.tar.gz --prefix=src/ HEAD &&

I think a lot more portable and robust way to test the feature is to
configure git config tar.tar.test.command (or come up with a name for
a suffix to be used in the test), point it at a script created in this
test script and run git archive with output filename that would trigger
the command.  Then, arrange the test to notice if the "test" script was
called with expected command line arguments and standard input.

That way, you do not need to rely on prereqs and you do not have to
resort to un-portable use of the "file" command.  After all, you are
*not* testing if "bzip2 -c" the user happens to have on their $PATH
produces output their "find" recognises as bzip2 compressed.

