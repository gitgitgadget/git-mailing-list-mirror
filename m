Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B686C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74674613C9
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhFBUNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:13:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57894 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhFBUNe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:13:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B84DE1F5AE;
        Wed,  2 Jun 2021 20:11:50 +0000 (UTC)
Date:   Wed, 2 Jun 2021 20:11:50 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <20210602201150.GA29388@dcvr>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local>
 <YLfgy94sbmStC0mR@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLfgy94sbmStC0mR@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> And so when he gets this error:
> 
>   fatal: fsync error on '.git/objects/pack/tmp_pack_NkPgqN': Interrupted system call
> 
> presumably we were in fsync() when the signal arrived, and unlike most
> other platforms, the call needs to be restarted manually (even though we
> set up the signal with SA_RESTART). I'm not sure if this violates POSIX
> or not (I couldn't find a definitive answer to the set of interruptible
> functions in the standard). But either way, the workaround is probably
> something like:

"man 3posix fsync" says EINTR is allowed ("manpages-posix-dev"
package in Debian non-free).

>   #ifdef FSYNC_NEEDS_RESTART

The wrapper should apply to all platforms.  NFS (and presumably
other network FSes) can be mounted with interrupts enabled.

>   #undef fsync /* we'd define to git_fsync() in a header file */
>   static int git_fsync(int fd)
>   {
> 	int ret;
> 	while ((ret = fsync(fd)) < 0 && errno == EINTR)
> 		; /* try again */
> 	return ret;
>   }

Looks fine.
