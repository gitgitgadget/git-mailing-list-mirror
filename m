Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1460FC433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 07:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9769206F4
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 07:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgGOHmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:42:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57876 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbgGOHmv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 03:42:51 -0400
Received: (qmail 9685 invoked by uid 109); 15 Jul 2020 07:42:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jul 2020 07:42:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7304 invoked by uid 111); 15 Jul 2020 07:42:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jul 2020 03:42:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jul 2020 03:42:50 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 0/4] deterministic commit timestamps in tests
Message-ID: <20200715074250.GB3249056@coredump.intra.peff.net>
References: <20200709203336.GA2748777@coredump.intra.peff.net>
 <xmqqa707rpuu.fsf@gitster.c.googlers.com>
 <20200714123142.GA2587001@coredump.intra.peff.net>
 <20200714123334.GB2587001@coredump.intra.peff.net>
 <20200714214728.GA21660@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714214728.GA21660@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 14, 2020 at 09:47:28PM +0000, Eric Wong wrote:

> > -     git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
> > -     git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
> > +     git log --format="tree %T %s" remotes/git-svn |
> > +	perl -lne "print unless \$seen{\$_}++" |
> > +	cut -d" " -f1-2 >a &&
> > +     git log --format="tree %T" remotes/alt >b &&
> >       test_cmp a b'
> 
> The future of non-strict one-liners with Perl7 on the horizon
> seems uncertain :<   cut is unnecessary either way, but
> I suggest awk, here:
> 
> 	awk "!seen[\$0]++ { print \$1, \$2 }'

Thanks, that is nicer.

> >  name='check imported tree checksums expected tree checksums'
> > 
> > It does lose a little bit of information, which is that in the original
> > we confirmed that the duplicates were always next to each other. But I'm
> > not sure that's important. We'd get confused if the same subject
> > appeared twice, but all of the commits have distinct hard-coded
> > subjects in the earlier tests.
> 
> Yeah, but I think it's fine.  It's been a while since I wrote
> this

OK. If you're on board, then I think doing it this way is slightly
nicer, as it's less likely to be confusing or bite somebody in the
future.

Here's a revised patch (I see Junio already picked up the other fix; if
that ends up being merged instead, that's not the end of the world).

(compared to the earlier version, you can skip everything in the commit
message before "One fix would be...").

-- >8 --
Subject: [PATCH] t9100: stop depending on commit timestamps

The early part of t9100 creates an unusual "doubled" history in the
"git-svn" ref. When we get to t9100.17, it looks like this:

  $ git log --oneline --graph git-svn
  [...]
  *   efd0303 detect node change from file to directory #2
  |\
  * | 3e727c0 detect node change from file to directory #2
  |/
  *   3b00468 try a deep --rmdir with a commit
  |\
  * | b4832d8 try a deep --rmdir with a commit
  |/
  * f0d7bd5 import for git svn

Each commit we make with "git commit" is paired with one from "git svn
set-tree", with the latter as a merge of the first and its grandparent.

Later, t9100.17 wants to check that "git svn fetch" gets the same trees.
And it does, but just one copy of each. So it uses rev-list to get the
tree of each commit and pipes it to "uniq" to drop the duplicates. Our
input isn't sorted, but it will find adjacent duplicates. This works
reliably because the order of commits from rev-list always shows the
duplicates next to each other. For any one of those merges, we could
choose to show its duplicate or the grandparent first. But barring
clocks running backwards, the duplicate will always have a time equal to
or greater than the grandparent. Even if equal, we break ties by showing
the first-parent first, so the duplicates remain adjacent.

But this would break if the timestamps stopped moving in chronological
order. Normally we would rely on test_tick for this, but we have _two_
sources of time here:

  - "git commit" creates one commit based on GIT_COMMITTER_DATE (which
    respects test_tick)

  - the "svn set-tree" one is based on subversion, which does not have
    an easy way to specify a timestamp

So using test_tick actually breaks the test, because now the duplicates
are far in the past, and we'll show the grandparent before the
duplicate. And likewise, a proposed change to set GIT_COMMITTER_DATE in
all scripts will break it.

One fix would be to sort the list of trees before removing duplicates,
but that loses information:

  - we do care that the fetched history is in the same order

  - there's a tree which appears twice in the history, and we'd want to
    make sure that it's there both times

So instead, let's de-duplicate using a hash (preserving the order), and
drop only lines with identical trees and subjects (preserving the tree
which appears twice, since it has different subjects each time).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9100-git-svn-basic.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 9f2d19ecc4..3055943a22 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -200,8 +200,9 @@ GIT_SVN_ID=alt
 export GIT_SVN_ID
 test_expect_success "$name" \
     'git svn init "$svnrepo" && git svn fetch &&
-     git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
-     git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
+     git log --format="tree %T %s" remotes/git-svn |
+	awk "!seen[\$0]++ { print \$1, \$2 }" >a &&
+     git log --format="tree %T" alt >b &&
      test_cmp a b'
 
 name='check imported tree checksums expected tree checksums'
-- 
2.28.0.rc0.394.ga62ae196ad

