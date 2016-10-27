Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5696E20193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964981AbcJ0VFC (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:05:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:35030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934631AbcJ0VFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:05:01 -0400
Received: (qmail 32598 invoked by uid 109); 27 Oct 2016 21:05:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 21:05:01 +0000
Received: (qmail 23564 invoked by uid 111); 27 Oct 2016 21:05:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 17:05:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2016 17:04:59 -0400
Date:   Thu, 27 Oct 2016 17:04:59 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Aaron Pelly <aaron@pelly.co>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Expanding Includes in .gitignore
Message-ID: <20161027210458.ptzh4y75dkfaixeo@sigill.intra.peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <CA+P7+xqmVM-bEc7sZcn+p3qhFUUJvC+rko7CYu+KgyTAeiOifw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqmVM-bEc7sZcn+p3qhFUUJvC+rko7CYu+KgyTAeiOifw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 12:48:34PM -0700, Jacob Keller wrote:

> > I think the normal behavior in such "foo.d" directory is to just sort
> > the contents lexically and read them in order, as if they were all
> > concatenated together, and with no recursion. I.e., behave "as if" the
> > user had run "cat $dir/*".
> 
> Yea, this is the normal behavior, and the user is expected to order
> their files lexically such as "00-name", "50-name" and so on. Pretty
> traditional for a lot of newer configurations.

One thing I will say about this approach is that you can implement it
without any changes in git by doing:

  path=.git/info/exclude
  cat $path.d/* >$path

and I have seen several config mechanisms basically do that (e.g.,
Debian packaging for a program that doesn't have its own ".d" mechanism,
but needs to grab config provided by several separate packages).

The reason to teach that trick to git is convenience; you don't have to
remember to build the master file from its parts because it's done
dynamically whenever git needs to look at it.

> One thing to keep in mind would be that we should make sure we can
> handle the .gitignore being a submodule or a git repository, so that
> users could just do something like

I'm not convinced this is needed for in-repo .gitignore files. The point
is that you are pulling together separate files that may be administered
independently. But git repositories inherently have a whole-project
view. I'm not sure that separate files buy you a lot there. And the
compatibility issues are more complicated.

I do agree that:

  cd .git/info
  git clone /my/exclude/repo exclude ;# or exclude.d

should work; ignoring dotfiles when reading the directory solves that,
and is a pretty standard solution.

-Peff
