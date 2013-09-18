From: Jeff King <peff@peff.net>
Subject: Re: git clone silently aborts if stdout gets a broken pipe
Date: Wed, 18 Sep 2013 16:01:52 -0400
Message-ID: <20130918200152.GA17074@sigill.intra.peff.net>
References: <A612847CFE53224C91B23E3A5B48BAC798CD91DB0B@xmail3.se.axis.com>
 <20130918184551.GC18821@sigill.intra.peff.net>
 <20130918190437.GD18821@sigill.intra.peff.net>
 <xmqqmwnaudtg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 22:02:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMNwt-0006hD-6A
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 22:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab3IRUCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 16:02:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:56918 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031Ab3IRUCB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 16:02:01 -0400
Received: (qmail 25125 invoked by uid 102); 18 Sep 2013 20:02:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Sep 2013 15:02:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Sep 2013 16:01:52 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmwnaudtg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234989>

On Wed, Sep 18, 2013 at 12:31:23PM -0700, Junio C Hamano wrote:

> > Hrm, this actually breaks t5701, which expects "clone 2>err" to print
> > nothing to stderr.
> 
> Hmm, where in t5701?  Ah, you meant t5702 and possibly t5601.

Yes, sorry, I meant t5702.

> I actually think "it is long and not meant to be seen sequentially"
> is a bad classifier; these new messages are also progress report in
> that it reports "we are now in this phase".  So if I were to vote, I
> would say we should apply the same progress-silencing criteria,
> preferrably by not checking isatty() again, but by recording the
> decision we have already made when squelching the progress during
> the transfer in order to make sure they stay consistent.

Unfortunately that decision is made in the transport code, not by clone
itself. We can cheat and peek at "transport->progress" after
initializing the transport. That would require some refactoring, though;
we print "Cloning into" before setting up the transport. And we do not
even tell the transport about our progress options if we are doing a
local clone.

If we wanted to _just_ suppress "Checking connectivity" (and not
"Cloning into..."), that's a bit easier. And I could see an argument
that the former is the only one that falls into the "progress report"
category.

> > Also, we should arguably give the "Cloning into..." message the same
> > treatment. We have printed that to stdout for a very long time, so there
> > is a slim chance that somebody actually tries to parse it. But I think
> > they are wrong to do so; we already changed it once (in 28ba96a), and
> > these days it is internationalized, anyway.
> 
> Good thinking.  Please make it so ;-)

OK. I've squashed the "use stderr" patches into one, and added a patch
on top to correctly check the progress flag.

  [1/2]: clone: send diagnostic messages to stderr
  [2/2]: clone: treat "checking connectivity" like other progress

-Peff
