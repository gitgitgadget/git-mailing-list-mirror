From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Add a credential-helper for KDE
Date: Sun, 18 Sep 2011 14:49:54 -0400
Message-ID: <20110918184954.GB31176@sigill.intra.peff.net>
References: <4E594B5A.6070902@gmail.com>
 <20110831014237.GA2519@sigill.intra.peff.net>
 <4E7605CA.7020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 20:50:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5MRF-00047L-1T
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 20:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207Ab1IRSt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 14:49:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47046
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755680Ab1IRStz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 14:49:55 -0400
Received: (qmail 16778 invoked by uid 107); 18 Sep 2011 18:50:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Sep 2011 14:50:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Sep 2011 14:49:54 -0400
Content-Disposition: inline
In-Reply-To: <4E7605CA.7020204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181620>

On Sun, Sep 18, 2011 at 04:52:58PM +0200, Lukas Sandstr=C3=B6m wrote:

> Right. Multiple usernames per "unique" context is supported in this v=
ersion.
> I looked at the git-credential-storage helper when I wrote the first =
patch,
> which didn't have obvious support for multiple usernames per unique c=
ontext.

Yeah, sorry about that. The -cache helper is much more fully fleshed ou=
t
(though I have improved the -store helper in the past few days to handl=
e
multiple usernames better).

> Keeping the username outside the token is probably a good thing, but =
perhaps it
> should be clarified in the api-docs that multiple usernames has to be=
 supported.

OK, I'll try to write up a clarification.

> Also; what about rejecting credentials. This code currently deletes j=
ust a=20
> username/password pair if a username is specified, and all credential=
s associated
> with the token if only --unique and --reject is specified. Is this co=
rrect/expected
> behavior?

Yes, that's what I think should happen, and what both of my helpers do.
In practice, I don't think it will be called that way by git, which
will always be rejecting a username we just tried. But I wanted to leav=
e
things flexible in case a user wants to manually remove a credential
from a store.

> When I first wrote the helper I tried to immediately ask for a new pa=
ssword if a
> credential was rejected, but this didn't work with the HTTP auth code=
, since it
> doesn't retry the auth with the new credentials after a reject. I thi=
nk it would
> be better if we asked for a new password instead of just saying "auth=
 failed" and=20
> having the user retry the fetch/pull when the stored credentials are =
incorrect.

Yeah, I had a patch early on to retry authentication a few times before
exiting, but I wondered how helpful it was. It's usually pretty easy to
retry your command again via shell history, and sometimes looping on
asking for authentication can be annoying (because things like askpass
will actually grab the keyboard focus).

So I dunno what is best. I don't consider it a big deal, but maybe
others do.

Even if we did do the retry from git, the helper shouldn't ask
immediately for the new credential inside a --reject. It should wait to
be invoked again asking for the password. I know this may be an extra
fork/exec/startup cycle, but it keeps the interface to the helper simpl=
e
and flexible.

-Peff
