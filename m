From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Mon, 10 Nov 2014 01:09:35 -0500
Message-ID: <20141110060935.GA24860@peff.net>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net>
 <20141109015918.GA24736@peff.net>
 <CAPc5daUJBs-GwEkJPwru6wjb6pJOMSceEAznXQ+ZW-mOyr-ipw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 07:09:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XniAY-00067g-CX
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 07:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbaKJGJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 01:09:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:38587 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbaKJGJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 01:09:38 -0500
Received: (qmail 14478 invoked by uid 102); 10 Nov 2014 06:09:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 00:09:38 -0600
Received: (qmail 32272 invoked by uid 107); 10 Nov 2014 06:09:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 01:09:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 01:09:35 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daUJBs-GwEkJPwru6wjb6pJOMSceEAznXQ+ZW-mOyr-ipw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 09, 2014 at 06:56:45PM -0800, Junio C Hamano wrote:

> > We could fix this by using a "--" to disambiguate, but we
> > are probably better off using names that are less confusing
> > to make it more clear that they are unrelated to the working
> > tree files.  This patch turns "a/b" into "one/two".
> 
> Hmph, but the branch a and the file A _do_ have names that are
> unrelated to each other, and it is only the case insensitive fs
> that is confused ;-).  Renaming is not so bad and certainly is
> not wrong per-se as a workaround, but I have this suspicion
> that it sends a wrong message to people on such a filesystem,
> namely, "you cannot use Git to manage a file called 'master'",
> or something silly like that. Disambiguation with double-dashes
> does not have such a problem, and instead shows a way how
> scripts that are meant to be portable is written. More importantly,
> that is more in line with the problem description (i.e. we complain
> pointing out the ambiguity, implying that everything is fine as long
> as you disambiguate).
>
> 
> So I would rather see the workaround done that way.

My main concern is that it leaves t1410 in an "accident waiting to
happen" state, where some hapless developer will add a new test using
a/b and not realizing they need to be careful to disambiguate. The test
will pass for them on Linux, but some luckless OS X user will end up
wasting time tracking down the error.

Or another way of looking at it: it is perfectly possible to have git
manage a file called "master" or even "HEAD". But that does not mean it
is a _good idea_, or is without annoyances. :)

> But that is only if this were before you actually wrote the patch.
> The above is not a preference strong enough to make me ask
> you to reroll ;-)

The alternate form is quite trivial. I think I still prefer the
"one/two" version, but here is the "--" patch for reference. You can
decide which to pick up.

-- >8 --
Subject: t1410: fix breakage on case-insensitive filesystems

Two tests recently added to t1410 create branches "a" and
"a/b" to test d/f conflicts on reflogs. Earlier tests in
that script create the path "A/B" in the working tree.
There's no conflict on a case-sensitive filesystem, but on a
case-insensitive one, "git log" will complain that "a/b" is
both a revision and a working tree path.

We can fix this by using "--" to disambiguate.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1410-reflog.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 976c1d4..48bcd59 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -258,7 +258,7 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
 
 	git branch a/b master &&
 	echo "a/b@{0} branch: Created from master" >expect &&
-	git log -g --format="%gd %gs" a/b >actual &&
+	git log -g --format="%gd %gs" a/b -- >actual &&
 	test_cmp expect actual &&
 	git branch -d a/b &&
 
@@ -266,7 +266,7 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
 	# we should move it out of the way to create "a" reflog
 	git branch a master &&
 	echo "a@{0} branch: Created from master" >expect &&
-	git log -g --format="%gd %gs" a >actual &&
+	git log -g --format="%gd %gs" a -- >actual &&
 	test_cmp expect actual
 '
 
@@ -275,7 +275,7 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
 
 	git branch a/b master &&
 	echo "a/b@{0} branch: Created from master" >expect &&
-	git log -g --format="%gd %gs" a/b >actual &&
+	git log -g --format="%gd %gs" a/b -- >actual &&
 	test_cmp expect actual &&
 	git branch -d a/b &&
 
@@ -283,7 +283,7 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
 	# it already exists, which it does not
 	git -c core.logallrefupdates=false branch a master &&
 	: >expect &&
-	git log -g --format="%gd %gs" a >actual &&
+	git log -g --format="%gd %gs" a -- >actual &&
 	test_cmp expect actual
 '
 
-- 
2.1.2.596.g7379948
