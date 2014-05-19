From: Jeff King <peff@peff.net>
Subject: Re: Returning error message from custom smart http server
Date: Mon, 19 May 2014 11:09:42 -0400
Message-ID: <20140519150942.GC20289@sigill.intra.peff.net>
References: <5371CC4F.80602@intland.com>
 <20140516230116.GC180798@vauxhall.crustytoothpaste.net>
 <CAGyf7-EoSgTxZzReFArOgcrBaARv7fRiZTMPZX+Loy9dec23aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Frb3Ms?= Tajti <akos.tajti@intland.com>,
	Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Mon May 19 17:09:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmPCH-0001eF-32
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 17:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbaESPJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 11:09:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:55051 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751895AbaESPJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 11:09:44 -0400
Received: (qmail 20301 invoked by uid 102); 19 May 2014 15:09:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 May 2014 10:09:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2014 11:09:42 -0400
Content-Disposition: inline
In-Reply-To: <CAGyf7-EoSgTxZzReFArOgcrBaARv7fRiZTMPZX+Loy9dec23aQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249583>

On Mon, May 19, 2014 at 06:12:10PM +1000, Bryan Turner wrote:

> For starters, to return an error message, your status must be 200 OK.
> You can't return any other status code or Git will interpret your
> error as some form of _HTTP_ error rather than a _git_ error.

As of git v1.8.3, git will show text/plain content sent along with a
a non-200 HTTP code.

However, it does this _only_ for the initial refs fetch (along with
several other error-reporting niceties, including specifically handling
HTTP 401s). The thinking was that the interesting smart-http errors
happen on that initial contact (e.g., failure to login, access denied,
etc). Errors at the HTTP level that happen later during POST requests
mean that the server is misconfigured or broken somehow, and should be
rare. That's the theory anyway.

In the original poster's example, it looks like the server is rejecting
the push with an HTTP 401 during the POST call, after the initial ref
advertisement. This is non-ideal, because it means the client may have
gone to significant work to generate the packfile. It should instead
reject it as soon as it sees a request for
".../info/refs?service=git-receive-pack". Current git clients will
prompt for errors, and will also show the text/plain content.

> - Set the content type to "application/x-<service>-advertisement"
> (e.g. "application/x-git-receive-pack-advertisement") (Not all command
> line Git versions require this, but JGit does)

A side note, but command-line Git cares about the content-type since
v1.8.1.5.

> [...how git's ERR lines work...]

Your description seemed accurate from my brief read. Sending ERR lines
goes back much further. However, for a 401, I think they really want to
send the HTTP code (and at the right time), so that the client can
recognize this, gather credentials from the user, and try again.

-Peff
