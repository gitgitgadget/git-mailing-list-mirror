From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: add a feature to show side-by-side diff
Date: Tue, 18 Oct 2011 03:36:02 -0700 (PDT)
Message-ID: <m3zkgy6103.fsf@localhost.localdomain>
References: <CAFo4x0L4BAKnCDa1uEK0Rskd9kTsR-94D4mkYKnLGqVDnuyuBA@mail.gmail.com>
	<m34nz771mj.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 12:36:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG71o-0005HC-3c
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 12:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab1JRKgH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Oct 2011 06:36:07 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36097 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1JRKgF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2011 06:36:05 -0400
Received: by ggnb1 with SMTP id b1so412411ggn.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 03:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=ucHkMMdTpdsyec2svZXJ0lPr3lKqB2f/GJyB8w0oxws=;
        b=hyMmgGhYPRYhTx5P7zi91yYsE23XZePyI3DSxbzip/MuZq+YvqZ+MwFSyWGVtx2yUI
         5HtEQGz7+Xj+sBvidIPmd1aVyGcMlyvv0YhH5A9XTCVb9/wqsMBIh1Q4j64SjjQgwMgk
         t1KcEViv/B7BPzbzLsns7W1cj3bIyp+ih/FnA=
Received: by 10.223.76.135 with SMTP id c7mr3243942fak.16.1318934164075;
        Tue, 18 Oct 2011 03:36:04 -0700 (PDT)
Received: from localhost.localdomain (abvu235.neoplus.adsl.tpnet.pl. [83.8.218.235])
        by mx.google.com with ESMTPS id k26sm2875443fab.12.2011.10.18.03.36.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Oct 2011 03:36:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9IAZZWb011058;
	Tue, 18 Oct 2011 12:35:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9IAZOv5011055;
	Tue, 18 Oct 2011 12:35:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m34nz771mj.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183877>

Jakub Narebski <jnareb@gmail.com> writes:

> Kato Kazuyoshi <kato.kazuyoshi@gmail.com> writes:
>=20
> > gitweb currently has a feature to show diff but it doesn't support
> > "side-by-side" style. This modification introduces:
> >=20
> >  * The "ds" query parameter to specify the style of diff.
> >  * The format_diff_chunk() to reorganize an output of diff.
> >  * The diff_nav() for form.
>=20
> I would state it a bit differently.
>=20
> I would say that this patch introduces support for side-by-side diff
> in git_patchset_body, and that style of diff is controlled by newly
> introduces 'diff_style' ("ds") parameter.
>=20
> I would say a bit later that navigation bar got extended to make it
> easy to switch between 'inline' and 'sidebyside' diff.

I think it would be good idea to explain algorithm here, and perhaps
also layout used.

When I was thinking about implementing side-by-side diff in gitweb, I
was always stopped by the problem of aligning changes.  In your
solution changes are always aligned to top, which is a simple
solution.

> > +sub format_diff_chunk {
> > +	my @chunk =3D @_;
> > +
> > +	my $first_class =3D $chunk[0]->[0];
> > +	my @partial =3D map { $_->[1] } grep { $_->[0] eq $first_class } =
@chunk;
> > +
> > +	if (scalar @partial < scalar @chunk) {
> > +		return join '', ("<div class=3D'chunk'><div class=3D'old'>",
> > +		             @partial,
> > +		             "</div>",
> > +		             "<div class=3D'new'>",
> > +		             (map {
> > +		                 $_->[1];
> > +		             } @chunk[scalar @partial..scalar @chunk-1]),
> > +		             "</div></div>");
> > +	} else {
> > +		return join '', ("<div class=3D'chunk'><div class=3D'",
> > +		             ($first_class eq 'add' ? 'new' : 'old'),
> > +		             "'>",
> > +		             @partial,
> > +		             "</div></div>");
> > +	}
> > +}

This is I think unnecessary complicated.  What you do here is
separating removed and added lines (either can be empty), and putting
removed on left (as "old"), and added on right (as "new").

It means that the following unified diff:

     --- a/foo
     +++ b/foo
     @@ -1,5 +1,4 @@
     -foo
     -FOO
      bar
     -baz
     +b
     +baZ
      quux

would be turned into following side by side diff:

      foo             |=20
      FOO             |
      bar             |  bar
      baz             |  b
                      |  baZ
      quux            |  quux

It's a bit strange that context is put line by line, and changed lines
are put in "blocks".

> > @@ -4940,12 +4967,31 @@ sub git_patchset_body {
> >=20
> >  		# the patch itself
> >  	LINE:
> > +		my @chunk;
> >  		while ($patch_line =3D <$fd>) {
> >  			chomp $patch_line;
> >=20
> >  			next PATCH if ($patch_line =3D~ m/^diff /);
> >=20
> > -			print format_diff_line($patch_line, \%from, \%to);
> > +			my ($class, $line) =3D format_diff_line($patch_line, \%from, \%=
to);
> > +			if ($is_inline) {
> > +				print $line;
> > +			} elsif ($class eq 'add' || $class eq 'rem') {
> > +				push @chunk, [ $class, $line ];
> > +			} else {
> > +				if (@chunk) {
> > +					print format_diff_chunk(@chunk);
> > +					@chunk =3D ();
> > +				} elsif ($class eq 'chunk_header') {
> > +					print $line;
> > +				} else {
> > +					print '<div class=3D"chunk"><div class=3D"old">',
> > +					      $line,
> > +					      '</div><div class=3D"new">',
> > +					      $line,
> > +					      '</div></div>';
> > +				}
> > +			}

Note that your side by side diff wouldn't work for combined diff,
which gitweb supports.  You should show 'unified' / 'inline' format
for combined diff (more than one parent / from).

--=20
Jakub Nar=EAbski
