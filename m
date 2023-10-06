Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340B5E94139
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjJFWfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjJFWfb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:35:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7BA83
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:35:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77F9C1DD75;
        Fri,  6 Oct 2023 18:35:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=GEJoA32UhEh/FRosNQDxxQHhcw0oA7aLp+hhF5
        oCZ50=; b=sAGqucWiAGxLNx9BiS958WcJo/goRM6wmtfdcxa1KtLzS2okUjK7wZ
        XZq2nZzAx/hDFgAkUe+avAmjT+KNyKMaLJC0a64GKBfV9zBzPhX0FQFVq+zxvxLR
        FpMJeDKZuTegqffUx8+YbR1h9Z6vSXZ0r0cGoiKWL1cDZWOlj/TyM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F3541DD74;
        Fri,  6 Oct 2023 18:35:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6A4B1DD73;
        Fri,  6 Oct 2023 18:35:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for
 `--write-pack`
In-Reply-To: <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 6 Oct 2023 18:02:07 -0400")
References: <cover.1696629697.git.me@ttaylorr.com>
        <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
Date:   Fri, 06 Oct 2023 15:35:25 -0700
Message-ID: <xmqqil7j751u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A581ABEA-6498-11EE-9530-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When using merge-tree often within a repository[^1], it is possible to
> generate a relatively large number of loose objects, which can result in
> degraded performance, and inode exhaustion in extreme cases.

Well, be it "git merge-tree" or "git merge", new loose objects tend
to accumulate until "gc" kicks in, so it is not a new problem for
mere mortals, is it?

As one "interesting" use case of "merge-tree" is for a Git hosting
site with bare repositories to offer trial merges, without which
majority of the object their repositories acquire would have been in
packs pushed by their users, "Gee, loose objects consume many inodes
in exchange for easier selective pruning" becomes an issue, right?

Just like it hurts performance to have too many loose object files,
presumably it would also hurt performance to keep too many packs,
each came from such a trial merge.  Do we have a "gc" story offered
for these packs created by the new feature?  E.g., "once merge-tree
is done creating a trial merge, we can discard the objects created
in the pack, because we never expose new objects in the pack to the
outside, processes running simultaneously, so instead closing the
new packfile by calling flush_bulk_checkin_packfile(), we can safely
unlink the temporary pack.  We do not even need to spend cycles to
run a gc that requires cycles to enumerate what is still reachable",
or something like that?

Thanks.
