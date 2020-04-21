Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECD0C38A30
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 01:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4A12070B
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 01:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dc4Fku3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUBRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:17:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64260 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDUBRI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 21:17:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 685975B382;
        Mon, 20 Apr 2020 21:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aGQsbKeWRloDC0Nnj6F/SrR5JHc=; b=dc4Fku
        3XVtvhofl85SZfkbX8fnJHr5Rrj/feATwrlvS18HICxketuDAy/hR+DB1tufJReU
        wQZHoATHOEh6/oCDECB1/Kip408YL0nBg4xOER+jlFjc0z4MlGT3PfIO9U0u8l80
        YEqucoOh/18uQlhdgKKDOvssF4+mDt0y3uT/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ve5xqP8GvP+vldhX93V8c8AHGRQn8UhP
        uI6AquEqWIOKLIlmR/MBwkNTYyvVHhcepk04PnlVgZDr4o32IlIF7Wxdj2i9Roih
        PJVXACzIsBC8pCCwfwK0UOanJIqX4QSBEyU62hcnHUt4Pezp/8YERPsBgnkXlMhN
        RRcEAlLYdgo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D45A5B381;
        Mon, 20 Apr 2020 21:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C920C5B380;
        Mon, 20 Apr 2020 21:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: Re: [PATCH 0/3] commit-graph: write non-split graphs as read-only
References: <cover.1587422630.git.me@ttaylorr.com>
        <xmqq5zdtrbby.fsf@gitster.c.googlers.com>
        <20200420233907.GA97996@syl.local>
Date:   Mon, 20 Apr 2020 18:17:05 -0700
In-Reply-To: <20200420233907.GA97996@syl.local> (Taylor Blau's message of
        "Mon, 20 Apr 2020 17:39:07 -0600")
Message-ID: <xmqqlfmpprhq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D05985AA-836D-11EA-87FB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>   * do want to respect core.sharedRepository, in which case the
>     current behavior of always setting split-graph permissions to '0444'
>     is wrong, or

Yes, I would say "always 0444" is wrong.

>   * we do not want to respect core.sharedRepository, in which case these
>     patches are doing what we want by setting all commit-graph files to
>     have read-only permissions.
>
> My hunch is that we do not want to abide by core.sharedRepository here
> for the same reason that, say, loose objects are read-only. What do you
> think?

I thought that adjusting perm for sharedRepository is orthogonal to
the read-only vs read-write.  If a file ought to be writable by the
owner, we would make it group writable in a group shared repository.
If a file is readable by the owner, we make sure it is readable by
group in such a repository (and we do not want to flip write bit
on).  That happens by calling path.c::calc_shared_perm().

