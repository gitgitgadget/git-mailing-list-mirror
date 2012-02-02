From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (version B)] gitweb: Allow UTF-8 encoded CGI query parameters and  path_info
Date: Thu, 2 Feb 2012 23:57:29 +0100
Message-ID: <201202022357.29569.jnareb@gmail.com>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com> <20120202214646.1b84f23e@gmail.com> <201202022207.52220.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 23:56:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt5aK-0007G3-1U
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 23:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab2BBW4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 17:56:51 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48438 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab2BBW4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 17:56:50 -0500
Received: by eekc14 with SMTP id c14so945666eek.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 14:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=HtWbiT8vugVjm76XkugDeCvW7ibW0+HNAmW7Z4ehjdQ=;
        b=lOSv+5g0ruRe98dtQ+1w9J1KdLuCzdubjDgKD/jXsufrl6mbGkqUAT3C3DXf+UiYmP
         zq1wm9R05curPilUJMGTzduYpHYMTGUTIMaNn/jsa9Rr/5OhdRUTrRDs7c/0mC+Epr2r
         GZ1H/R0SA+OeFTa9uP0VUpXk/23asmhI51t6M=
Received: by 10.14.2.142 with SMTP id 14mr1456712eef.104.1328223407581;
        Thu, 02 Feb 2012 14:56:47 -0800 (PST)
Received: from [192.168.1.13] (abwd54.neoplus.adsl.tpnet.pl. [83.8.227.54])
        by mx.google.com with ESMTPS id x4sm14517429eeb.4.2012.02.02.14.56.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 14:56:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201202022207.52220.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189720>

On Thu, 2 Feb 2012, Jakub Narebski wrote:
> On Thu, 2 Feb 2012, Micha=C5=82 Kiedrowicz wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> >=20
> > > Gitweb tries hard to properly process UTF-8 data, by marking outp=
ut
> > > from git commands and contents of files as UTF-8 with to_utf8()
> > > subroutine.  This ensures that gitweb would print correctly UTF-8
> > > e.g. in 'log' and 'commit' views.
> > >=20
> > > Unfortunately it misses another source of potentially Unicode inp=
ut,
> > > namely query parameters.  The result is that one cannot search fo=
r a
> > > string containing characters outside US-ASCII.  For example searc=
hing
> > > for "Micha=C5=82 Kiedrowicz" (containing letter '=C5=82' - LATIN =
SMALL LETTER L
> > > WITH STROKE, with Unicode codepoint U+0142, represented with 0xc5=
 0x82
> > > bytes in UTF-8 and percent-encoded as %C5%81) result in the follo=
wing
> > > incorrect data in search field
> > >=20
> > > 	Micha=C3=85=C2=82 Kiedrowicz
> > >=20
> > > This is caused by CGI by default treating '0xc5 0x82' bytes as tw=
o
> > > characters in Perl legacy encoding latin-1 (iso-8859-1), because =
's'
> > > query parameter is not processed explicitly as UTF-8 encoded stri=
ng.
> > >=20
> > > The solution used here follows "Using Unicode in a Perl CGI scrip=
t"
> > > article on http://www.lemoda.net/cgi/perl-unicode/index.html:
> > >=20
> > > 	use CGI;
> > > 	use Encode 'decode_utf8;
> > > 	my $value =3D params('input');
> > > 	$value =3D decode_utf8($value);
> > >=20
> > > This is done when filling %input_params hash; this required to mo=
ve
> > > from explicit $cgi->param(<label>) to $input_params{<name>} in a =
few
> > > places.
> >=20
> > I'm sorry but this doesn't work for me. I would be happy to help if=
 you
> > have some questions about it.
>=20
> Strange.  http://www.lemoda.net/cgi/perl-unicode/index.html says that
> those two approaches should be equivalent.  The -utf8 pragma version
> doesn't work for me at all, while this one works in that if finds wha=
t
> it is supposed to, but shows garbage in search form.

Is it what you mean by "this doesn't work for me", i.e. working search,
garbage in search field?
=20
> Will investigate.

Damn.  If we use $cgi->textfield(-name =3D> "s", -value =3D> $searchtex=
t) like
in gitweb, CGI.pm would read $cgi->param("s") by itself - without decod=
ing.
To skip this we need to pass -force=3D>1  or  -override=3D>1 (i.e. furt=
her
changes to gitweb).

-utf8 pragma works with more modern CGI.pm, but does not with 3.10.

--=20
Jakub Narebski
Poland
