Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF06C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 20:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiHBUv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 16:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiHBUv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 16:51:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B52442ADB
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 13:51:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ECD6F1A1284;
        Tue,  2 Aug 2022 16:51:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pLuXZICtKUJdrr4sNPJ26VUV+22ic8cUoJhvII
        o5p3I=; b=fawoZx18tDBTaiKsvJPaoIPAqxwUM76n81TLAbZ5xUQ5p2Dh4IuUZM
        cDM9ZD8DYxpN3QuP9Tuw/NgGz1Y9rXwtBBQ/RQCaTJBHOCFzx61PhRFgtAWHAxaC
        pTwEHEbZ1hznHxjqQK9gAbnN0KneNz+eHW3d4R7nSMU530cMgNJ+E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4EF31A1283;
        Tue,  2 Aug 2022 16:51:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 948E31A1282;
        Tue,  2 Aug 2022 16:51:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 3/7] builtin/bugreport.c: avoid size_t overflow
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <e8abfdfa892f5670ed411ed6daef26a4ffa1bfe6.1659388498.git.gitgitgadget@gmail.com>
        <xmqqpmhjmwu4.fsf@gitster.g>
        <c075e483-6e00-5de4-b923-af8983ba384e@github.com>
Date:   Tue, 02 Aug 2022 13:51:51 -0700
In-Reply-To: <c075e483-6e00-5de4-b923-af8983ba384e@github.com> (Victoria Dye's
        message of "Tue, 2 Aug 2022 09:26:37 -0700")
Message-ID: <xmqqwnbqfjx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFD8C9B8-12A4-11ED-92B9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> I chose 'uint64_t' to mimic 'throughput_string()' [1], but the signed
> 'off_t' is a better choice given its use in 'strbuf_humanise_bytes()'.
>
> On a related note, while writing this I made the (unsubstantiated)
> assumption that 'off_t' would be a 64-bit int, even on 32-bit systems. Your
> comment prompted me to confirm that assumption; while 'off_t' is not always
> guaranteed to be an int64 by default [2], Git is compiled with '#define
> _FILE_OFFSET_BITS 64' [3] so 'off_t' is equivalent to 'off64_t'.

Offset into a single file can be smaller than the size of the whole
disk, after all, so from that point of view, use of off_t in
"humanise_bytes" API may be something we would want to fix
eventually to reduce confusion.

I do not particularly mind casting up to uint64, especially if that
matches the code lifted from scalar.  As long as our longer term
plan is to update strbuf_humanise_bytes() to take the widest
possible unsigned integer, what we do right now would not make that
much of a difference.

Thanks.
