From: Jeff King <peff@peff.net>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 9 May 2011 07:24:28 -0400
Message-ID: <20110509112428.GE9060@sigill.intra.peff.net>
References: <20110506065601.GB13351@elie>
 <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
 <20110506172334.GB16576@sigill.intra.peff.net>
 <BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
 <20110509073535.GA5657@sigill.intra.peff.net>
 <BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
 <20110509081219.GB6205@sigill.intra.peff.net>
 <BANLkTimKRo_36Ce2aFWWXdM1a+EgQ-u77Q@mail.gmail.com>
 <20110509104446.GB9060@sigill.intra.peff.net>
 <BANLkTikUjGLBH6_ze7EvRfoKb9h-RREmuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 13:24:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJOZo-0006oT-Ep
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 13:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab1EILYb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 07:24:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54934
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267Ab1EILYb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 07:24:31 -0400
Received: (qmail 7930 invoked by uid 107); 9 May 2011 11:26:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 07:26:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 07:24:28 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikUjGLBH6_ze7EvRfoKb9h-RREmuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173222>

On Mon, May 09, 2011 at 09:07:31PM +1000, Jon Seymour wrote:

> > I don't really see any need for git's role in this to be more than:
> >
> > =C2=A01. Check a set list of directories for extra paths to add to =
PATH and
> > =C2=A0 =C2=A0 MANPATH.
> >
> > =C2=A02. Tell the packager's script what that set list is, so they =
can be
> > =C2=A0 =C2=A0 sure to put their files in the right spot.
> >
>=20
> The problem with presenting a list of possible directories is that
> given a list, the choice is ambiguous.

Well, yeah. Though between git and the package script, I think it ends
up being simplified to the --system-extension-dir thing, because out of
the three places I mentioned you might want to install something:

  1. You definitely don't want to install in the distro location. If yo=
u
     did, then you would be a distro package, and therefore would not
     have to be asking git where that location is.

  2. You do need to know where the locally-installed system path is, so
     we provide an option to query that.

  3. You don't need to ask git where the per-user path is. It will be a=
t
     some well-known location like $HOME/.gitplugins.

That being said, I think you are more concerned with not presenting
too many choices to the user. And that still leaves one choice: system
(2) versus user (3) install.

But I don't think there's a way around that. You are going to have user=
s
of both types, and you will want to serve them. You can make a guess
based on something like writability of the system directory, I suppose,
and let them override via the command-line if they want to.

That strikes me as somewhat flaky and unpredictable, but I am perhaps
not a representative sample. I have always thought the Windows "if you
install as Administrator, it is available to everybody, but otherwise i=
t
is available only to you" behavior was confusing, and this seems like
the same thing.

> Sure a decision procedure can be arrived at to choose, but it might b=
e
> hard for the user to predict what decision the procedure will reach.
> In that case, the user must be prompted for a selection.

I think this is in agreement with what I just wrote above.

> Again, part of the idea is to give the extension installer some degre=
e
> of confidence that the selected prefix/bin is, in fact, in the path
> and to give the user an override in case the compiled in default isn'=
t
> workable for some reason (for example, due to a permissions issue).

So from this, I gather you would like to see something like:

  $ cd git-work && ./install
  fatal: unable to write to /usr/local/share/git: permission denied
  You may install git-work just for the current user with:

    ./install --user

I.e., the script has a predictable and sane behavior, but you guide the
user through overriding it if need be. That doesn't seem unreasonable t=
o
me.

Anyway, with respect to "core.preferredPluginPath", if you do want to g=
o
in that direction, I don't think any extra git support is needed. You
can already just do "git config --path core.preferredPluginPath" to get
the value (with tilde-expansion, even).

-Peff
