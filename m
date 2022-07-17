Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F9C43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 22:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiGQWbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiGQWbW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 18:31:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DF8DF09
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 15:31:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF3E3147199;
        Sun, 17 Jul 2022 18:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PvZOmi0Dm7a/
        636AnVu0/nltS0edXO+gBZJGxDAyB8A=; b=SfNzrgkOhxWDFsE7X4LX429y2Rh3
        DI92aEwtasjDeEQ2zsH/eVcgMEVrfa3WxF00287XFT+m5j38SqMOF+k7OpwDvKLt
        dgWhuso4wkaYH0E4kcJ44PzLO///9QfhfXYEPg7g5tFlwKFBUrow+KlSyy3/+aI+
        YYVbosP1EQbwKao=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3EB1147198;
        Sun, 17 Jul 2022 18:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44532147197;
        Sun, 17 Jul 2022 18:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 00/10] typed sort of linked lists
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Date:   Sun, 17 Jul 2022 15:31:18 -0700
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 16 Jul 2022 18:50:02 +0200")
Message-ID: <xmqqk08bv0ax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2DA6407C-0620-11ED-AB18-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> It starts by making llist_mergesort() leaner without reducing its
> performance:
>
>   mergesort: unify ranks loops
>   mergesort: tighten merge loop
>
> This matters for the next step, which creates the macro version of
> that function:
>
>   mergesort: add macros for typed sort of linked lists
>
> The next two patches show the impact of using the macro on performance
> and object text size of the test helper:
>
>   test-mergesort: use DEFINE_LIST_SORT_DEBUG
>   test-mergesort: use DEFINE_LIST_SORT
>
> Then all llist_mergesort() callers get converted:
>
>   blame: use DEFINE_LIST_SORT
>   commit: use DEFINE_LIST_SORT
>   fetch-pack: use DEFINE_LIST_SORT
>   packfile: use DEFINE_LIST_SORT
>
> ... and the final patch removes the function which has become unused:
>
>   mergesort: remove llist_mergesort()

A nicely presented coherent story that results in an overall code
reduction.  Thanks for a pleasant read.

Will queue.


>  Makefile                  |   1 -
>  blame.c                   |  30 ++++-------
>  commit.c                  |  20 +++----
>  fetch-pack.c              |   8 +++
>  mergesort.c               |  84 -----------------------------
>  mergesort.h               | 108 ++++++++++++++++++++++++++++++++++----
>  packfile.c                |  18 ++-----
>  remote.c                  |  22 --------
>  remote.h                  |   2 -
>  t/helper/test-mergesort.c |  34 +++---------
>  t/perf/p0071-sort.sh      |   4 +-
>  t/t0071-sort.sh           |   2 +-
>  12 files changed, 134 insertions(+), 199 deletions(-)
>  delete mode 100644 mergesort.c
>
> --
> 2.37.1
