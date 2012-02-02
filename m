From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (version B)] gitweb: Allow UTF-8 encoded CGI query parameters and  path_info
Date: Thu, 2 Feb 2012 22:07:51 +0100
Message-ID: <201202022207.52220.jnareb@gmail.com>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com> <201202022110.07127.jnareb@gmail.com> <20120202214646.1b84f23e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 22:07:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt3sI-00008N-NV
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 22:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab2BBVHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 16:07:15 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59605 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031Ab2BBVHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 16:07:13 -0500
Received: by eaah12 with SMTP id h12so1214076eaa.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 13:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=CWxiOv27AoxRajfCRffYEsQqKPHrBCIWhRKmVxsZYCI=;
        b=FS2e19kT+Cn5w5YahK5y3MbTSeKF+py0NuoD0eCqKpgPzQhjTSa0n7igZOXdk15lPu
         ui/gqNvwkhxih33ySNUA6Cxm7Lt8M4E1N4P6PcpCoT+DdRXozyCi9jp3Kwaoad7b0lDB
         UzlRN1j6Cyfubtv1s/IeAhx+DWIgWp4owHfGQ=
Received: by 10.213.11.19 with SMTP id r19mr715620ebr.92.1328216830884;
        Thu, 02 Feb 2012 13:07:10 -0800 (PST)
Received: from [192.168.1.13] (abwd54.neoplus.adsl.tpnet.pl. [83.8.227.54])
        by mx.google.com with ESMTPS id n17sm13506588eei.3.2012.02.02.13.07.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 13:07:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120202214646.1b84f23e@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189708>

On Thu, 2 Jan 2012, Micha=C5=82 Kiedrowicz wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>=20
> > Gitweb tries hard to properly process UTF-8 data, by marking output
> > from git commands and contents of files as UTF-8 with to_utf8()
> > subroutine.  This ensures that gitweb would print correctly UTF-8
> > e.g. in 'log' and 'commit' views.
> >=20
> > Unfortunately it misses another source of potentially Unicode input=
,
> > namely query parameters.  The result is that one cannot search for =
a
> > string containing characters outside US-ASCII.  For example searchi=
ng
> > for "Micha=C5=82 Kiedrowicz" (containing letter '=C5=82' - LATIN SM=
ALL LETTER L
> > WITH STROKE, with Unicode codepoint U+0142, represented with 0xc5 0=
x82
> > bytes in UTF-8 and percent-encoded as %C5%81) result in the followi=
ng
> > incorrect data in search field
> >=20
> > 	Micha=C3=85=C2=82 Kiedrowicz
> >=20
> > This is caused by CGI by default treating '0xc5 0x82' bytes as two
> > characters in Perl legacy encoding latin-1 (iso-8859-1), because 's=
'
> > query parameter is not processed explicitly as UTF-8 encoded string=
=2E
> >=20
> > The solution used here follows "Using Unicode in a Perl CGI script"
> > article on http://www.lemoda.net/cgi/perl-unicode/index.html:
> >=20
> > 	use CGI;
> > 	use Encode 'decode_utf8;
> > 	my $value =3D params('input');
> > 	$value =3D decode_utf8($value);
> >=20
> > This is done when filling %input_params hash; this required to move
> > from explicit $cgi->param(<label>) to $input_params{<name>} in a fe=
w
> > places.
>=20
> I'm sorry but this doesn't work for me. I would be happy to help if y=
ou
> have some questions about it.

Strange.  http://www.lemoda.net/cgi/perl-unicode/index.html says that
those two approaches should be equivalent.  The -utf8 pragma version
doesn't work for me at all, while this one works in that if finds what
it is supposed to, but shows garbage in search form.

Will investigate.
=20
> > Alternate solution would be to simply use the '-utf8' pragma (via
> > "use CGI '-utf8';"), but according to CGI.pm documentation it may
> > cause problems with POST requests containing binary files... and
> > it doesn't work with old CGI.pm version 3.10 from Perl v5.8.6.

[...]
> > @@ -816,9 +816,9 @@ sub evaluate_query_params {
> > =20
> >  	while (my ($name, $symbol) =3D each %cgi_param_mapping) {
> >  		if ($symbol eq 'opt') {
> > -			$input_params{$name} =3D [ $cgi->param($symbol) ];
> > +			$input_params{$name} =3D [ map { decode_utf8($_) } $cgi->param(=
$symbol) ];
> >  		} else {
> > -			$input_params{$name} =3D $cgi->param($symbol);
> > +			$input_params{$name} =3D decode_utf8($cgi->param($symbol));
> >  		}
> >  	}
> >  }
--=20
Jakub Narebski
Poland
