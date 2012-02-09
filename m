From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in fill_project_list_info
Date: Thu, 9 Feb 2012 23:36:48 +0100
Message-ID: <201202092336.48772.jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com> <1328359648-29511-2-git-send-email-jnareb@gmail.com> <7vhayzvf38.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 23:36:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvcbi-0000bW-1L
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 23:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758300Ab2BIWgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 17:36:45 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60877 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab2BIWgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 17:36:44 -0500
Received: by eaah12 with SMTP id h12so729040eaa.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 14:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=wFkW1+kc17fzeJ4793f0FTgsUzLhhCegX8QQDD9+IGc=;
        b=QKGaQWuX1dkptZnJKwzWMVIVpSqwFDrfPywUNR3lLdv2g3xN1zByU+YURsNoHdPFTV
         Ybd5+YVLOn5YyxRoZFqYRgZINwO0Lxa3rOfwCoieGlhxTLTTnDwHL60/OqIfHMHssj/z
         p52pNcAmKiWNV0FS1ZHqltzAyOJLYW52E3m6U=
Received: by 10.213.15.142 with SMTP id k14mr661557eba.91.1328827003550;
        Thu, 09 Feb 2012 14:36:43 -0800 (PST)
Received: from [192.168.1.13] (abvq91.neoplus.adsl.tpnet.pl. [83.8.214.91])
        by mx.google.com with ESMTPS id x4sm14625365eeb.4.2012.02.09.14.36.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 14:36:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vhayzvf38.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190335>

On Thu, 9 Feb 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > This could have been squashed with the next commit, but this way it=
 is
> > pure refactoring that shouldn't change gitweb behavior.
>=20
> It is not obvious why this shouldn't change gitweb behaviour from the
> patch text.
>=20
> The old code says "Unconditionally call git_get_last_activity(), and =
if we
> found nothing, do not do anything extra for this project". The new co=
de
> says "we do that but only if the project does not know its 'age' yet"=
=2E

Well, till next patch in this series gitweb always filled some parts of
project info by processing $projects_list i.e. reading a file or scanni=
ng
a directory.  Then fill_project_list_info was called to fill the rest
of projects data.

Which parts were filled in first step depends on whether $projects_list
is a file with list of projects or a directory to scan, but 'age' was=20
_never_ filled.

But I agree that it is not obvious.


I think that better solution would be to either squash 1/5 and 2/5, or
make 1/5 only about introduction of project_info_needs_filling(), witho=
ut
@fill_only but with the 'age' check change.

> The lack of any real use of @fill_only in this patch also makes it ha=
rd to
> judge if the new API gives a useful semantics.  I would, without look=
ing
> at the real usage in 2/5 patch, na=C3=AFvely expect that such a lazy =
filling
> scheme would say "I am going to use A, B and C; I want to know if any=
 of
> them is missing, because I need values for all of them and I am going=
 to
> call a helper function to fill them if any of them is missing. Having=
 A
> and B is not enough for the purpose of this query, because I still ne=
ed to
> know C and I would call the helper function that computes all of them=
 in
> such a case. Even though it might be wasteful to recompute A and B,
> computing all three at once is the only helper function available to =
me".
>=20
> So for a person who does not have access to the real usage of the new=
 API,
> being able to give only a single $key *appears* make no sense at all,=
 and
> also the meaning of the @fill_only parameter is unclear, especially t=
he
> part that checks if that single $key appears in @fill_only.

fill_project_list_info() is, at least after a fix with 'age', about fil=
ling
information that is not already present.  If @fill_only is nonempty, it
fills only selected information, again only if it is not already presen=
t.
@fill_only empty means no restrictions... which probably is not very ob=
vious,
but is documented.

project_info_needs_filling() returns true if $key is not filled and is
interesting.
=20
> > Adding project_info_needs_filling() subroutine could have been spli=
t
> > into separate commit, but it would be subroutine without use...
> >
> >  gitweb/gitweb.perl |   41 +++++++++++++++++++++++++++++++---------=
-
> >  1 files changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 913a463..b7a3752 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -5185,35 +5185,56 @@ sub git_project_search_form {
> >  	print "</div>\n";
> >  }
> > =20
> > +# entry for given $key doesn't need filling if either $key already=
 exists
> > +# in $project_info hash, or we are interested only in subset of ke=
ys
> > +# and given key is not among @fill_only.
> > +sub project_info_needs_filling {
> > +	my ($project_info, $key, @fill_only) =3D @_;

So in new version @fill_only will be removed...

> > +
> > +	if (!@fill_only ||            # we are interested in everything
> > +	    grep { $key eq $_ } @fill_only) { # or key is in @fill_only
> > +		# check if key is already filled
> > +		return !exists $project_info->{$key};

=2E..and this will be the only line of project_info_needs_filling() wra=
pper.

> > +	}
> > +	# uninteresting key, outside @fill_only
> > +	return 0;
> > +}
> > +
> >  # fills project list info (age, description, owner, category, fork=
s)
> >  # for each project in the list, removing invalid projects from
> > -# returned list
> > +# returned list, or fill only specified info (removing invalid pro=
jects
> > +# only when filling 'age').
> > +#
> >  # NOTE: modifies $projlist, but does not remove entries from it
> >  sub fill_project_list_info {
> > -	my $projlist =3D shift;
> > +	my ($projlist, @fill_only) =3D @_;

Here also @fill_only would be not present.

> >  	my @projects;
> > =20
> >  	my $show_ctags =3D gitweb_check_feature('ctags');
> >   PROJECT:
> >  	foreach my $pr (@$projlist) {
> > -		my (@activity) =3D git_get_last_activity($pr->{'path'});
> > -		unless (@activity) {
> > -			next PROJECT;
> > +		if (project_info_needs_filling($pr, 'age', @fill_only)) {

This change makes 'age' not special.

[...]

--=20
Jakub Narebski
Poland
