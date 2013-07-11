From: Jeff King <peff@peff.net>
Subject: Re: t0008 hang on streaming test (OS X)
Date: Thu, 11 Jul 2013 09:34:14 -0400
Message-ID: <20130711133414.GF6015@sigill.intra.peff.net>
References: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 15:34:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxH0u-0000Uy-EH
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 15:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269Ab3GKNeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 09:34:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:58055 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071Ab3GKNeR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 09:34:17 -0400
Received: (qmail 859 invoked by uid 102); 11 Jul 2013 13:35:34 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Jul 2013 08:35:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jul 2013 09:34:14 -0400
Content-Disposition: inline
In-Reply-To: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230100>

On Wed, Jul 10, 2013 at 12:36:40PM -0400, Brian Gernhardt wrote:

> The newest test in t0008 "streaming support for --stdin", seems to
> hang sporadically on my MacBook Pro (running 10.8.4).  The hang seems
> to be related to running it in parallel with other tests, as I can
> only reliably cause it by running with prove  and -j 3.  However, once
> that has hung I am able to semi-reliably have it occur by running the
> test separately (with the test hung in the background, using separate
> trash directories via the --root option).

I can't replicate the hang here (on Linux) doing:

  for i in `seq 1 30`; do
      ./t0008-ignores.sh --root=/tmp/foo/$i &
  done

Do you know which test it is hanging on? You mentioned that you can
replicate it outside of "prove"; what does running with "-v" say?

The last test in t0008, with the fifos, would make me the most
suspicious. The way we do it _should_ be fine, but I'm wondering if the
shell is blocking in exec here:

  mkfifo in out &&
  (git check-ignore -n -v --stdin <in >out &) &&
  exec 9>in &&

That is, if the fifo is not opened for some reason by the backgrounded
process (there's a race, of course, but the outer shell should just
block until the sub-shell actually opens it). I wonder if the
descriptor-opening behavior of:

  cmd <in >out &

is different between shells (that is, if it backgrounds the opening of
in and out on some shells, but not on others). But then I would expect
it to fail consistently.

Just for fun, does switching the middle line there to:

  (sh -c "git check-ignore -n -v --stdin <in >out" &) &&

have any effect?

-Peff
