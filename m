Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60638C43217
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AB561090
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJDHdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 03:33:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43468 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhJDHdb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 03:33:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 876E91F8C8;
        Mon,  4 Oct 2021 07:31:42 +0000 (UTC)
Date:   Mon, 4 Oct 2021 07:31:42 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hash: reduce size of algo member of object ID
Message-ID: <20211004073142.GA25608@dcvr>
References: <8da7bad2-b5a8-5aef-284b-dfa4e78556a9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8da7bad2-b5a8-5aef-284b-dfa4e78556a9@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> wrote:
> cf0983213c (hash: add an algo member to struct object_id, 2021-04-26)
> introduced the algo member as an int.  This increased the size of struct
> object_id by 4 bytes (12.5%) and imposed a 4-byte alignment.  Currently
> we only need to stored the values 0, 1 and 2 in it.  Let's use an
> unsigned char instead to reduce the size overhead and lift the alignment
> requirement.

I like it.  Btw, would a bitfield enum be portable enough for us?

	enum git_hash_algo algo:8;  /* or algo:2 */

I've used those in other projects, but AFAIK they were for
gcc||clang-only.

> Not sure how to measure the performance impact of this change.  The perf
> tests mentioned by cf0983213c don't show much of a difference with
> GIT_PERF_REPEAT_COUNT=10 for me:

Thanks for that info.  I'm not familiar enough with most git
internals to know if it ought to make a difference as-is.

In my experience, changes like this open the door to further
struct-packing opportunities (possibly combined with conditional
use of __attribute__((packed)) ).
