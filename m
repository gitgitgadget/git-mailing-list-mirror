Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F938C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 20:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D281206B7
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 20:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cunBFlzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgITUI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 16:08:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62371 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITUI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 16:08:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 931F7F290E;
        Sun, 20 Sep 2020 16:08:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xdXWI0jcijPxplnIFCXZMwoE0Tw=; b=cunBFl
        zbKpVvgmLAmfnxzpAdm3nk1WitODs7JTZRAqRz049IfkxdR4mhleGZTJtBT6h8dU
        9mqZgm1hcow+aOLw/I5G+YIx3g4niqkyGsrmpVnDvWh7J8HRganbmTspCWYl5+oj
        s1MhkO/fzV6/6Jdv88hRo5eqPjeNWbaob+zqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gYZcZPq5puXnrIgz7PWSiarXr2l0bkZD
        He39lc7vXLfsMsCo7CvWQqYZQOqGu0XaLvGYjhQ+7ygkdaLq4+OqDiZH/S4dmFfp
        Hs+oLOwzXi7c4XJI3WElqqsX54gYlnolf+i0anNDc2+xKVL7PJwCSznYsSLdgYBp
        M3nwLSBOth4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C599F290C;
        Sun, 20 Sep 2020 16:08:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7E2CF290B;
        Sun, 20 Sep 2020 16:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca, peff@peff.net
Subject: Re: [PATCH v2] diff: Fix modified lines stats with --stat and
 --numstat
References: <20200918113256.8699-2-tguyot@gmail.com>
        <20200920130945.26399-1-tguyot@gmail.com>
        <20200920153915.GB2726066@nand.local>
        <xmqqlfh4gt5z.fsf@gitster.c.googlers.com>
Date:   Sun, 20 Sep 2020 13:08:21 -0700
In-Reply-To: <xmqqlfh4gt5z.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 20 Sep 2020 12:11:20 -0700")
Message-ID: <xmqqh7rsgqiy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0904B4C4-FB7D-11EA-A40C-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But I suspect that the best fix is to teach diff_fill_oid_info() to
> hash the in-memory data to compute the oid, instead of punting and
> filling the oid field with null_oid.  If function builtin_diffstat()
> is allowed to look at the contents and run memcmp() here, the 'data'
> field should have been filled and valid when diff_fill_oid_info()
> looked at it already.
>
> The "best" fix will have wider consequences, so we may not want to
> jump to it right away without careful consideration.

And then after giving a bit more thought, I don't recommend to go
with this approach, because it breaks an established convention that
objects with unknown name is perfectly OK and shown with the null
oid.

In other words, I'd suggest to use the "second best" one I gave in
the message I am responding to.

Thanks.

