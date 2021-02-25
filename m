Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F80C43381
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A784964F4B
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhBYT2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 14:28:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51420 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbhBYT0H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 14:26:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FB571208F9;
        Thu, 25 Feb 2021 14:25:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RYnA8Viwf48Mbr6BlbQOMLYVagU=; b=leLOZT
        i7Eyx4GCvBrx/CRYfe3RMTrNOczAIoYpFUt3yBTaZrf2zB1TPCdNs80UaHqfEyLI
        LdLaDa0TAK3VUdI7RIMLxyReIv2elrwLR3PDa7JG41iVqdBmCFWNHHiOzYlGrSd1
        WsXZ6IY+CLkQHMSShTQGaQ+RRSEjnk+YY5KQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yGwU0duiou3ApBRW1pE+S54BPlXSBdG9
        UMLFZttJu4mZzU7n0niyceNO1JKc3bRD3iKMbw/VKqr4Gwfoa9Q/HN4xUyuzPGwC
        8ZVabgB38MVYVOK+g0Gt5XaEl9GvH+guN5YvJpavJYtbUSvMECWhkJyF1hdB18a+
        IFeW1vyiz7k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A0591208F8;
        Thu, 25 Feb 2021 14:25:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A05D1208F7;
        Thu, 25 Feb 2021 14:25:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Blake Burkhart <bburky@bburky.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] open in-tree files with O_NOFOLLOW
References: <YCsBA002yv8XpppM@coredump.intra.peff.net>
        <YCsBRUQkrAm8l2gz@coredump.intra.peff.net>
        <87y2foaltl.fsf@evledraar.gmail.com>
        <YCsc0OePtrotjeg5@coredump.intra.peff.net>
        <YCu/FoLl8p15mwio@coredump.intra.peff.net>
        <YCvaJg8o882IqNnx@coredump.intra.peff.net>
Date:   Thu, 25 Feb 2021 11:25:19 -0800
In-Reply-To: <YCvaJg8o882IqNnx@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 16 Feb 2021 09:43:50 -0500")
Message-ID: <xmqqh7m0uezk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3376FEEE-779F-11EB-A4EF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 16, 2021 at 07:48:23AM -0500, Jeff King wrote:
>
>> I am beginning to wonder if just opening them all with O_NOFOLLOW (and a
>> hacky 2-syscall fallback for portability) might be less ugly than all of
>> this.
>
> So here's what that series might look like. It would replace all of this
> verify_path() stuff entirely (and fsck, though we might want to add
> detection to fsck just as an informational thing). It gives similar
> protections, and would similarly force people using an in-tree symlink
> to stop doing that. But it makes it much less of a pain to do so,
> because they can still check out, etc; the symlinks just won't be
> followed.
>
> I think we could even use the same technique to roll back the
> restrictions on .gitmodules being a symlink. That one makes me a bit
> more nervous, just because we also write it. I _think_ that might be
> safe, because we only do so using a temp file and rename(), which should
> replace the symlink.
>
>   [1/6]: add open_nofollow() helper
>   [2/6]: attr: convert "macro_ok" into a flags field
>   [3/6]: exclude: add flags parameter to add_patterns()
>   [4/6]: attr: do not respect symlinks for in-tree .gitattributes
>   [5/6]: exclude: do not respect symlinks for in-tree .gitignore
>   [6/6]: mailmap: do not respect symlinks for in-tree .mailmap
>
>  attr.c                    | 60 +++++++++++++++++++++++++--------------
>  builtin/sparse-checkout.c |  8 +++---
>  dir.c                     | 21 ++++++++++----
>  dir.h                     |  3 +-
>  git-compat-util.h         |  7 +++++
>  mailmap.c                 | 22 ++++++++++----
>  t/t0003-attributes.sh     | 36 +++++++++++++++++++++--
>  t/t0008-ignores.sh        | 34 ++++++++++++++++++++++
>  t/t4203-mailmap.sh        | 31 ++++++++++++++++++++
>  wrapper.c                 | 16 +++++++++++
>  10 files changed, 197 insertions(+), 41 deletions(-)

So, I've read these changes and they all looked quite reasonable.

Where do we want to go from here?

Merge it down and forget about the changes in verify_path() and fsck
in the jk/symlinked-dotgitx-files topic?  Do we want to also cover
the .gitmodules file with the same mechansim?

Thanks.
