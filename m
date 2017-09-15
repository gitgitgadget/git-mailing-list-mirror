Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6757120A21
	for <e@80x24.org>; Fri, 15 Sep 2017 11:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdIOLGq (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 07:06:46 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:37168 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdIOLGp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 07:06:45 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:54078 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dsoSK-0000Wl-OO; Fri, 15 Sep 2017 07:06:44 -0400
Date:   Fri, 15 Sep 2017 07:06:43 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how to remove from history just *one* version of a file/dir?
In-Reply-To: <20170914122338.4vlgx2rjr4mk62rh@sigill.intra.peff.net>
Message-ID: <alpine.LFD.2.21.1709150701010.4944@localhost.localdomain>
References: <alpine.LFD.2.21.1709140721130.19770@localhost.localdomain> <20170914122338.4vlgx2rjr4mk62rh@sigill.intra.peff.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Sep 2017, Jeff King wrote:

> On Thu, Sep 14, 2017 at 07:32:11AM -0400, Robert P. J. Day wrote:
>
> >   [is this the right place to ask questions about git usage? or is
> > there a different forum where one can submit possibly
> > embarrassingly silly questions?]
>
> No, this is the right place for embarrassing questions. :)
>
> >   say, early on, one commits a sizable directory of content, call
> > it /mydir. that directory sits there for a while until it becomes
> > obvious it's out of date and worthless and should never have been
> > committed. the obvious solution would seem to be:
> >
> >   $ git filter-branch --tree-filter 'rm -rf /mydir' HEAD
> >
> > correct?
>
> That would work, though note that using an --index-filter would be
> more efficient (since it avoids checking out each tree as it walks
> the history).

  i'm just digging into --index-filter as we speak, i realize it's
noticeably faster.

> >   however, say one version of that directory was committed early
> > on, then later tossed for being useless with "git rm", and
> > subsequently replaced by newer content under exactly the same
> > name. now i'd like to go back and delete the history related to
> > that early version of /mydir, but not the second.
>
> Makes sense as a goal.
>
> >   obviously, i can't use the above command as it would delete both
> > versions. so it appears the solution would be a trivial
> > application of the "--commit-filter" option:
> >
> >    git filter-branch --commit-filter '
> >      if [ "$GIT_COMMIT" = "<commit-id>" ] ; then
> >        skip_commit "$@";
> >      else
> >        git commit-tree "$@";
> >      fi' HEAD
> >
> > where <commit-id> is the commit that introduced the first verrsion of
> > /mydir. do i have that right? is there a simpler way to do this?
>
> No, this won't work. Filter-branch is not walking the history and
> applying the changes to each commit, like rebase does.  It's
> literally operating on each commit object, and recall that each
> commit object points to a tree that is a snapshot of the repository
> contents.
>
> So if you skip a commit, that commit itself goes away. But the
> commit after it (which didn't touch the unwanted contents) will
> still mention those contents in its tree.

  ah, of course, duh.

> I think you want to stick with a --tree-filter (or an
> --index-filter), but just selectively decide when to do the
> deletion. For example, if you can tell the difference between the
> two states based on the presence of some file, then perhaps:
>
>   git filter-branch --prune-empty --index-filter '
> 	if git rev-parse --verify :dir/sentinel >/dev/null 2>&1
> 	then
> 	  git rm --cached -rf dir
> 	fi
>   ' HEAD
>
> The "--prune-empty" is optional, but will drop commits that become
> empty because they _only_ touched that directory.
>
> We use ":dir/sentinel" to see if the entry is in the index, because
> the index filter won't have the tree checked out. Likewise, we need
> to use "rm --cached" to just touch the index.

  got it. one last query -- i note that there is no "else" clause in
that code for "--index-filter". am i assuming correctly that if i was
using "--tree-filter" instead, i really would need if/then/else along
the lines of:

  if blah ; then
    skip_commit "$@"
  else
    git commit-tree "$@"
  fi

thank you kindly.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
