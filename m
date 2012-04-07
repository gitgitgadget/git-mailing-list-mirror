From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential: do not store credentials received from
 helpers
Date: Sat, 7 Apr 2012 01:09:13 -0400
Message-ID: <20120407050913.GA4211@sigill.intra.peff.net>
References: <20120407033417.GA13914@sigill.intra.peff.net>
 <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com>
 <7v398gywb1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 07:09:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGNuJ-0000A2-QW
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 07:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156Ab2DGFJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 01:09:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53121
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100Ab2DGFJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 01:09:16 -0400
Received: (qmail 19362 invoked by uid 107); 7 Apr 2012 05:09:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Apr 2012 01:09:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Apr 2012 01:09:13 -0400
Content-Disposition: inline
In-Reply-To: <7v398gywb1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194936>

On Fri, Apr 06, 2012 at 09:56:18PM -0700, Junio C Hamano wrote:

> I am afraid that "do not trigger the cache helper" might be throwing the
> baby with bathwater to solve the real problem the patch tries to address,
> which is:
> 
> Peff>   2. If you use a time-based storage helper like
> Peff>      "git-credential-cache", every time you run a git
> Peff>      command which uses the credential, it will also
> Peff>      re-insert the credential after use, freshening the
> Peff>      cache timestamp. So the cache will eventually expire N
> Peff>      time units after the last _use_, not after the time the
> Peff>      user actually typed the password. This is probably not

Actually, that was not the real problem. The real problem I had was the
leakage between helpers. I just noticed this one while thinking about
it. So the very thing that is useful to Shawn is also potentially
dangerous to people who are doing something less clever.

> Shouldn't the memory cache based helper already have enough clue to tell
> when a new entry is first inserted vs when the existing entry it supplied
> came back from the network layer after use?  If there is not enough clue
> with the current network-layer-to-helper protocol, then wouldn't it be a
> better approach to add that, so that the memory cache helper can make more
> intelligent management of its timer?

You can approximate it. The daemon sees that somebody is inserting the
same thing that it already there, and can guess that it probably came
from the daemon in the first place. There are some corner cases with
expiration boundaries (we get the credential, the daemon expires it,
then the http request succeeds, and we tell the daemon "hey, store
this").

> Once that is fixed, I would imagine that you can tell your users to use 
> two helpers (yours and generic caching one) and configure them so that (1)
> the caching one is asked first and then fall back to ask yours, and (2)
> the expiration time of the caching one is set close to $X.

Yeah, in my other response to Shawn, I mentioned that we could add a
flag to do the "leaking" behavior if that's what the user wants. But it
would have the side effect of refreshing his timestamp on each use, so
his $X would not expire (although that is also the case now, and he
hasn't complained).

So I actually do think he would be better to implement the caching
inside his helper, even if it is by calling out to git-credential-cache.
And as a bonus, it makes configuration easier on the users (they don't
have to configure the cache helper separately, and they don't have to
set the timeout on it manually).

-Peff
