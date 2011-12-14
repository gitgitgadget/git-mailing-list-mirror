From: Jeff King <peff@peff.net>
Subject: Re: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue,
 13))
Date: Wed, 14 Dec 2011 18:07:13 -0500
Message-ID: <20111214230713.GA13128@sigill.intra.peff.net>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
 <20111214070916.GA14954@elie.hsd1.il.comcast.net>
 <201112141717.15021.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Dec 15 00:07:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raxv0-0000EQ-4N
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 00:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758344Ab1LNXHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 18:07:17 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50237
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164Ab1LNXHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 18:07:16 -0500
Received: (qmail 3354 invoked by uid 107); 14 Dec 2011 23:13:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 18:13:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 18:07:13 -0500
Content-Disposition: inline
In-Reply-To: <201112141717.15021.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187174>

On Wed, Dec 14, 2011 at 05:17:14PM +0100, Thomas Rast wrote:

> > I also find Jeff's patch [3] appealing.
> 
> Me too, though wonder whether feeding a file full of garbage wouldn't
> be better, so as to trip up commands that try to read only from a
> non-tty stdin.

Interesting idea. Instead of getting an immediate EOF from /dev/null,
they'll get some junk which they may or may not complain about. I played
around with this a bit, redirecting test stdin from a file with:

  This is a garbage file that will be connected to the stdin of each
  test.

(with the hope that when you see that in an error message, it will be
obvious what has happened).

It turns out that shortlog (the one bug of this type in the test suite)
doesn't care at all. It will happily chew on that garbage and behave
just the same as if it had been given /dev/null.

There is also the minor issue that if there are multiple invocations of
the input-chewing command, the first one will eat all of the input, and
subsequent ones will just get the equivalent of /dev/null anyway. I.e.:

  test_expect_success 'git shortlog $foo' ;# will eat all of our stdin
  test_expect_success 'git shortlog $bar' ;# sees immediate EOF

That may not matter, though, as you would hope for the first invocation
to complain, at which point you fix it, revealing the failures in later
tests (or if you're clever, noticing in the first place that they all
have the same bug).

You can make this somewhat more robust by redirecting stdin for
_test_eval (so each test gets a fresh descriptor to the garbage file).
However, that disallows redirecting a specific test's stdin in the test
script, like:

  test_expect_success 'some test' '
    cat >expect &&
    some_command >actual &&
    test_cmp expect actual
  ' <<\EOF
  the expected
  data
  EOF

This construct probably seems silly at first, but see how it is used in
t6006:

  test_format author %an%n%ae%n%ad%n%aD%n%at <<\EOF
  commit ...
  A U Thor
  author@example.com
  ... etc ...
  EOF

where test_format is a generic function that just gobbles stdin into the
"expect" file. As it turns out, test_format actually runs the "cat"
outside of the "test_expect_success", but quite often we put it inside.
So maybe it isn't worth caring about. You could also argue that the
whole thing should just be inside a test_expect_success.

-Peff
