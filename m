Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0D620802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbdFVVwl (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:52:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:49462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753812AbdFVVwi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:52:38 -0400
Received: (qmail 25907 invoked by uid 109); 22 Jun 2017 21:52:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 21:52:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6254 invoked by uid 111); 22 Jun 2017 21:52:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 17:52:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 17:52:36 -0400
Date:   Thu, 22 Jun 2017 17:52:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
Message-ID: <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
 <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
 <87efud7xjd.fsf@kyleam.com>
 <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
 <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
 <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
 <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
 <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
 <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 01:32:44PM -0700, Junio C Hamano wrote:

> I do not think command line parser does not allow "log -g
> maint..master" so all the "limited" processing the remainder of
> get_revision_1() does shouldn't matter.

Yeah, I don't think negative endpoints work at all, and "foo...bar"
seems to also break (though with a confusing message). It seems clear to
me that multiple positive endpoints don't work well either, if they have
overlapping commits.

> I however think pathspec will affect simplify_commit() and suspect
> that "git log -g -20 HEAD path" will behave differently.  Perhaps
> the difference is "it used to use path in an unexplainable way, now
> it ignores", in which case this is an improvement.

The current behavior there does seem like nonsense, because it's based
on the fake parents. For instance, if I set up a simple two-branch case:

  commit() {
	echo "$1" >"$1" && git add "$1" && git commit -m "$1"
  }

  git init repo
  cd repo
  commit base
  commit master
  git checkout -b side HEAD^
  commit side
  git merge --no-edit master
  commit combined

Then I get:

  $ git log -g --oneline --name-status -- master
  f06c3cd HEAD@{1}: merge master: Merge made by the 'recursive' strategy.
  5bf12c4 HEAD@{3}: checkout: moving from master to side
  dfa408b HEAD@{4}: commit: master
  A       master

Even though only one of those commits touched master. But with my patch,
it's also somewhat confusing. We ignore the pathspec when picking which
commits to show, but still apply it for diffing. So:

  03cf1ad HEAD@{0}: commit: combined
  f06c3cd HEAD@{1}: merge master: Merge made by the 'recursive' strategy.
  277042b HEAD@{2}: commit: side
  5bf12c4 HEAD@{3}: checkout: moving from master to side
  dfa408b HEAD@{4}: commit: master
  A       master
  5bf12c4 HEAD@{5}: commit (initial): base

I think we'd want to just omit any entries that are TREESAME to their
parents. We don't actually care about true parent rewriting (since we're
not walking the parents), but if it happened as a side effect that would
probably be OK.

It looks like simplify_commit() is also where we apply bits like
--no-merges, which doesn't work with my patch. It _also_ behaves
nonsensically in the current code, because of course the fake reflog
parents are never merges.

Which really makes me feel like this patch is going in the right
direction, as it makes all of this behave conceptually like:

  while read old new etc ...
  do
    git show $new
  done <.git/logs/$ref

which is simple to explain and is what I'd expect (and is certainly the
direction we went with the "diff uses real parents" commit).

We just need to hit the simplify_commit() code path here.

-Peff
