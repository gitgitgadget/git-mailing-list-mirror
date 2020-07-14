Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7897C433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B819421D79
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 12:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGNMbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:31:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:56984 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbgGNMbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 08:31:43 -0400
Received: (qmail 6096 invoked by uid 109); 14 Jul 2020 12:31:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2020 12:31:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31639 invoked by uid 111); 14 Jul 2020 12:31:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2020 08:31:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Jul 2020 08:31:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 0/4] deterministic commit timestamps in tests
Message-ID: <20200714123142.GA2587001@coredump.intra.peff.net>
References: <20200709203336.GA2748777@coredump.intra.peff.net>
 <xmqqa707rpuu.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa707rpuu.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 10, 2020 at 03:02:01PM -0700, Junio C Hamano wrote:

> I have this queued on top for today's integration run.  The last
> step is something worth doing in the longer term, but certainly not
> for the upcoming release ;-).
> 
> -- >8 --
> Subject: [PATCH] BANDAID: t9100.17 & t9100.18

Oof, thanks for catching. I don't usually have subversion on my system
at all. I have been trying to pay more attention to our CI, but I have
another topic I've been working on that has been causing failures in my
integration runs, so I didn't notice this one.

It took me a while to untangle just what's happening in the test, but I
think your "unset" workaround is actually what we want. The patch below
could go second-to-last in jk/tests-timestamp-fix, before the actual
switch to setting GIT_COMMITTER_DATE.

-- >8 --
Subject: [PATCH] t9100: explicitly unset GIT_COMMITTER_DATE

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

We _could_ fix this by sorting before removing duplicates, but
presumably it's a useful part of the test to make sure the trees appear
in the same order in both spots. Likewise, we could use something like:

  perl -ne 'print unless $seen{$_}++'

to remove duplicates without impacting the order. But that doesn't work
either, because there are actually multiple (non-duplicate) commits with
the same trees (we change a file mode and then change it back). So we'd
actually have to de-duplicate the combination of subject and tree. Which
then further throws off t9100.18, which compares the tree hashes
exactly; we'd have to strip the result back down.

Since this test _isn't_ buggy, the simplest thing is to just work around
the proposed change by documenting our expectation that git-created
commits are correctly interleaved using the current time.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9100-git-svn-basic.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 9f2d19ecc4..b80952f0ac 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -8,6 +8,10 @@ GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
 . ./lib-git-svn.sh
 
+# Make sure timestamps of commits created by Git interleave
+# with those created by "svn set-tree".
+unset GIT_COMMITTER_DATE
+
 case "$GIT_SVN_LC_ALL" in
 *.UTF-8)
 	test_set_prereq UTF8
-- 
2.28.0.rc0.402.g7b15ae678a

