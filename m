Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B38C43468
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A2720708
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 16:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AZkgwvcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgIUQNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:13:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52857 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgIUQNC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 12:13:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2BE584049;
        Mon, 21 Sep 2020 12:12:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bt6r4p0EJaPKvXwhX8TzTRYtAZs=; b=AZkgwv
        czv/+qFNWLntAVXUnpyeU9UlEexCL3NYjyoIt0gtja75D+ouF5dSRwRT4N+BPlMq
        zLmWglerzLD+VgeFEeijmM1+DkkpwKdngD0bUnUkJwjQpmDWT54ozlb7WMaLmEKq
        UxhfwQl8FJnlY+Q659dJ1GUuVfsM8pd7QZq2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZxIvJQWBSHc41RiGREEZNNxxvfwFdShu
        eefAMOQUR+yXS5yin45qeZTV9T/9ogv+Y1uIh7wzYmcRh7S0uZQMiZqk8asJZvab
        vQbLKA6M6Q/vLuKqxyytl6nMXVdQvsfoWCFd4v8CVaVdZGu2yjxziVHWIrdI7or4
        V9Zh0j640oM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA2E284048;
        Mon, 21 Sep 2020 12:12:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F09C84047;
        Mon, 21 Sep 2020 12:12:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] push: add reflog check for "--force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-2-shrinidhi.kaushik@gmail.com>
        <xmqqft7djzz0.fsf@gitster.c.googlers.com>
        <f6bb2b1f-0f1b-f196-59f1-893580430cf2@gmail.com>
Date:   Mon, 21 Sep 2020 09:12:58 -0700
In-Reply-To: <f6bb2b1f-0f1b-f196-59f1-893580430cf2@gmail.com> (Phillip Wood's
        message of "Mon, 21 Sep 2020 14:19:24 +0100")
Message-ID: <xmqqv9g7f6r9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5135E710-FC25-11EA-8AFE-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> As I said before[1] I think we should also be checking the reflog
> dates so that we do not look at any local reflog entries that are
> older than the most recent reflog entry for the remote tracking
> branch. This protects against a background fetch when the remote has
> been rewound and it would also reduce the number of calls to
> in_merge_bases().

Meaning we first check the timestamp of the topmost reflog entry of
remote-tracking branch (i.e. the time *we* acquired the tip commit
that we are about to lose), and leverage on the fact that no local
commit older than that timestamp can possibly be written with the
knowledge of that remote work?  Assuming that local timestamp is
monotonically increasing, it is a quite valid optimization (and the
clock skew we often talk about in the context of revision traversal
are often discrepancy between matchines).

Having said that.

The new generation number based on (adjusted) timestamp is being
worked in, and that work is supposed to bring such an optimization
to us automatically (at least on the reachability's side, i.e. logic
that uses get_merge_bases()), I think, so we probably do *not* want
to add such a heuristics specifically for this codepath.

Thanks.
