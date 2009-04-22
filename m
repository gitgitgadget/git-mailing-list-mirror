From: Jeff King <peff@peff.net>
Subject: Re: Cryptic error messages?
Date: Wed, 22 Apr 2009 16:32:51 -0400
Message-ID: <20090422203251.GD14146@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0030@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:35:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwj9n-000820-Dn
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbZDVUc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 16:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbZDVUc4
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 16:32:56 -0400
Received: from peff.net ([208.65.91.99]:47552 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393AbZDVUcz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 16:32:55 -0400
Received: (qmail 18199 invoked by uid 107); 22 Apr 2009 20:33:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 16:33:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 16:32:51 -0400
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70ACE0030@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117254>

On Mon, Apr 20, 2009 at 04:18:09PM -0400, John Dlugosz wrote:

> $ git push
> Counting objects: 9, done.
> Compressing objects: 100% (8/8), done.
> Writing objects: 100% (8/8), 3.62 KiB, done.
> Total 8 (delta 4), reused 0 (delta 0)
> Unpacking objects: 100% (8/8), done.
> fatal: unresolved deltas left after unpacking
> error: unpack failed: unpacker exited with error code
> To //tx01fs01/sys/dev/git/repositories/aardvark.git
>  ! [remote rejected] dev -> dev (n/a (unpacker error))
> error: failed to push some refs to
> '//tx01fs01/sys/dev/git/repositories/aardvark
> .git'
> 
> Huh?  I'm having trouble defending git's reputation.

Yeah, that is horribly cryptic. What is happening is:

  1. send-pack on the local system spawns receive-pack on the
     remote, which in turn spawns unpack-objects as a helper

  2. unpack-objects barfs with

       fatal: unresolved deltas left after unpacking

     to stderr which is the actual useful bit.

  3. receive-pack notices that the unpacker failed, and spews

       error: unpack failed: unpacker exited with error code

     to stderr, in case unpack-objects didn't say anything.

  4. receive-pack also marks the "status" passed back to send-pack
     as "n/a (unpacker error)"

  5. send-pack gives you the usual nice status table with the ugly
     status from receive-pack marked in it, and then says "OK, I failed
     to push".

So making it better is not quite as simple as you might hope, since
there are three processes involved, and none knows that the other has
spewed to stderr already. But I think there is some low-hanging fruit:

  1. There is no point in receive-pack saying anything to stderr about
     the unpacker failing; in most cases, the unpacker already said
     something, and even if it didn't, we are reporting the problem to
     send-pack in the status field.

  2. "n/a (unpacker error)" is unnecessarily cryptic. Yes, the specifics
     of the message are "not available" (which is presumably what the
     n/a stands for), but the user doesn't care. I think something like
     "failed to unpack objects" would be better.

That leaves only the fact that the _specific_ reason the unpacker failed
is not part of the usual status table. Fixing that is actually a little
tricky because of the multiple processes involved (which do not already
have a string-based communications channel between them).

And of course, it's still a bit cryptic to get "unresolved deltas after
unpacking". However, that is one of those messages that _should_ never
come up, unless the sender is pushing a bogus pack. I wouldn't be
surprised if it an msysgit bug.

-Peff
