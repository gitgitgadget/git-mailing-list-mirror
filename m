From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos
 containing damaged trees.
Date: Mon, 25 Jul 2011 19:28:12 +1000
Message-ID: <CAH3AnrrVwodvtwWfaJCJqjuHThtv75jaWeDjvwRgdFbgXA3ziA@mail.gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
	<7v1uxfwmq3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 11:28:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlHSb-0003k9-5H
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 11:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab1GYJ2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jul 2011 05:28:16 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49802 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab1GYJ2N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 05:28:13 -0400
Received: by vxh35 with SMTP id 35so2732575vxh.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dC9yW+aA6GhGZGPO7KrTns7jH+4d7D1tMSEUemoTF+A=;
        b=N/66KzRCzDjaH4SH8aREAcRFnssqDl/3/zwojccGc3H+Uk/iq9PubKjuMjOytUM6En
         SppcaaiE6cK38WhMYjI3PzFyz/Y8gGpPjUhFmnxT9zqzcJpwg4/2bBV2jV3Ln/HJZT76
         gJp/Ltx2/a7ep67R0S757RtXwU4pckxt6NQoc=
Received: by 10.52.21.194 with SMTP id x2mr4126906vde.39.1311586092065; Mon,
 25 Jul 2011 02:28:12 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Mon, 25 Jul 2011 02:28:12 -0700 (PDT)
In-Reply-To: <7v1uxfwmq3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177789>

On Mon, Jul 25, 2011 at 4:35 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> ... In particular, it
>> allows git bisect to be used to locate commits containing damaged tr=
ees.
>
> I am afraid it wouldn't allow it, and I am not going to take this ser=
ies
> that adds an option to bisect to ignore errors during checkout.

Understand that you don't wish to accept the series, but I do think
you are mistaken about whether it will work.

>
> Remember that bisection is to find a single event in the history whos=
e
> effect consistently persists in all the commits into the future from =
that
> point. =C2=A0For example, if you have this history:
>
> =C2=A0 =C2=A0---A---B---C
>
> and there is a bitflip in a blob contained in the commit B's tree, yo=
u may
> not be able to check it out. But that does _not_ mean you cannot chec=
k C
> out due to a corrupt object in B. The change going from B to C may be=
 to
> remove that blob, for example. "A tree that refers to a corrupt objec=
t was
> introduced by this commit" is not a single event whose effect cascade=
s
> through the history into the future [*1*].

I don't think you understood my intention. Suppose, I have

B4 - B5 - B6' - B7' - B8' - B9

such that B6 and B7 and B8 all contain a damaged tree, but B4, B5 and B=
9 don't
since it contains a different tree, then:

        git bisect start B8' B4 --ignore-checkout-failure &&
	git bisect run eval "git status >/dev/null 2>&1 || false"

will stop with bisect/bad =3D B6'

This is exactly the result I wanted, and I discover B6' with a binary
search, rather than a linear search.

(I could also discover B8' with a binary search by reversing the sense
of the test).

In other words, I don't understand why you say that it won't work -
since it clearly does work for the purposes which I intended.

=46or a real example, see [1].

>
> Besides, if you have a corrupt commit, your history traversal may not=
 even
> be correct, as we won't be reading its parent pointers correctly.
>

Agreed. This only works when you have dealt with broken commits by
applying suitable grafts.

I noticed a neat heuristic for doing this is to compute the diff
between the first good commit after the broken
region and the first good dangling commit (as reported by fsck) - the
one with the smallest delta may well be
a suitable object to use as one end of the graft. [ needs to be sanity
checked, of course ]. It may not be perfect,
but when the objective is to get a consistent (in the sense of fsck),
if incomplete repository, it may well do.

> Having said that, an option to bisect that does _not_ touch the index=
 nor
> the working tree at all may be a useful thing to have. The test you w=
ant
> to run on the candidate revisions bisect suggests may not need a work=
ing
> tree (e.g. it may be built around "git grep -e foo $revision -- $path=
"),
> and it may work just as well for the bisection you wanted to do in yo=
ur
> broken repository.
>

I am happy to do this, since clearly enables a superset of the cases
handled by --ignore-checkout-failure.

I propose to do this with a new ref (perhaps BISECT_CURSOR) which will
be used in place of HEAD
for the purposes of driving the bisection algorithm if --no-checkout
has been specified on the
git bisect start command.

Any comments?

jon.

----------------
[1] a test execution that shows that the bisection does, in fact, help
to identify the boundaries of a broken region.

(Note NEAREST could also be discovered with a binary search, but this
isn't done in this example).

expecting success:
        git bisect reset &&
	NEAREST=3D$(git rev-list broken | while read c
	do
	    git ls-tree -r $c >/dev/null || {
	    	echo $c;
		exit 0;
	    }
	done) &&
        git bisect start $NEAREST $HASH1 --ignore-checkout-failure &&
	git bisect run eval "git status >/dev/null 2>&1 || false" >
my_bisect_log.txt &&
        grep "$BROKEN_HASH6 is the first bad commit" my_bisect_log.txt

We are not bisecting.
error: Could not read 39f7e61a724187ab767d2e08442d9b6b9dab587d
Bisecting: 3 revisions left to test after this (roughly 2 steps)
fatal: unable to read tree 39f7e61a724187ab767d2e08442d9b6b9dab587d
warn: checkout failed. Updating HEAD directly. The working tree and
index may be inconsistent.
[32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <=
hello>.
fatal: unable to read tree 39f7e61a724187ab767d2e08442d9b6b9dab587d
warn: checkout failed. Updating HEAD directly. The working tree and
index may be inconsistent.
fatal: unable to read tree 39f7e61a724187ab767d2e08442d9b6b9dab587d
warn: checkout failed. Updating HEAD directly. The working tree and
index may be inconsistent.
1b0312df05d867dc49f5d9f82617ee42cce1430d is the first bad commit
ok 49 - bisect: find the first inconsistent commit
