Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D982BC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 02:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F2B20679
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 02:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JwdiKk26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfKVCeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:34:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56454 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKVCeV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 21:34:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B321B3869D;
        Thu, 21 Nov 2019 21:34:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TGYDuVk91nVs7cAIsSOFbKKbiXQ=; b=JwdiKk
        26OPd/XSdbm03ucYWVpDMG+zNZ/zkrZiHgbPj8pvYDaP9CEzeq7SVbS+ZtbtOYaM
        np4qdw+8lBDCzEcZQJALoPAK8AiTD0P1SXVW1u3lD7NhtQwc0NUVUn8hb7qFZU4M
        IL3Om8/YI9uPB/Ryka0T5SQmtX/UHMrrM4AnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cw7bLCsBfaf8pE4SAwIDk5eFnm7wEz7S
        FgxQd4Zt10sd3YKnwc087PvriPofkcNzbfppqETVDkhfluX6f21Y0F42dfrvH2MG
        DleY/ylJApGCh4KyUbmElTPj5X+gXWo/NushFQyrafZctko9I4YiXaezlu/dtJij
        rFYKNpA4h6M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAF2A3869C;
        Thu, 21 Nov 2019 21:34:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E43A3869B;
        Thu, 21 Nov 2019 21:34:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: provide pathspecs/patterns via file or stdin
References: <20191122011646.218346-1-emilyshaffer@google.com>
        <20191122021419.GA52557@generichostname>
Date:   Fri, 22 Nov 2019 11:34:17 +0900
In-Reply-To: <20191122021419.GA52557@generichostname> (Denton Liu's message of
        "Thu, 21 Nov 2019 18:14:20 -0800")
Message-ID: <xmqqwobs7i6u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 950A16C2-0CD0-11EA-A58E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The reason I ask is because (correct me if I'm wrong) a lot of other git
> commands (like add, reset and checkout) don't seem to accept pathspecs
> via stdin and could suffer the same problem. xargs seems like a more
> general way of solving the problem of long command lines.

You contributors who are potentially throwing your own topics into
the cauldron, please be paying a bit more attention to other topics
already cooking in the pot.  I think am/pathspec-from-file wants to
go in the general direction.

There are things "xargs" is sufficient, and there are things that
absolutely requires a single invocation of "git".  "grep" is a bit
of both.

    $ git grep -e "$pattern" -- A B C

(where A, B and C are hundreds) can be split into three independent
invocations of "git grep" via "xargs", essentially running

    $ git grep -e "$pattern" -- A
    $ git grep -e "$pattern" -- B
    $ git grep -e "$pattern" -- C

independently.

But

    $ git grep -e P1 -e P2 -e P3 -- A

(where each of "-e Pn" in reality may be "-e Pn1 -e Pn2 -e Pn3..."
that has hundreds of patterns) cannot be split into separate
invocations and keep the same meaning.

    $ git grep -e P1 -- A
    $ git grep -e P2 -- A
    $ git grep -e P3 -- A

may show the same lines, but (1) lines with both P1 and P2 would be
shown duplicated, and (2) the order of the output would be different
from a single invocation looking for all patterns at once.

Needless to say, the ability to combine patterns with --all-match,
--and, etc., and negate them would mean the list of patterns must be
split (even when it makes sense to do so) at the right places.

    $ git grep -e P1 --and -e P2

cannot be split into two or more invocations, for example.






