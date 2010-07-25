From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/WIP] git-svn: tweak log format to match "svn log" output
Date: Sun, 25 Jul 2010 08:10:57 +0000
Message-ID: <20100725081057.GA22373@dcvr.yhbt.net>
References: <20100423134611.GA3440@merkur.sol.de> <20100426132710.GA9930@progeny.tock> <20100427112656.GB16323@merkur.sol.de> <20100725023114.GB18606@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jens Seidel <jensseidel@users.sf.net>
X-From: git-owner@vger.kernel.org Sun Jul 25 10:11:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcwIe-0003rr-9L
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 10:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab0GYILB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 04:11:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53292 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab0GYIK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 04:10:58 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA5F1F44B;
	Sun, 25 Jul 2010 08:10:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100725023114.GB18606@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151709>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> From: Jens Seidel <jensseidel@users.sf.net>
>=20
> Tweak "git svn log" output to more closely match what svn produces.
> In particular, if Locale::gettext is available, use that to produce
> localized output using svn=E2=80=99s translations.

<snip>

> [jn: made Locale::gettext dependency optional; added a test script]
>=20
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jens Seidel wrote at http://bugs.debian.org/578915:
> >> Jens Seidel wrote:
>=20
> > Ah, git svn ignores any locale, this explains the problem.
> >
> >>> The dot stands for an ordinal number (e.g. "19." =3D=3D "19th").
> >>> Second: "line(s)" is not translated. I can workaround by starting=
 git/svn in an
> >>> English locale ...
> >
> > I tried to fix both.
> >
> >>> Third: the git log often contains an addional empty line.
>
> > This remains open. Probably that can be solved by setting a git con=
fig
> > option and resyncing all git svn history from git.

Hi Jens, Jonathan,

I just made an additional patch that should solve the problem
(see my reply to this email).

> Sorry to leave this hanging for so long.  I think it is an improvemen=
t
> as is, but I have not tested in the following scenarios:
>=20
>  - Locale::gettext not available
>  - subversion not translated
>  - subversion translated but not to the current language
>=20
> And the extra blank line at the end of log messages remains unsolved.
>=20
> Thoughts?

Everything looks reasonable to me.  gettext should just fall back to th=
e
original string when a translation is not available.

I've squashed the following cleanup on top of Jens' original change:

diff --git a/git-svn.perl b/git-svn.perl
index 55dc50d..5252722 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5536,14 +5536,12 @@ sub format_svn_date {
 	my $gm =3D timelocal(gmtime($t));
 	my $sign =3D qw( + + - )[ $t <=3D> $gm ];
 	my $gmoff =3D sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,=
1]);
-	my $format;
+	my $format =3D " (%a, %d %b %Y)";
 	if ($can_localize) {
 		my $d =3D Locale::gettext->domain("subversion");
-		$format =3D "%Y-%m-%d %H:%M:%S $gmoff" . $d->get(" (%a, %d %b %Y)");
-	} else {
-		$format =3D "%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)";
+		$format =3D $d->get($format);
 	}
-	return strftime($format, localtime($t));
+	return strftime("%Y-%m-%d %H:%M:%S $gmoff$format", localtime($t));
 }
=20
 sub parse_git_date {
@@ -5646,8 +5644,8 @@ sub show_commit_normal {
=20
 	if ($can_localize) {
 		my $d =3D Locale::gettext->domain("subversion");
-		$sing_fmt =3D $d->nget(" | %d line", " | %d lines", 1);
-		$plur_fmt =3D $d->nget(" | %d line", " | %d lines", 10);
+		$sing_fmt =3D $d->nget($sing_fmt, $plur_fmt, 1);
+		$plur_fmt =3D $d->nget($sing_fmt, $plur_fmt, 10);
 	}
 	if (my $l =3D $c->{l}) {
 		while ($l->[$#$l] eq "\n" && $#$l > 0
--=20
Eric Wong
