Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4AEE1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 20:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbdBNUrx (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 15:47:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:55299 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751941AbdBNUrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 15:47:51 -0500
Received: (qmail 19592 invoked by uid 109); 14 Feb 2017 20:47:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 20:47:51 +0000
Received: (qmail 6444 invoked by uid 111); 14 Feb 2017 20:47:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 15:47:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 15:47:49 -0500
Date:   Tue, 14 Feb 2017 15:47:49 -0500
From:   Jeff King <peff@peff.net>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     git@vger.kernel.org
Subject: Re: missing handling of "No newline at end of file" in git am
Message-ID: <20170214204748.wqnsqkbig4ktw5wf@sigill.intra.peff.net>
References: <20170214201104.GA26407@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214201104.GA26407@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 09:11:04PM +0100, Olaf Hering wrote:

> How is git send-email and git am supposed to handle a text file which
> lacks a newline at the very end? This is about git 2.11.0.

That workflow should handle this case, and the resulting applied patch
should not have a newline.

> Right now the patch in an email generated with 'git send-email' ends
> with '\ No newline at end of file', which 'git am' can not handle.  To
> me it looks like whatever variant of "diff" is used does the right thing
> and indicates the lack of newline. Just the used variant of "patch" does
> not deal with it.

I can't reproduce here:

  # new repo with nothing in it (the base commit is to have something to
  # reset back to)
  git init
  git commit --allow-empty -m base

  # our file with no trailing newline
  printf foo >file
  git add file
  git commit -m no-newline

  # now make a patch email; it should have the "\ No newline" bit at the
  # end.
  git format-patch -1
  cat 0001-no-newline.patch

  # and now reset back and try to apply it
  git reset --hard HEAD^
  git am 0001-no-newline.patch

  # double check that it has no newline
  xxd <file

I'm using format-patch instead of send-email, but that is the underlying
command that send-email is using. Is it possible that your patch is
getting munged during email transit in a way that destroy the "No
newline" message?

-Peff
