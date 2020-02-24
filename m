Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2279EC38BE2
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E674F21556
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uAJKa8QF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgBXUw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:52:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50591 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgBXUwz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 15:52:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2A4948208;
        Mon, 24 Feb 2020 15:52:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Srrp/8dPxaxqs0RXtEZIp7k1Jk=; b=uAJKa8
        QF0lHymwH4md1Fq/ALx3/Tf4/G8A1V3o+hIHcfmoiCZTRf+y0S8nMZ5jt4QfaIa+
        ihEslcotT/sS6hG9EWdW0lqOT2xRh8Tw13D/TGD4fX2KK0v7g3JGleUursFrA2Og
        n/hJS+ApgIn5e6pQuiYUDUw/mYKf2Igr2fW2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SIeIxUfvUOWuprJOS/UiYd/HMHTL0Hgs
        +LohLojBul9Q2UxmWAs81AKhqeBPl1MBnjem3kggPQ9hlSlXlUPBv20LVHCVZtrI
        JToXeH+BEBd3m7XVZHlU+1bBksBXOMyFpk/waNF8dA9DIWOgJ/KtO6tR359LY4Jb
        kUr1kw3j9fE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9130748207;
        Mon, 24 Feb 2020 15:52:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D57FD48206;
        Mon, 24 Feb 2020 15:52:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Benno Evers <benno@bmevers.de>
Cc:     git@vger.kernel.org, spearce@spearce.org
Subject: Re: [PATCH] describe: dont abort too early when searching tags
References: <20200223125102.6697-1-benno@bmevers.de>
Date:   Mon, 24 Feb 2020 12:52:52 -0800
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de> (Benno Evers's message
        of "Sun, 23 Feb 2020 13:51:02 +0100")
Message-ID: <xmqq4kvfpv17.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0B800F8-5747-11EA-A9EF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Benno Evers <benno@bmevers.de> writes:

> When searching the commit graph for tag candidates, `git-describe`
> will stop as soon as there is only one active branch left and
> it already found an annotated tag as a candidate.
>
> This works well as long as all branches eventually connect back
> to a common root, but if the tags are found across branches
> with no common ancestor
>
>                   B
>                   o----.
>                         \
>           o-----o---o----x
>           A
>
> it can happen that the search on one branch terminates prematurely
> because a tag was found on another, independent branch. This scenario
> isn't quite as obscure as it sounds, since cloning with a limited
> depth often introduces many independent "dead ends" into the commit
> graph.
>
> The help text of `git-describe` states pretty clearly that when
> describing a commit D, the number appended to the emitted tag X should
> correspond to the number of commits found by `git log X..D`.

To be fair, that description was written for the case in a normal
history with only a single root.

How much, if any, does this change hurt the performance by forcing
the code to dig further if there aren't multiple roots?  If there is
such an unnecessary overhead that degrades performance for the more
common case, can we improve it further to avoid it?

Thanks.



