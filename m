Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D477EC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34752051A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="atOv9y2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgCYGwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:52:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50873 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYGwt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:52:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F7A860DEE;
        Wed, 25 Mar 2020 02:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4uWNbmksvRSNlbr1XdAa1gTRcPQ=; b=atOv9y
        2SyKzjfonET+W5XXvrhZTjbfK+xoJRaps/2MNnR+cgueLan3p5hqStm24YN4rAad
        +AQLWbzLQhxvMZju2CsDqLnVJ4rOemtNMVh6A1WKL/dPDQ/LsXWdC7D7TrTd8NHL
        BQ2uMSyCW1vxG5ycax6E7fpgQ4Qmya7RvH6tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a25JXZiA4E9AV8+Uu4K5ERue5OhcaCHB
        +zeWW4mABuPkkdz5rIhill4W+iFU8qlteWclnljLqeFNXxfEAIMMzU07nwxOynKR
        V5fYXxJiMoVBiMptqh6tKMy9rzLUU4ALItUrCuMPa2xeCbw+E2eMHv9X3L4P+8ni
        8WCrGIffI5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2698A60DED;
        Wed, 25 Mar 2020 02:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1A9860DEC;
        Wed, 25 Mar 2020 02:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Daniel Sommermann <dcsommer@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [RFC PATCH] git-apply: Permit change of file mode when filename does not change
References: <20200324160054.1535824-1-dcsommer@gmail.com>
        <20200325061102.GD651138@coredump.intra.peff.net>
Date:   Tue, 24 Mar 2020 23:52:47 -0700
In-Reply-To: <20200325061102.GD651138@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 25 Mar 2020 02:11:02 -0400")
Message-ID: <xmqqeethx6ww.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CAB146C-6E65-11EA-B7F6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Mar 24, 2020 at 09:00:54AM -0700, Daniel Sommermann wrote:
>
>> The documentation for git's diff format does not expressly disallow
>> changing the mode of a file without splitting it into a delete and
>> create. Mercurial's `hg diff --git` in fact produces git diffs with such
>> format. When applying such patches in Git, this assert can be hit. The check
>> preventing this type of diff has been around since 2005 in
>> 3cca928d4aae691572ef9a73dcc29a04f66900a1.
>
> This description confused me for a moment, because in Git we generally
> refer to "mode changes" as flipping the executable bit. And anything
> further is a "type change" (and this isn't just academic; options like
> --diff-filter distinguish the two).

I too found that file "mode" made me confused and thought we reject
a patch that flips executable bits of files with or without touching
their contents.  You are talking about a patch that changes file
"type" between regular files and symbolic links, or worse yet,
regular files or symbolic links and submodules.

It sounds more like a documentation bug, or a bug in the reader of
the documentation.  It's not like what is not explicitly disallowed
are all allowed.

> And we do indeed allow a simple mode change like:
>
>   $ git show c9d4999155700651a37f4eb577cec1f4b5b8d6be --format=
>   diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
>   old mode 100644
>   new mode 100755
>
> But you're talking about typechanges here, and we do always represent
> those as a deletion/addition pair:

While I, like you said below, do not offhand think of a reason why
it may hurt if we allowed to express a replacement of a symbolic
link with a regular file that holds the result of readlink(2) as
pure mode bits change without (or even with) content change at the
mechanical level, I strongly suspect that we chose not to emit such
a patch on the "diff" side because it would be easily missed by
human readers, and that is why such a change is always shown as a
deletion followed by a creation.

And this safety was there in the oldest "still not yet fully but
started working barely" version, so we can safely say that we never
allowed such a patch.

So, I am not sure if we want to lose it.  As you found out, the
removed segment is not only about regular file becoming symlink,
and I do not think we would want to allow other typechanges by
just simply removing the check like the proposed patch did.

Thanks.
