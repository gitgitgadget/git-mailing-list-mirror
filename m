Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA3C1F855
	for <e@80x24.org>; Fri, 29 Jul 2016 22:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbcG2Wbl (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 18:31:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:51395 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752937AbcG2Wbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 18:31:38 -0400
Received: (qmail 17674 invoked by uid 102); 29 Jul 2016 22:31:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 18:31:39 -0400
Received: (qmail 6106 invoked by uid 107); 29 Jul 2016 22:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 18:32:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 18:31:35 -0400
Date:	Fri, 29 Jul 2016 18:31:35 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" +
 "pull.rebase = preserve" - "user.email"
Message-ID: <20160729223134.GA22591@sigill.intra.peff.net>
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
 <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
 <20160729181121.GB14953@sigill.intra.peff.net>
 <xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 11:37:59AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... So I do think there may be a bug to be fixed,
> > but it is simply commands being over-eager to make sure we have an
> > ident when they might not need it.
> 
> 36267854 (pull: fast-forward "pull --rebase=true", 2016-06-29) may
> be a part of a good solution for that, perhaps?

Hmm. So the solution I came up with is below, and I think is the "most
correct" in the sense that it leaves the check to the low-level code
which actually creates commits, and so we know that we will absolutely
only ever complain when we actually need an ident.

But I could also see an argument along the lines of: if you do not have
an ident set up, you don't really have any business running "git rebase
-i" in the first place, and it is OK for us to complain even there's a
chance your rebase might be a noop. So we should prefer consistency over
absolute flexibility in rebase, and just fix the common case of invoking
"rebase" at all when we know it is a fast-forward.

Which is what your patch is doing. I can buy that argument in general
for rebase, though it is a little funny that "git pull --rebase" would
then behave differently than "git fetch && git rebase".

There's a middle ground, too, which goes something like: it is OK to
invoke "rebase" (interactive or not) without a valid ident if you have
no commits to rebase. But as soon as we know there are commits to pick,
we should do the ident check and bail, canceling the rebase entirely.

That seems to be what happens in the non-interactive case (we call "git
am --rebasing" and it bails immediately without leaving any state).
Implementing that would mean shifting rebase--interactive's ident check
to the right spot (after seeing the insn sheet has entries) and bailing
appropriately.

TBH, I'm not sure anybody cares that much between the three. Even before
user.useConfigOnly, this could be an issue on machines where the ident
could not be auto-configured, and it seems like nobody ran across it.
It's only the funny interaction with pull.rebase that makes it likely to
come up, so as long as that code path is fixed (one way or another), I
doubt anybody would bring it up again.

Anyway, here's my patch.

-- >8 --
Subject: rebase-interactive: drop early check for valid ident

Since the very inception of interactive-rebase in 1b1dce4
(Teach rebase an interactive mode, 2007-06-25), there has
been a preemptive check, before looking at any commits, to
see whether the user has a valid name/email combination.

This is convenient, because it means that we abort the
operation before even beginning (rather than just
complaining that we are unable to pick a particular commit).

However, it does the wrong thing when the rebase does not
actually need to generate any new commits (e.g., a
fast-forward with no commits to pick, or one where the base
stays the same, and we just pick the same commits without
rewriting anything). In this case it may complain about the
lack of ident, even though one would not be needed to
complete the operation.

This may seem like mere nit-picking, but because interactive
rebase underlies the "preserve-merges" rebase, somebody who
has set "pull.rebase" to "preserve" cannot make even a
fast-forward pull without a valid ident, as we bail before
even realizing the fast-forward nature.

This commit drops the extra ident check entirely. This means
we rely on individual commands that generate commit objects
to complain. So we will continue to notice and prevent cases
that actually do create commits, but with one important
difference: we fail while actually executing the "pick"
operations, and leave the rebase in a conflicted, half-done
state.

In some ways this is less convenient, but in some ways it is
more so; the user can then manually commit or even "git
rebase --continue" after setting up their ident (or
providing it as a one-off on the command line).

Reported-by: Dakota Hawkins <dakotahawkins@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 git-rebase--interactive.sh |  3 ---
 t/t7517-per-repo-email.sh  | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ded4595..f0f4777 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1180,9 +1180,6 @@ To continue rebase after editing, run:
 	;;
 esac
 
-git var GIT_COMMITTER_IDENT >/dev/null ||
-	die "$(gettext "You need to set your committer info first")"
-
 comment_for_reflog start
 
 if test ! -z "$switch_to"
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index 337e6e3..2a22fa7 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -36,4 +36,51 @@ test_expect_success 'succeeds cloning if global email is not set' '
 	git clone . clone
 '
 
+test_expect_success 'set up rebase scenarios' '
+	# temporarily enable an actual ident for this setup
+	test_config user.email foo@example.com &&
+	test_commit new &&
+	git branch side-without-commit HEAD^ &&
+	git checkout -b side-with-commit HEAD^ &&
+	test_commit side
+'
+
+test_expect_success 'fast-forward rebase does not care about ident' '
+	git checkout -B tmp side-without-commit &&
+	git rebase master
+'
+
+test_expect_success 'non-fast-forward rebase refuses to write commits' '
+	test_when_finished "git rebase --abort || true" &&
+	git checkout -B tmp side-with-commit &&
+	test_must_fail git rebase master
+'
+
+test_expect_success 'fast-forward rebase does not care about ident (interactive)' '
+	git checkout -B tmp side-without-commit &&
+	git rebase -i master
+'
+
+test_expect_success 'non-fast-forward rebase refuses to write commits (interactive)' '
+	test_when_finished "git rebase --abort || true" &&
+	git checkout -B tmp side-with-commit &&
+	test_must_fail git rebase -i master
+'
+
+test_expect_success 'noop interactive rebase does not care about ident' '
+	git checkout -B tmp side-with-commit &&
+	git rebase -i HEAD^
+'
+
+test_expect_success 'fast-forward rebase does not care about ident (preserve)' '
+	git checkout -B tmp side-without-commit &&
+	git rebase -p master
+'
+
+test_expect_success 'non-fast-forward rebase refuses to write commits (preserve)' '
+	test_when_finished "git rebase --abort || true" &&
+	git checkout -B tmp side-with-commit &&
+	test_must_fail git rebase -p master
+'
+
 test_done
-- 
2.9.2.666.g67a7da4

