From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor of bad rev
Date: Sun, 13 Jul 2008 08:37:40 +0200
Message-ID: <200807130837.40961.chriscool@tuxfamily.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org> <7vd4llpkxq.fsf@gitster.siamese.dyndns.org> <200807110036.17504.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 08:34:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHvAb-0007o4-VO
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 08:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbYGMGdy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 02:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbYGMGdy
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 02:33:54 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:34813 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbYGMGdx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jul 2008 02:33:53 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 33B471AB2C6;
	Sun, 13 Jul 2008 08:33:52 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id C220E1AB2B0;
	Sun, 13 Jul 2008 08:33:51 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200807110036.17504.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88289>

Le vendredi 11 juillet 2008, Christian Couder a =E9crit :
> Le jeudi 10 juillet 2008, Junio C Hamano a =E9crit :
> > Christian Couder <chriscool@tuxfamily.org> writes:
> > > Yeah, in that case...
> > >
> > >> The whole idea of "bisect" relies on that idea, that any ancesto=
r of
> > >> a good commit is good.  Otherwise you'd have to check the commit=
s
> > >> one by one, not in a bisecting manner.
> >
> > Didn't we already discuss this at length?
>
> Yes, the thread is there:
>
> http://thread.gmane.org/gmane.comp.version-control.git/86951
>
> > > No, you just need to check that the merge bases between the bad r=
ev
> > > on one side and each good rev on the other side are good too. And=
 if
> > > that is the case, then you can be sure that bisection will point =
to a
> > > first bad commit.
> > >
> > > So the choice is between a simple and fast but not fully reliable
> > > bisect, or a more complex and slower but fully reliable bisect.
> >
> > I have not looked at your implementation, but I do think:
> >
> >  - The current one is not "fully reliable"; the user needs to know =
what
> >    he is doing.  You might call it "prone to user errors".
>
> I agree.
>
> >  - "Test this merge-base before going forward, please" will add
> > typically only one round of check (if you have more merge bases bet=
ween
> > good and bad, you need to test all of them are good to be sure), so=
 it
> > is not "slower nor more complex".
>
> By "slower" I meant that it would need more rounds of check on averag=
e.
> By "more complex" I meant that more code is needed.
>
> And I think you are right, all the merge bases need to be tested so I
> will send a patch on top of the patch discussed here.

Ok, here is an untested patch that should check all merge bases. I don'=
t=20
have time right now to add tests and a good commit message but I will d=
o=20
that when I come back from vacancy in about one week. So please conside=
r it=20
as just a RFC.

Thanks,
Christian.

-----8<------------

[PATCH] bisect: check all merge bases instead of only one


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 50f912f..ca16609 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -375,7 +375,6 @@ Warning: the merge base between $_bad and $_g must =
be=20
skipped.
 So we cannot be sure the first bad commit is between $_mb and $_bad.
 We continue anyway.
 EOF
-	mark_merge_base_ok "$_bad" "$_g"
 }
=20
 check_merge_bases() {
@@ -384,19 +383,21 @@ check_merge_bases() {
 	_skip=3D"$3"
 	for _g in $_good; do
 		is_merge_base_ok "$_bad" "$_g" && continue
-		_mb=3D$(git merge-base $_g $_bad)
-		if test "$_mb" =3D "$_g" || is_among "$_mb" "$_good"; then
-			mark_merge_base_ok "$_bad" "$_g"
-		elif test "$_mb" =3D "$_bad"; then
-			handle_bad_merge_base "$_bad" "$_g"
-		elif is_among "$_mb" "$_skip"; then
-			handle_skipped_merge_base "$_bad" "$_g" "_mb"
-		else
-			mark_testing_merge_base "$_mb"
-			checkout "$_mb" "a merge base must be tested"
-			checkout_done=3D1
-			break
-		fi
+		for _mb in $(git merge-base --all $_g $_bad); do
+			if test "$_mb" =3D "$_g" || is_among "$_mb" "$_good"; then
+				continue
+			elif test "$_mb" =3D "$_bad"; then
+				handle_bad_merge_base "$_bad" "$_g"
+			elif is_among "$_mb" "$_skip"; then
+				handle_skipped_merge_base "$_bad" "$_g" "_mb"
+			else
+				mark_testing_merge_base "$_mb"
+				checkout "$_mb" "a merge base must be tested"
+				checkout_done=3D1
+				return
+			fi
+		done
+		mark_merge_base_ok "$_bad" "$_g"
 	done
 }
=20
--=20
1.5.6.2.221.gf54e0.dirty
