Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D4FC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B732084E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 18:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nj5DHjxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgBDSse (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:48:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60240 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgBDSse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 13:48:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B508251D36;
        Tue,  4 Feb 2020 13:48:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fBJn9tCSGNQmTTSSz/akqoUp93g=; b=nj5DHj
        xcqimvWAcI1s84q5b3R67oM2KnOin5mKpjaZqov6ReFqABcRTIqSktaO+xjHCD5w
        ehNyeX+H1XXDLCthwG4LtNGMJdIFKh2G8c8fPqxfjXBi/v8x62jy1XIGe7qk95Pi
        MiG5qQMR0n/P9x5i6VH3C68/6VROvaQlbHbD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hz89JtpmpP/LvkuKviG4iqwGwBGGgm5K
        t/Qn5g2GWez8sF4HeHIPlJ1U9tkDSs+fXcmcpx0Afia74YfyCyNyR2VeMjH1l4pm
        nBNVfg4Cv6kpHkHqmzIj13K5ka2HivD5gCmYTrlBVVQIyOMvC71B+9ZkoybSjEta
        iVWUVncZXDE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACA7B51D35;
        Tue,  4 Feb 2020 13:48:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A02651D34;
        Tue,  4 Feb 2020 13:48:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 12/15] bugreport: count loose objects
References: <20200124033436.81097-1-emilyshaffer@google.com>
        <20200124033436.81097-13-emilyshaffer@google.com>
Date:   Tue, 04 Feb 2020 10:48:30 -0800
In-Reply-To: <20200124033436.81097-13-emilyshaffer@google.com>
        (emilyshaffer@google.com's message of "Thu, 23 Jan 2020 19:34:33
        -0800")
Message-ID: <xmqqd0au89z5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0E578E0-477E-11EA-A0EC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emilyshaffer@google.com writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> The number of unpacked objects in a user's repository may help us
> understand the root of the problem they're seeing, especially if a
> command is running unusually slowly.
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> The refactor removed much of the code Dscho suggested; and yet it
> remains true that he helped me while developing this commit (although
> his suggestions didn't survive). Shall I leave the Helped-by line or
> remove it?

You two collectively thought about viable alternatives and decided
to reject what was not wanted in the final result, and not having
that rejected code was good for the project, right?  If so, I would
say it still is the help that deserves recognition.  After all,
making the result better by removing things is harder than by adding
things ;-)

>  bugreport.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> ...

The patch text looked sensible.
