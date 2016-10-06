Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB009207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbcJFTAS (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:00:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:53546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932620AbcJFTAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:00:17 -0400
Received: (qmail 29709 invoked by uid 109); 6 Oct 2016 19:00:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 19:00:16 +0000
Received: (qmail 30459 invoked by uid 111); 6 Oct 2016 19:00:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 15:00:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 15:00:14 -0400
Date:   Thu, 6 Oct 2016 15:00:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
Message-ID: <20161006190014.owmqr2eqyk5h5cau@sigill.intra.peff.net>
References: <20161006114124.4966-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161006114124.4966-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 06:41:24PM +0700, Nguyễn Thái Ngọc Duy wrote:

> Throwing something at the mailing list to see if anybody is
> interested.
> 
> Current '!' aliases move cwd to $GIT_WORK_TREE first, which could make
> handling path arguments hard because they are relative to the original
> cwd. We set GIT_PREFIX to work around it, but I still think it's more
> natural to keep cwd where it is.
> 
> We have a way to do that now after 441981b (git: simplify environment
> save/restore logic - 2016-01-26). It's just a matter of choosing the
> right syntax. I'm going with '!!'. I'm not very happy with it. But I
> do like this type of alias.

Hmm. I wonder if any commands will be fooled by not being moved to
GIT_WORK_TREE. I know that there is a bug already in this case:

  export HOME=$PWD

  for i in one two; do
  	git init $i &&
  	(cd $i &&
  	 echo "* diff=$i" >.gitattributes &&
  	 git add . &&
  	 git commit -m $i) &&
  	git config --global diff.$i.textconv "sed s/^/$i:/"
  done

  cd two &&
  git --git-dir=$(pwd)/../one/.git --work-tree=$(pwd)/../one show

This shows the contents of repo one using the .gitattributes from repo
two. I am not sure if the bug is that when GIT_WORK_TREE is set,
git-show doesn't position itself at the toplevel of that tree, or if the
attributes machinery should be more careful about looking up paths in
the work-tree versus the current directory.

This bug is tangential to your patch (it has nothing to do with aliases,
and should be fixed regardless). But I wonder if your "!!" aliases will
expose this bug more frequently.

-Peff

PS I think your "!!" syntax conflicts with something like:

    git -c alias.has-changes="!! git diff --quiet' has-changes

   I don't know if that is worth worrying about or not. I also notice
   that using "!!git diff" with no space seems broken, as it seems to
   skip using the shell. I wonder if that is a bug in run-command.
