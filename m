From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v2 8/8] gitweb: Refinement highlightning in combined
 diffs
Date: Fri, 30 Mar 2012 08:49:29 +0200
Message-ID: <20120330084929.3c4fa23e@mkiedrowicz.ivo.pl>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1332543417-19664-9-git-send-email-michal.kiedrowicz@gmail.com>
	<201203300137.11932.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 08:49:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDVec-00075s-7N
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 08:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab2C3Gtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 02:49:40 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40184 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab2C3Gtj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2012 02:49:39 -0400
Received: by wgbdr13 with SMTP id dr13so283561wgb.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 23:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=xvzgS0hwIiPFR5sqdKymsbti3eBf00t2NHtrBrnHd98=;
        b=P27i1Xm+JXRglpOrnk1wSX+Vn3Cn/ajUepf33gA5GNZ6wRdrzxCuBSfnpeDtU0QokY
         ZkK+u9R/HtZnzm0YzdFW7DCujOcooZMPN0dgR95fsMs0ceHBj9ZEqBzopGLWnyD7KNTu
         O+FTKLwffcWvyxyUVP1os2lpvRhXTG1YZktpDeMTOQVs2lk6XoRf/JjneZZAqQi/zZ20
         8BDNoEwADjBMhi+DsvulSHGAi0RTrMZ6stvxT+D1jJ3wPfqtyoQBuutKhuX11fy0epOd
         XyxtYGOBO3yvRCaDtF8pbQkrLE5UISgJdc2dYK14U45rgtdZcqtk854WqueW5tHk0A3Q
         rh4A==
Received: by 10.180.80.104 with SMTP id q8mr3291426wix.14.1333090177983;
        Thu, 29 Mar 2012 23:49:37 -0700 (PDT)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id 9sm6488505wid.2.2012.03.29.23.49.36
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 23:49:37 -0700 (PDT)
In-Reply-To: <201203300137.11932.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194332>

Jakub Narebski <jnareb@gmail.com> wrote:

> On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:
>=20
> > The highlightning of combined diffs is currently disabled.  This is
> > because output from a combined diff is much harder to highlight
> > because it's not obvious which removed and added lines should be
> > compared.
> >=20
> Is -> was?
>=20
> > Moreover, code that compares added and removed lines doesn't care
> > about combined diffs. It only skips first +/- character, treating
> > second +/- as a line content.
>=20
> Well, we explicitly skip combined diffs.  I think what you want to sa=
y
> here is that it is not possible to simply use existing algorithm
> unchanged for combined diffs.

Yep, your wording is much better.

>=20
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
>=20
> O.K., that's a nice and sensible first step.
>=20
> I wonder if it would be worth to specify that we currently require
> that pattern of '-'-es in pre-image match pattern of '+'-es in
> postimage.
>=20
> Nb. the prefix of combined diff would either include '+', or '-',
> but never mixed (this is documented, but I had trouble with this).
>=20
> >=20
> > Further changes may introduce more intelligent approach that better
> > handles combined diffs.
>=20
> Very sensible approach.
> >=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
>=20
>   Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>=20
> > ---
>=20
> BTW. I went and checked if this approach helps for non-trivial merges
> in git.git history:
>=20
> * b10656c - helps a bit, though one can see limitation of pre/post-fi=
x
>   matching here, but it is present also for non-combined diff.
>=20
> * 8b132bc - helps a bit, though char-interdiff or word-interdiff migh=
t
>   be better.  Nb. I think that red background for 'marked' is a bit
>   too dark (intensive).
>=20
> * c58499c - doesn't help too much.
>=20
> * f629c23, aa145bf - helps.
>=20

Thanks for testing.  I'll experiment with less intensive backgrounds.

> >  gitweb/gitweb.perl |   57
> > +++++++++++++++++++++++++++++++++++++++------------ 1 files
> > changed, 43 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 872ba12..c056e83 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -5057,12 +5057,12 @@ sub print_inline_diff_lines {
> >  # Format removed and added line, mark changed part and HTML-format
> > them. # Impementation is based on contrib/diff-highlight
>=20
> Implementation
>    ^---
>=20
> >  sub format_rem_add_line {
> > -	my ($rem, $add) =3D @_;
> > +	my ($rem, $add, $num_parents) =3D @_;
> >  	my @rem =3D split(//, $rem);
> >  	my @add =3D split(//, $add);
> >  	my ($esc_rem, $esc_add);
> > -	# Ignore +/- character, thus $prefix_len is set to 1.
> > -	my ($prefix_len, $suffix_len) =3D (1, 0);
> > +	# Ignore leading +/- characters for each parent.
> > +	my ($prefix_len, $suffix_len) =3D ($num_parents, 0);
>=20
> Nice.
>=20
> [...]
> > @@ -5099,15 +5099,43 @@ sub format_rem_add_line {
> > =20
> >  # HTML-format diff context, removed and added lines.
> >  sub format_ctx_rem_add_lines {
> > -	my ($ctx, $rem, $add, $is_combined) =3D @_;
> > +	my ($ctx, $rem, $add, $num_parents) =3D @_;
> >  	my (@new_ctx, @new_rem, @new_add);
> > +	my $can_highlight =3D 0;
> > +	my $is_combined =3D ($num_parents > 1);
> > =20
> >  	# Highlight if every removed line has a corresponding
> > added line.
> > -	# Combined diffs are not supported ATM.
> > -	if (!$is_combined && @$add > 0 && @$add =3D=3D @$rem) {
> > +	if (@$add > 0 && @$add =3D=3D @$rem) {
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
> > +			for (my $i =3D 0; $i < @$add; $i++) {
> > +				my $prefix_rem =3D
> > substr($rem->[$i], 0, $num_parents);
> > +				my $prefix_add =3D
> > substr($add->[$i], 0, $num_parents); +
> > +				$prefix_rem =3D~ s/-/+/g;
> > +
> > +				if ($prefix_rem ne $prefix_add) {
> > +					$can_highlight =3D 0;
> > +					last;
> > +				}
> > +			}
> > +		}
> > +	}
>=20
> Good.
>=20
> > +
> > +	if ($can_highlight) {
> >  		for (my $i =3D 0; $i < @$add; $i++) {
> >  			my ($line_rem, $line_add) =3D
> > format_rem_add_line(
> > -			        $rem->[$i], $add->[$i]);
> > +			        $rem->[$i], $add->[$i],
> > $num_parents); push @new_rem, $line_rem;
> >  			push @new_add, $line_add;
> >  		}
>=20
> [...]
> > @@ -5326,7 +5355,7 @@ sub git_patchset_body {
> > =20
> >  	} continue {
> >  		if (@chunk) {
> > -			print_diff_chunk($diff_style,
> > $is_combined, \%from, \%to, @chunk);
> > +			print_diff_chunk($diff_style, scalar
> > @hash_parents, \%from, \%to, @chunk); @chunk =3D ();
> >  		}
> >  		print "</div>\n"; # class=3D"patch"
>=20
> I was wondering about 'commitdiff' between two commits, which is not
> combined even ifany of those commits is a merge commit... but it look=
s
> like it works all right.
>=20
