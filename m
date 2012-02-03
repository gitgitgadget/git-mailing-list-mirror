From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH/RFC (version B)] gitweb: Allow UTF-8 encoded CGI query
 parameters and  path_info
Date: Fri, 3 Feb 2012 08:39:35 +0100
Message-ID: <20120203083935.5d9d4b18@mkiedrowicz.ivo.pl>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com>
	<20120202214646.1b84f23e@gmail.com>
	<201202022207.52220.jnareb@gmail.com>
	<201202022357.29569.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 08:39:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtDkI-0006f8-2Q
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 08:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab2BCHjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 02:39:41 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55456 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab2BCHjk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 02:39:40 -0500
Received: by eaah12 with SMTP id h12so1330693eaa.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 23:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=GhA0V5CzXEpsw1HRhVBCylQA7Z4yaAkVPlWGcZjkmkk=;
        b=vOEQ8wpMiPKIxliWbyZf7UVkGaEdie0t87eCbAFyA0GiNe30E1Opq0Wo+Zel1K8STV
         CFkBTaKIld+PB3m8Z7z6yfUcFhnhrjaF3GtFmFOmPqhOh2eqsxKXb/9Y40AlHo18cZXA
         QycsFGjhgeXSzzucaibogmfodJQzf/7th2Ai0=
Received: by 10.213.104.140 with SMTP id p12mr976641ebo.111.1328254778950;
        Thu, 02 Feb 2012 23:39:38 -0800 (PST)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id t11sm18815954eea.10.2012.02.02.23.39.38
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 23:39:38 -0800 (PST)
In-Reply-To: <201202022357.29569.jnareb@gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189742>

Jakub Narebski <jnareb@gmail.com> wrote:

> On Thu, 2 Feb 2012, Jakub Narebski wrote:
> > On Thu, 2 Feb 2012, Micha=C5=82 Kiedrowicz wrote:
> > > Jakub Narebski <jnareb@gmail.com> wrote:
> > >=20
> > > > Gitweb tries hard to properly process UTF-8 data, by marking
> > > > output from git commands and contents of files as UTF-8 with
> > > > to_utf8() subroutine.  This ensures that gitweb would print
> > > > correctly UTF-8 e.g. in 'log' and 'commit' views.
> > > >=20
> > > > Unfortunately it misses another source of potentially Unicode
> > > > input, namely query parameters.  The result is that one cannot
> > > > search for a string containing characters outside US-ASCII.
> > > > For example searching for "Micha=C5=82 Kiedrowicz" (containing
> > > > letter '=C5=82' - LATIN SMALL LETTER L WITH STROKE, with Unicod=
e
> > > > codepoint U+0142, represented with 0xc5 0x82 bytes in UTF-8 and
> > > > percent-encoded as %C5%81) result in the following incorrect
> > > > data in search field
> > > >=20
> > > > 	Micha=C3=85=C2=82 Kiedrowicz
> > > >=20
> > > > This is caused by CGI by default treating '0xc5 0x82' bytes as
> > > > two characters in Perl legacy encoding latin-1 (iso-8859-1),
> > > > because 's' query parameter is not processed explicitly as
> > > > UTF-8 encoded string.
> > > >=20
> > > > The solution used here follows "Using Unicode in a Perl CGI
> > > > script" article on
> > > > http://www.lemoda.net/cgi/perl-unicode/index.html:
> > > >=20
> > > > 	use CGI;
> > > > 	use Encode 'decode_utf8;
> > > > 	my $value =3D params('input');
> > > > 	$value =3D decode_utf8($value);
> > > >=20
> > > > This is done when filling %input_params hash; this required to
> > > > move from explicit $cgi->param(<label>) to
> > > > $input_params{<name>} in a few places.
> > >=20
> > > I'm sorry but this doesn't work for me. I would be happy to help
> > > if you have some questions about it.
> >=20
> > Strange.  http://www.lemoda.net/cgi/perl-unicode/index.html says
> > that those two approaches should be equivalent.  The -utf8 pragma
> > version doesn't work for me at all, while this one works in that if
> > finds what it is supposed to, but shows garbage in search form.
>=20
> Is it what you mean by "this doesn't work for me", i.e. working
> search, garbage in search field?

I mean "garbage in search field". Search works even without the patch
(at least on Debian with git-1.7.7.3, perl-5.10.1 and CGI-3.43; I
don't have my notebook nearby at the moment to check).

> =20
> > Will investigate.

Thanks for your time spending on this. I wouldn't call this problem
"production critial" but it seems wrong to support UTF-8 everywhere
properly except for one place.

>=20
> Damn.  If we use $cgi->textfield(-name =3D> "s", -value =3D> $searcht=
ext)
> like in gitweb, CGI.pm would read $cgi->param("s") by itself -
> without decoding.=20

Makes sense. When I tried calling to_utf8() in the line that defines
textfield (this was my first approach to this problem), it haven't
changed anything.

> To skip this we need to pass -force=3D>1  or
> -override=3D>1 (i.e. further changes to gitweb).
>=20
> -utf8 pragma works with more modern CGI.pm, but does not with 3.10.
>=20
