Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AECBC46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 19:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjAKTH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 14:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbjAKTHS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 14:07:18 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB515B867
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 11:07:17 -0800 (PST)
Received: (qmail 30669 invoked by uid 109); 11 Jan 2023 19:07:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Jan 2023 19:07:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7976 invoked by uid 111); 11 Jan 2023 19:07:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Jan 2023 14:07:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Jan 2023 14:07:16 -0500
From:   Jeff King <peff@peff.net>
To:     Arthur Milchior <arthur.milchior@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Misleading error message on a failed `git mv`
Message-ID: <Y78I5E/BCr1QQ6aL@coredump.intra.peff.net>
References: <CAEcbrFc=R=3aEwEE56EvZSPSV4+RWFxt=hm7csZ7oBTR8BDQzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEcbrFc=R=3aEwEE56EvZSPSV4+RWFxt=hm7csZ7oBTR8BDQzA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 05:19:29AM +0100, Arthur Milchior wrote:

> Error message is
> 
> fatal: renaming 'file' failed: No such file or directory
> 
> 
> What's different between what you expected and what actually happened?
> 
> The error message seems to indicate that file does not exists. It
> actually exists. The destination directory does not exists and is the
> one that should be mentionned.

I agree the message is not specific as to which case happened, but this
is all we get from the kernel's error reporting. We called rename(), the
syscall returned ENOENT, and we fed that to strerror() to get "No such
file or directory". From the manpage for rename(2):

  ENOENT The link named by oldpath does not exist; or, a directory
	 component in newpath does not exist; or, oldpath or newpath is
	 an empty string.

If we wanted to be more specific, we'd have to go to extra work to
diagnose each case. Most tools don't bother. For example:

  $ touch foo
  $ mv foo bar/foo
  mv: cannot move 'foo' to 'bar/foo': No such file or directory

It's quirky, for sure, but it's how most Unix tools behave here.

-Peff
