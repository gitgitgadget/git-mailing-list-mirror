Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DC5209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 12:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbdINMXl (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 08:23:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:38546 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751516AbdINMXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 08:23:41 -0400
Received: (qmail 15689 invoked by uid 109); 14 Sep 2017 12:23:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 12:23:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26834 invoked by uid 111); 14 Sep 2017 12:24:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 08:24:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Sep 2017 08:23:38 -0400
Date:   Thu, 14 Sep 2017 08:23:38 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how to remove from history just *one* version of a file/dir?
Message-ID: <20170914122338.4vlgx2rjr4mk62rh@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1709140721130.19770@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1709140721130.19770@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2017 at 07:32:11AM -0400, Robert P. J. Day wrote:

>   [is this the right place to ask questions about git usage? or is
> there a different forum where one can submit possibly embarrassingly
> silly questions?]

No, this is the right place for embarrassing questions. :)

>   say, early on, one commits a sizable directory of content, call it
> /mydir. that directory sits there for a while until it becomes obvious
> it's out of date and worthless and should never have been committed.
> the obvious solution would seem to be:
> 
>   $ git filter-branch --tree-filter 'rm -rf /mydir' HEAD
> 
> correct?

That would work, though note that using an --index-filter would be more
efficient (since it avoids checking out each tree as it walks the
history).

>   however, say one version of that directory was committed early on,
> then later tossed for being useless with "git rm", and subsequently
> replaced by newer content under exactly the same name. now i'd like to
> go back and delete the history related to that early version of
> /mydir, but not the second.

Makes sense as a goal.

>   obviously, i can't use the above command as it would delete both
> versions. so it appears the solution would be a trivial application of
> the "--commit-filter" option:
> 
>    git filter-branch --commit-filter '
>      if [ "$GIT_COMMIT" = "<commit-id>" ] ; then
>        skip_commit "$@";
>      else
>        git commit-tree "$@";
>      fi' HEAD
> 
> where <commit-id> is the commit that introduced the first verrsion of
> /mydir. do i have that right? is there a simpler way to do this?

No, this won't work. Filter-branch is not walking the history and
applying the changes to each commit, like rebase does.  It's literally
operating on each commit object, and recall that each commit object
points to a tree that is a snapshot of the repository contents.

So if you skip a commit, that commit itself goes away. But the commit
after it (which didn't touch the unwanted contents) will still mention
those contents in its tree.

I think you want to stick with a --tree-filter (or an --index-filter),
but just selectively decide when to do the deletion. For example, if you
can tell the difference between the two states based on the presence of
some file, then perhaps:

  git filter-branch --prune-empty --index-filter '
	if git rev-parse --verify :dir/sentinel >/dev/null 2>&1
	then
	  git rm --cached -rf dir
	fi
  ' HEAD

The "--prune-empty" is optional, but will drop commits that become empty
because they _only_ touched that directory.

We use ":dir/sentinel" to see if the entry is in the index, because the
index filter won't have the tree checked out. Likewise, we need to use
"rm --cached" to just touch the index.

-Peff
