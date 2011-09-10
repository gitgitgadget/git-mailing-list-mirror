From: Jeff King <peff@peff.net>
Subject: Re: git credential helper design [was: What's cooking in git.git
 (Aug 2011, #07; Wed, 24)]
Date: Sat, 10 Sep 2011 02:53:32 -0400
Message-ID: <20110910065332.GA10935@sigill.intra.peff.net>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
 <20110825202057.GB6165@sigill.intra.peff.net>
 <7vhb55i11i.fsf@alter.siamese.dyndns.org>
 <20110831023801.GB3340@sigill.intra.peff.net>
 <CAEBDL5XnoCtiKQB8jRxvueWc9zy-yzC+MxgTLmP1amY+U=7aOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>,
	Ted Zlatanov <tzz@lifelogs.com>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Sat Sep 10 08:53:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2HRb-0002h0-Pf
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 08:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab1IJGxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Sep 2011 02:53:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32981
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754685Ab1IJGxe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 02:53:34 -0400
Received: (qmail 6267 invoked by uid 107); 10 Sep 2011 06:54:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Sep 2011 02:54:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Sep 2011 02:53:32 -0400
Content-Disposition: inline
In-Reply-To: <CAEBDL5XnoCtiKQB8jRxvueWc9zy-yzC+MxgTLmP1amY+U=7aOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181148>

On Fri, Sep 09, 2011 at 05:55:38AM -0400, John Szakmeister wrote:

> A little feedback here: I do look into my keychain on Mac OS X.  I
> tend to keep most of my credentials in a separate keychain that gets
> whenever my computer sleeps or the screen saver kicks on.  So that
> blob ends up being user-visible to some degree.  Could I munge it int=
o
> something else?  Sure.  But I do wonder if it might be better to make
> it something closer to what the user expects to see.

Sure, I agree. I guess my question is: what does the user expect to see=
?

> > =C2=A0https://foo@example.com/specific-repo.git
> >
> > if the user wants a repo-specific authentication context.
>=20
> Or pass that the information via --domain and --path parameters.  It'=
d
> be nice to keep most credential backends from having to parse urls.
> Not that its hard, just cumbersome.  But the keychain implementation
> and the gnome-keyring implementation could both benefit from having
> the pieces broken out separately.  Likewise, it's probably not
> difficult to parse it out of the token if we needed to.

Perhaps it's worth providing the information in two forms: parsed and
broken out by individual pieces, and as a more opaque blob. Then system=
s
which care can use the pieces, and systems which are trying to be as
simple as possible can use the blob.

That still leaves the question of how the user specifies policy about
which parts of the blob are relevant. That is, how do they say that onl=
y
the "domain" portion of the hostname is relevant? Or that the path is o=
r
is not relevant?

I was really hoping for the user to be able to specify this at the git
level, to give each storage helper roughly the same feature set.

Maybe it would be enough to do something like:

  1. Assemble all of the parts (protocol, username (if any), hostname,
     path) into a canonicalized URL representing the authentication
     context.

  2. Look for git config matching the context URL, and allow
     transformations (e.g., match and replace the whole thing, or even
     regexp-style substitution).

  3. Break the resulting context URL back into constituent parts.

  4. Give the helper the context URL, and the broken down parts from
     (3). It chooses which to use.

> One thing that crossed my mind while looking at this: what happens
> when a command is meant to be non-interactive?  Looking at the
> kdewallet implementation, it appears that not only is the credential
> helper intended to help do the lookup, but also ask the user for a
> password, if it doesn't find anything.  That doesn't seem like it
> would play well in a non-interactive environment.  Additionally, the
> act of looking up the entry could pop up a dialog in most
> keychain-like applications.  Is there a need to be sensitive to the
> fact that we may be run non-interactively?

I think this is somewhat outside the boundaries of what git can provide=
=2E
We don't know whether we are interactive or not; we can only make
guesses based on things like whether there is a terminal available. The
helper should be able to make an even better guess, because it can ask
for system-specific things (e.g., a Linux one might check whether
$DISPLAY is set before trying to pop up a dialog). And helpers are free
to simply return nothing. Even though most people will only configure a
single helper, there is actually a stack, and git will try the next one=
,
and so on until it gets an answer (or if it hits the end without an
answer, will complain).

-Peff
