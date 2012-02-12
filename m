From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 8/8] gitweb: Highlight combined diffs
Date: Sat, 11 Feb 2012 16:03:19 -0800 (PST)
Message-ID: <m3ty2wsyt6.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-9-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 01:03:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwMv1-0004Ld-0d
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 01:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab2BLADW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 19:03:22 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59905 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124Ab2BLADV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 19:03:21 -0500
Received: by eaah12 with SMTP id h12so1353046eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 16:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=ElnS+coFauzCj9f03eUp34OmZ0R0xeOLd0ZD7RJKqgo=;
        b=Gk02lv9dp2T4g+ihLqQNbBGDxjD9odb6ibXaS87cth1fKSLLg/XMcyyhqehfs+p5M5
         X0Xcbh+MOUi73SxC+bB80szs6H4jW6N5fDfFWOvRrsJuqJI+OZJ1Bd0BMQzkwbfkvfPF
         du064UqxixCkCmR5WcTI42rLozPA0D18u8V7c=
Received: by 10.213.8.76 with SMTP id g12mr1166450ebg.11.1329005000353;
        Sat, 11 Feb 2012 16:03:20 -0800 (PST)
Received: from localhost.localdomain (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id z47sm41549833eeh.9.2012.02.11.16.03.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 16:03:19 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1C03IfP022063;
	Sun, 12 Feb 2012 01:03:19 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1C03H4W022060;
	Sun, 12 Feb 2012 01:03:17 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328865494-24415-9-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190547>

Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> The highlightning of combined diffs is currently disabled.  This is
> because output from a combined diff is much harder to highlight becau=
se
> it's not obvious which removed and added lines should be compared.
>=20
> Moreover, code that compares added and removed lines doesn't care abo=
ut
> combined diffs. It only skips first +/- character, treating second +/=
-
> as a line content.
>=20
> Let's start with a simple case: only highlight changes that come from
> one parent, i.e. when every removed line has a corresponding added li=
ne
> for the same parent.  This way the highlightning cannot get wrong. Fo=
r
> example, following diffs would be highlighted:
>=20
> 	- removed line for first parent
> 	+ added line for first parent
> 	  context line
> 	 -removed line for second parent
> 	 +added line for second parent
>=20
> or
>=20
> 	- removed line for first parent
> 	 -removed line for second parent
> 	+ added line for first parent
> 	 +added line for second parent
>=20
> but following output will not:
>=20
> 	- removed line for first parent
> 	 -removed line for second parent
> 	 +added line for second parent
> 	++added line for both parents
>=20
That is a very reasonable approach.

> Further changes may introduce more intelligent approach that better
> handles combined diffs.
>=20
> Signed-off-by: Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>  gitweb/gitweb.perl |   40 +++++++++++++++++++++++++++++++++++++---
>  1 files changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1a5b454..2b6cb9e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4944,13 +4944,16 @@ sub esc_html_mark_range {
> =20
>  # Format removed and added line, mark changed part and HTML-format t=
hem.
>  sub format_rem_add_line {
> -	my ($rem, $add) =3D @_;
> +	my ($rem, $add, $is_combined) =3D @_;
>  	my @r =3D split(//, $rem);
>  	my @a =3D split(//, $add);
>  	my ($esc_rem, $esc_add);
>  	my ($prefix, $suffix_rem, $suffix_add) =3D (1, $#r, $#a);
>  	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
> =20
> +	# In combined diff we must ignore two +/- characters.
> +	$prefix =3D 2 if ($is_combined);
> +

Errr... actually number of prefix is equalt to number of parents, so
it might be in case of octopus merge more than 2.

>  	while ($prefix < @r && $prefix < @a) {
>  		last if ($r[$prefix] ne $a[$prefix]);
> =20
> @@ -4988,11 +4991,42 @@ sub format_ctx_rem_add_lines {
>  	my ($ctx, $rem, $add, $is_combined) =3D @_;
>  	my (@new_ctx, @new_rem, @new_add);
>  	my $num_add_lines =3D @$add;
> +	my $can_highlight;
> +
> +	# Highlight if every removed line has a corresponding added line.
> +	if ($num_add_lines > 0 && $num_add_lines =3D=3D @$rem) {
> +		$can_highlight =3D 1;
> +
> +		# Highlight lines in combined diff only if the chunk contains
> +		# diff between the same version, e.g.
> +		#
> +		#    - a
> +		#   -  b
> +		#    + c
> +		#   +  d
> +		#
> +		# Otherwise the highlightling would be confusing.
> +		if ($is_combined) {
> +			for (my $i =3D 0; $i < $num_add_lines; $i++) {
> +				my $prefix_rem =3D substr($rem->[$i], 0, 2);
> +				my $prefix_add =3D substr($add->[$i], 0, 2);
> +
> +				$prefix_rem =3D~ s/-/+/g;
> +
> +				if ($prefix_rem ne $prefix_add) {
> +					$can_highlight =3D 0;
> +					last;

Nb. this assumes that we cannot refine and highlight something like
this:

   		#    - a
   		#   -  b
   		#    + c
   		#   ++ d

But perhaps this is better left for future improvemnt.

> +				}
> +			}
> +		}
> +	} else {
> +		$can_highlight =3D 0;
> +	}

This 'else' would be not necessary if $can_highlight was initialized
to 0.

> =20
> -	if (!$is_combined && $num_add_lines > 0 && $num_add_lines =3D=3D @$=
rem) {
> +	if ($can_highlight) {
>  		for (my $i =3D 0; $i < $num_add_lines; $i++) {
>  			my ($line_rem, $line_add) =3D format_rem_add_line(
> -				$rem->[$i], $add->[$i]);
> +				$rem->[$i], $add->[$i], $is_combined);
>  			push @new_rem, $line_rem;
>  			push @new_add, $line_add;

O.K.

--=20
Jakub Nar=EAbski
