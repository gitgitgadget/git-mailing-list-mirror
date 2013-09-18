From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git clone -q ends with early EOF
Date: Wed, 18 Sep 2013 14:14:44 -0400
Message-ID: <20130918181443.GA18821@sigill.intra.peff.net>
References: <201309181444.19070.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marek Vasut <marex@denx.de>
X-From: git-owner@vger.kernel.org Wed Sep 18 20:14:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMMHA-0006tY-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 20:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab3IRSOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 14:14:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:56205 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab3IRSOw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 14:14:52 -0400
Received: (qmail 19720 invoked by uid 102); 18 Sep 2013 18:14:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Sep 2013 13:14:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Sep 2013 14:14:44 -0400
Content-Disposition: inline
In-Reply-To: <201309181444.19070.marex@denx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234977>

On Wed, Sep 18, 2013 at 02:44:18PM +0200, Marek Vasut wrote:

> I am trying to clone a repository and I am getting the following output:
> 
> $ git clone -q git://kernel.ubuntu.com/ubuntu/linux.git
> fatal: The remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed
> 
> The "fatal:" lines usually appear a few minutes after running the clone. Of 
> course, the clone does not finish successfully. Interestingly, when I drop the 
> '-q' option from the git clone commandline, the clone finishes correctly.

As Junio mentioned, this does seem like the issue that 05e9515
(upload-pack: send keepalive packets during pack computation,
2013-09-08) tries to fix. The server is quiet for a long period while
preparing the pack, and something in the network stack thinks the
connection has timed out and kills it.

One way you can check this is by running:

  time git clone -q git://kernel.ubuntu.com/ubuntu/linux.git

If it's a network timeout, it will die consistently at some nice round
number. In this case, I just ran that command twice, and it died both
times at just a hair over 2 minutes.  So that is probably what is going
on.  There's no proxy on my end, so presumably there is some front-end
reverse proxying happening on the server end, and it has a 2-minute
timeout.

The keepalive patch is not in any released version yet, but we have been
running it in production at GitHub for a few weeks. You may want to file
a support request with the Ubuntu folks asking to pick up the patch, or
to increase the timeouts on their proxies.

-Peff
