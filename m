Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D4B1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 03:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfJODHP (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 23:07:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55191 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfJODHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 23:07:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0A20268FD;
        Mon, 14 Oct 2019 23:07:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9vORkLyS0KQujNAfJ9jhcbjwnNI=; b=lVWKxP
        1y0yxEjniNrkbCKyW7Nj6zAawwN9AW6Ta9O46LHtp12CT4jVf++hnVsFfnay5pC8
        DK5AT26e5nSzGIk8wnvu6T7LE57nEJGXPCDAyWMlD+Ag9d7kRVD5pUbOE0UdPEpD
        ZrCIH0/sdBGahEodlIgrOH1GKpHypSV6WPk08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I+8sg4Bq7xErXoey7cpdwXdbcr2yNlEo
        Kf/7ItF6xSDWSkhLIvSb63jpOKBn67lhoRNOQGDbqbcKyuA7csl24Kw/wtivSnoV
        biRnDbieUJokPDwNXYiuVPNFohZF+0q+jVu0tUfEL6sz7bFJyUUHLcOMRP5oKqig
        g2jCPqBfAc4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E971E268FC;
        Mon, 14 Oct 2019 23:07:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 585EF268FB;
        Mon, 14 Oct 2019 23:07:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH 1/1] Teach remote add the --prefix-tags option
References: <cover.1571089481.git.wink@saville.com>
        <d47c5de5fc812b1fbd04bb259a522e453d4b21e2.1571089481.git.wink@saville.com>
Date:   Tue, 15 Oct 2019 12:07:08 +0900
In-Reply-To: <d47c5de5fc812b1fbd04bb259a522e453d4b21e2.1571089481.git.wink@saville.com>
        (Wink Saville's message of "Mon, 14 Oct 2019 15:01:00 -0700")
Message-ID: <xmqq4l0ad7vn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E04B2464-EEF8-11E9-9997-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> When --prefix-tags is passed to `git remote add` the tagopt is set to
> --prefix-tags and a second fetch line is added so tags are placed in
> a separate hierarchy per remote.


In the olden days, there was no refs/remotes/$remoteName/ hiearchy,
and until we made it the default at around Git 1.5.0, such a modern
layout for the branches were called the "separate remote" layout,
and can be opted into with "clone --use-separate-remote" by early
adopters.

I doubt that use of refs/tags/$remoteName/ is a good design if we
want to achieve similar isolation between local tags and and tags
obtained from each remote.

An obvious alternative, refs/remotes/$remoteName/tags/, is not a
good design for exactly the same reason.  You cannot tell between a
local tag foo/bar and a tag bar obtained from remote foo when you
see refs/tags/foo/bar, and you cannot tell between a branch tag/bar
obtained from remote foo and a tag bar obtained from remote foo when
you see refs/remotes/foo/tags/bar.  In the past, people suggested to
use refs/remoteTags/$remoteName/ for proper isolation, and it might
be a better middle-ground than either of the two, at least in the
shorter term, but not ideal.

In short, if you truly want to see "separate hierarchy per remote",
you should consider how you can reliably implement an equivalent of
"git branch --list --remote"; a design that does not allow it is a
failure.

A better solution with longer lifetime would probably be to use

	refs/remotes/$remoteName/{heads,tags,...}/

when core.useTotallySeparateRemote configuration exists (and
eventually at Git 3.0 make the layout the default).  It would
involve changes in the refname look-up rules, but it would not have
to pollute refs/ namespace like the refs/remoteTags/ half-ground
design, which would require us to add refs/remoteNotes/ and friends,
who knows how many more we would end up having to support if we go
that route.

Thanks.



