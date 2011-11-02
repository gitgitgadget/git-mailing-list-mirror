From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Wed, 2 Nov 2011 16:09:47 -0400
Message-ID: <20111102200947.GA5628@sigill.intra.peff.net>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com>
 <4EAFC18A.1070502@atlas-elektronik.com>
 <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
 <loom.20111101T205618-231@post.gmane.org>
 <loom.20111101T211624-511@post.gmane.org>
 <20111102180327.GA30668@sigill.intra.peff.net>
 <20111102181041.GA5366@sigill.intra.peff.net>
 <7vwrbiibgz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 21:09:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLh8F-0006f4-Cs
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 21:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab1KBUJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 16:09:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60355
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab1KBUJu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 16:09:50 -0400
Received: (qmail 15897 invoked by uid 107); 2 Nov 2011 20:15:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 16:15:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 16:09:47 -0400
Content-Disposition: inline
In-Reply-To: <7vwrbiibgz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184663>

On Wed, Nov 02, 2011 at 12:13:48PM -0700, Junio C Hamano wrote:

> > The simplest thing is to just drop the behavior in (2), and let it drop
> > to a 401. The extra round trip probably isn't that big a deal.
> 
> That is essentially what Stefan's fix is about.

Right. I think it may be the sanest thing to do.

> The cases we have "extra" roundtrip are:
> 
>  - when you have username@ in URL but no password is stored in .netrc;
>  - when you have username@ in URL and no $HOME/.netrc file.
> 
> and in such a case using URL without username@ in it as a workaround would
> save the roundtrip but forces you to type your username@ over and over
> again, which is _not_ a real workaround.

Yeah. There's no way for us to know before we hand off to curl what you
have in netrc. So these netrc cases will always be at odds with the
no-netrc case.

Normally I would say to implement in favor of the no-netrc case, as it
is probably more common (and will hopefully be more so after the auth
helpers are finished). But the problem is that the penalties are
different. On the one hand, we have the extra http round-trip. Which is
annoying, but mostly invisible to the user. But on the other, we have
git prompting the user unnecessarily, which is just awful.

> > The other option is to start parsing netrc ourselves, or do the extra
> > round trip if we detect ~/.netrc or something. But that last one is
> > getting pretty hackish.
> 
> I tend to agree that we wouldn't want to parse netrc ourselves (that is
> what library support e.g. CURLOPT_NETRC is for). The latter is hackish but
> on the other hand it is a cheap, simple and useful hack.

Note that it's not always right, of course. You might have a .netrc but
no entry for that host. But at least it lets the common case people
(i.e., people who never heard of or touched netrc) to avoid the round
trip.

> How would the upcoming keystore support fit in this picture, by the way?

Any time we would call getpass(), we ask the helper for the credential.
So for user@host, we would call out to the helper for the password
proactively, and otherwise wait for a 401.

We _could_ be proactive and actually ask the helpers for a username and
password even for "https://host/repo", which would save a round-trip to
get the 401 in some cases. But that assumes that asking the helper is
cheap. It might actually require the user inputting a password to unlock
the keystore, which would be annoying if the remote doesn't require
auth at all.

We could try to be clever and use a heuristic that fetch probably
doesn't need auth, but push does. Then fetch gets the extra round-trip
but push doesn't. But that just seems needlessly complex to save one
http round-trip on push.

-Peff
