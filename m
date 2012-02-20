From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC v2] Document format of basic Git objects
Date: Mon, 20 Feb 2012 11:11:01 -0500
Message-ID: <20120220161101.GA27105@sigill.intra.peff.net>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
 <1329624946-32173-1-git-send-email-pclouds@gmail.com>
 <7vlinzp67m.fsf@alter.siamese.dyndns.org>
 <CACsJy8CEeZPf55idLB9NE-rf--ySmZh_9gkMc_zo0VmiVftMUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 17:11:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzVpZ-0000mo-3V
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 17:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab2BTQLG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 11:11:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43926
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771Ab2BTQLF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 11:11:05 -0500
Received: (qmail 2867 invoked by uid 107); 20 Feb 2012 16:11:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 11:11:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 11:11:01 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CEeZPf55idLB9NE-rf--ySmZh_9gkMc_zo0VmiVftMUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191080>

On Mon, Feb 20, 2012 at 08:55:28PM +0700, Nguyen Thai Ngoc Duy wrote:

> > Author-ident is typically utf-8 already, so you cannot assume "ASCI=
I".
>=20
> I wonder if anyone puts non utf-8 strings in there, or could we
> enforce utf-8 (i.e. validate and reject non utf-8 strings) and accept
> encoded word syntax (rfc 2047) with the help of the new
> $GIT_IDENT_ENCODING variable. The "accept ..." part can wait until
> someone is hit by "utf-8 only" check and steps up.

I was just having a similar discussion with libgit2 folks, who were
wondering if there would ever be non-utf8 in there. When we call
"reencode_commit_message", it looks like we do the whole object. In
other words, your author name _must_ match any encoding you specify in
the "encoding" header.

I.e., if you do:

  # latin1 =C3=A9
  e=3D`printf '\xe9'`

  export GIT_AUTHOR_NAME=3D"P${e}ff King"
  git init
  git config i18n.commitencoding iso8859-1
  touch foo && git add foo &&
  git commit --allow-empty -m "more latin1 ${e}ncoding"

both the name and the message should show fine on your utf8 terminal if
you do this:

  git config i18n.logoutputencoding utf8
  git show

And similarly, we do the right thing in format-patch, both with and
without logoutputencoding set:

  $ git format-patch --root --stdout | grep -Ei "^(from|subject):"
  From: =3D?iso8859-1?q?P=3DE9ff=3D20King?=3D <peff@peff.net>
  Subject: [PATCH] =3D?iso8859-1?q?more=3D20latin1=3D20=3DE9ncoding?=3D

  $ git config i18n.logoutputencoding utf8
  $ git format-patch --root --stdout | grep -Ei "^(from|subject):"
  From: =3D?utf8?q?P=3DC3=3DA9ff=3D20King?=3D <peff@peff.net>
  Subject: [PATCH] =3D?utf8?q?more=3D20latin1=3D20=3DC3=3DA9ncoding?=3D

(where 0xc3a9 is the utf8 equivalent of latin1 0xe9).

So I have no idea if people are using it or not, but it is actually
usable.

-Peff
