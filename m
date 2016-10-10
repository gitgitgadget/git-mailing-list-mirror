Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F6220989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbcJJSTL (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:19:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:55194 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752110AbcJJSTK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:19:10 -0400
Received: (qmail 7114 invoked by uid 109); 10 Oct 2016 18:19:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 18:19:09 +0000
Received: (qmail 354 invoked by uid 111); 10 Oct 2016 18:19:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 14:19:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 14:19:07 -0400
Date:   Mon, 10 Oct 2016 14:19:07 -0400
From:   Jeff King <peff@peff.net>
To:     Seaders Oloinsigh <seaders69@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git filter-branch --subdirectory-filter not working as expected,
 history of other folders is preserved
Message-ID: <20161010181907.bqekupn6npuimbir@sigill.intra.peff.net>
References: <CAN40BKqPdPP2+K4FBzgDDfYiGkzk1gYcOeP==_t+pr5w0rj0EQ@mail.gmail.com>
 <20161010153032.v2x773cbs4ifvzec@sigill.intra.peff.net>
 <CAN40BKoWroM4ZJHHdMvO8YvvCho0FnWzV9BG9E5xnCZbYOO2pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN40BKoWroM4ZJHHdMvO8YvvCho0FnWzV9BG9E5xnCZbYOO2pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 05:12:25PM +0100, Seaders Oloinsigh wrote:

> Due to the structure of this repo, it looks like there are some
> branches that never had anything to do with the android/ subdirectory,
> so they're not getting wiped out.  My branch is in a better state to
> how I want it, but still, if I run your suggestion,
> [...]

Hmm. Yeah, I think this is an artifact of the way that filter-branch
works with pathspec limiting. It keeps a mapping of commits that it has
rewritten (including ones that were rewritten only because their
ancestors were), and realizes that a branch ref needs updated when the
commit it points to was rewritten.

But if we don't touch _any_ commits in the history reachable from a
branch (because they didn't even show up in our pathspec-limited
rev-list), then it doesn't realize we touched the branch's history at
all.

I agree that the right outcome is for it to delete those branches
entirely. I suspect the fix would be pretty tricky, though.

In the meantime, I think you can work around it by either:

  1. Make a pass beforehand for refs that do not touch your desired
     paths at all, like:

       path=android ;# or whatever
       git for-each-ref --format='%(refname)' |
       while read ref; do
         if test "$(git rev-list --count "$ref" -- "$path")" = 0; then
	   echo "delete $ref"
	 fi
       done |
       git update-ref --stdin

     and then filter what's left:

       git filter-branch --subdirectory-filter $path -- --all

or

  2. Do the filter-branch, and because you know you specified --all and
     that your filters would touch all histories, any ref which _wasn't_
     touched can be deleted. That list is anything which didn't get a
     backup entry in refs/original. So something like:

       git for-each-ref --format='%(refname)' |
       perl -lne 'print $1 if m{^refs/original/(.*)}' >backups

       git for-each-ref --format='%(refname)' |
       grep -v ^refs/original >refs

       comm -23 refs backups |
       sed "s/^/delete /" |
       git update-ref --stdin

-Peff
