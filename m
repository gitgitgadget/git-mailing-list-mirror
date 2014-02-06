From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Thu, 06 Feb 2014 11:29:16 +0100
Organization: Organization?!?
Message-ID: <87mwi4k003.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<874n4ewouz.fsf@fencepost.gnu.org>
	<xmqqr47i7dt4.fsf@gitster.dls.corp.google.com>
	<87zjm6v99y.fsf@fencepost.gnu.org>
	<xmqqmwi67cty.fsf@gitster.dls.corp.google.com>
	<87vbwuuf5g.fsf@fencepost.gnu.org>
	<xmqqk3d92t0z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 11:29:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBMDP-0002f9-9U
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 11:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbaBFK3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 05:29:34 -0500
Received: from plane.gmane.org ([80.91.229.3]:41905 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754010AbaBFK3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 05:29:32 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WBMD3-0002PV-Og
	for git@vger.kernel.org; Thu, 06 Feb 2014 11:29:29 +0100
Received: from x2f4740e.dyn.telefonica.de ([2.244.116.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 11:29:29 +0100
Received: from dak by x2f4740e.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 11:29:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f4740e.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:hit1dZx/SUL9ogqWNqzifL/fnfw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241686>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> It's snake oil making debugging harder.
>
> OK, that is a sensible argument.
>
>>> This was fun ;-)
>>
>> At the expense of seriously impacting my motivation to do any furthe=
r
>> code cleanup on Git.
>
> Well, I said it was "fun" because I was learning from a new person
> who haven't made much technical or code aethesitics discussion here
> so far.  If teaching others frustrates you and stops contributing to
> the project, that is a loss.

So let's post something noteworthy technical: the current code iteratio=
n
sported the following routine:

static struct blame_entry *blame_merge(struct blame_entry *list1,
				       struct blame_entry *list2)
{
	struct blame_entry *p1 =3D list1, *p2 =3D list2,
		**tail =3D &list1;

	if (!p1)
		return p2;
	if (!p2)
		return p1;

	if (p1->s_lno <=3D p2->s_lno) {
		do {
			tail =3D &p1->next;
			if ((p1 =3D *tail) =3D=3D NULL) {
				*tail =3D p2;
				return list1;
			}
		} while (p1->s_lno <=3D p2->s_lno);
	}
	for (;;) {
		*tail =3D p2;
		do {
			tail =3D &p2->next;
			if ((p2 =3D *tail) =3D=3D NULL)  {
				*tail =3D p1;
				return list1;
			}
		} while (p1->s_lno > p2->s_lno);
		*tail =3D p1;
		do {
			tail =3D &p1->next;
			if ((p1 =3D *tail) =3D=3D NULL) {
				*tail =3D p2;
				return list1;
			}
		} while (p1->s_lno <=3D p2->s_lno);
	}
}


This is decidedly more complex than the equivalent

static struct blame_entry *blame_merge(struct blame_entry *list1,
				       struct blame_entry *list2)
{
	struct blame_entry *p1 =3D list1, *p2 =3D list2,
		**tail =3D &list1;

	while (p1 && p2) {
		if (p1->s_lno <=3D p2->s_lno) {
			*tail =3D p1;
			p1 =3D *(tail =3D &p1->next);
		} else {
			*tail =3D p2;
			p2 =3D *(tail =3D &p2->next);
		}
	}
	*tail =3D p1 ? p1 : p2;
	return list1;
}

Why not use the latter one?  Apart from the somewhat
obsessive-compulsive avoidance of checking the same condition twice in =
a
row (which nowadays compilers are pretty capable of taking into account
by themselves) the actually decisive difference is to avoid rewriting
links that are already pointing to the right place.

Those are the only write accesses that take place, and since we are
talking about _sorting_, it is to be expected that in the long run,
every record ends up in a cacheline different from its ultimate
neighbors.  Also, assuming a more or less random distribution and
equally sized chains, about half of the links will already be correct.
In practice, the situation tends to be more degenerate, leading to a
_higher_ ratio of already correct links.  Cutting down the expensive
writeout of cachelines by a factor of more than 2 makes quite a
difference in performance.

Does it matter here?  Unlikely.  Profiling tools tend to be useless for
seeing the impact of dirty cachelines since their operation
significantly interferes with the read/write patterns so this kind of
detail often escapes notice.  But the total contribution of this stage
to the runtime of git blame will be insignificant either way.

> new blood bringing in new ideas is fine, but I'd want to see those ne=
w
> ideas backed by solid thiniking, and that means they may have to
> explain themselves to those who are new to their ideas.

Well, there _is_ solid thinking behind the above code, but there _also_
is solid thinking behind the notion that it won't matter in this case.
I=A0still prefer not pushing out code in the wild that I=A0would hesita=
te to
employ in _all_ comparable circumstances.  Consider it as a pattern or =
a
style: a lot of thinking went into it once, and what this should buy yo=
u
is to never have to think about this issue again.

C++ is better at actual code reuse, but with C you basically get patter=
n
reuse.  Your head is instantiating the templates.  And it's a good idea
not to crowd one's head with unnecessary and/or suboptimal patterns.

--=20
David Kastrup
