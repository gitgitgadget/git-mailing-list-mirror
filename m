From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH/RFCv2 (version B)] gitweb: Allow UTF-8 encoded CGI query
 parameters and  path_info
Date: Fri, 3 Feb 2012 18:45:57 +0100
Message-ID: <20120203184557.59042dec@gmail.com>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com>
	<201202022357.29569.jnareb@gmail.com>
	<20120203083935.5d9d4b18@mkiedrowicz.ivo.pl>
	<201202031344.55750.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 18:46:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtND7-0004cM-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 18:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022Ab2BCRqE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 12:46:04 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62957 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293Ab2BCRqD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 12:46:03 -0500
Received: by eekc14 with SMTP id c14so1229920eek.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 09:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=6iTxvA+83X6iKOJQdqAIXeuYoBpeLPUEPboVu5JeGHM=;
        b=v1L2KYPfAYMeudS1Dxc9vPJGKxZeUZdDzq89b5nw9xTxfzhiOJ89GkJgsRHiK/FD8Q
         FqsjVSGQ0tyLtQTKb8eQp/kxvpQbQ1FV9Fpjy/tXKzu6phlXNIonC2M/ZWFiQ/9EBbKj
         nHqvzT3FGrOp26mUH0soLSsIw1Mkkj79t3ucw=
Received: by 10.14.47.68 with SMTP id s44mr2565161eeb.11.1328291160671;
        Fri, 03 Feb 2012 09:46:00 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id e12sm24231964eea.5.2012.02.03.09.45.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 09:46:00 -0800 (PST)
In-Reply-To: <201202031344.55750.jnareb@gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189787>

Jakub Narebski <jnareb@gmail.com> wrote:

> Gitweb tries hard to properly process UTF-8 data, by marking output
> from git commands and contents of files as UTF-8 with to_utf8()
> subroutine.  This ensures that gitweb would print correctly UTF-8
> e.g. in 'log' and 'commit' views.
>=20
> Unfortunately it misses another source of potentially Unicode input,
> namely query parameters.  The result is that one cannot search for a
> string containing characters outside US-ASCII.  For example searching
> for "Micha=C5=82 Kiedrowicz" (containing letter '=C5=82' - LATIN SMAL=
L LETTER L
> WITH STROKE, with Unicode codepoint U+0142, represented with 0xc5 0x8=
2
> bytes in UTF-8 and percent-encoded as %C5%81) result in the following
> incorrect data in search field
>=20
> 	Micha=C3=85=C2=82 Kiedrowicz
>=20
> This is caused by CGI by default treating '0xc5 0x82' bytes as two
> characters in Perl legacy encoding latin-1 (iso-8859-1), because 's'
> query parameter is not processed explicitly as UTF-8 encoded string.
>=20
> The solution used here follows "Using Unicode in a Perl CGI script"
> article on http://www.lemoda.net/cgi/perl-unicode/index.html:
>=20
> 	use CGI;
> 	use Encode 'decode_utf8;
> 	my $value =3D params('input');
> 	$value =3D decode_utf8($value);
>=20
> Decoding UTF-8 is done when filling %input_params hash and $path_info
> variable; the former required to move from explicit $cgi->param(<labe=
l>)
> to $input_params{<name>} in a few places, which is a good idea anyway=
=2E
>=20
> Another required change was to add -override=3D>1 parameter to
> $cgi->textfield() invocation (in search form).  Otherwise CGI would
> use values from query string if it is present, filling value from
> $cgi->param... without decode_utf8().  As we are using value of
> appropriate parameter anyway, -override=3D>1 doesn't change the
> situation but makes gitweb fill search field correctly.
>=20
> Alternate solution would be to simply use the '-utf8' pragma (via
> "use CGI '-utf8';"), but according to CGI.pm documentation it may
> cause problems with POST requests containing binary files... and
> it requires CGI 3.31 (I think), released with perl v5.8.9.
>=20
> Noticed-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> ---
> On Fri, 3 Feb 2012, Michal Kiedrowicz wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
>=20
> > > Is it what you mean by "this doesn't work for me", i.e. working
> > > search, garbage in search field?
> >=20
> > I mean "garbage in search field". Search works even without the pat=
ch
> > (at least on Debian with git-1.7.7.3, perl-5.10.1 and CGI-3.43; I
> > don't have my notebook nearby at the moment to check).
> [...]
>=20
> > > Damn.  If we use $cgi->textfield(-name =3D> "s", -value =3D> $sea=
rchtext)
> > > like in gitweb, CGI.pm would read $cgi->param("s") by itself -
> > > without decoding.=20
> >=20
> > Makes sense. When I tried calling to_utf8() in the line that define=
s
> > textfield (this was my first approach to this problem), it haven't
> > changed anything.
>=20
> Yes, and it doesn't makes sense in gitweb case - we use value of=20
> $cgi->param("s") as default value of text field anyway, but in
> Unicode-aware way.
> =20
> > > To skip this we need to pass -force=3D>1  or
> > > -override=3D>1 (i.e. further changes to gitweb).
>=20
> This patch does this. =20
>=20
> Does it make work for you?
>=20

Yes, it works for me. Search form properly displays "=C5=82". Thanks!
