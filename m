From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Mon, 17 Dec 2007 11:57:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171151490.9446@racer.site>
References: <20071215155150.GA24810@coredump.intra.peff.net>
 <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net>
 <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org>
 <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net>
 <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071216221545.GA32596@coredump.intra.peff.net>
 <7vtzmii8io.fsf@gitster.siamese.dyndns.org> <20071216222919.GA2260@coredump.intra.peff.net>
 <EBD73F46-810F-4605-972C-54EED0EF9A63@wincent.com> <Pine.LNX.4.64.0712171038130.9446@racer.site>
 <36E62F9B-26FF-4DC0-99B8-D6DC2B960E67@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:58:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Ebp-0004HN-IS
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 12:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763196AbXLQL5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 06:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935380AbXLQL5q
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:57:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:54407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763190AbXLQL5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 06:57:45 -0500
Received: (qmail invoked by alias); 17 Dec 2007 11:57:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 17 Dec 2007 12:57:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cyrcqwmbcwjq42Br7n+eU7TPi5mjApgleR4OZjT
	G79UcyDU9jc1Fl
X-X-Sender: gene099@racer.site
In-Reply-To: <36E62F9B-26FF-4DC0-99B8-D6DC2B960E67@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68548>

Hi,

On Mon, 17 Dec 2007, Wincent Colaiuta wrote:

> El 17/12/2007, a las 11:39, Johannes Schindelin escribi?:
> 
> > On Mon, 17 Dec 2007, Wincent Colaiuta wrote:
> > 
> > > El 16/12/2007, a las 23:29, Jeff King escribi?:
> > > 
> > > > On Sun, Dec 16, 2007 at 02:23:27PM -0800, Junio C Hamano wrote:
> > > > 
> > > > > > Aren't we using "git diff" for the second diff there nowadays?
> > > > > 
> > > > > Some people seem to think that is a good idea, but I generally 
> > > > > do not like using "git diff" between expect and actual (both 
> > > > > untracked) inside tests.  The last "diff" is about validating 
> > > > > what git does and using "git diff" there would make the test 
> > > > > meaningless when "git diff" itself is broken.
> > > > 
> > > > I think that is a valid concern. But ISTR that were some issues 
> > > > with using GNU diff. Commit 5bd74506 mentions getting rid of the 
> > > > dependency in all existing tests, but gives no reason.
> > > 
> > > I'd say it's safe and sensible to use "git diff" in all tests 
> > > *except* for tests of "git diff" itself.
> > 
> > To the contrary.  It has to test "git diff", so it must use "git 
> > diff".
> 
> Obviously, you can only test "git diff" by actually running it.

Sorry, I should have made clear that I meant this as funny:

	;-)

> > As for the reference output: we include the expected diffs as texts, 
> > and therefore do not really have to rely on having GNU diff installed.
> > 
> > Besides, we cannot even test the goodies like "rename from" by 
> > comparing to GNU diff's output.
> 
> Sorry, I didn't make myself clear. That's not what I was proposing at 
> all. I was talking about this kind of example:
> 
> > + git diff -U0 | sed -e "/^index/d" -e "s/$z2047/Z/g" >actual &&
> > + diff -u expect actual
> 
> First line uses "git diff", if the second line uses "git diff" as well 
> and "git diff" happens to be broken then you're using a broken tool to 
> test a broken tool, as Junio already pointed out.

Hmm.  There is some chicken-and-egg problem here (I read the thread, but 
did not really see a problem, as I assumed that _other_ tests would assure 
that "git diff --no-index" works as expected).

But as at least one released version of GNU diff has a pretty serious bug, 
I would rather not rely too much on diff.  (BTW this was the reason I 
wanted --no-index so badly.)

So yeah, the second "diff" cannot be "git diff".  Maybe "cmp", but not 
"git diff".

Ciao,
Dscho
