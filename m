Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D0C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 23:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiIZXDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 19:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiIZXC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 19:02:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124DCA74CF
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 16:02:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7169F1CE617;
        Mon, 26 Sep 2022 19:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FtN8pQujr2njZgfKztM5vvr51G5cFpeBQLQ1nL
        xUuQo=; b=uirflTpCv8ms+Y3AzuPi3p0FMvtpo8dDJYvFEJ9KGDfuvRW8zur47X
        Wz8RaII++xAavGn//i2tY2LzQDPvO7dMGVNT2ztpE54jwHUUjVBegoqvUfVA/NEF
        P6j7ca/CspI0C6O4iq8KxKQiIxznPb5qFveRunUlFsLVf2vZT+1nQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A5001CE616;
        Mon, 26 Sep 2022 19:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 13AEF1CE612;
        Mon, 26 Sep 2022 19:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] read-cache: avoid misaligned reads in index v4
References: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
        <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net>
        <YzH4rDpHXdeLURSN@coredump.intra.peff.net>
        <YzH+IPFBGleIsAUe@coredump.intra.peff.net>
Date:   Mon, 26 Sep 2022 16:02:49 -0700
In-Reply-To: <YzH+IPFBGleIsAUe@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 26 Sep 2022 15:31:44 -0400")
Message-ID: <xmqqmtalagdi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58948A94-3DEF-11ED-8059-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do find it a bit more straight-forward, but the extra copy is ugly,
> plus the "yuck" comment.

Yeah, the "yuck" memcpy() is, eh, unfortunate.  Consistently using a
single "pointer" (pos) to keep track of where we are does make the
structure of the code appear uniform and easier to follow, though.

