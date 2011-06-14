From: Jeff King <peff@peff.net>
Subject: Re: error: error in sideband demultiplexer
Date: Tue, 14 Jun 2011 12:49:43 -0400
Message-ID: <20110614164943.GA26764@sigill.intra.peff.net>
References: <9E9413C214124A0980AADBDFAD7DF28E@aggress.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Richard Shaw <richard@aggress.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 18:49:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWWoJ-0005WS-V1
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 18:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab1FNQtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 12:49:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51383
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab1FNQtp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 12:49:45 -0400
Received: (qmail 27973 invoked by uid 107); 14 Jun 2011 16:49:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 12:49:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 12:49:43 -0400
Content-Disposition: inline
In-Reply-To: <9E9413C214124A0980AADBDFAD7DF28E@aggress.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175782>

On Tue, Jun 14, 2011 at 01:20:32PM +0100, Richard Shaw wrote:

> Could someone please give me an explanation of what the following error message means:
> 
> error: error in sideband demultiplexer

The git protocol generally operates over a single stream. Most of that
stream will have object data on it, but we also want to be able to pass
informational messages. So there is a "sideband", which works something
like:

  1. The remote end puts a header at the beginning of each packet
     telling us whether it's for the data stream or the sideband.

  2. We either fork or start a thread to read the data from the remote
     and demultiplex it. If it's sideband, we output it to stderr. If
     it's data, we pass it on to the main git program.

The error message indicates that the thread or forked process
implementing the sideband demultiplexer returned an error in its exit
code. Usually it will have printed some other error message already that
is more specific, but you may have found a case where it doesn't.

Which platform are you on? Are you building with threads (i.e., are you
setting NO_PTHREADS)? Are there any other error messages? If not, is it
possible to use "strace -f" to get a trace that shows the error?

-Peff
