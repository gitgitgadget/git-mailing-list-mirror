Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11CA20441
	for <e@80x24.org>; Sat, 31 Dec 2016 21:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754815AbcLaVmw (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 16:42:52 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:43368 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754776AbcLaVmv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 16:42:51 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cNEoD-0006RW-Jj
        for git@vger.kernel.org; Sat, 31 Dec 2016 17:14:33 +0900
Date:   Sat, 31 Dec 2016 17:14:33 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Rebasing multiple branches at once
Message-ID: <20161231081433.3zo6lrsjsu2qho4u@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've had this kind of things to do more than once, and had to do it a
lot today, so I figured it would be worth discussing whether git-rebase
should be enhanced to support this, or if this should go in a separate
tool or whatever.

So here is what I'm trying to do in a not-too painful way:

I'm starting with something like this:
A---B---C---D---E
            \---F

where A is master, and E and F are two local topics with a common set of
things on top of master.

The next thing that happens is that master is updated, and I want to
rebase both topics on top of the new master.

So I now have:

A---G
\---B---C---D---E
            \---F

If I do the dumb thing, which is to do `git rebase master E` and `git
rebase master F`, I end up with:

A---G---B'---C'---D'---E'
    \---B"---C"---D"---F'

That is, I just lost the fast that E and F had common history.

I could go with `git rebase master E` followed by `git rebase --onto D'
D F` but that's cumbersome, especially when you have more than 2 topics,
not necessarily diverging at the same point (e.g. I might have another
topic that diverges at C)

So, what I end up doing is something like:
- git co -b merge E
- git merge --strategy ours F (and any other topic I might want to
  rebase)
- git rebase master --preserve-merges

If everything goes fine, then I can `git update-ref` the topics to each
parent of the merge branch.

But, usually, since rebase --preserve-merges redoes merges with the
default strategy, I end up with conflicts, and instead of trying to
figure stuff out, I just pick the rewritten sha1s from
.git/rebase-merge/rewritten/* to update the refs.

It is my understanding that the --strategy option to git-rebase is used
for the rebase itself, so I'm not sure there's a way to tell rebase to
use a specific strategy for the preserved merges only.

Anyways, it /seems/ like just allowing multiple branches on the git
rebase command line and make this work would improve things
significantly. The question then, is how would that interact with other
options (I'm thinking e.g. -i, but -i already has a problem with
--preserve-merges). But it does seem like it would be a worthwhile
improvement.

What do you think?

Mike
