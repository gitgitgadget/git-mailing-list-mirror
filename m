From: Jeff King <peff@peff.net>
Subject: Re: Cryptic error messages?
Date: Wed, 22 Apr 2009 17:23:51 -0400
Message-ID: <20090422212351.GB16096@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0030@EXCHANGE.trad.tradestation.com> <20090422203251.GD14146@coredump.intra.peff.net> <20090422205006.GE14146@coredump.intra.peff.net> <7vws9c1jdz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 23:25:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwjwh-00012B-JJ
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbZDVVX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbZDVVX5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:23:57 -0400
Received: from peff.net ([208.65.91.99]:42917 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbZDVVX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:23:56 -0400
Received: (qmail 18719 invoked by uid 107); 22 Apr 2009 21:24:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 17:24:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 17:23:51 -0400
Content-Disposition: inline
In-Reply-To: <7vws9c1jdz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117266>

On Wed, Apr 22, 2009 at 02:14:00PM -0700, Junio C Hamano wrote:

> > Actually, this is not true. receive-pack actually passes the error code
> > back to send-pack, which prints it. I think it is doing so because we
> > get that status separate from the individual ref status. But if you look
> > at receive-pack, it doesn't even bother trying individual refs if the
> > unpack failed; every ref will just get the "unpack failed" message.
> 
> How could it even "bother" to tell which ref?  The protocol says "Here are
> the values for the refs after you unpack the data that follows; here is
> the pack data for you", and then you find the error in the pack data.

Sorry, I don't understand. The errors are coming from receive-pack, so
it sends:

  unpack <some error code>\n
  ng refs/heads/whatever n/a (unpacker error)\n

So what I mean is that receive-pack doesn't actually _do_ anything
per-ref after the unpacker error. If there is an unpacker error, then it
_always_ will say "n/a (unpacker error)".

So I wonder if it would be nicer for send-pack not to spew "unpack
error: <blah blah>" to stderr, and instead put something meaningful into
the status table, which is where people are expecting to find error
codes. Even if it is repetitious. IOW, something like:

  To git://blah/blah
   ! [remote rejected] foo -> foo (unpacker exited with error code)

or if you are pushing several refs:

  To git://blah/blah
   ! [remote rejected] foo -> foo (unpacker exited with error code)
   ! [remote rejected] bar -> bar (unpacker exited with error code)

-Peff
