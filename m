Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8430C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB90B2075F
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S6HbIy6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgG2SKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:10:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62901 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgG2SKD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:10:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFC64E3B41;
        Wed, 29 Jul 2020 14:10:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xHQBhUGrAX1HdTO0Qb2SW5vsTzQ=; b=S6HbIy
        6VCDp/VJ5T2NTkPtpaJ64XlYb9Cg0X2h8v+uBYQOQfHTRi4nKMH8djBZXV5jVNXo
        cGIlLe4jom4XuKVNv15EuJBDG4ZIAKH6JTjoCZFhw42NUHoGvL/GT7J0inTUPr/e
        ImmxSwOLeRaPyKiRggkAex46Ea9Rds6iPXazg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RnR92V+jf3uDVGrTes1jvnvZNo6GxGxu
        2cDv9XWs1ZdPvB7xk73x20vx3B/VPex9hxAlM5jsiJbxbQZdFm6VnESkWHY+2xY9
        QHc62O9S9bxVyQEhiNMq2P+4nYJpnLZ9c4Aw/liSzGYxZbAvR+yAVs7GUiroSLBX
        PnFbMm/ARWU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98E91E3B40;
        Wed, 29 Jul 2020 14:10:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC9CCE3B3A;
        Wed, 29 Jul 2020 14:09:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     <git@vger.kernel.org>
Subject: Re: I have gone and done a bad thing - malformed tree objects
References: <19ca801d66541$cf872af0$6e9580d0$@pdinc.us>
        <xmqqh7trb0sr.fsf@gitster.c.googlers.com>
        <19cab01d66544$ecb402d0$c61c0870$@pdinc.us>
Date:   Wed, 29 Jul 2020 11:09:57 -0700
In-Reply-To: <19cab01d66544$ecb402d0$c61c0870$@pdinc.us> (Jason Pyeron's
        message of "Tue, 28 Jul 2020 21:09:35 -0400")
Message-ID: <xmqq8sf2b3be.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6B3F700-D1C6-11EA-A3C4-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason Pyeron" <jpyeron@pdinc.us> writes:

>> gc and fsck may not have pruned the dangling object yet, but
>> --batch-all-objects is a request to enumerate objects that exist in
>> the repository, regardless of their reachability from any ref.
>> 
>> Perhaps "git prune --expire=now" would get rid of it?
>
> Both that and
>
> git -c gc.reflogExpire=now -c gc.reflogExpireUnreachable=now   -c gc.rerereresolved=now -c gc.rerereunresolved=now   -c gc.pruneExpire=now -c gc.worktreePruneExpire=now gc --prune=now --aggressive
>
> leave it in.

If the cruft has already been stored in a packfile, then prune would
not touch it.  "git repack -a -d && git prune --expire=now" would be
the next thing to do.
