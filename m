From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Wed, 18 Jul 2007 20:30:43 -0700 (PDT)
Message-ID: <571532.59758.qm@web31813.mail.mud.yahoo.com>
References: <7vvech42nb.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>,
	Matt McCutchen <hashproduct@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 05:30:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBMj1-0007vo-Du
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 05:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283AbXGSDap convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Jul 2007 23:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758209AbXGSDap
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 23:30:45 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:22229 "HELO
	web31813.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754158AbXGSDao (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 23:30:44 -0400
Received: (qmail 59802 invoked by uid 60001); 19 Jul 2007 03:30:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=2rgochyROFM8Hti27nsAghcKwZcc7Y6a9fyMJM7+CORxHn1mC9l3Sdl8Y9wCoYjspbLLyR8tW1LNq5aWTbii9qy2YyOBcuH6BuXfsXnbsDG1BnvRUACfX0w7+VZ+ains2xBiNYxUqFPpWIyFBpFPTP8OWW/GSFL7o1zEo7xSjc8=;
X-YMail-OSG: uTwpUKIVM1k5bG2JANGV0nenukIkC2lLOUuxtOXwmjHDLfQpB.larCfpEEYUR_Zdp33v_A--
Received: from [68.186.61.63] by web31813.mail.mud.yahoo.com via HTTP; Wed, 18 Jul 2007 20:30:43 PDT
In-Reply-To: <7vvech42nb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52930>

--- Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > On Tue, 17 July 2007, Matt McCutchen napisa=C5=82:
> > ...
> >> Alert for gitweb site administrators: This patch changes the forma=
t of
> >> $feature{'snapshot'}{'default'} in gitweb_config.perl from a list =
of
> >> three pieces of information about a single format to a list of one=
 or
> >> more formats you wish to offer from the set ('tgz', 'tbz2', 'zip')=
=2E
> >> Update your gitweb_config.perl appropriately.  The preferred names=
 for
> >> gitweb.snapshot in repository configuration have also changed from
> >> 'gzip' and 'bzip2' to 'tgz' and 'tbz2', but the old names are stil=
l
> >> recognized for compatibility.
> >
> > This alert/warning should probably be put in RelNotes for when it w=
ould
> > be in git.git
>=20
> Does anybody else worry about the backward imcompatibility, I
> wonder...  List?

I wouldn't mind an improvement in the snapshot area of gitweb.
I wasn't really happy with the snapshot feature as it was originally
implemented, as it would generate a tar file with ".tar.bz2"
name extension, but the file was NOT bz2, and I had to always
manually rename, bz2, and rename back.

> I really hate to having to say something like that in the
> RelNotes.  I do not think this is a good enough reason to break
> existing configurations; I would not want to be defending that
> change.
>=20
> >> I thought of another incompatibility: previously bookmarked snapsh=
ot
> >> URLs will no longer work because they lack the new "sf" parameter.=
  I
> >> don't care about this; do any of you?
> >
> > I think either having good error message, or using first format ava=
iable
> > would be good enough.
>=20
> I doubt bookmarked snapshot URL would make sense to begin with,
> so this would be Ok.
>=20
> I am wondering if something like this patch (totally untested,
> mind you) to convert the old style %feature in configuration at
> the site at runtime would be sufficient.

"totally untested" is a problem.  Anything going into gitweb for
public consumption (master branch, next ok), should be completely
and exhaustively tested.

   Luben

>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f17c983..cdec4d0 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -236,9 +236,39 @@ our %feature =3D (
>  		'default' =3D> [0]},
>  );
> =20
> +# Functions to convert values from older gitweb configuration
> +# into the current data format
> +sub gitweb_bc_feature_snapshot {
> +	my $def =3D $feature{'snapshot'}{'default'};
> +	# Older definition was to have either undef (to disable), or
> +	# a three-element array whose first element was content encoding
> +	# without leading "application/".
> +	return if (ref $def ne 'ARRAY');
> +	if (!defined $def->[0] && @$def =3D=3D 1) {
> +		# Disabled -- the new way to spell it is to have an empty
> +		# arrayref.
> +		$feature{'snapshot'}{'default'} =3D [];
> +		return;
> +	}
> +	return if (@$def !=3D 3);
> +	for ($def->[0]) {
> +		if (/x-gzip/) {
> +			$feature{'snapshot'}{'default'} =3D ['tgz'];
> +		}
> +		if (/x-bz2/) {
> +			$feature{'snapshot'}{'default'} =3D ['tbz2'];
> +		}
> +		if (/x-zip/) {
> +			$feature{'snapshot'}{'default'} =3D ['zip'];
> +		}
> +	}
> +}
> +
>  sub gitweb_check_feature {
>  	my ($name) =3D @_;
>  	return unless exists $feature{$name};
> +	eval "gitweb_bc_feature_$name()";
> +
>  	my ($sub, $override, @defaults) =3D (
>  		$feature{$name}{'sub'},
>  		$feature{$name}{'override'},
>=20
>=20
