Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1EBCD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 21:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjIRVUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 17:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIRVUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 17:20:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3DC90
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 14:20:06 -0700 (PDT)
Received: (qmail 11738 invoked by uid 109); 18 Sep 2023 21:20:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Sep 2023 21:20:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4114 invoked by uid 111); 18 Sep 2023 21:20:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Sep 2023 17:20:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Sep 2023 17:20:04 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] git-send-email.perl: avoid printing undef when
 validating addresses
Message-ID: <20230918212004.GC2163162@coredump.intra.peff.net>
References: <ZQhI5fMhDE82awpE@debian.me>
 <545729b619308c6f3397b9aa1747f26ddc58f461.1695054945.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <545729b619308c6f3397b9aa1747f26ddc58f461.1695054945.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2023 at 12:35:53PM -0400, Taylor Blau wrote:

> When validating email addresses with `extract_valid_address_or_die()`,
> we print out a helpful error message when the given input does not
> contain a valid email address.
> 
> However, the pre-image of this patch looks something like:
> 
>     my $address = shift;
>     $address = extract_valid_address($address):
>     die sprintf(__("..."), $address) if !$address;
> 
> which fails when given a bogus email address by trying to use $address
> (which is undef) in a sprintf() expansion, like so:
> 
>     $ git.compile send-email --to="pi <pi@pi>" /tmp/x/*.patch --force
>     Use of uninitialized value $address in sprintf at /home/ttaylorr/src/git/git-send-email line 1175.
>     error: unable to extract a valid address from:

Yeah, we overwrite the variable we're reporting on, so I don't think the
original could possibly work. Your fix makes sense.

> This regression dates back to e431225569 (git-send-email: remove invalid
> addresses earlier, 2012-11-22), but became more noticeable in a8022c5f7b
> (send-email: expose header information to git-send-email's
> sendemail-validate hook, 2023-04-19), which validates SMTP headers in
> the sendemail-validate hook.

I didn't quite understand how a8022c5f7b made this worse, but I guess we
just call it the bad function in more instances. The bug is definitely
from e431225569, though.

-Peff
