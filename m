From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] git-config and large integers
Date: Tue, 20 Aug 2013 22:43:55 -0400
Message-ID: <20130821024355.GB25296@sigill.intra.peff.net>
References: <20130820223953.GA3429@sigill.intra.peff.net>
 <xmqqli3wufmc.fsf@gitster.dls.corp.google.com>
 <xmqqhaekudzp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 04:44:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VByOz-0001hB-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 04:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab3HUCoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 22:44:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:42640 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727Ab3HUCoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 22:44:00 -0400
Received: (qmail 25300 invoked by uid 102); 21 Aug 2013 02:43:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 21:43:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 22:43:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqqhaekudzp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232678>

On Tue, Aug 20, 2013 at 04:41:30PM -0700, Junio C Hamano wrote:

> If this applied on the writing side, I would understand it very
> much, i.e.
> 
> 	$ git config --int32 foo.size 2g
>         fatal: "2g" is too large to be read as "int32".

It does, by the way. When you request a type on the writing side, we
normalize (and complain in the same way as we do when reading).

> and as a complement it may make sense as a warning mechanism to also
> error out when existing value does not fit on the "platform" int, so
> your 
> 
> >>   $ git config --int foo.size
> >>   fatal: bad config value for 'foo.size' in .git/config
> 
> might make sense (even though I'd suggest being more explicit than
> "bad value" in this case---"the value specified will not fit when
> used in a variable of type int on this platform").

Yes, the error message is terrible, and I think an extra patch on top to
improve it is worth doing. But note that I am not introducing that error
here at all. On 32-bit systems, we already correctly range-checked and
produced that error. It is only on 64-bit systems that the range check
was flat out wrong. It checked against "long"'s precision, but then cast
the result to an int, losing bits. A possibly worse example than the
negative one is:

  $ git config foo.bar 4g
  $ git config --int foo.bar
  0

Again, that is what git's internal code is seeing. And that is why
keeping the range check for git-config has value: it lets you see what
git would see internally.

> When .git/config is shared on two different boxes (think: NFS), the
> size of "int" might be different between them, so the logic to produce
> such a warning may have to explicitly check against int32_t, not
> platform int and say "will not fit in 'int' on some machines".

I don't really see the value in that. You can always write whatever you
like in the config file. The reader is responsible during parsing for
saying "Hey, I am 32-bit and I can't handle this". And we already do
that, and it works fine. So if you have an NFS-shared .git/config, and
you set "pack.deltacachesize" to "4g", a 64-bit machine will do fine
with that, and a 32-bit machine will complain. Which seems like the only
sane thing to do.

There are a few config options that use "unsigned long" that I would
argue should be "off_t" or something (for example,
core.bigFileThreshold, which cannot be more than 4G on a 32-bit machine,
simply because we can't represent the size. On the other hand, there is
probably a ton of stuff that does not work with 4G files on such a
system, because we use unsigned long all over the place inside the
code).
-Peff
