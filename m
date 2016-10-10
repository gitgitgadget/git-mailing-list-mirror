Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD4D20989
	for <e@80x24.org>; Mon, 10 Oct 2016 15:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbcJJPaf (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 11:30:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:55044 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753006AbcJJPae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 11:30:34 -0400
Received: (qmail 29408 invoked by uid 109); 10 Oct 2016 15:30:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 15:30:34 +0000
Received: (qmail 31292 invoked by uid 111); 10 Oct 2016 15:30:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 11:30:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 11:30:32 -0400
Date:   Mon, 10 Oct 2016 11:30:32 -0400
From:   Jeff King <peff@peff.net>
To:     Seaders Oloinsigh <seaders69@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git filter-branch --subdirectory-filter not working as expected,
 history of other folders is preserved
Message-ID: <20161010153032.v2x773cbs4ifvzec@sigill.intra.peff.net>
References: <CAN40BKqPdPP2+K4FBzgDDfYiGkzk1gYcOeP==_t+pr5w0rj0EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN40BKqPdPP2+K4FBzgDDfYiGkzk1gYcOeP==_t+pr5w0rj0EQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 02:42:36PM +0100, Seaders Oloinsigh wrote:

> We have a git repository that looks like
> 
> sdk/
> android/
> ios/
> unity/
> windows/
> 
> Which we'd like to split into 4 repositories, 1 for each platform.  To
> start this process (for splitting android out), I ran,
> 
> git filter-branch -f --prune-empty --subdirectory-filter android -- --all

OK, so that should rewrite each ref to have only the contents of the
"android" directory at the top-level.

Note that filter-branch saves a copy of the old refs in refs/original.

> Which rewrote a ton of history and commits, and looked like it worked, but
> on closer inspection had left a ton of history behind.
> 
> If I run
> 
> git log --all -- unity/
> 
> It returns a list of commits that happened in the unity/ subfolder of the
> original root.

Here you asked for "--all", which includes refs/original. So you are
seeing the original, unwritten commits (and none of your new ones, of
course, because they do not have a unity/ directory!).

Try:

  git log --all --source -- unity

to see which ref each commit is coming from.

Or try:

  git log --branches --tags -- unity

to confirm that your branches and tags do not include that path.

Or just:

  git for-each-ref --format='delete %(refname)' refs/original |
  git update-ref --stdin

to get rid of the backup refs entirely.

-Peff
