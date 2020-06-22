Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A36C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 17:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156E320656
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 17:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kXROaLCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgFVReR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:34:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51642 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVReQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 13:34:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3C1B5B5BB;
        Mon, 22 Jun 2020 13:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WTrJ7dxy+DzIHEqo7BFwoDqjzHs=; b=kXROaL
        CR2Lagt1DJSDn9CZQurBmX5IypJZmtXH1WGYnneGD3gnTyon/jMvt6NkhDjiWBkC
        cOQClPYEXFIiBhjFsy9GF9giaXokvCvVtXXJp1oNLCz/I+AnHPP1qGzWJbtrxkxM
        acLVY+UKz4SrSFzEwrcNmLJ0tSIN6NSo4dNi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MQGtwQEwz0/A0s46m8dhWiWIYM2on5Ff
        Vc7KjnDq98I7Y1osXRMJePkYqKXzXw/HQHvbDSbee5GJWhrCLS+YCwR8H5CM5twl
        N3nbeGyNuNcf+f/rjEYfkjl83inbRNDVIv3VjNXLOoXtdLmclzsji6WpKDViJwcT
        lmtftzjT0Ao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CFA85B5BA;
        Mon, 22 Jun 2020 13:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 366485B5B9;
        Mon, 22 Jun 2020 13:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] drop specialized knowledge from generic worktree code
References: <20200619233544.42025-1-sunshine@sunshineco.com>
Date:   Mon, 22 Jun 2020 10:34:13 -0700
In-Reply-To: <20200619233544.42025-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Fri, 19 Jun 2020 19:35:42 -0400")
Message-ID: <xmqq7dvzdmy2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9735061A-B4AE-11EA-8021-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This patch series removes specialized knowledge from the libified
> worktree code about how front-end "git worktree list" wants worktrees
> sorted, and instead makes it the responsibility of "git worktree list"
> itself to do the sorting.
>
> It is built atop es/worktree-duplicate-paths since that series adds
> another caller of get_worktrees() which this series touches.
>
> A possible argument against this patch series is that some other entity
> may someday want worktrees sorted in the same fashion as "git worktree
> list", however, that seems a case of YAGNI.

Is anything hurting to have the "mostly extra" flag and its handling
that is added only to support "worktree list"?  That would be
another possible argument against this clean-up.

Having said that, I think this is good.

Thanks.  Will queue.
