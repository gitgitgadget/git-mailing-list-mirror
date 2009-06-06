From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/3] bisect: when skipping, choose a commit away from a skipped commit
Date: Sat, 6 Jun 2009 06:38:25 +0200
Message-ID: <200906060638.25566.chriscool@tuxfamily.org>
References: <20090605040238.8885.92790.chriscool@tuxfamily.org> <20090605041044.8885.92104.chriscool@tuxfamily.org> <7vmy8np44z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 06:41:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCniJ-0005v6-7X
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 06:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbZFFEi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 00:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbZFFEi1
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 00:38:27 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:59999 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbZFFEi0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 00:38:26 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D3A35818044;
	Sat,  6 Jun 2009 06:38:20 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9D24D818049;
	Sat,  6 Jun 2009 06:38:17 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vmy8np44z.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120867>

Le Friday 05 June 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > +static struct commit_list *apply_skip_ratio(struct commit_list *li=
st,
> > +					    int count,
> > +					    int skip_num, int skip_denom)
> > +{
> > +	int index, i;
> > +	struct commit_list *cur, *previous;
> > +
> > +	cur =3D list;
> > +	previous =3D NULL;
> > +	index =3D count * skip_num / skip_denom;
> > +
> > +	for (i =3D 0; cur; cur =3D cur->next, i++) {
> > +		if (i =3D=3D index) {
> > +			if (hashcmp(cur->item->object.sha1, current_bad_sha1))
> > +				return cur;
> > +			if (previous)
> > +				return previous;
>
> When you return "previous", don't you need to make sure it is not the
> currently bad one?  That is,...
>
> > +			return list;
> > +		}
> > +		previous =3D cur;
>
> ... shouldn't this be
>
>                 if (hashcmp(cur->item->object.sha1, curret_bad_sha1))
>                         previous =3D cur;
>
> > +	}

I think the current bad will always have the worst goodness value so it=
 will=20
always be the last item in the list, so it cannot be "previous".

You can try it out with "git rev-list --bisect-all HEAD ^HEAD~10" for=20
example, the bad item (HEAD in this example) will always appear=20
with "(dist=3D0)" at the end.

We rely on that in "bisect_next_all" to decide if we found the first ba=
d=20
commit. We do:

	bisect_rev =3D revs.commits->item->object.sha1;
	...

	if (!hashcmp(bisect_rev, current_bad_sha1)) {
		exit_if_skipped_commits(tried, current_bad_sha1);
		printf("%s is first bad commit\n", bisect_rev_hex);
		show_diff_tree(prefix, revs.commits->item);
		/* This means the bisection process succeeded. */
		exit(10);
	}

> I do not understand the math/logic you are using here.  The incoming =
list
> is sorted by the "goodness" value, and untestable ones have already b=
een
> removed.

Yes.

> By picking ones that are far from the tip, you are deliberately=20
> accepting far suboptimal bisection, but I do not see how you are
> guaranteeing that making such a trade-off is driving you away from th=
e
> untestable ones.=20

I think picking one commit far from the tip, doens't mean accepting far=
=20
suboptimal bisection. HPA wrote in a recent thread (RFE: "git bisect=20
reverse"):

"You don't drop to 1/2 bit of information until x =3D 0.11 or 0.89"

and I think the worst possible value with my code means x =3D 0.2 or x =
=3D 0.8=20
(with the 3/5 ratio).

It's true that when using a ratio to skip away from an untestable one w=
e=20
don't check that we don't come near another untestable one.=20

> It almost feels to me that it is no better than=20
> randomly picking one from the list, so why can this be an improvement
> over "pick the one that is testable that appears first in the list th=
at
> is sorted by the goodness value"?

We rely on the assumption that the probability that there are many=20
untestable ones in many different places quite far away from an untesta=
ble=20
one and from each other is very low.

=46or example using the following script:

-------------
#!/bin/sh

new_commit() {
    num=3D"$1"
    echo "line for commit $num" >> hello
    git commit -m "commit $num" hello
}

touch hello
git add hello

for val in $(seq 100)
do
  new_commit $val
done
-------------

and then bisecting between the first and last commits gives something l=
ike:

$ git bisect start HEAD HEAD~99
Bisecting: 49 revisions left to test after this (roughly 6 steps)
[e65f680ee31729d2db66dbed7eb24ea8c0e8b6c3] commit 50
$ git bisect skip
Bisecting: 48 revisions left to test after this (roughly 6 steps)
[6cc0df3b9762928c90a5ce7ad4d27bf3340983c3] commit 51
$ git bisect skip
Bisecting: 48 revisions left to test after this (roughly 6 steps)
[45387fab3997ca8c449ac419cb401207aa63da4d] commit 71
$ git bisect skip
Bisecting: 48 revisions left to test after this (roughly 6 steps)
[dd20066ed8a287e8105b833911de7509ca5ec339] commit 40
$ git bisect skip
Bisecting: 48 revisions left to test after this (roughly 6 steps)
[8f0c63e6eede9650bb577dba6f3092703409509e] commit 20
$ git bisect skip
Bisecting: 48 revisions left to test after this (roughly 6 steps)
[4809a426fd411f2db43291bc5d206b199ca9e648] commit 30
$ git bisect skip
Bisecting: 48 revisions left to test after this (roughly 6 steps)
[095cc6a1c6f071f3807ca123ab5bcfc133f36f96] commit 61
$ git bisect skip
Bisecting: 48 revisions left to test after this (roughly 6 steps)
[94a00c0de61ed8ddef261bebfbbb00bc6e0a3a1f] commit 82
$ git bisect skip
Bisecting: 48 revisions left to test after this (roughly 6 steps)
[5d1a2332b7d5d409faebb7056e11028f5b7642f4] commit 29
$ git bisect skip
Bisecting: 48 revisions left to test after this (roughly 6 steps)
[ad46dfdfb0a871b13144395efe26607cb63c7f5b] commit 39

So after testing commits 50 and 51 that are near the middle, you test m=
any=20
commits far away from both commits 50 and 51 and from each other, and y=
et=20
not too close to 0 or 100.

> Imagine you have a graph like this (G is good, B is bad, and both
> branches have similar number of commits):
>
> 	G-------------y--z--a--b--c--B
>                               /
>         G--------------f--e--d
>
> In the above graph, a and d would give the best bisection, because th=
ey
> can reach about half the number of nodes in the entire graph, and the
> goal of the basic "find_bisection()" is to find a commit that cuts th=
e
> graph into closest-to-the-equal halves.  For this reason, 'a' and 'd'
> would be near the beginning of the output from find_bisection(find_al=
l)
> you run when there are untestable commits in your managed_skipped().
>
> Suppose 'd' was already marked untestable, but 'a' is not.  And 'd' h=
as
> slightly better "goodness" value than 'a'.
>
> 	Side note.  I do not think the situation should change drastically
> 	if 'a' has a better "goodness" value than 'd' has, but your
> 	"skipped_first" logic that I already said I do not understand in
> 	my earlier comment treats them quite differently, so this example
> 	explicitly talks about the case where 'd' is better than 'a'.
>
> You do not check 'a' but check somewhere much older, either on the to=
p
> branch or on the bottom branch.  Why?

The reason is that it would make the code more complex to check that we=
 are=20
in this case, and that this case may not happen very often (it relies o=
n=20
both being near a merge and having branches of the same size), and that=
 we=20
don't loose much (see above my reference to what HPA wrote) by testing =
a=20
commit quite far away.

> 'b', because it is direct descendant of 'd', is likely to have inheri=
ted
> the unrelated breakage from 'd' that made it untestable.  'c', being =
its
> descendant, can also be contaminated with the unrelated breakage, but
> there is a chance that such an unrelated breakage was fixed there.
> Similarly, 'e' is likely to share the same unrelated breakage as 'd' =
has,
> because it is a direct ancestor.  'f' shares the possibility but has =
a
> better chance of being testable than 'e' is.
>
> But 'a' does not have any relationship with 'd' and it is unlikely su=
ch
> an unrelated breakage exists there.
>
> I _think_ the solution to the "bisection with untestable" problem sho=
uld
> be handled as an optimization problem of two goodness values that can=
not
> be directly compared and traded-off:
>
>  - The point chosen should be close to the mid-point.  The closer
> "weight" value given in do_find_bisection() is to half the number of
> nodes, the better;

I am not so sure this is so important.

>  - The point chosen should be far from any known untestable commits. =
 We
>    do not currently have function to count distance from untestable
>    commits, nor make a call to such a function after filtering untest=
able
>    commits, but I think we should.

I think this should be the case with my patch series.

> We already have an efficient and good implementation to compute the
> former criteria (find_bisection).
>
> The "badness" value that comes from the latter criteria essentially
> should be how close, from ancestry point of view, each commit is rela=
ted
> to the ones that are known to be untestable.  In the picture, 'b' and=
 'e'
> are close relatives (they have thick blood relationship with 'd') and
> worse than 'c' and 'f' but 'a' shouldn't be punished for being marrie=
d to
> 'd' that has a bad blood at all.
>
> Now coming back to the "skipped_first" topic.  Let's use the same gra=
ph,
> but now let's assume neither 'a' nor 'd' is known to be untestable, a=
nd
> also 'a' gives slightly better "goodness" value than 'd' does.  Furth=
er
> suppose that 'z' was already known to be untestable this time.
>
> Even though 'a' may have a better goodness value, hence it is not
> skipped, shouldn't we be favoring 'd' over 'a' because 'a' is far lik=
ely
> to be untestable (due to closer blood tie with 'z') than 'd' is, and =
'a'
> and 'd' would give roughly the same "goodness" value?
>
> This is why I said I do not understand your skipped_first logic.

I agree that we could probably analyse the graph much better than what =
my=20
patch series does, but I think that it would be quite complex.

> > +static struct commit_list *managed_skipped(struct commit_list *lis=
t,
> > +					   struct commit_list **tried)
> > +{
> > +	int count, skipped_first;
> > +	int skip_num, skip_denom;
> > +
> > +	*tried =3D NULL;
> > +
> > +	if (!skipped_revs.sha1_nr)
> > +		return list;
> > +
> > +	if (!skip_num)
> > +		return filter_skipped(list, tried, 0, NULL, NULL);
>
> skip_num is uninitialized and then checked here.  Is it supposed to b=
e
> "static int" with implied 0 initialization?

Ooops, I forgot to remove these 2 lines. They were usefull in my previo=
us=20
series but they should be removed in this one.

> > +	list =3D filter_skipped(list, tried, 0, &count, &skipped_first);
> > +
> > +	if (!skipped_first)
> > +		return list;
> > +
> > +	/* Use alternatively 1/5, 2/5 and 3/5 as skip ratio. */
> > +	skip_num =3D count % 3 + 1;
> > +	skip_denom =3D 5;
> > +
> > +	return apply_skip_ratio(list, count, skip_num, skip_denom);
> > +}

I will repost the series with the above fix and some added comments.

Thanks,
Christian.
