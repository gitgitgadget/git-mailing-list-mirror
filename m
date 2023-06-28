Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97296EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 17:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjF1RI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 13:08:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58632 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjF1RIY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 13:08:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40DA6190393;
        Wed, 28 Jun 2023 13:08:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g5MfvLXjz09kgh3PQnv6ySBAt8hP8LZrSBNvlX
        M3z5E=; b=dXojXrXlxJObEu8JBlfl4dSsOx2Lxt8Thq6QOzqBCurBlCEV+r3tDA
        BOK5S1iaUoQI0eKKfed2RbELsCCl/3j8K1wgLlu0DeaYEngkxnTmXn2LGq0UD5jR
        l/BhzGIS18dm0+zS07sl1+cxObosWWVdlIfcLMu9tk4Z/umi/1kCg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3826F190392;
        Wed, 28 Jun 2023 13:08:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99C36190391;
        Wed, 28 Jun 2023 13:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/2] for-each-ref: add --count-matches option
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
        <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
        <20230627073007.GD1226768@coredump.intra.peff.net>
        <f6fd39bc-65d4-76e3-94b4-9163194c89dd@gmail.com>
        <776c3682-d2eb-d2d7-3ea8-4a7db8cd7842@gmail.com>
Date:   Wed, 28 Jun 2023 10:08:21 -0700
In-Reply-To: <776c3682-d2eb-d2d7-3ea8-4a7db8cd7842@gmail.com> (Phillip Wood's
        message of "Wed, 28 Jun 2023 14:12:38 +0100")
Message-ID: <xmqqzg4jcy62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6332A750-15D6-11EE-B1DD-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> So it seems most of the slowdown I was seeing yesterday was due it
> looking up a loose object. I'm surprised repacking makes such a
> difference in a repository that only contains two objects.

If we compare what is done in packfile.c:packed_object_info() and
object-file.c:loose_object_info() when we are only interested in
finding out the object type, there aren't that many differences
in the set of system calls each codepath needs to make.

 * The packfile codepath needs to open and mmap *.pack and *.idx,
   binary search in the .idx for the object location, then read a
   few bytes from .pack, before being able to decode the header to
   find out the type.

 * The loose object codepath needs to open and mmap the loose object
   file, read a few bytes from there, before being abole to decode
   the header to find out the type. After that, it needs to munmap.

The cost of open/mmap for packfile codepath amortises over number of
objects (hence number of refs) very well.  If there are many refs
that point at the same object, cache object layer will kick in to
avoid disk access for second and subsequent accesses to the same
object, but it helps both codepaths equally, so there should not be
much difference either way.

Thanks for a interesting piece of food for thought.
