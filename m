From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor of bad rev
Date: Tue, 22 Jul 2008 08:15:32 +0200
Message-ID: <200807220815.32989.chriscool@tuxfamily.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org> <200807130837.40961.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807131504130.4816@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 08:12:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLB75-0006Jc-4X
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 08:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbYGVGLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jul 2008 02:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYGVGLn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 02:11:43 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:47617 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYGVGLm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jul 2008 02:11:42 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6924D1AB2BB;
	Tue, 22 Jul 2008 08:11:40 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E2D571AB2AA;
	Tue, 22 Jul 2008 08:11:39 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807131504130.4816@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89441>

Hi,

Le dimanche 13 juillet 2008, Johannes Schindelin a =E9crit :
> Hi,
>
> On Sun, 13 Jul 2008, Christian Couder wrote:
> > [PATCH] bisect: check all merge bases instead of only one
>
> It would have been so much nicer to squash the two patches into one, =
as
> we generally frown upon "let's submit one patch that we know is fault=
y,
> and then another that fixes it".  That's so CVS/SVN.

I didn't think the first one was "faulty". It just didn't fix everythin=
g.

> > @@ -384,19 +383,21 @@ check_merge_bases() {
> >  	_skip=3D"$3"
> >  	for _g in $_good; do
>
> I really wonder if we can be blessed with less ugly variable names.=20
> Maybe some that do not start with an underscore for no apparent reaso=
n,

There is a reason though. It's because in "bisect_next", variables with=
=20
those names ("good", "bad" and "skip") are already used, so reusing the=
=20
same name is not easily possible.

> and maybe some that are longer than one letter, so that you have a ch=
ance
> to understand later what it is supposed to contain.  I.e. something l=
ike:
>
> 	for good in $good_revisions
> 	do
>
> (You see that I also broke up the "for" and "do" into two lines, as i=
s
> common practice in the rest of Git's shell code.)

There are other places in git-bisect.sh where "for" and "do" are in the=
 same=20
line. Perhaps one day I will submit a patch to fix these.

> >  		is_merge_base_ok "$_bad" "$_g" && continue
> > -		_mb=3D$(git merge-base $_g $_bad)
> > -		if test "$_mb" =3D "$_g" || is_among "$_mb" "$_good"; then
> > -			mark_merge_base_ok "$_bad" "$_g"
> > -		elif test "$_mb" =3D "$_bad"; then
> > -			handle_bad_merge_base "$_bad" "$_g"
> > -		elif is_among "$_mb" "$_skip"; then
> > -			handle_skipped_merge_base "$_bad" "$_g" "_mb"
> > -		else
> > -			mark_testing_merge_base "$_mb"
> > -			checkout "$_mb" "a merge base must be tested"
> > -			checkout_done=3D1
> > -			break
> > -		fi
> > +		for _mb in $(git merge-base --all $_g $_bad); do
> > +			if test "$_mb" =3D "$_g" || is_among "$_mb" "$_good"; then
> > +				continue
> > +			elif test "$_mb" =3D "$_bad"; then
> > +				handle_bad_merge_base "$_bad" "$_g"
> > +			elif is_among "$_mb" "$_skip"; then
> > +				handle_skipped_merge_base "$_bad" "$_g" "_mb"
> > +			else
> > +				mark_testing_merge_base "$_mb"
> > +				checkout "$_mb" "a merge base must be tested"
> > +				checkout_done=3D1
> > +				return
> > +			fi
> > +		done
> > +		mark_merge_base_ok "$_bad" "$_g"
> >  	done
> >  }
>
> I really wonder if we cannot do better than that, in terms of code
> complexity.
>
> For example, I wonder if we should special-case the start, and not ju=
st
> check everytime if there are unchecked merge bases instead.  If there
> are, check the first.

In fact, there was such a thing in my patch, search=20
for "$GIT_DIR/BISECT_ANCESTORS_OK". But it was a little bit broken if=20
people didn't test the commit that "git bisect" suggested.

In the next version I will post just after this mail, this is in the 2/=
2=20
patch (and hopefully fixed).

> But that can wait until you come back from your vacation...
>
> Have fun,
> Dscho

Thanks,
Christian.
