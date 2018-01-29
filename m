Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8A01FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 12:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeA2MG2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 07:06:28 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36508 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbeA2MG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 07:06:28 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8EC941F404;
        Mon, 29 Jan 2018 12:06:27 +0000 (UTC)
Date:   Mon, 29 Jan 2018 12:06:27 +0000
From:   Eric Wong <e@80x24.org>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: t9128 failing randomly with svn 1.9?
Message-ID: <20180129120627.al2xvx4yhhvwn6ih@untitled>
References: <20180129015134.GN431130@genre.crustytoothpaste.net>
 <20180129025812.GD1427@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180129025812.GD1427@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> wrote:
> brian m. carlson wrote:
> > r7 = f8467f2cee3bcead03e84cb51cf44f467a87457d (refs/remotes/origin/tags/tag3)
> > error: git-svn died of signal 11
> > 
> > Doing the following three times, I had two crashes.
> > 
> > (set -e; for i in $(seq 1 20); do (cd t && ./t9128-git-svn-cmd-branch.sh --verbose); done)
> > 
> > I'm not really familiar with git svn or its internals, and I didn't see
> > anything recently on the list about this.  Is this issue known?

The SVN bindings have been known to crash occasionally and I
can't really get my head around XS/Swig or Perl internals :/
Looking at the coredump, it seems to be around exit and
destruction (only Perl in the stacktrace, nothing from libsvn).
So I suspect it's a lifetime or ordering bug, testing a patch
below (slowly).

"branch" is also the only place we use SVN::Client->new these
days.

> For me, it's tests 3 and 4 which fail with the same error.
> I thought it was a failure in subversion or the perl
> bindings rather than git, so I simply disabled them in the
> Fedora builds.  The Debian packages skip 9128 as well (and
> 9167, which fails similarly).
> 
> I've seen the failures in t9141 from 'git svn branch' as
> well.  I made a note to re-enable those tests after Jeff's
> work to make it easier to run with shell tracing enabled by
> default, but have not done so yet.

Just a guess, but it might be related to destruction order.
Running t9128 on a 32-bit Pentium-M, it took me 39 tries to
fail.

diff --git a/git-svn.perl b/git-svn.perl
index 76a75d0b3d..2ba14269bb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1200,6 +1200,11 @@ sub cmd_branch {
 	$ctx->copy($src, $rev, $dst)
 		unless $_dry_run;
 
+	# Release resources held by ctx before creating another SVN::Ra
+	# so destruction is orderly.  This seems necessary Subversion 1.9.5
+	# to avoid segfaults.
+	$ctx = undef;
+
 	$gs->fetch_all;
 }
 

I'll be looping t9128, t9141 and t9167 with that for a few
hours or day.  Will report back sooner if it fails.
I'm on an ancient 32-bit system, I guess you guys encountered
it on 64-bit machines?
