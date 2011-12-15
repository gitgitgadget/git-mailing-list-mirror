From: Jeff King <peff@peff.net>
Subject: Re: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue,
 13))
Date: Wed, 14 Dec 2011 19:25:30 -0500
Message-ID: <20111215002530.GA2566@sigill.intra.peff.net>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
 <20111214070916.GA14954@elie.hsd1.il.comcast.net>
 <201112141717.15021.trast@student.ethz.ch>
 <20111214230713.GA13128@sigill.intra.peff.net>
 <20111214232151.GB13128@sigill.intra.peff.net>
 <20111214233119.GA2354@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 01:25:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raz8x-0002AM-D8
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 01:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab1LOAZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 19:25:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50269
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755375Ab1LOAZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 19:25:32 -0500
Received: (qmail 4314 invoked by uid 107); 15 Dec 2011 00:32:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 19:32:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 19:25:30 -0500
Content-Disposition: inline
In-Reply-To: <20111214233119.GA2354@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187178>

On Wed, Dec 14, 2011 at 05:31:19PM -0600, Jonathan Nieder wrote:

> > @@ -469,7 +471,7 @@ test_debug () {
> >  test_eval_ () {
> >  	# This is a separate function because some tests use
> >  	# "return" to end a test_expect_success block early.
> > -	eval >&3 2>&4 "$*"
> > +	eval <"$TEST_DIRECTORY/stdin-garbage" >&3 2>&4 "$*"
> 
> How about /dev/urandom on platforms that support it?  It wouldn't be
> as pleasant to debug as "This is a magic stdin garbage stream", but it
> would be more likely to (despite the name :)) predictably trip errors,
> or at least hangs, in problematic tests.

I'd rather have something deterministic. If you really want to be mean
to accidental readers of stdin, then put binary junk into stdin-garbage
(even the results of a single run of /dev/urandom, if you like). But I
suspect arbitrary text is good enough to throw a monkey wrench into
anything that will care about its input (and those that don't are beyond
our ability to auto-detect anyway[1]). And it's way easier to debug than
seeing random binary bits.

-Peff

[1] Actually, you could abandon the idea of feeding garbage altogether,
and instead open the descriptor outside the test, then check that its
offset is still 0 after the test. You'd have to use a helper program to
do the ftell(), but it should work as the descriptor position will be
shared.
