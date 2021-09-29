Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A1CC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26796138D
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhI2EJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 00:09:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54808 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhI2EJo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 00:09:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43782162B13;
        Wed, 29 Sep 2021 00:08:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fLWJtmR4YsUwqqyqewzb2oCX/9NAMAWkhANT8R
        f76zY=; b=T4mBAj7+vVmmuPLgvroKr52BIJE+f5iOlokMI05/NpDK2ejQdNT+8m
        2mk0NJZhquQiMawBWX5JyO9dgtm46ClBBEHACqLoK0AvUJrGDsX0Hv1/OoVOgiaV
        b9merT+X0E3F7YNJZzugJmk8Og+tPl5/0iEzz2OpcKoCR9cu7trQA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C661162B12;
        Wed, 29 Sep 2021 00:08:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9EF77162B10;
        Wed, 29 Sep 2021 00:08:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
        <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
Date:   Tue, 28 Sep 2021 21:08:00 -0700
In-Reply-To: <YVOiggCWAdZcxAb6@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 28 Sep 2021 19:17:22 -0400")
Message-ID: <xmqqsfxof2hr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D694980E-20DA-11EC-BAB5-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   Side note: The pretend_object_file() approach is actually even better,
>   because we know the object is fake. So it does not confuse
>   write_object_file()'s "do we already have this object" freshening
>   check.
>
>   I suspect it could even be made faster than the tmp_objdir approach.
>   From our perspective, these objects really are tempfiles. So we could
>   write them as such, not worrying about things like fsyncing them,
>   naming them into place, etc. We could just write them out, then mmap
>   the results, and put the pointers into cached_objects (currently it
>   insists on malloc-ing a copy of the input buffer, but that seems like
>   an easy extension to add).
>
>   In fact, I think you could get away with just _one_ tempfile per
>   merge. Open up one tempfile. Write out all of the objects you want to
>   "store" into it in sequence, and record the lseek() offsets before and
>   after for each object. Then mmap the whole result, and stuff the
>   appropriate pointers (based on arithmetic with the offsets) into the
>   cached_objects list.

Cute.  The remerge diff code path creates a full tree that records
the mechanical merge result.  By hooking into the lowest layer of
write_object() interface, we'd serialize all objects in such a tree
in the order they are computed (bottom up from the leaf level, I'd
presume) into a single flat file ;-)
