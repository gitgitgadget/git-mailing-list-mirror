From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v2] merge-base: teach "git merge-base" to accept more than 2 arguments
Date: Mon, 28 Jul 2008 08:10:20 +0200
Message-ID: <200807280810.20922.chriscool@tuxfamily.org>
References: <20080727053324.b54fe48e.chriscool@tuxfamily.org> <7vabg43pcp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 08:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNLtR-0004TW-EL
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbYG1GGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 02:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbYG1GGh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:06:37 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:44916 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbYG1GGg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 02:06:36 -0400
X-Greylist: delayed 90004 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jul 2008 02:06:36 EDT
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id CED0EB0194;
	Mon, 28 Jul 2008 08:06:32 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 993EFB0159;
	Mon, 28 Jul 2008 08:06:32 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vabg43pcp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90413>

Le dimanche 27 juillet 2008, Junio C Hamano a =E9crit :
>
> The point of merge_bases_many() is that it allows you to compute a me=
rge
> base between a commit and another commit that does not yet exist whic=
h is
> a merge across all others.
>
>                o---o---o---o---C
>               /                 :
>              /   o---o---o---B..(M)
>             /   /                 :
> 	---o---*---o---o---o---A..(X)
>
> Suppose you have commits A, B and C, and you would want to come up wi=
th
> an Octopus merge X across these three commits.  Because our low-level
> merge machinery works always on two trees with one common ancestor tr=
ee,
> we would first create a tree that is a merge between B and C (which i=
s
> marked as (M) in the picture), and then merge the tree of (M) and A u=
sing
> common ancestor between (M) and A.
>
> If we did not have merge_bases_many(), we would actually create (M) a=
s a
> real commit, and compute merge base between A and (M), which is marke=
d as
> "*" in the picture.  The use of merge_bases_many() allows us to run t=
he
> same merge base computation without actually creating commit (M).=20
> Instead of computing merge-base between A and (M), you can ask for th=
e
> merge base between A ("the first commit") and B, C ("the other commit=
s")
> to obtain the same answer "*".

Yeah, but what is quite confusing I think is that a merge base seems to=
 be=20
defined as "an as good as possible _common_ ancestor" but in this case,=
 the=20
result of "git merge-base A B C" is not an ancestor of C (even with --a=
ll=20
option). So perhaps we need a better definition.

> Base between A and B is that "*", and you are correct to say that it =
is
> an ancestor of the "*" that is output from the command; base between =
A
> and C is the parent of "*", and again you are correct to say it is
> ancestor of the "*" that is output from the command.
>
> But if we output any other commit between "*" and A from the command,=
 it
> still satisifies your condition.  "The merge base between A and each =
of
> B, C,... should be an ancestor of what is output".  In order to satis=
ify
> your condition, in the extreme case, we could even output A.  Both th=
e
> merge base between A and B, and the merge base between A and C, would=
 be
> an ancestor of A.
>
> So your description may not be incorrect, but I think it completely
> misses the point of what is being computed.
>
> >  Author
> >  ------
> > diff --git a/builtin-merge-base.c b/builtin-merge-base.c
> > index 1cb2925..f2c9756 100644
> > --- a/builtin-merge-base.c
> > +++ b/builtin-merge-base.c
> > @@ -2,9 +2,11 @@
> >  #include "cache.h"
> >  #include "commit.h"
> >
> > -static int show_merge_base(struct commit *rev1, struct commit *rev=
2,
> > int show_all) +static int show_merge_base(struct commit *rev1, int
> > prev2_nr, +			   struct commit **prev2, int show_all)
> >  {
> > -	struct commit_list *result =3D get_merge_bases(rev1, rev2, 0);
> > +	struct commit_list *result =3D get_merge_bases_many(rev1, prev2_n=
r,
> > +							  prev2, 0);
>
> This is just style, but if you must break lines somewhere, I'd prefer=
 to
> have prev2_nr and prev2 on the same line, like this:
>
> 	struct commit_list *result =3D get_merge_bases_many(rev1,
> 							  prev2_nr, prev2, 0);
>
> because they logically belong to each other.  Further, I think this
> 84-column single-line statement is perfectly fine as well in this cas=
e:
>
> 	struct commit_list *result =3D get_merge_bases_many(rev1, prev2_nr, =
prev2,
> 0);
>
> I would probably do this myself in this case, though:
>
> 	struct commit_list *result;
>
> 	result  =3D get_merge_bases_many(rev1, prev2_nr, prev2, 0);

I used that in v3.

Thanks,
Christian.
