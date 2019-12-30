Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03682C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C780C20409
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rgAgy1Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfL3RCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:02:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53884 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfL3RCY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 12:02:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10FF230979;
        Mon, 30 Dec 2019 12:02:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xNOpIuJeIDDS7DnkKTaZ0gFdF8E=; b=rgAgy1
        Eec9OWgBrOGYhl1Zgjv4KPr2RkLarOcZlVft0ZlrStns5nfzhGrw/9TZefau8coD
        qc+PxV1FRb3JgCxh48uQ/5WZ20GEu07eu6QZCHLmKjs4WZ3T6SiOFTaWCQgl8Aog
        k36G2WgoSCi4ywU63wWCv0iVW2wLweQZxSLOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fEkUCyXn+7KdW/GvYqnkuWMldlwXhsD7
        YQQmatdMztqTDDX1+3yA9094FoLxocAKiuMkmJVRGpbN80BxhXXFGiopOspG1Hc5
        1GZkZT5joiTcluMoULWXPLmYX+IopiOylL4hdbl1Tyk5l8GIz+a8nwjerD9MDBgM
        oWxf9xoy33g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC90F30978;
        Mon, 30 Dec 2019 12:02:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48A1E30977;
        Mon, 30 Dec 2019 12:02:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <20191222093036.GA3449072@coredump.intra.peff.net>
        <e9a4e4ff-5466-dc39-c3f5-c9a8b8f2f11d@gmail.com>
        <20191229062414.GC220034@coredump.intra.peff.net>
Date:   Mon, 30 Dec 2019 09:02:19 -0800
In-Reply-To: <20191229062414.GC220034@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 29 Dec 2019 01:24:14 -0500")
Message-ID: <xmqqsgl1hhlw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24BC0974-2B26-11EA-96B9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is holding internal state in diff_options, but the same
> diff_options is often used for multiple diffs (e.g., "git log --raw"
> would use the same rev_info.diffopt over and over again).
>
> So it would need to be cleared between diffs. There's a similar feature
> in the "has_changes" flag, though it looks like it is cleared manually
> by callers. Yuck.

Do you mean we want reset_per_invocation_part_of_diff_options()
helper or something?

> I actually wonder if this could be rolled into the has_changes and
> diff_can_quit_early() feature. This really just a generalization of that
> feature (which is like setting max_changes to "1").

Yeah, I wondered about the same thing, after seeing the impressive
numbers ;-)
