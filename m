From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Make the output of "git svn clone" less confusing.
Date: Thu, 18 Oct 2007 03:33:01 -0700
Message-ID: <20071018103301.GA21121@soma>
References: <87k5poflp5.fsf@lysator.liu.se> <20071018070617.GA29238@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 12:33:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiSgn-0000T7-Lv
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 12:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760667AbXJRKdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 06:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755726AbXJRKdF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 06:33:05 -0400
Received: from hand.yhbt.net ([66.150.188.102]:48365 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756769AbXJRKdE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 06:33:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 2A0F77DC0FE;
	Thu, 18 Oct 2007 03:33:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071018070617.GA29238@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61512>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> David K=E5gedal <davidk@lysator.liu.se> wrote:
> > The problem is that the first thing it prints is
> >=20
> >   Initialized empty Git repository in .git/
> >=20
> > even if actually created a subdirectory and changed into it first. =
But to the
> > user, it looks like it is creating a .git/ dir in the directory he/=
she is
> > started git from.
>=20
> Eric, ack/nack?

Nack, here's (hopefully) a better patch.

David: agree/disagree?

=46rom 62648d512a27a546707da160c939d665e6da57b4 Mon Sep 17 00:00:00 200=
1
=46rom: Eric Wong <normalperson@yhbt.net>
Date: Thu, 18 Oct 2007 03:29:28 -0700
Subject: [PATCH] git-svn: make the output of "git svn clone" less confu=
sing
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Original patch by David K=E5gedal:
> The problem is that the first thing it prints is
>
>   Initialized empty Git repository in .git/
>
> even if actually created a subdirectory and changed into it
> first. But to the user, it looks like it is creating a .git/ dir
> in the directory he/she is started git from.

Instead of using a relative path, I'm capturing the
output of git-init and adding the absolute path to it.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 I've actually just noticed that setting GIT_DIR=3D before running
 git-svn clone is very broken, and I probably won't get a chance
 to fix it for at least 24 hours (if I'm even awake)...

 Johannes/Benoit/all: git-svn submodules will probably have to
 wait till the weekend...

 git-svn.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 777e436..4873bad 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3,6 +3,7 @@
 # License: GPL v2 or later
 use warnings;
 use strict;
+use Cwd qw/getcwd/;
 use vars qw/	$AUTHOR $VERSION
 		$sha1 $sha1_short $_revision
 		$_q $_authors %users/;
@@ -272,7 +273,9 @@ sub do_git_init_db {
 				push @init_db, "--shared";
 			}
 		}
-		command_noisy(@init_db);
+		my $init_out =3D command(@init_db);
+		$init_out =3D~ s!(\.git)!getcwd .  "/$1"!e;
+		print $init_out, "\n";
 	}
 	my $set;
 	my $pfx =3D "svn-remote.$Git::SVN::default_repo_id";
--=20
Eric Wong
