From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH/RFC (version A)] gitweb: use CGI with -utf8 to process
 Unicode query  parameters correctly
Date: Thu, 2 Feb 2012 21:43:36 +0100
Message-ID: <20120202214336.0c9daf9f@gmail.com>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com>
	<m37h05c8c1.fsf@localhost.localdomain>
	<201202022108.51353.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:43:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt3VU-0005b8-VQ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab2BBUno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 15:43:44 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37768 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab2BBUnn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 15:43:43 -0500
Received: by eaah12 with SMTP id h12so1206986eaa.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=1kcDSD7Dv6pLPIkdpvgkNo5KBfS5eQ17SVwcXn5Fx7c=;
        b=KO/qfaVhWQN1z5ntLcsAtG91i4h9rObDsNvMCA2cGpHoNatSEsL2/E1LOxzcPRGJwj
         QCwaTcyz087dqSOcVEah5wLSCFg0J9QgCGDOsZdbVqsVnbiyzGHDfEDGlmJ3Xx5LPzgg
         Y038mVJLaIND4Dz5oM5z84IP03+Q+ABr7uTUI=
Received: by 10.213.13.209 with SMTP id d17mr105416eba.20.1328215420741;
        Thu, 02 Feb 2012 12:43:40 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id a58sm13213017eeb.8.2012.02.02.12.43.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:43:40 -0800 (PST)
In-Reply-To: <201202022108.51353.jnareb@gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189702>

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
> According to "Using Unicode in a Perl CGI script" article on
> http://www.lemoda.net/cgi/perl-unicode/index.html the simplest
> solution is to just import '-utf8' pragma for CGI module:
>=20
> 	use CGI '-utf8';
> 	my $value =3D params('input');
>=20
> According to CGI module documentation, the '-utf8' pragma may cause
> problems with POST requests containing binary files... but gitweb
> currently do not use POST requests at all, so this should be not a
> problem now.

This was exactly my feeling  when I sent this patch :).

>=20
> Alternate solution would be to explicity decode query parameters when
> storing them in %input_params (and perhaps also path_info).
>=20
> [jn: reworded / rewritten commit message]
>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>

Thanks, I forgot about that.

> Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9cf7e71..a7441ef 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -10,7 +10,7 @@
>  use 5.008;
>  use strict;
>  use warnings;
> -use CGI qw(:standard :escapeHTML -nosticky);
> +use CGI qw(:standard :escapeHTML -nosticky -utf8);
>  use CGI::Util qw(unescape);
>  use CGI::Carp qw(fatalsToBrowser set_message);
>  use Encode;
