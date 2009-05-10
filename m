From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [BUG] fatal error during merge
Date: Sun, 10 May 2009 18:33:36 +0200
Message-ID: <20090510163336.GA27241@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?iso-8859-15?Q?G=E1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 18:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Bz9-0003Dg-BZ
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 18:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbZEJQee convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2009 12:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZEJQee
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 12:34:34 -0400
Received: from mout2.freenet.de ([195.4.92.92]:47125 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbZEJQed convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2009 12:34:33 -0400
Received: from [195.4.92.20] (helo=10.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1M3ByC-00027Y-D7; Sun, 10 May 2009 18:33:44 +0200
Received: from x697e.x.pppool.de ([89.59.105.126]:58899 helo=tigra.home)
	by 10.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1M3ByC-0000yc-1I; Sun, 10 May 2009 18:33:44 +0200
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 7216E277D8;
	Sun, 10 May 2009 18:33:36 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 43CD936D28; Sun, 10 May 2009 18:33:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118726>

I still have the patch below (rebased) in my tree.
Was the problem fixed somehow differently?

Alex Riesen, Fri, Nov 14, 2008 00:09:32 +0100:
> SZEDER G=E1bor, Thu, Nov 13, 2008 19:09:31 +0100:
> > On Thu, Nov 13, 2008 at 06:06:52PM +0100, Anders Melchiorsen wrote:
> > > SZEDER G=E1bor wrote:
> > > > It doesn't matter.  The test script errors out at the merge, an=
d not
> > > > at the checkout.  Furthermore, it doesn't matter, whether HEAD~=
,
> > > > HEAD~, or HEAD^ is checked out, the results are the same.
> > >=20
> > > Just to be sure, I tried reverting the commit that you bisected -=
- and my
> > > test case still fails.
> >=20
> > Well, oddly enough, your second test case behaves somewhat differen=
tly
> > than the first one, at least as far as bisect is concerned.  Bisect
> > nails down the second test case to 0d5e6c97 (Ignore merged status o=
f
> > the file-level merge, 2007-04-26; put Alex on Cc).  Reverting this
> > commit on master makes both of your test cases pass.
>=20
> Well, the case is a bit unfair: all files have the same SHA-1!
>=20
> Whatever, the code pointed by the commit you bisected does look like =
a
> problem: it does not update the index after refusing to rewrite the
> worktree file (because its SHA-1 matches the SHA-1 of the data it
> would be rewritten with. So updating the file would be a no-op, just
> wasted effort). Instead of reverting the commit, I suggest the
> attached patch. It is a long time ago since I looked at the code
> (and it is a mess, which I'm feeling a bit ashamed of), so another
> lot of reviewing eyeglasses is definitely in order.
>=20

=46rom f8eb1a64251b3d4ce080c5aaa7240b209a1b5257 Mon Sep 17 00:00:00 200=
1
=46rom: Alex Riesen <raa.lkml@gmail.com>
Date: Thu, 13 Nov 2008 23:55:04 +0100
Subject: [PATCH] Update index after refusing to rewrite files unchanged=
 during merge

Otherwise the path can stay marked as unresolved in the index,
causing the merge to fail.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 merge-recursive.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a3721ef..d5c43d1 100644
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
+					add_cacheinfo(mfi.mode, mfi.sha, ren1_dst, 0, 0, ADD_CACHE_OK_TO_=
ADD);
+				} else {
 					if (mfi.merge || !mfi.clean)
 						output(o, 1, "Renaming %s =3D> %s", ren1_src, ren1_dst);
 					if (mfi.merge)
--=20
1.6.3.28.ga852b
