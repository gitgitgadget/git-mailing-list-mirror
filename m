Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE991F576
	for <e@80x24.org>; Thu,  8 Feb 2018 11:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeBHLZL (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 06:25:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:44920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750961AbeBHLZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 06:25:10 -0500
Received: (qmail 10598 invoked by uid 109); 8 Feb 2018 11:25:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Feb 2018 11:25:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7943 invoked by uid 111); 8 Feb 2018 11:25:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Feb 2018 06:25:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2018 06:25:08 -0500
Date:   Thu, 8 Feb 2018 06:25:08 -0500
From:   Jeff King <peff@peff.net>
To:     Nick O'Leary <nick.oleary@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unexpected git diff output during merge conflict
Message-ID: <20180208112508.GA3506@sigill.intra.peff.net>
References: <CAF=vhqdJ2fByjSVt37b34wQUFo5_tb7rHbCddsaCzdvKywSBdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF=vhqdJ2fByjSVt37b34wQUFo5_tb7rHbCddsaCzdvKywSBdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 08, 2018 at 10:51:57AM +0000, Nick O'Leary wrote:

> $ git diff README.md
> diff --cc README.md
> index 61d78b2,620d806..0000000
> --- a/README.md
> +++ b/README.md
> @@@ -1,7 -1,1 +1,11 @@@
>  -This is my default readme
> ++<<<<<<< HEAD
>  +merged-history-test
>  +===================
>  +
>  +### About
>  +
>  +This is your project's README.md file. It helps users understand what your
> - project does, how to use it and anything else they may need to know.
> ++project does, how to use it and anything else they may need to know.
> ++=======
> ++This is my default readme
> ++>>>>>>> dev
> 
> This does not look right to me. The 'This is my default readme' line
> has ++ at the start - suggesting its new to both parent copies of the
> file, which isn't the case - it came from the dev branch so should be
> prefixed with '+ '.
> I'm also not clear why the line beginning 'project does' has both a -
> and ++ prefix.

Are you sure there aren't whitespace differences in those two lines?

For instance, if I do:

  # base commit
  git init
  git commit --allow-empty -m base

  # one side; note missing newline!
  printf 'this is my default readme' >file
  git add file
  git commit -m default

  # other side
  git checkout -b other HEAD^
  {
	echo this is a longer
	echo and more involved
	echo README
  } >file
  git add file
  git commit -m longer

  # and now merge and get a conflict
  git merge master

Then I get similar output to you.  The content with merge-conflicts
can't represent the original lack-of-newline for that file, because of
course there's another ">>>" line after it.

If I swap out the printf for echo, adding the newline, then it produces
the output you'd expect.

-Peff
