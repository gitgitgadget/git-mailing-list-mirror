From: Jeff King <peff@peff.net>
Subject: Re: [BUG] clone: regression in error messages in master
Date: Thu, 20 Jun 2013 09:34:22 -0400
Message-ID: <20130620133422.GA18200@sigill.intra.peff.net>
References: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:34:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upf0P-00067G-UL
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757789Ab3FTNe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:34:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:56836 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757531Ab3FTNeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:34:25 -0400
Received: (qmail 19639 invoked by uid 102); 20 Jun 2013 13:35:24 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 08:35:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 09:34:22 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228503>

On Thu, Jun 20, 2013 at 06:46:55PM +0530, Ramkumar Ramachandra wrote:

> So this should explain the problem:
> 
>   # using v1.8.3.1
>   $ git clone https://google.com
>   Cloning into 'google.com'...
>   fatal: repository 'https://google.com/' not found
> 
>   # using master
>   $ git clone https://google.com
>   Cloning into 'google.com'...
>   fatal: repository 'https://google.com/' not found
>   fatal: Reading from helper 'git-remote-https' failed
>
> [...]
> The bisect pointed me to: 81d340d4 (transport-helper: report errors
> properly, 2013-04-10).

Yeah, that is a not-so-great fallout from 81d340d4. The point of that
commit was that we do not know whether the remote helper has printed
anything useful; it died unexpectedly while we tried to read from it.

In this case, of course it has, and so the extra message is redundant
and unwanted.

I'm not sure if there is a good way to distinguish the two cases
(snooping on stderr would add complexity, and is not even robust, as we
do not know the meaning of human-readable messages coming over stderr).
Waiting for an "expected" time for the helper give us EOF does not work
either; I think in this case we asked for a "list" or "fetch", and the
helper died without giving us an answer (because there is no answer to
give; there is no "oops, I could not complete your request" on the
fetch side of the transport helper protocol).

So I'm not sure if there is a better option than reverting 81d340d4 and
living with the lesser of two evils (no good message when the helper
dies silently).

-Peff
