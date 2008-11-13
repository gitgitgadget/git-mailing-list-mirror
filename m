From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [BUG] fatal error during merge
Date: Fri, 14 Nov 2008 00:09:32 +0100
Message-ID: <20081113230932.GA8552@blimp.localdomain>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk> <2008-11-13-14-23-19+trackit+sam@rfc1149.net> <20081113140323.GA10267@neumann> <2008-11-13-15-26-33+trackit+sam@rfc1149.net> <20081113145325.GD29274@neumann> <57814.N1gUGH5fRhE=.1226596012.squirrel@webmail.hotelhot.dk> <20081113180931.GE29274@neumann>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?iso-8859-15?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Nov 14 00:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0lKv-0003z2-LN
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 00:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbYKMXJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 18:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbYKMXJh
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 18:09:37 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:47182 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbYKMXJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 18:09:36 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CU82p9Cj
Received: from tigra.home (Fa8e1.f.strato-dslnet.de [195.4.168.225])
	by post.strato.de (mrclete mo13) (RZmta 17.20)
	with ESMTP id y03365kADN94UF ; Fri, 14 Nov 2008 00:09:33 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id C31E1277C8;
	Fri, 14 Nov 2008 00:09:32 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 5C29D36D27; Fri, 14 Nov 2008 00:09:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081113180931.GE29274@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=E1bor, Thu, Nov 13, 2008 19:09:31 +0100:
> On Thu, Nov 13, 2008 at 06:06:52PM +0100, Anders Melchiorsen wrote:
> > SZEDER G=E1bor wrote:
> > > It doesn't matter.  The test script errors out at the merge, and =
not
> > > at the checkout.  Furthermore, it doesn't matter, whether HEAD~,
> > > HEAD~, or HEAD^ is checked out, the results are the same.
> >=20
> > Just to be sure, I tried reverting the commit that you bisected -- =
and my
> > test case still fails.
>=20
> Well, oddly enough, your second test case behaves somewhat differentl=
y
> than the first one, at least as far as bisect is concerned.  Bisect
> nails down the second test case to 0d5e6c97 (Ignore merged status of
> the file-level merge, 2007-04-26; put Alex on Cc).  Reverting this
> commit on master makes both of your test cases pass.

Well, the case is a bit unfair: all files have the same SHA-1!

Whatever, the code pointed by the commit you bisected does look like a
problem: it does not update the index after refusing to rewrite the
worktree file (because its SHA-1 matches the SHA-1 of the data it
would be rewritten with. So updating the file would be a no-op, just
wasted effort). Instead of reverting the commit, I suggest the
attached patch. It is a long time ago since I looked at the code
(and it is a mess, which I'm feeling a bit ashamed of), so another
lot of reviewing eyeglasses is definitely in order.

=46rom c395f4234ca5492206923e1821a316a777c651cd Mon Sep 17 00:00:00 200=
1
=46rom: Alex Riesen <raa.lkml@gmail.com>
Date: Thu, 13 Nov 2008 23:55:04 +0100
Subject: [PATCH] Update index after refusing to rewrite unchanged files

Specifically, which were not changed during recursive merge.
Otherwise the path can stay marked as unresolved in the index,
causing the merge to fail.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

diff --git a/merge-recursive.c b/merge-recursive.c
index 7472d3e..28f9e12 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -944,14 +944,15 @@ static int process_renames(struct merge_options *=
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
