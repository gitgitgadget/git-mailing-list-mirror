From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Commit a series of patches to SVN without rebase
Date: Fri, 21 Dec 2007 20:53:40 -0800
Message-ID: <20071222045340.GA21524@soma>
References: <20071220164044.GA22683@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sat Dec 22 05:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5wNB-0005pG-73
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 05:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbXLVExm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 23:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbXLVExm
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 23:53:42 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43545 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbXLVExl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 23:53:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 85BCF7DC122;
	Fri, 21 Dec 2007 20:53:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071220164044.GA22683@alea.gnuu.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69120>

J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
> Hi,
>=20
> I've a number of patches in git I want to send to a SVN repository. g=
it
> svn dcommit does a rebase after each commit which makes the whole com=
mit
> takes very long. Is it possible to skip the rebase? All patches are i=
n
> one branch without merges, a simple chain. Is it save to use --no-reb=
ase
> in this case?

Right now, only if the changes don't depend on each other (they all
modify different files).

The following patch should allow dcommit of multiple changes that depen=
d
on each other with --no-rebase.  --no-rebase was Karl's idea, and I've
never used it myself so I don't know how it works.

I don't have time to write a test case for --no-rebase at the
moment, but any reports/feedback would be helpful.  Thanks.

diff --git a/git-svn.perl b/git-svn.perl
index c51f1e7..9b1113a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -418,7 +418,7 @@ sub cmd_dcommit {
 		warn "Attempting to commit more than one change while ",
 		     "--no-rebase is enabled.\n",
 		     "If these changes depend on each other, re-running ",
-		     "without --no-rebase will be required."
+		     "without --no-rebase may be required."
 	}
 	while (1) {
 		my $d =3D shift @$linear_refs or last;
@@ -453,6 +453,7 @@ sub cmd_dcommit {
 				                               $parents->{$d};
 			}
 			$_fetch_all ? $gs->fetch_all : $gs->fetch;
+			$last_rev =3D $cmt_rev;
 			next if $_no_rebase;
=20
 			# we always want to rebase against the current HEAD,
@@ -512,7 +513,6 @@ sub cmd_dcommit {
 				$parents =3D \%p;
 				$linear_refs =3D \@l;
 			}
-			$last_rev =3D $cmt_rev;
 		}
 	}
 	unlink $gs->{index};

--=20
Eric Wong
