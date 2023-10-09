Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2814BCD611A
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 18:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377511AbjJISPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 14:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377444AbjJISPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 14:15:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29926A3
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 11:15:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D3DC1BAA5D;
        Mon,  9 Oct 2023 14:15:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=atySR9fcc1txeSB5FDt7E2xZUgoK0N8HxGyyRC
        jAA0o=; b=BinqMmzYUBlb0fZXu8EC8EmjjwczfzFiDIcDhZu5Var8JU943fs9+P
        eHa4SF0Vea4QGLFXGHZWI8N1fxdQM+ysnHyEBt/DcxzzctrpxUjUYC5FHtsyayyh
        IPxqIK7E693QNdhqMiXNq+70iQs0qb4ioOZnNam9JqVpmjkDJ5g1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82FB01BAA5B;
        Mon,  9 Oct 2023 14:15:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AD751BAA59;
        Mon,  9 Oct 2023 14:15:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] ref-cache.c: fix prefix matching in ref iteration
In-Reply-To: <3585d72f-9f06-d190-ad5a-bec6db3f647f@github.com> (Victoria Dye's
        message of "Mon, 9 Oct 2023 09:21:53 -0700")
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
        <59276a5b3fd1fd3b25db73e096cf0e834af2d4f9.1696615769.git.gitgitgadget@gmail.com>
        <xmqqfs2n8lnn.fsf@gitster.g> <ZSPQLjJwq-7SjsDT@tanuki>
        <3585d72f-9f06-d190-ad5a-bec6db3f647f@github.com>
Date:   Mon, 09 Oct 2023 11:15:06 -0700
Message-ID: <xmqqa5sr1x3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6ED2780-66CF-11EE-B78E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> I originally operated on the assumption that it was the first case, which is
> why I didn't include a test in this patch. Commands like 'for-each-ref',
> 'show-ref', etc. either use an empty prefix or a directory prefix with a
> trailing slash, which won't trigger this issue.

Ah, yes, I didn't mention it but I suspected as such (i.e. the code
is structured in such a way that this broken implementation does not
matter to the current callers).

> I encountered the problem
> while working on a builtin that filtered refs by a user-specified prefix -
> the results included refs that should not have been matched, which led me to
> this fix.

OK, perfectly understandable.

> Scanning through the codebase again, though, I do see a way to replicate the
> issue:
>
> $ git update-ref refs/bisect/b HEAD
> $ git rev-parse --abbrev-ref --bisect
> refs/bisect/b
>
> Because 'rev-parse --bisect' uses the "refs/bisect/bad" prefix (no trailing
> slash) and does no additional filtering in its 'for_each_fullref_in'
> callback, refs like "refs/bisect/b" and "refs/bisect/ba" are (incorrectly)
> matched. I'll re-roll with the added test.

Good find.  Thanks!
