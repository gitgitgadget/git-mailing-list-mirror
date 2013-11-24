From: Jeff King <peff@peff.net>
Subject: Re: error: git-remote-https died of signal 13
Date: Sun, 24 Nov 2013 08:33:56 -0500
Message-ID: <20131124133356.GA3507@sigill.intra.peff.net>
References: <5290D994.9040505@googlemail.com>
 <20131124065400.GB5535@sigill.intra.peff.net>
 <5291F70A.7070508@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Nov 24 14:34:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkZp9-0000wV-6U
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 14:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab3KXNeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 08:34:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:44804 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752247Ab3KXNeB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 08:34:01 -0500
Received: (qmail 5063 invoked by uid 102); 24 Nov 2013 13:34:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Nov 2013 07:34:01 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Nov 2013 08:33:56 -0500
Content-Disposition: inline
In-Reply-To: <5291F70A.7070508@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238260>

On Sun, Nov 24, 2013 at 01:54:34PM +0100, Stefan Beller wrote:

> Here is the output of 
> sb@sb:/tmp$ GIT_TRANSPORT_HELPER_DEBUG=1 git clone https://github.com/Bertram25/ValyriaTear.git tmp

Thanks. I think I see what is going on.

We finish the helper conversation here:

> Checking connectivity... done.
> Debug: Disconnecting.
> error: git-remote-https died of signal 13
> sb@sb:/tmp$ 

which means that remote-https is trying to exit, and is cleaning up any
curl connections. The actual SIGPIPE in the strace is here:

[pid 28319] write(3, "\25\3\2\0...[binary goo]...", 27) = -1 EPIPE (Broken pipe)

and if you walk backwards, fd 3 is:

  [pid 28319] socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 3
  ...
  [pid 28319] connect(3, {sa_family=AF_INET,
                          sin_port=htons(443),
                          sin_addr=inet_addr("192.30.252.131")}, 16
                          ) = -1 EINPROGRESS (Operation now in progress)

So it's sending binary junk to the https socket while trying to exit,
which makes me guess that it's something to do with terminating the SSL
session, but the server has already hung up. Which would make it a curl
problem.

Googling "curl sigpipe" seems to come up with a report of this exact
case:

  http://curl.haxx.se/mail/archive-2013-01/0003.html

with a bug opened here:

  http://sourceforge.net/p/curl/bugs/1180/

Looks like the fix went into curl 7.32.0. I have 7.33.0, which seems
fine. Can you confirm that your libcurl is a bit older?

-Peff
