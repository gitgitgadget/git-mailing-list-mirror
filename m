Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA3BC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52CC20715
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fUtTv8uR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfKUN3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:29:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65093 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfKUN3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 08:29:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2FFA320CD;
        Thu, 21 Nov 2019 08:29:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=daOTj0W070npBQFboPYEu7vFgzA=; b=fUtTv8
        uRj624sSvf2iz8mMeRXwTSWrR3aTA8Ob7ZSaedoJN2tn57mvvtd9CAwhpCnpj1OT
        sE+By1vgZHoicdiWmkmTaQIfjz5rsGsnNs3D+U0JnW8xQwYrCkrNNjFQTYqB+8sH
        2spiZ3vejwlCNlK2DmDzJk39I8HwBRJhBpnOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sOpsk2L1bVQNj642a+M0cM0KGB2W5H48
        inWe2HfUnl5Hj4PBoeG32bGIkK+oO/jKdnI7D35D44JbsOGT8YY4DFiZ58VLeAFl
        +GGxx0iZCmU33GXuQYIfmaok+oigPSJ3XnwWz2F5esoG+AEWgrjG5ESvasdXxvqX
        +bq8yiJI/DA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B39F320CC;
        Thu, 21 Nov 2019 08:29:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 094BD320CB;
        Thu, 21 Nov 2019 08:29:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     M Lewis <picevio@gmail.com>, git@vger.kernel.org
Subject: Re: GitAttributes feature export-ignore works, but -export-ignore (with dash) should also work
References: <01e0a4ab-d809-d968-5671-b731438c2bc4@gmail.com>
        <20191121075837.GA30966@sigill.intra.peff.net>
Date:   Thu, 21 Nov 2019 22:29:21 +0900
In-Reply-To: <20191121075837.GA30966@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 21 Nov 2019 02:58:37 -0500")
Message-ID: <xmqq5zjd8ij2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE2E3D6E-0C62-11EA-86BF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Now obviously there is recursion happening inside git-archive, as it
> walks the tree. And the current behavior is that it sees the ignored
> subtree and doesn't walk into it at all. So it _could_ make your
> original example work by actually searching within the tree for any
> paths marked -export-ignore, and including the directory if and only if
> it has unignored entries.
>
> I can't offhand think of anything that would break if we started doing
> that,...

If there is some effect we want to attach to a directory itself
without affecting the paths inside it, the current and original
design lets you express it naturally.  If we make a pattern that
match a directory to recurse, it is still possible to express it,
but it is a bit cumbersome, e.g.

	/directory	want-to-affect-this
	/directory/**	-want-to-affect-this

I would think.

Git generally does *not* track directories, so in a sense it is
arguable if it even makes sense to think about attaching an
attribute to a directory itself (as opposed to a non-directory
inside the directory) in the first place, though.



