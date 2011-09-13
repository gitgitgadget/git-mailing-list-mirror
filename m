From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3200: test branch creation with -v
Date: Mon, 12 Sep 2011 23:57:24 -0400
Message-ID: <20110913035724.GA4828@sigill.intra.peff.net>
References: <20110909193033.GA31184@sigill.intra.peff.net>
 <49578782dd114220aa2562b5bd29755fc2bdd0fa.1315597137.git.git@drmicha.warpmail.net>
 <20110909194357.GA31446@sigill.intra.peff.net>
 <4E6B6647.7090802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 05:57:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3K7o-0007oi-Hf
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 05:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab1IMD51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 23:57:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47598
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801Ab1IMD51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 23:57:27 -0400
Received: (qmail 22798 invoked by uid 107); 13 Sep 2011 03:58:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Sep 2011 23:58:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 23:57:24 -0400
Content-Disposition: inline
In-Reply-To: <4E6B6647.7090802@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181266>

On Sat, Sep 10, 2011 at 03:29:43PM +0200, Michael J Gruber wrote:

> Jeff King venit, vidit, dixit 09.09.2011 21:43:
> > On Fri, Sep 09, 2011 at 09:40:59PM +0200, Michael J Gruber wrote:
> > 
> >> +test_expect_success 'git branch -v t should work' ' +	git branch
> >> -v t && +	test .git/refs/heads/t &&
> > 
> > test -f ?
> > 
> > Also, don't we have test_path_is_file which yields slightly prettier 
> > output (and maybe some portability benefits; I don't remember)?
> > 
> >> +	git branch -d t && +	test ! -f .git/refs/heads/t
> > 
> > Ditto for 'test_path_is_missing' here.
> > 
> > -Peff
> 
> Well, I tried to follow the surrounding style. That t3200 could benefit
> from some attention, though, which I did not want to mix in with the
> issue at hand.

The "test_path_is_file" thing is style. But not using "test -f" is just
wrong; you are testing "is .git/refs/heads/t an empty string?" which is
useless.

You want this on top of what's in mg/branch-list:

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c466b20..b513115 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -100,14 +100,14 @@ test_expect_success 'git branch -m q r/q should fail when r exists' '
 
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
-	test .git/refs/heads/t &&
+	test -f .git/refs/heads/t &&
 	git branch -v -d t &&
 	test ! -f .git/refs/heads/t
 '
 
 test_expect_success 'git branch -v -m t s should work' '
 	git branch t &&
-	test .git/refs/heads/t &&
+	test -f .git/refs/heads/t &&
 	git branch -v -m t s &&
 	test ! -f .git/refs/heads/t &&
 	test -f .git/refs/heads/s &&
@@ -116,7 +116,7 @@ test_expect_success 'git branch -v -m t s should work' '
 
 test_expect_success 'git branch -m -d t s should fail' '
 	git branch t &&
-	test .git/refs/heads/t &&
+	test -f .git/refs/heads/t &&
 	test_must_fail git branch -m -d t s &&
 	git branch -d t &&
 	test ! -f .git/refs/heads/t
@@ -124,7 +124,7 @@ test_expect_success 'git branch -m -d t s should fail' '
 
 test_expect_success 'git branch --list -d t should fail' '
 	git branch t &&
-	test .git/refs/heads/t &&
+	test -f .git/refs/heads/t &&
 	test_must_fail git branch --list -d t &&
 	git branch -d t &&
 	test ! -f .git/refs/heads/t

I suspect you didn't notice the bogosity before because those are just
confirming the precondition that "git branch" actually created the file.

-Peff
