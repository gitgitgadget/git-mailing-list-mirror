From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix for a merge where a branch has an F->D transition
Date: Mon, 11 May 2009 21:25:36 +0200
Message-ID: <20090511192536.GA1485@blimp.localdomain>
References: <81b0412b0905110242u3624f0eeyc0dc9b2b987bfa2b@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?iso-8859-15?Q?G=E1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 11 21:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3b9I-00066b-3n
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbZEKT0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 15:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188AbZEKT0A
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:26:00 -0400
Received: from mout1.freenet.de ([195.4.92.91]:45775 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880AbZEKTZ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 15:25:59 -0400
Received: from [195.4.92.25] (helo=15.mx.freenet.de)
	by mout1.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1M3b8F-0006aT-IQ; Mon, 11 May 2009 21:25:48 +0200
Received: from x4413.x.pppool.de ([89.59.68.19]:55743 helo=tigra.home)
	by 15.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1M3b8B-00053R-KH; Mon, 11 May 2009 21:25:44 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id EA313277D8;
	Mon, 11 May 2009 21:25:36 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 8871336D28; Mon, 11 May 2009 21:25:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0905110242u3624f0eeyc0dc9b2b987bfa2b@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118828>

Some path names which transitioned from file to a directory were not
updated in the final part of the merge (loop around unmerged entries in
merge_trees), because the branch in process_renames which filtered out
updates for the files with the same content ("merged same as existing")
has left the rename entry in processed state. In this case, the
processing cannot be finished at the process_renames phase (because
the old file still blocks creation of directory where new files should
appear), and must be postponed until the update_entry phase.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Mon, May 11, 2009 11:42:17 +0200:
> The problem is that if a file was replaced with a directory containin=
g
> another file with the same content and mode, an attempt to merge it
> with a branch descended from a commit before this F->D transition wil=
l
> cause merge-recursive to break. It breaks even if there were no
> conflicting changes on that other branch.
>=20
> 2009/5/11 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >
> > Maybe you can turn this into a patch adding a test (with
> > test_expect_failure to mark it as a bug)? =A0This would make debugg=
ing a lot
> > easier, as a non-installed Git could be tested.
>=20
> Here.
>=20
>  t/t6020-merge-df.sh |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
>=20

=46rankly, I'm not really sure. The solution came largely ... empirical
way. IOW, I tried more or less random things which looked like they
should fix the problem. So a review is very much appreciated. Please.

 merge-recursive.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a3721ef..3c5420b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -980,14 +980,15 @@ static int process_renames(struct merge_options *=
o,
=20
 				if (mfi.clean &&
 				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
-				    mfi.mode =3D=3D ren1->pair->two->mode)
+				    mfi.mode =3D=3D ren1->pair->two->mode) {
 					/*
 					 * This messaged is part of
 					 * t6022 test. If you change
 					 * it update the test too.
 					 */
 					output(o, 3, "Skipped %s (merged same as existing)", ren1_dst);
-				else {
+					ren1->dst_entry->processed =3D 0;
+				} else {
 					if (mfi.merge || !mfi.clean)
 						output(o, 1, "Renaming %s =3D> %s", ren1_src, ren1_dst);
 					if (mfi.merge)
--=20
1.6.3.28.ga852b
