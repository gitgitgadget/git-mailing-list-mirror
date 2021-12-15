Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6B4C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 19:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhLOTqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 14:46:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64320 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLOTqT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 14:46:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CDB110C947;
        Wed, 15 Dec 2021 14:46:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fhKDRCGy83OPkWTPTpUb/qksqVhgOu1fpa/bth
        673aE=; b=IA+kplTnBfHisqH/wHUEVZMX9SZ11fiJ6zI79eO3t64gDrjblb4s5j
        ntnzyVDJV4CTR1xFcVDFO8vt7SB0jXdO+4xusyRo3MAKLxblbiu44/VNB8VnGz1W
        qyC45WmasJdCtdJLx15gsxwCBWWVn/VEqq/TVIs10m71LizkcMmt8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7434A10C946;
        Wed, 15 Dec 2021 14:46:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D40B310C945;
        Wed, 15 Dec 2021 14:46:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com
Subject: Re: [PATCH v2 0/8] midx: prevent bitmap corruption when permuting
 pack order
References: <cover.1638991570.git.me@ttaylorr.com>
        <cover.1639446906.git.me@ttaylorr.com>
Date:   Wed, 15 Dec 2021 11:46:16 -0800
In-Reply-To: <cover.1639446906.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 13 Dec 2021 20:55:22 -0500")
Message-ID: <xmqqee6d648n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB8CA7C2-5DDF-11EC-8573-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is a reroll of my series which fixes a serious problem with MIDX bitmaps by
> which they can become corrupt when permuting their pack order.

This seems to depend on tb/cruft-packs that is not yet in 'next', so
I'll redo this topic branch by forking it at 'master', merging the
other topic in, and then queuing these 8 patches.

> So I'm definitely open to suggestions there, but otherwise this series should go
> a long ways towards fixing my design mistake of having the MIDX .rev file be
> separate from the MIDX itself.

Yeah, a single file with different chunks is a good way to ensure
atomicity of update.

A note to reviewers.

We need to make sure that not just we can still read .rev in
existing repositories (and convert it to the new chunk) correctly,
but also decide what to do to older versions of Git once the
repository is touched by this new version.  Would they be upset to
see no .rev files or is it just the performance thing (and it is
more correct to recompute the reverse index on the fly)?  Should the
new chunk be made mandatory to cause them notice that they should
not muck with the repository, or is it optional?  Things like that.

Thanks.
