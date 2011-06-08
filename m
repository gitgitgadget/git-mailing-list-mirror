From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 08 Jun 2011 19:11:20 +0200
Message-ID: <vpqsjrkqmdj.fsf@bauges.imag.fr>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
	<20110608150106.GB7805@sigill.intra.peff.net>
	<vpqhb8049m3.fsf@bauges.imag.fr>
	<BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com>
	<vpqtyc0wc1j.fsf@bauges.imag.fr>
	<BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, thomas@xteddy.org, git@vger.kernel.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMI1-0002at-IO
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab1FHRL3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 13:11:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54733 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab1FHRL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:11:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p58HBIR3001933
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 8 Jun 2011 19:11:18 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QUMHo-000535-NA; Wed, 08 Jun 2011 19:11:20 +0200
In-Reply-To: <BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com>
 (=?iso-8859-1?Q?=22J=E9r=E9mie?=
	NIKAES"'s message of "Wed, 8 Jun 2011 18:15:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 08 Jun 2011 19:11:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p58HBIR3001933
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1308157880.17664@SL4rPunKcn5xNbGHR0McHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175404>

J=E9r=E9mie NIKAES <jeremie.nikaes@gmail.com> writes:

> Yes I tried uri_escape, but that only works in the direction mediawik=
i -> git.
> A page named "Et=E9" on mediawiki comes as a Et%C3%A9.mw file on the =
repo.
> However, when I try to send that file "Et%C3%A9" with the mediawiki
> API, I get this error
>
> "Can't use an undefined value as a HASH reference at
> /usr/local/share/perl/5.10.1/MediaWiki/API.pm line 554."
>
> So I tried to backslash the '%' but it does not do it...
> Any idea ? Thanks

OK, I know that's cheating, but reading the doc helped ;-)

http://search.cpan.org/~exobuzz/MediaWiki-API-0.35/lib/MediaWiki/API.pm=
#MediaWiki::API-%3Eedit%28_$query_hashref,_$options_hashref_%29

  The options hashref currently has one optional parameter (skip_encodi=
ng
  =3D> 1). This is described above in the MediaWiki::API->api call
  documentation.
 =20
which leads us to:

  MediaWiki's API uses UTF-8 and any 8 bit character string parameters =
are
  encoded automatically by the API call. If your parameters are already=
 in
  UTF-8 this will be detected and the encoding will be skipped. If your
  parameters for some reason contain UTF-8 data but no UTF-8 flag is se=
t
  (i.e. you did not use the "use utf8;" pragma) you should prevent
  re-encoding by passing an option skip_encoding =3D> 1 in the
  $options_hash.

In other words, Perl and MediaWiki::API use some black magic to detect
UTF-8, and you want to disable it like this:

$mw->edit( {
    action =3D> 'edit',
    title =3D> $title,
    text =3D> $text,
}, {
    skip_encoding =3D> 1
} ) || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};

Tried it, worked :-).

This may well be an alternative solution to the earlier UTF-8 problem.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
