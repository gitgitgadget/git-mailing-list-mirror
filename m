Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F74DC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 17:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiGMRlu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 13:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiGMRlt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 13:41:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3171C2CE23
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 10:41:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1308E144CA4;
        Wed, 13 Jul 2022 13:41:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vzjs4jIPU7MccefA2Xx4T0acWVKgITJRAo0fOU
        NUEv8=; b=qvOTRQwMPrfzCLfakmlrhZzs0uEVtH9w+7D/wqlYWSkj+8OvEpSn0A
        qdq1A7XfSvXjTsEnSKy0gHBS9aW3tx/iM25CBg2h3WdX5DNwtoAunVAXLdfpzSv0
        fC9lhE76dpdszfFjvC4LERt214DkbqodVFPI31CAPziT5cluL0TWk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09FF5144CA3;
        Wed, 13 Jul 2022 13:41:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71D95144CA2;
        Wed, 13 Jul 2022 13:41:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, peff@peff.net,
        ps@pks.im, wfc@wfchandler.org
Subject: Re: [PATCH 0/3] commit-graph: fix corruption during generation v2
 upgrade
References: <cover.1657667404.git.me@ttaylorr.com>
Date:   Wed, 13 Jul 2022 10:41:45 -0700
In-Reply-To: <cover.1657667404.git.me@ttaylorr.com> (Taylor Blau's message of
        "Tue, 12 Jul 2022 19:10:18 -0400")
Message-ID: <xmqqk08gdi5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10FF0E40-02D3-11ED-84C3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This brief series resolves a bug where a commit-graph would become
> corrupt when upgrading from generation number v1 to v2, as originally
> reported in [1].
>
> Some speculation occurred as to what might be causing that bug in the
> thread beginning at [1], until the problem was explained in more detail
> by Will Chandler in [2].
>
> The crux of the issue, as is described in [2] and [3], is that the
> commit_graph_data slab is reused for read and write operations involving
> the commit-graph, leading to situations where data computed in
> preparation of a write is clobbered by a read of existing data.
>
> The first patch demonstrates the issue, and the second patch prepares to
> fix it by introducing a helper function. The crux of the issue is
> described and fixed in the third patch.
>
> [1]: https://lore.kernel.org/git/YqD5dgalb9EPnz85@coredump.intra.peff.net/
> [2]: https://lore.kernel.org/git/DD88D523-0ECA-4474-9AA5-1D4A431E532A@wfchandler.org/
> [3]: https://lore.kernel.org/git/YsS7H4i5DqUZVQ5i@nand.local/

Thanks.  Do we know where this breaks?  Applying [1/3] on Git 2.32,
2.34, and 2.35 seems to claim that "known breakage vanished".
