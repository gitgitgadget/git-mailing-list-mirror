From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support for snapshot
Date: Sat, 19 Aug 2006 16:22:42 +0200
Organization: At home
Message-ID: <ec76rd$8qf$1@sea.gmane.org>
References: <44E54AC6.9010600@gmail.com>	<20060818195148.66411.qmail@web31807.mail.mud.yahoo.com>	<7v64gp7prk.fsf@assigned-by-dhcp.cox.net>	<cc723f590608190110t68e6de8etbf6b5b002fd83ca1@mail.gmail.com> <7virkp3snv.fsf@assigned-by-dhcp.cox.net> <44E71888.30104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Aug 19 16:23:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GERj0-0003DY-3v
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 16:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWHSOWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 Aug 2006 10:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWHSOWy
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 10:22:54 -0400
Received: from main.gmane.org ([80.91.229.2]:7840 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751746AbWHSOWy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 10:22:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GERil-00039m-Vb
	for git@vger.kernel.org; Sat, 19 Aug 2006 16:22:43 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 16:22:43 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 16:22:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25723>

Aneesh Kumar K.V wrote:

> I tested this and added some comments. I also fixed some code.=20
> I am attaching the full diff.=20

Below comments to the patch.

> BTW git-repo-config have the below bug.=20
>=20
> $ git repo-config --bool --get gitweb.blame
> true
> $ git repo-config --get --bool gitweb.blame
> $
>=20
> So i dropped --get from the git_get_project_config

Wouldn't it be better to correct the error in git-repo-config?=20
Or (easier) add '--get' last (see comments)?

> +# Feature configuration.

Wouldn't it make it easier to understand code to put %feature hash=20
and gitweb_check_feature subroutine _before_ subroutines for specific
features?

> +# These subs are only called when per repository
> +# overrides are allowed. =A0They take the default options,
> +# inspect the repository and return the values from there if
> +# the repository wants to override the system default.
> +
> +# To enable system wide have in $GITWEB_CONFIG
> +# $feature{'blame'} =3D =A0[\&feature_blame, 0, 1];

This enables system wide, but also disables per-project override.
To enable system wide, while allowing for per project disabling
it should read
# $feature{'blame'} =3D [\&feature_blame, 1, 1]; # overridable, enabled=
 by default

> +# To disbale project wide=20

Typo. disbale -> disable.

> +# you should have allow-override enabled in =A0$GITWEB_CONFIG
Example:
# $feature{'blame'} =3D [\&feature_blame, 1, 1]; # overridable, enabled=
 by default
or just

$feature{'blame'}->[1] =3D 1;

(See below for comments on that form)

> +# and in project config   gitweb.blame =3D 0;
Example:
# $ git repo-config --bool gitweb.blame false

> +# To disable system wide have in $GITWEB_CONFIG
> +# $feature{'snapshot'} =3D =A0[\&feature_snapshot, 0, undef, undef, =
undef];
It would be enough to put:
$feature{'snapshot'} =3D  [\&feature_snapshot, 0, undef];

> +# You define site-wide feature defaults here; override them with
> +# $GITWEB_CONFIG as necessary.
> +our %feature =3D
> +(
> +       # feature       =3D> [feature-sub, allow-override, default op=
tions...]
> +
> +       'blame'         =3D> [\&feature_blame, 0, 0],
> +       'snapshot'      =3D> [\&feature_snapshot, 0, 'x-gzip', 'gz', =
'gzip'],
> +);

By the way, wouldn't it be better to use _hash_ for mixed meaning
than _array_? I.e.

our %feature =3D
(
       # feature       =3D> {'sub' =3D> feature-sub, 'override' =3D> al=
low-override, 'default' =3D> default options...]

       'blame'         =3D> {'sub' =3D> \&feature_blame, 'override' =3D=
> 0, 'default' =3D> 0},
   #or 'blame'         =3D> {'sub' =3D> \&feature_blame, 'override' =3D=
> 0, 'default' =3D> [ 0 ]},
       'snapshot'      =3D> {'sub' =3D> \&feature_snapshot, 'override' =
=3D> 0, 'default =3D> [ 'x-gzip', 'gz', 'gzip' ]},
);

Then you could enable override, or change default simplier in
$GITWEB_CONFIG, e.g. $feature{'blame'}{'override'} =3D 1; instead
of $feature{'blame'}[1] =3D 1;

By the way, it has more sense to have feature by default=20
(i.e. in gitweb.perl) with override enabled if it is set to on.

> =A0sub git_get_project_config {
[...]
> -=A0=A0=A0=A0=A0=A0=A0my $val =3D qx($GIT repo-config --get gitweb.$k=
ey);
> +=A0=A0=A0=A0=A0=A0=A0my @x =3D ($GIT, 'repo-config');
> +=A0=A0=A0=A0=A0=A0=A0if (defined $type) { push @x, $type; }
Just add '--get' as the last argument, _after_ type:
  +       push @x, '--get';
> +=A0=A0=A0=A0=A0=A0=A0push @x, "gitweb.$key";
> +=A0=A0=A0=A0=A0=A0=A0my $val =3D qx(@x);
> +=A0=A0=A0=A0=A0=A0=A0chomp $val;
> =A0=A0=A0=A0=A0=A0=A0=A0return ($val);
> =A0}


> -=A0=A0=A0=A0=A0=A0=A0die_error('403 Permission denied', "Permission =
denied") if (!git_get_project_config_bool ('blame'));
> +
> +=A0=A0=A0=A0=A0=A0=A0if (!gitweb_check_feature('blame')) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0die_error(undef, "Permi=
ssion denied");
> +=A0=A0=A0=A0=A0=A0=A0}

Why did you drop '403 Permission denied' HTTP return code from call
to die_error? (And not set in other similar cases)?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
