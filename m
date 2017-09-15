Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B94B20286
	for <e@80x24.org>; Fri, 15 Sep 2017 11:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbdIOLfi (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 07:35:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:39962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751198AbdIOLfh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 07:35:37 -0400
Received: (qmail 12697 invoked by uid 109); 15 Sep 2017 11:35:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 11:35:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6705 invoked by uid 111); 15 Sep 2017 11:36:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 07:36:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Sep 2017 07:35:35 -0400
Date:   Fri, 15 Sep 2017 07:35:35 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how to remove from history just *one* version of a file/dir?
Message-ID: <20170915113535.vpeltdmewmq6ekhl@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1709140721130.19770@localhost.localdomain>
 <20170914122338.4vlgx2rjr4mk62rh@sigill.intra.peff.net>
 <alpine.LFD.2.21.1709150701010.4944@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1709150701010.4944@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2017 at 07:06:43AM -0400, Robert P. J. Day wrote:

> > I think you want to stick with a --tree-filter (or an
> > --index-filter), but just selectively decide when to do the
> > deletion. For example, if you can tell the difference between the
> > two states based on the presence of some file, then perhaps:
> >
> >   git filter-branch --prune-empty --index-filter '
> > 	if git rev-parse --verify :dir/sentinel >/dev/null 2>&1
> > 	then
> > 	  git rm --cached -rf dir
> > 	fi
> >   ' HEAD
> >
> > The "--prune-empty" is optional, but will drop commits that become
> > empty because they _only_ touched that directory.
> >
> > We use ":dir/sentinel" to see if the entry is in the index, because
> > the index filter won't have the tree checked out. Likewise, we need
> > to use "rm --cached" to just touch the index.
> 
>   got it. one last query -- i note that there is no "else" clause in
> that code for "--index-filter". am i assuming correctly that if i was
> using "--tree-filter" instead, i really would need if/then/else along
> the lines of:
> 
>   if blah ; then
>     skip_commit "$@"
>   else
>     git commit-tree "$@"
>   fi
> 
> thank you kindly.

No, I think a tree-filter would just be:

  if test -e dir/sentinel
  then
    rm -rf dir
    git add -u
  fi

(I can't remember if the "add -u" is necessary or not; I rarely use tree
filters).

In other words, for each commit you are just saying "if the bad version
of the directory is present, then get rid of it". You shouldn't need to
deal with commit-tree at all. The filter-branch script will take care of
committing whatever tree state your filter leaves in place.

Do note that I didn't test either of the versions I sent to you, so it's
possible I'm missing some subtle thing. But I'm pretty sure the general
direction is correct.

-Peff
