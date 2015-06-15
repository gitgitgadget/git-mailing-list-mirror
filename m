From: Jeff King <peff@peff.net>
Subject: [PATCH] Revert "stash: require a clean index to apply"
Date: Mon, 15 Jun 2015 14:27:22 -0400
Message-ID: <20150615182721.GA4041@peff.net>
References: <5570F094.10007@quantopian.com>
 <20150607124001.GA11042@peff.net>
 <CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
 <20150610185635.GA22800@peff.net>
 <xmqq616vl6gm.fsf@gitster.dls.corp.google.com>
 <20150610192734.GA23715@peff.net>
 <xmqqsi9samx1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?b=C3=A4r?= <crashcookie@gmail.com>,
	Jonathan Kamens <jkamens@quantopian.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:27:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Z6Y-0001Ii-SE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbbFOS10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:27:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:46327 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754315AbbFOS1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:27:24 -0400
Received: (qmail 1135 invoked by uid 102); 15 Jun 2015 18:27:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Jun 2015 13:27:24 -0500
Received: (qmail 5855 invoked by uid 107); 15 Jun 2015 18:27:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Jun 2015 14:27:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jun 2015 14:27:22 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsi9samx1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271699>

On Mon, Jun 15, 2015 at 10:42:18AM -0700, Junio C Hamano wrote:

> > I dunno. With respect to the original patch, I am OK if we just want to
> > revert it. This area of stash seems a bit under-designed IMHO, but if
> > people were happy enough with it before, I do not think the safety
> > benefit from ed178ef is that great (it is not saving you from destroying
> > working tree content, only the index state; the individual content blobs
> > are still available from git-fsck).
> 
> Yeah, I agree.   Somebody care to do the log message?

Patch is below. It's a straight revert. The other option would be to
allow it with "--force", and teach people to use that. I'm not sure it's
worth the effort.

> This is a tangent, but I'd actually not just agree with "'stash -k'
> is a bit under-designed" but also would say something stronger than
> that, IMHO ;-)

Yeah, I agree with everything you said here. :)

-- >8 --
Subject: Revert "stash: require a clean index to apply"

This reverts commit ed178ef13a26136d86ff4e33bb7b1afb5033f908.

That commit was an attempt to improve the safety of applying
a stash, because the application process may create
conflicted index entries, after which it is hard to restore
the original index state.

Unfortunately, this hurts some common workflows around "git
stash -k", like:

    git add -p       ;# (1) stage set of proposed changes
    git stash -k     ;# (2) get rid of everything else
    make test        ;# (3) make sure proposal is reasonable
    git stash apply  ;# (4) restore original working tree

If you "git commit" between steps (3) and (4), then this
just works. However, if these steps are part of a pre-commit
hook, you don't have that opportunity (you have to restore
the original state regardless of whether the tests passed or
failed).

It's possible that we could provide better tools for this
sort of workflow. In particular, even before ed178ef, it
could fail with a conflict if there were conflicting hunks
in the working tree and index (since the "stash -k" puts the
index version into the working tree, and we then attempt to
apply the differences between HEAD and the old working tree
on top of that). But the fact remains that people have been
using it happily for a while, and the safety provided by
ed178ef is simply not that great. Let's revert it for now.
In the long run, people can work on improving stash for this
sort of workflow, but the safety tradeoff is not worth it in
the meantime.

Signed-off-by: Jeff King <peff@peff.net>
---
This is directly on jk/stash-require-clean-index, but it should merge
fine up to master.

 git-stash.sh     | 2 --
 t/t3903-stash.sh | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index cc28368..d4cf818 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -442,8 +442,6 @@ apply_stash () {
 	assert_stash_like "$@"
 
 	git update-index -q --refresh || die "$(gettext "unable to refresh index")"
-	git diff-index --cached --quiet --ignore-submodules HEAD -- ||
-		die "$(gettext "Cannot apply stash: Your index contains uncommitted changes.")"
 
 	# current index state
 	c_tree=$(git write-tree) ||
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0746eee..f179c93 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -45,13 +45,6 @@ test_expect_success 'applying bogus stash does nothing' '
 	test_cmp expect file
 '
 
-test_expect_success 'apply requires a clean index' '
-	test_when_finished "git reset --hard" &&
-	echo changed >other-file &&
-	git add other-file &&
-	test_must_fail git stash apply
-'
-
 test_expect_success 'apply does not need clean working directory' '
 	echo 4 >other-file &&
 	git stash apply &&
-- 
2.4.3.699.g84b4da7
