From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Tue, 4 Jun 2013 23:04:18 +0100
Message-ID: <20130604220418.GP1072@serenity.lan>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
 <51A7A73C.6070103@web.de>
 <20130531194051.GC1072@serenity.lan>
 <51AD0EEB.4020106@web.de>
 <20130603222341.GL1072@serenity.lan>
 <20130604052950.GA2943@book.hvoigt.net>
 <20130604081045.GM1072@serenity.lan>
 <20130604111717.GA306@book.hvoigt.net>
 <20130604124826.GN1072@serenity.lan>
 <51AE5E8D.7080007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 05 00:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjzLE-0002Wb-1O
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 00:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651Ab3FDWE3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 18:04:29 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:47208 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab3FDWE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 18:04:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id ABF156064F2;
	Tue,  4 Jun 2013 23:04:26 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZaZCnrBH-7V; Tue,  4 Jun 2013 23:04:26 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 863BA198005;
	Tue,  4 Jun 2013 23:04:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <51AE5E8D.7080007@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226416>

On Tue, Jun 04, 2013 at 11:39:25PM +0200, Jens Lehmann wrote:
> Am 04.06.2013 14:48, schrieb John Keeping:
> > The problem is that sometimes you do want to adjust the path and
> > sometimes you don't.  Reading git-submodule(1), it says:
> >=20
> >      This may be either an absolute URL, or (if it begins with ./ o=
r
> >      ../), the location relative to the superproject=E2=80=99s orig=
in
> >      repository.
> >      [snip]
> >      If the superproject doesn=E2=80=99t have an origin configured =
the
> >      superproject is its own authoritative upstream and the current
> >      working directory is used instead.
> >=20
> > So I think it's quite reasonable to have a server layout that looks=
 like
> > this:
> >=20
> >     project
> >     |- libs
> >     |  |- libA
> >     |  `- libB
> >     |- core.git
> >=20
> > and with only core.git on your local system do:
> >=20
> >     cd core/libs
> >     git submodule add ../libs/libB
> >=20
> > expecting that to point to libB.  But if we adjust the path then th=
e
> > user has to do:
> >=20
> >     git submodule add ../../libs/libB
> >=20
> > However, it is also perfectly reasonable to have no remote configur=
ed
> > and the library next to the repository itself.  In which case we do=
 want
> > to specify the additional "../" so that shell completion works in t=
he
> > natural way.
>=20
> Exactly.
>=20
> > The only way I can see to resolve the ambiguity is to die when we h=
it
> > this particular case.
>=20
> Hmm, I'm not so sure about that. Don't the first three lines in
> resolve_relative_url() show how to distinguish between these two
> cases?
>
> resolve_relative_url ()
> {
> 	remote=3D$(get_default_remote)
> 	remoteurl=3D$(git config "remote.$remote.url") ||
> 		remoteurl=3D$(pwd) # the repository is its own authoritative upstre=
am
> ...

If it's this simple, yes.  But I think there's also a third possibility
that combines both of these: what if the local directory structure is
the same as that on the "origin" remote?  Then "origin" exists but we
still want to adjust for the subdirectory.

The risk is that I can't see a behaviour that doesn't seem to choose
whether to convert the given path or not arbitrarily.  Even knowing the
rules, I expect that I could end up being surprised by this if I create
a new repository and haven't set up "origin" yet.
