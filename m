Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3037201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 21:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935035AbdBQVmY (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 16:42:24 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35469 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934415AbdBQVmX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 16:42:23 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so4841190pfx.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 13:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PnwIAzsZzafzLwBDGCMRcUzG1SECgn8oSyacIFkJ36Y=;
        b=VN6Z8TDsDTSkE61XXWhM0bpR4z5ybNpwLz6eBxk4+CepLrG8GAugcaysoMj98AkFzi
         a7XIbHc+xD9ITOcHkKVlsCwBpIqf2pNeBMeLcKNVa5PoplChfIE3xbq6fL4aNrv2TXbN
         5vV3pTShDJg+BIG/kjgQbVqleuT/0LwBehFBeD+1XzwLl1BltsqUqccxHcxCKbbHfDfp
         ++F+Qrot5ByQfwmEh813TW4rgCg+s6gEjN86gdRP/GSs8I/tHtq3u5MhgIiJ9XQQXbcI
         zaFUuKSYPKFfPPwPM4dK21WVSJApvFfddJqM7o/9lXIigPQjsxXqbq+CETXVBkqhM6sy
         vU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PnwIAzsZzafzLwBDGCMRcUzG1SECgn8oSyacIFkJ36Y=;
        b=bqhS8awGpPZwG2NyBo3haLnFGagGzU1LhM28+P3I/RKZabbQydoiXyqPZoCggZBD4V
         DnidMDknXr36LYqPp3+WZMHO0VsltXjJpdbM5ZQrCF0j+l7pJEPT7sm8R9CgEc4Wbitj
         n+OpPuPLHZDpBUv1hBKQ6v+HBo6h54PeUlLwCb7h9dN2+Sk/9c5UwnZzEEV3wS+z/GOI
         V2224zmwEeQnvGwHAJWgRUe+VqNTFf0G0GMdX8XfqRkGdgNVZOJZkG/LnpoStB9K0kDK
         Xqd+Qw1mU2CH/IOATQMxDtVycd5U4lz8M74SSTpMYDMyCxNqFKWc6lgw/ZI2MOCd2JIG
         NoRQ==
X-Gm-Message-State: AMke39lZKEC5vrdoPVSXJJrGKwqoDpAKdmAkprK03wy0cvWXSYg9L4xHFP+jO4coQyYGyg==
X-Received: by 10.99.60.91 with SMTP id i27mr11152294pgn.170.1487367742749;
        Fri, 17 Feb 2017 13:42:22 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id c2sm21289539pfl.61.2017.02.17.13.42.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 13:42:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?Q?J=C3=A1chym_Barv=C3=ADnek?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
References: <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
        <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
        <87tw7uv439.fsf@linux-m68k.org>
        <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
        <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
        <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
        <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
        <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
        <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
        <xmqq37fcsejx.fsf@gitster.mtv.corp.google.com>
        <20170217212106.bew6krtb7pqpi3rr@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 13:42:21 -0800
In-Reply-To: <20170217212106.bew6krtb7pqpi3rr@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 17 Feb 2017 16:21:06 -0500")
Message-ID: <xmqqy3x4qyte.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 17, 2017 at 01:17:06PM -0800, Junio C Hamano wrote:
>
>> Stepping back a bit, would this be really needed?  Even if the ferror()
>> does not update errno, the original stdio operation that failed
>> would have, no?
>
> Sure, but we have no clue what happened in between.

Hmm, so we are protecting against somebody who does "errno = 0"
explicitly, because she knows that she's dealt with the error from
stdio earlier?  Such a careful person would have called clearerr()
as well, I would guess.

So let's assume we only care about the case where some other error
was detected and errno was updated by a system library call.

> I think our emails crossed, but our patches are obviously quite similar.
> My commit message maybe explains a bit more of my thinking.

Yes, but ;-)

If we are trying to make sure that the caller would not say "failed
to close tempfile: ERRNO" with an ERRNO that is unrelated to any
stdio opration, I am not sure if the patch improves things.  The
caller did not fail to close (most likely we successfully closed
it), and no matter what futzing we do to errno, the message supplied
by such a caller will not be improved.

If the caller used "noticed an earlier error while closing tempfile:
ERRNO", such a message would describe the situation more correctly,
but then ERRNO that is not about stdio is probably acceptable in the
context of that message (the original ERRNO might be ENOSPC that is
even more specific than EIO, FWIW).  So I am not sure if the things
will improve from the status quo.

It's easy for us to either apply the patch and be done with it (or
drop and do the same), and in the bigger picture it wouldn't make
that much of a difference, I would think, so I can go either way.


