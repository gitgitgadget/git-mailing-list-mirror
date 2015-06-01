From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: dereference tags with
 --ignore-if-in-upstream
Date: Mon, 1 Jun 2015 07:47:29 -0400
Message-ID: <20150601114729.GA5160@peff.net>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
 <1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
 <20150601102046.GA31792@peff.net>
 <20150601112212.GA140991@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 13:47:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzOBt-0006sq-88
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 13:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbbFALrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 07:47:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:38750 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751609AbbFALrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 07:47:31 -0400
Received: (qmail 4051 invoked by uid 102); 1 Jun 2015 11:47:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 06:47:31 -0500
Received: (qmail 28747 invoked by uid 107); 1 Jun 2015 11:47:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 07:47:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 07:47:29 -0400
Content-Disposition: inline
In-Reply-To: <20150601112212.GA140991@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270402>

On Mon, Jun 01, 2015 at 11:22:12AM +0000, brian m. carlson wrote:

> > As an aside, now that we are dereferencing, these flags are from the
> > wrong object. They _should_ be the same (we mark the tag as
> > UNINTERESTING, too), but it's a little weird that at the end of the
> > function we restore the saved flags from the tag object onto the commit.
> > Just bumping the assignment of flags{1,2} would work (or just bump up
> > the lookup_commit_or_die call to where we assign to o{1,2}).
> 
> I tried looking up the flags after dereferencing the tags, but that led
> to the die("Not a range.") being triggered.  That's why the commit
> message ended up mentioning loading the flags before dereferencing.

Oh, sorry, I somehow totally missed that mention in the commit message.

It seems doubly wrong then to pull the flags from the tag and then later
apply them to the commit at the end. And in fact, if you do not have the
UNINTERESTING flag on your commit here, that is a real problem. If we
make your test:

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 60b9875..37bf70a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -60,8 +60,9 @@ test_expect_success "format-patch --ignore-if-in-upstream" '
 test_expect_success "format-patch --ignore-if-in-upstream handles tags" '
 
 	git tag -a v1 -m tag side &&
+	git tag -a v2 -m tag master &&
 	git format-patch --stdout \
-		--ignore-if-in-upstream master..v1 >patch1 &&
+		--ignore-if-in-upstream v2..v1 >patch1 &&
 	cnt=$(grep "^From " patch1 | wc -l) &&
 	test $cnt = 2
 

then it fails (the key is having the tag on the left-hand side, because
that is where we need the UNINTERESTING flag to be).

Normally this flag is propagated to the dereferenced commit as part of
prepare_revision_walk, but we are looking at the flags before that gets
called. So you'll have to either propagate it manually here, or just
feed the original tags to the sub-traversal. I think the latter is
probably simpler. Something like:

  1. Check the flags on the original objects (o1 and o2).

  2. Peel them to commits; complain if they're not both commits. Store
     the result in another variable (e.g., commit1, commit2).

  3. Feed o1 and o2 to the new check_rev traversal.

  4. Clear the commit flags off of commit1 and commit2.

  5. Restore the original flags to o1 and o2.

Yeesh. I would have thought that we could just do this as part of the
normal traversal by using "--cherry-pick" (I think format-patch predates
that option). We have to have a symmetric range to do that, but I wonder
if we could simulate it by converting "foo..bar" into "--cherry-pick
--right-only foo...bar".

I guess that is basically "--cherry", but we still have to massage
"foo..bar" into "foo...bar". I think that is basically just:

   o1 ^= ~UNINTERESTING;
   o1 |= SYMMETRIC_LEFT;

but there might be a hidden catch I am not considering.

> > I think this avoids the usual "wc" whitespace pitfall because you don't
> > use double-quotes. But maybe:
> > 
> >   grep "^From " patch1 >count &&
> >   test_line_count = 2 patch1
> > 
> > would be more idiomatic.
> 
> I can certainly make that change.  I made the test as similar as
> possible to other tests in the area, but I wasn't aware of
> test_line_count.

Ah, I just looked at the context in your patch, not at the whole test. I
don't mind matching the surrounding code. But I also don't mind a
preparatory modernization patch to the test script. :)

-Peff
