Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC721F461
	for <e@80x24.org>; Sat, 18 May 2019 04:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfERERK (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 00:17:10 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:58998 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfERERK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 00:17:10 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hRqmQ-0008BG-Tv; Sat, 18 May 2019 13:17:06 +0900
Date:   Sat, 18 May 2019 13:17:06 +0900
From:   Mike Hommey <mh@glandium.org>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Revision walking, commit dates, slop
Message-ID: <20190518041706.ct6ie5trvxgdhjar@glandium.org>
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
 <20190518015005.GA951@szeder.dev>
 <20190518035828.pjaqfrkkvldhri6v@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190518035828.pjaqfrkkvldhri6v@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 18, 2019 at 12:58:28PM +0900, Mike Hommey wrote:
> On Sat, May 18, 2019 at 03:50:05AM +0200, SZEDER Gábor wrote:
> > On Sat, May 18, 2019 at 09:54:12AM +0900, Mike Hommey wrote:
> > > There are established corner cases, where in a repo where commit dates
> > > are not monotonically increasing, revision walking can go horribly
> > > wrong. This was discussed in the past in e.g.
> > > https://public-inbox.org/git/20150521061553.GA29269@glandium.org/
> > > 
> > > The only (simple) workable way, given the current algorithm, to get an
> > > accurate view off rev-list is to essentially make slop infinite. This
> > > works fine, at the expense of runtime.
> > > 
> > > Now, ignoring any modification for the above, I'm hitting another corner
> > > case in some other "weird" history, where I have 500k commits all with
> > > the same date. With such a commit dag, something as trivial as
> > > `git rev-list HEAD~..HEAD` goes through all commits from the root commit
> > > to HEAD, which takes multiple seconds, when the (obvious) output is one
> > > commit.
> > > 
> > > It looks like the only way revision walking stops going through all the
> > > ancestry is through slop, and slop is essentially made infinite by the
> > > fact all commits have the same date (because of the date check in
> > > still_interesting(). By extension, this means the workaound for the
> > > first corner case above, which is to make slop infinite, essentially
> > > makes all rev walking go through the entire ancestry of the commits
> > > given on the command line.
> > > 
> > > It feels like some cases of everybody_uninteresting should shorcut slop
> > > entirely, but considering the only way for slop to decrease at all is
> > > when everybody_uninteresting returns true, that would seem like a wrong
> > > assumption. But I'm also not sure what slop helps with in the first
> > > place (but I don't have a clear view of the broader picture of how the
> > > entire revision walking works).
> > > 
> > > Anyways, a rather easy way to witness this happening is to create a
> > > dummy repo like:
> > >   git init foo
> > >   cd foo
> > >   for i in $(seq 1 50); do
> > >     echo $i > a;
> > >     git add a;
> > >     git commit -a -m $i;
> > >   done
> > > 
> > > The something as simple as `git rev-list HEAD~..HEAD` will go through
> > > all 50 commits (assuming the script above created commits in the same
> > > second, which it did on my machine)
> > > 
> > > By the time both HEAD~ and HEAD have been processed, the revision
> > > walking should have enough information to determine that it doesn't need
> > > to go further, but still does. Even with something like HEAD~2..HEAD,
> > > after the first round of processing parents it should be able to see
> > > there's not going to be any more interesting commits.
> > > 
> > > I'm willing to dig into this, but if someone familiar with the
> > > algorithm could give me some hints as to what I might be missing in the
> > > big picture, that would be helpful.
> > 
> > All the above is without commit-graph, I presume?  If so, then you
> > should give it a try, as it might bring immediate help in your
> > pathological repo.  With 5k commit in the same second (enforced via
> > 'export GIT_COMMITTER_DATE=$(date); for i in {1..5000} ...') I get:
> > 
> >   $ best-of-five -q git rev-list HEAD~..HEAD
> >   0.069
> >   $ git commit-graph write --reachableComputing commit graph generation
> >   numbers: 100% (5000/5000), done.
> >   $ best-of-five -q git rev-list HEAD~..HEAD
> >   0.004
> 
> I'm not observing any difference from using commit-graph, whether in
> time or in the number of commits that are looked at in limit_list().

-c core.commitGraph=true does make a difference in time, but not in the
number of commits looked at in limit_list(). So it's only faster because
each iteration of the loop is faster. It means it's still dependent on
the depth of the dag, and the larger the repo will grow, the slower it
will get.

Mike
