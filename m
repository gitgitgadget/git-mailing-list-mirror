Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98503C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 01:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E26611EE
	for <git@archiver.kernel.org>; Mon,  3 May 2021 01:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhECBXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 21:23:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56893 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhECBXB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 21:23:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A9BEB9DB4;
        Sun,  2 May 2021 21:22:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5VYjT/ssf2eoMh9xXKlBRCCOITtrcaEuVt84NA
        ibvJI=; b=iLO1f4zG62Is9nJOkGkxHfOiKHC+BReTKSy4XWJAry8SvWkuc6yxcH
        xQncd3qWSBL2HI2Kgf75Ui/+I7Agcybk0lOvxQnuJbIUFxC8YcJUf38UoO0pCmXC
        TOLYuaFpEFRo6m51seRVrNHUxll9oAzhIFSzIBpKwsKTXlm7lEJZs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 027E3B9DB3;
        Sun,  2 May 2021 21:22:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 703FDB9DB2;
        Sun,  2 May 2021 21:22:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: "Unpacking objects" question
References: <bdd50fcc-02c3-dc24-9d49-773db881b65d@gmail.com>
        <YI7Zl+odFFRIZ7aL@coredump.intra.peff.net>
Date:   Mon, 03 May 2021 10:22:07 +0900
In-Reply-To: <YI7Zl+odFFRIZ7aL@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 2 May 2021 12:55:51 -0400")
Message-ID: <xmqq5z00bohs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA77F5E2-ABAD-11EB-823B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't know if the documentation discusses this tradeoff anywhere, but
> off the top of my head:
>
>   - storing packs can be more efficient in disk space (because of deltas
>     within the pack, but also fewer inodes for small objects). This
>     effect is bigger the more objects you have.
>
>   - storing packs can be less efficient, because thin packs will be
>     completed with duplicates of already-stored objects. The overhead is
>     bigger the fewer objects you have.

Another original motivation was to avoid ending up with too many
small packs, as it would result in accessing objects taking
potentially order of number of packfiles in the repository in the
pre midx world.  After many small fetches, gc would be able to pack
them all into a single pack.

> There are some other subtle effects, too:
>
>   - storing packs from the wire may make git-gc more efficient (you can
>     often reuse deltas sent by the other side)

 - storing and using packs that came from the wire may not have as
   good locality among objects, especially when the other side was a
   server that is optimized to reduce outbound network bandwidth
   (read: size) and their own processing cycles (read: object reuse
   from their packs).  Local packing has a dedicated phase to
   reorder the objects to pack related ones close to each other, but
   the "server" side has no incentive to optimize for that.

>   - storing packs from the wire may produce a worse outcome after
>     git-gc, because you are reusing deltas produced by the client for
>     their push (who might not have spent as much CPU looking for them as
>     you would)
