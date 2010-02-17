From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [patch] git svn slowness on win32
Date: Wed, 17 Feb 2010 15:15:09 -0800
Message-ID: <20100217231509.GA29664@dcvr.yhbt.net>
References: <13237f021002160204o3c8af7a6i3e7105bd6bc43fa3@mail.gmail.com> <alpine.DEB.1.00.1002161130590.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: josh robb <josh_robb@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Feb 18 00:15:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nht6z-0006qn-IQ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 00:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849Ab0BQXPL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 18:15:11 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48515 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757770Ab0BQXPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 18:15:09 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66B6E1F4EF;
	Wed, 17 Feb 2010 23:15:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1002161130590.20986@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140269>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>=20
> On Tue, 16 Feb 2010, josh robb wrote:
>=20
> > I'm using git svn (1.6.4.msysgit.0) within a WindowsXP VM running
> > under VMWare fusion on OSX 10.5. For me (and at least one other per=
son
> > I know) git svn has been unbearably slow.
> >=20
> > My profiling shows that almost all of the git-svn runtime is being
> > spent in DynaLoader (via SVN::Base::import) which I guess is slow i=
n a
> > virtualized windows environment. For example:
> >=20
> > $ time perl /libexec/git-core/git-svn rebase
> > Current branch master is up to date.
> >=20
> > real 2m56.750s
> > user 0m3.129s
> > sys 2m39.232s
> >=20
> > I've been able to make=A0significant=A0(an order of=A0magnitude)
> > improvements to it's performance by delaying SVN::Base::import from
> > running until it's actually needed.=A0After making this change:
> >=20
> > $ time perl /libexec/git-core/git-svn rebase
> > Current branch master is up to date.
> >=20
> > real 0m33.407s
> > user 0m1.409s
> > sys 0m23.054s
> >=20
> > git svn rebase -n goes from 3m7.046s to 0m10.312s.
> >=20
> > Would love to get some feedback/thoughts etc...
>=20
> How about the following commit message (trying to follow=20
> http://repo.or.cz/w/git.git?a=3Dblob;f=3DDocumentation/SubmittingPatc=
hes;hb=3DHEAD):
>=20
> -- snip --
> git svn: delay importing SVN::Base until it is needed
>=20
> Importing functions from a .dll into Git for Windows' perl is pretty =
slow,
> so let's avoid importing if it is not necessary.
>=20
> [... timing statistics here...]
>=20
> Signed-off-by: Josh Robb <josh_robb@fastmail.fm>
> -- snap --

Hi Josh,

Your patch was missing a call to ::req_svn() in cmd_branch(), but
otherwise it appears fine and passes all tests.

Can you write a proper commit message + patch so we can apply
it cleanly as Johannes suggested?  Thanks!

(full diff below)

diff --git a/git-svn.perl b/git-svn.perl
index 473a0b9..224c29f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -36,11 +36,13 @@ $ENV{TZ} =3D 'UTC';
 $| =3D 1; # unbuffer STDOUT
=20
 sub fatal (@) { print STDERR "@_\n"; exit 1 }
-require SVN::Core; # use()-ing this causes segfaults for me... *shrug*
-require SVN::Ra;
-require SVN::Delta;
-if ($SVN::Core::VERSION lt '1.1.0') {
-	fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)";
+sub _req_svn {
+	require SVN::Core; # use()-ing this causes segfaults for me... *shrug=
*
+	require SVN::Ra;
+	require SVN::Delta;
+	if ($SVN::Core::VERSION lt '1.1.0') {
+		fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)";
+	}
 }
 my $can_compress =3D eval { require Compress::Zlib; 1};
 push @Git::SVN::Ra::ISA, 'SVN::Ra';
@@ -730,6 +732,7 @@ sub cmd_branch {
 		$src=3D~s/^http:/https:/;
 	}
=20
+	::_req_svn();
 	my $ctx =3D SVN::Client->new(
 		auth    =3D> Git::SVN::Ra::_auth_providers(),
 		log_msg =3D> sub {
@@ -4859,6 +4862,8 @@ sub new {
 	$url =3D~ s!/+$!!;
 	return $RA if ($RA && $RA->{url} eq $url);
=20
+	::_req_svn();
+
 	SVN::_Core::svn_config_ensure($config_dir, undef);
 	my ($baton, $callbacks) =3D SVN::Core::auth_open_helper(_auth_provide=
rs);
 	my $config =3D SVN::Core::config_get_config($config_dir);

--=20
Eric Wong
