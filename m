Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869CB1F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 02:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfJGCvP (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 22:51:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51861 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfJGCvO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 22:51:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C4E12491C;
        Sun,  6 Oct 2019 22:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZhQR/CRTZEHD
        LMDbQpdjuYxT+DU=; b=qlf03nJKROCJaYZ9XD75p6/pkZR99bhCZJY61uY4Iyg1
        phYePH+Imf/qH55Xt4veQzeXxDAqluy6pC/pfWa8BwglLOzO04VRWdGblDbMS2Xy
        NZ9GAygkTfXSgSep3Qas+IQw2RuuAFHr8wrpRhLazxEiQGge33Nv6WoiEcNcLHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ac2yVF
        fLdkir2dn231CgL7srX4S6mDzie5l/eyd7M3RMgZO7Ccf1HAOTb7UQfYj7+q3NMN
        qojJPhL0r1SCgmyN+rgKlBAEfh/CCKMLJ+HAnKd3oTIBh6yj3k3pObJUPEdh9U1m
        HjTXcdxmcNjhBQqpQV3GgrOTHKDzyKRqn6sbE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 439482491B;
        Sun,  6 Oct 2019 22:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F5D02491A;
        Sun,  6 Oct 2019 22:51:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] merge-recursive: fix the diff3 common ancestor label for virtual commits
References: <20191001144940.GH10875@sigill.intra.peff.net>
        <20191001181727.16009-1-newren@gmail.com>
Date:   Mon, 07 Oct 2019 11:51:12 +0900
In-Reply-To: <20191001181727.16009-1-newren@gmail.com> (Elijah Newren's
        message of "Tue, 1 Oct 2019 11:17:27 -0700")
Message-ID: <xmqq7e5h46an.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5356A728-E8AD-11E9-90D3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> In commit 743474cbfa8b ("merge-recursive: provide a better label for
> diff3 common ancestor", 2019-08-17), the label for the common ancestor
> was changed from always being
>
>          "merged common ancestors"
>
> to instead be based on the number of merge bases:
>
>     >=3D2: "merged common ancestors"
>       1: <abbreviated commit hash>
>       0: "<empty tree>"

I just saw, while running "git checkout next && git merge master",
this:

    diff --git a/packfile.c b/packfile.c
    index 3220761fb4..6413693a17 100644
    --- a/packfile.c
    +++ b/packfile.c
    @@ -16,7 +16,22 @@
     #include "object-store.h"
     #include "midx.h"
     #include "commit-graph.h"
    +<<<<<<< HEAD
     #include "promisor-remote.h"
    +||||||| merged common ancestors
    +<<<<<<<<< Temporary merge branch 1
    +||||||||| =E7=80=893.
    +=3D=3D=3D=3D=3D=3D=3D=3D=3D
    +#include "promisor-remote.h"
    +>>>>>>>>> Temporary merge branch 2
    +||||||||| =E7=80=893.
    +>>>>>>>>>>> Temporary merge branch 2
    +=3D=3D=3D=3D=3D=3D=3D=3D=3D
    +#include "promisor-remote.h"
    +>>>>>>>>> Temporary merge branch 2
    +=3D=3D=3D=3D=3D=3D=3D
    +#include "promisor-remote.h"
    +>>>>>>> master

     char *odb_pack_name(struct strbuf *buf,
                        const unsigned char *hash,

where the common ancestor blocks are marked with random garbage.

I do not have time or patience to bisect and do not know if this is
a regression around this commit, but it smells suspiciously close.

