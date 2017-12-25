Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A1E1FADF
	for <e@80x24.org>; Mon, 25 Dec 2017 03:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdLYDwU (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 22:52:20 -0500
Received: from imap.thunk.org ([74.207.234.97]:53988 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbdLYDwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 22:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cWcLJ1Bwv9gJsAScOFmeqr7rXn1dxxQm5CZVDYjkmL0=; b=hbGwxyR/m2PbUvRVuTPbgHPUVz
        fHdRTaoiMwUcrvw1W1jVuWgdw6RgwSx1QmflxlqUjk422Hsnk5ji5UOvWcCPzVeph/ILDMHNFEdhb
        YyhAt/p1ueziEt76eUWIKGiPxcO4CFAW1BnJ5dlLIWnhzNjkMK7uuvdZKeJTVMr/XZqs=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1eTJoI-0004Fj-2O; Mon, 25 Dec 2017 03:52:18 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8E253C00723; Sun, 24 Dec 2017 22:52:15 -0500 (EST)
Date:   Sun, 24 Dec 2017 22:52:15 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171225035215.GC1257@thunk.org>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 11:10:19PM -0700, Carl Baldwin wrote:
> I've been calling this proposal `git replay` or `git replace` but I'd
> like to hear other suggestions for what to name it. It works like
> rebase except with one very important difference. Instead of orphaning
> the original commit, it keeps a pointer to it in the commit just like
> a `parent` entry but calls it `replaces` instead to distinguish it
> from regular history. In the resulting commit history, following
> `parent` pointers shows exactly the same history as if the commit had
> been rebased. Meanwhile, the history of iterating on the change itself
> is available by following `replaces` pointers. The new commit replaces
> the old one but keeps it around to record how the change evolved.

As a suggestion, before diving into the technical details of your
proposal, it might be useful consider the usage scenario you are
targetting.  Things like "git rebase" and "git merge" and your
proposed "git replace/replay" are *mechanisms*.

But how they fit into a particular workflow is much more important
from a design perspective, and given that there are many different git
workflows which are used by different projects, and by different
developers within a particular project.

For example, rebase gets used in many different ways, and many of the
debates when people talk about "git rebase" being evil generally
presuppose a particular workflow that that the advocate has in mind.
If someone is using git rebase or git commit --amend before git
commits have ever been pushed out to a public repository, or to anyone
else, that's a very different case where it has been visible
elsewhere.  Even the the most strident, "you must never rewrite a
commit and all history must be preserved" generally don't insist that
every single edit must be preserved on the theory that "all history is
valuable".

> The git history now has two dimensions. The first shows a cleaned up
> history where fix ups and code review feedback have been rolled into
> the original changes and changes can possibly be ordered in a nice
> linear progression that is much easier to understand. The second
> drills into the history of a change. There is no loss and you don't
> change history in a way that will cause problems for others who have
> the older commits.

If your goal is to preserve the history of the change, one of the
problems with any git-centric solution is that you generally lose the
code review feedback and the discussions that are involved with a
commit.  Just simply preserving the different versions of the commits
is going to lose a huge amount of the context that makes the history
valuable.

So for example, I would claim that if *that* is your goal, a better
solution is to use Gerrit, so that all of the different versions of
the commits are preserved along with the line-by-line comments and
discussions that were part of the code review.  In that model, each
commit has something like this in the commit trailer:

Change-Id: I8d89b33683274451bcd6bfbaf75bce98

You can then cut and paste the Change-Id into the Gerrit user
interface, and see the different commits, more important, the
discussion surrounding each change.


If the complaint about Gerrit is that it's not a core part of Git, the
challenge is (a) how to carry the code review comments in the git
repository, and (b) do so in a while that it doesn't bloat the core
repository, since most of the time, you *don't* want or need to keep a
local copy of all of the code review comments going back since the
beginning of the project.

-------------

Here's another potential use case.  The stable kernels (e.g., 3.18.y,
4.4.y, 4.9.y, etc.) have cherry picks from the the upstream kernel,
and this is handled by putting in the commit body something like this:

    [ Upstream commit 3a4b77cd47bb837b8557595ec7425f281f2ca1fe ]

----

And here's yet another use case.  For internal Google kernel
development, we maintain a kernel that has a large number of patches
on top of a kernel version.  When we backport an upstream fix (say,
one that first appeared in the 4.12 version of the upstream kernel),
we include a line in the commit body that looks like this:

Upstream-4.12-SHA1: 5649645d725c73df4302428ee4e02c869248b4c5

This is useful, because when we switch to use a newer upstream kernel,
we need make sure we can account for all patches that were built on
top of the 3xx kernel (which might have been using 4.10, for the sake
of argument), to the 4xx kernel series (which might be using 4.15 ---
the version numbers have been changed to protect the innocent).  This
means going through each and every patch that was on top of the 3xx
kernel, and if it has a line such as "Upstream 4.12-SHA1", we know
that it will already be included in a 4.15 based kernel, so we don't
need to worry about carrying that patch forward.

In other cases, we might decide that the patch is no longer needed.
It could be because the patch has already be included upstream, in
which case we might check in a commit with an empty patch body, but
whose header contains something like this in the 4xx kernel:

Origin-3xx-SHA1: fe546bdfc46a92255ebbaa908dc3a942bc422faa
Upstream-Dropped-4.11-SHA1: d90dc0ae7c264735bfc5ac354c44ce2e

Or we could decide that the commit is no longer no longer needed ---
perhaps because the relevant subsystem was completely rewritten and
the functionality was added in a different way.  Then we might have
just have an empty commit with an explanation of why the commit is no
longer needed and the commit body would have the metadata:

Origin-Dropped-3xx-SHA1: 26f49fcbb45e4bc18ad5b52dc93c3afe

Or perhaps the commit is still needed, and for various reasons the
commit was never upstreamed; perhaps because it's only useful for
Google-specific hardware, or the patch was rejected upstream.  The we
will have a cherry-pick that would include in the body:

Origin-3xx-SHA1: 8f3b6df74b9b4ec3ab615effb984c1b5


(Note: all commits that are added in the rebase workflow, even the
empty commits that just have the Origin-Dropped-3xx-SHA1 or
Upstream-Droped-4.11-SHA1 headers, are patch reviewed through Gerrit,
so we have an audited, second-engineer review to make sure each commit
in the 3xx kernel that Google had been carrying had the correct
disposition when rebasing to the 4xx kernel.)

The point is that for this much more complex, real-world workflow, we
need much *more* metadata than a simple "Replaces" metadata.  (And we
also have other metadata --- for example, we have a "Tested: " trailer
that explains how to test the commit, or which unit test can and
should be used to test this commit, combined with a link to the test
log in our automated unit tester that has the test run, and a
"Rebase-Tested-4xx: " trailer that might just have the URL to the test
log when the commit was rebased since the testing instructions in the
Tested: trailer is still relevant.)

And since this metadata is not really needed by the core git
machinery, we just use text trailers in the commit body; it's not hard
to write code which parses this out of the git commit.

> Various git commands will have to learn how to handle this kind of
> history. For example, things like fetch, push, gc, and others that
> move history around and clean out orphaned history should treat
> anything reachable through `replaces` pointers as precious. Log and
> related history commands may need new switches to traverse the history
> differently in different situations.

I'd encourage you to think very hard about how exactly "git log" and
"gitk" might actually deal with these links.  In the Google kernel
development use cases, we use different repos for the 3xx and 4xx
kernels.  It would be possible to make hot links for the
Original-3xx-SHA1: trailers, but you couldn't do it using gitk.  It
would actually have to be a completely new tool.  (And we do have new
tools, most especially a dashboard so we can keep track of how many
commits in the 3xx kernel still have to be rebased to the 4xx kernel,
or can be confirmed to be in the upstream kernel, or can be confirmed
to be dropped.  We have a *large* number of patches that we carry, so
it's a multi-month effort involving a large number of engineers
working together to do a kernel rebase operation from a 4.x upstream
kernel to a 4.y upstream kernel.  So having a dashboard is useful
because we can see whether a particular subsystem team is ahead or
behind the curve in terms of handling those commits which are their
responsibility.)


My experience, from seeing these much more complex use cases ---
starting with something as simple as the Linux Kernel Stable Kernel
Series, and extending to something much more complex such as the
workflow that is used to support a Google Kernel Rebase, is that using
just a simple extra "Replaces" pointer in the commit header is not
nearly expressive enough.  And, if you make it a core part of the
commit data structure, there are all sorts of compatibility headaches
with older versions of git that wouldn't know about it.  And if it
then turns out it's not sufficient more the more complex workflows
*anyway*, maybe adding a new "replace" pointer in the core git data
structures isn't worth it.  It might be that just keeping such things
as trailers in the commit body might be the better way to go.

Cheers,

						- Ted
