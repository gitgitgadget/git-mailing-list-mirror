Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442D7C6377C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 02:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7AA610D0
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 02:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbhGTB0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 21:26:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62947 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355075AbhGSX1S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 19:27:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E1B4E0E59;
        Mon, 19 Jul 2021 20:07:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yrVbkrxwLhQZus8/Bf0xUo2AikbNU3Gv4RaUR4
        sHpD0=; b=YwTaUWTjlqb2DXHMajKzar9/wJz9Ahl3i8wh4m/z7+ACVoK5gGG6GA
        zfJSWvxpHUZE69IUzSZhJbjeqhDN62Asf+M6MA7qVFL7OFqDKAkFKcFukHKfMdLe
        WQn7kzOIIpgEfhbg++pAZfXpnKL9WnQ0Dg/ClotuDQQ1DJN5Ovfc4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 610FAE0E58;
        Mon, 19 Jul 2021 20:07:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9103E0E57;
        Mon, 19 Jul 2021 20:07:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin Fick <mfick@codeaurora.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Sun Chao <16657101987@163.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] packfile: freshen the mtime of packfile by
 configuration
References: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
        <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
        <YPXluqywHs3u4Qr+@nand.local>
Date:   Mon, 19 Jul 2021 17:07:53 -0700
In-Reply-To: <YPXluqywHs3u4Qr+@nand.local> (Taylor Blau's message of "Mon, 19
        Jul 2021 16:51:06 -0400")
Message-ID: <xmqqlf61j19i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 877B722A-E8EE-11EB-BF3A-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hmm. I'm still quite unconvinced that we should be taking this direction
> without better motivation. We talked about your assumption that NFS
> seems to be invalidating the block cache when updating the inodes that
> point at those blocks, but I don't recall seeing further evidence.

Me neither.  Not touching the pack and not updating the "most
recently used" time of individual objects smells like a recipe
for repository corruption.

> My opinion is that it is not, and that the bizarre caching behavior you
> are seeing is out of Git's control.

