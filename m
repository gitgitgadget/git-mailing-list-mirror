From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 8/8] gitweb: Highlight combined diffs
Date: Mon, 13 Feb 2012 07:48:56 +0100
Message-ID: <20120213074856.50b1bf37@mkiedrowicz.ivo.pl>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-9-git-send-email-michal.kiedrowicz@gmail.com>
	<m3ty2wsyt6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 07:49:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwpii-0003q3-Sv
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 07:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675Ab2BMGtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 01:49:01 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36005 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab2BMGtA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 01:49:00 -0500
Received: by eekc14 with SMTP id c14so1744605eek.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 22:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=YOd1qr7BU+VDV1XCPL5mxxTufu0QGHecHnRFX0bW9k8=;
        b=LmW1C5/dGmV8wNEgI7oxSI/jv6AilI2iWwGzjIFP9J1ESNqTCPs0UMX0VVPrVHmufq
         ITSmBU/X04yI4VPDR4TFSVAYeJcvfjgA42asNySk4VRmTS+EQPYiCmtWR6PQqPoltTy7
         beERgCrc/Gb+mYzeyGatkPYO/Z4Wgv/ODuR8Q=
Received: by 10.14.38.208 with SMTP id a56mr4786208eeb.53.1329115738722;
        Sun, 12 Feb 2012 22:48:58 -0800 (PST)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id y12sm57732322eeb.11.2012.02.12.22.48.58
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Feb 2012 22:48:58 -0800 (PST)
In-Reply-To: <m3ty2wsyt6.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190613>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > The highlightning of combined diffs is currently disabled.  This is
> > because output from a combined diff is much harder to highlight
> > because it's not obvious which removed and added lines should be
> > compared.
> >=20
> > Moreover, code that compares added and removed lines doesn't care
> > about combined diffs. It only skips first +/- character, treating
> > second +/- as a line content.
> >=20
> > Let's start with a simple case: only highlight changes that come
> > from one parent, i.e. when every removed line has a corresponding
> > added line for the same parent.  This way the highlightning cannot
> > get wrong. For example, following diffs would be highlighted:
> >=20
> > 	- removed line for first parent
> > 	+ added line for first parent
> > 	  context line
> > 	 -removed line for second parent
> > 	 +added line for second parent
> >=20
> > or
> >=20
> > 	- removed line for first parent
> > 	 -removed line for second parent
> > 	+ added line for first parent
> > 	 +added line for second parent
> >=20
> > but following output will not:
> >=20
> > 	- removed line for first parent
> > 	 -removed line for second parent
> > 	 +added line for second parent
> > 	++added line for both parents
> >=20
> That is a very reasonable approach.

Thanks.

>=20
> > Further changes may introduce more intelligent approach that better
> > handles combined diffs.
> >=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
> >  gitweb/gitweb.perl |   40 +++++++++++++++++++++++++++++++++++++---
> >  1 files changed, 37 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 1a5b454..2b6cb9e 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -4944,13 +4944,16 @@ sub esc_html_mark_range {
> > =20
> >  # Format removed and added line, mark changed part and HTML-format
> > them. sub format_rem_add_line {
> > -	my ($rem, $add) =3D @_;
> > +	my ($rem, $add, $is_combined) =3D @_;
> >  	my @r =3D split(//, $rem);
> >  	my @a =3D split(//, $add);
> >  	my ($esc_rem, $esc_add);
> >  	my ($prefix, $suffix_rem, $suffix_add) =3D (1, $#r, $#a);
> >  	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
> > =20
> > +	# In combined diff we must ignore two +/- characters.
> > +	$prefix =3D 2 if ($is_combined);
> > +
>=20
> Errr... actually number of prefix is equalt to number of parents, so
> it might be in case of octopus merge more than 2.

OK

>=20
> >  	while ($prefix < @r && $prefix < @a) {
> >  		last if ($r[$prefix] ne $a[$prefix]);
> > =20
> > @@ -4988,11 +4991,42 @@ sub format_ctx_rem_add_lines {
> >  	my ($ctx, $rem, $add, $is_combined) =3D @_;
> >  	my (@new_ctx, @new_rem, @new_add);
> >  	my $num_add_lines =3D @$add;
> > +	my $can_highlight;
> > +
> > +	# Highlight if every removed line has a corresponding
> > added line.
> > +	if ($num_add_lines > 0 && $num_add_lines =3D=3D @$rem) {
> > +		$can_highlight =3D 1;
> > +
> > +		# Highlight lines in combined diff only if the
> > chunk contains
> > +		# diff between the same version, e.g.
> > +		#
> > +		#    - a
> > +		#   -  b
> > +		#    + c
> > +		#   +  d
> > +		#
> > +		# Otherwise the highlightling would be confusing.
> > +		if ($is_combined) {
> > +			for (my $i =3D 0; $i < $num_add_lines; $i++)
> > {
> > +				my $prefix_rem =3D
> > substr($rem->[$i], 0, 2);
> > +				my $prefix_add =3D
> > substr($add->[$i], 0, 2); +
> > +				$prefix_rem =3D~ s/-/+/g;
> > +
> > +				if ($prefix_rem ne $prefix_add) {
> > +					$can_highlight =3D 0;
> > +					last;
>=20
> Nb. this assumes that we cannot refine and highlight something like
> this:
>=20
>    		#    - a
>    		#   -  b
>    		#    + c
>    		#   ++ d
>=20
> But perhaps this is better left for future improvemnt.

I can add a patch for that at the end of this series.

>=20
> > +				}
> > +			}
> > +		}
> > +	} else {
> > +		$can_highlight =3D 0;
> > +	}
>=20
> This 'else' would be not necessary if $can_highlight was initialized
> to 0.
>=20

OK.

> > =20
> > -	if (!$is_combined && $num_add_lines > 0 && $num_add_lines
> > =3D=3D @$rem) {
> > +	if ($can_highlight) {
> >  		for (my $i =3D 0; $i < $num_add_lines; $i++) {
> >  			my ($line_rem, $line_add) =3D
> > format_rem_add_line(
> > -				$rem->[$i], $add->[$i]);
> > +				$rem->[$i], $add->[$i],
> > $is_combined); push @new_rem, $line_rem;
> >  			push @new_add, $line_add;
>=20
> O.K.
>=20

Thanks for your thorough review.
