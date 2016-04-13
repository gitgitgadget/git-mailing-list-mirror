From: Jeff King <peff@peff.net>
Subject: Re: clone hang prevention / timeout?
Date: Wed, 13 Apr 2016 18:24:14 -0400
Message-ID: <20160413222414.GA9882@sigill.intra.peff.net>
References: <CALyZvKwxE4T8-FmEYgPMgAFKLmeAY5f-y-mDL8S9twTb0umRaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Vas Dias <jason.vas.dias@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:24:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTCv-00078E-Cz
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbcDMWYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:24:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:49118 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753033AbcDMWYR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:24:17 -0400
Received: (qmail 7575 invoked by uid 102); 13 Apr 2016 22:24:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:24:16 -0400
Received: (qmail 23357 invoked by uid 107); 13 Apr 2016 22:24:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:24:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Apr 2016 18:24:14 -0400
Content-Disposition: inline
In-Reply-To: <CALyZvKwxE4T8-FmEYgPMgAFKLmeAY5f-y-mDL8S9twTb0umRaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291500>

On Mon, Apr 11, 2016 at 10:49:19PM +0100, Jason Vas Dias wrote:

> It appears GIT has no way of specifying a timeout for a clone operation -
> if the server decides not to complete a get request, the clone can
> hang forever -
> is this correct ?

Yes. Git's protocol has no timeouts, though each side is generally
either writing or reading at any moment, and so an interrupted
connection should cause either EPIPE or EOF, ending the process. The
exceptions I have seen are:

 - protocol / implementation bugs that cause a true deadlock. At this
   we've fixed all known cases, but that doesn't mean there aren't bugs
   lurking.

 - the network drops out in such a way that the OS doesn't realize the
   connection is gone, and the reading side is left waiting for input
   forever

I think the TCP keepalive stuff that Eric mentioned should address the
latter, though I don't know how well it works in practice. We used to
sometimes see processes hung for days on GitHub, but it's been a long
time. I don't recall if it was pre-v1.8.5 (which introduced
SO_KEEPALIVE), or if we made some other change (we have a load-balancing
layer in front that has more aggressive timeouts).

> This appears to be what I am seeing, in a script that is attempting to do many
> successive clone operations, eg. of
> git://anongit.freedesktop.org/xorg/* , the script
> occasionally hangs in a clone - I can see with netstat + strace that the TCP
> connection is open and GIT is trying to read .
> Is there any option I can specify to get the clone to timeout, or do I manually
> have to strace the git process and send it a signal after a hang is detected?

There are periods where a git client may have to wait for a while in
read() while the other side is quiet (e.g., when the other side is badly
packed and needs to do a lot of up-front CPU work to prepare the
packfile). Since v1.8.4.2, the server side of a clone should generate
application-level keepalive packets, so that the client never sees
silence for more than ~5 seconds. The freedesktop servers appear to be
on v2.1.4, so a long read() as you're seeing probably is a real hang.

Note that pushing has a similar problem (the client may wait a long time
while the server chews on the uploaded packfile before reporting
status). There are no keepalives in that direction, though I have a
series there that I need to polish and submit.

-Peff
