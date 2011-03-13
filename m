From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Mon, 14 Mar 2011 00:09:01 +0100
Message-ID: <AANLkTinQU8=-thBQxKJFvsUQ=C+FiBohk+PrJtnHWYG7@mail.gmail.com>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian>
 <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
 <alpine.DEB.2.00.1102161122350.14950@debian> <AANLkTik-JGZFCE+m7g__mwfQhRReOM=Qe_EO3otw50XC@mail.gmail.com>
 <alpine.DEB.2.00.1103120930250.15442@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 00:09:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyuPg-0007Rk-It
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 00:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081Ab1CMXJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Mar 2011 19:09:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40353 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab1CMXJW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Mar 2011 19:09:22 -0400
Received: by qwk3 with SMTP id 3so894455qwk.19
        for <git@vger.kernel.org>; Sun, 13 Mar 2011 16:09:21 -0700 (PDT)
Received: by 10.229.56.148 with SMTP id y20mr9320479qcg.283.1300057761126;
 Sun, 13 Mar 2011 16:09:21 -0700 (PDT)
Received: by 10.229.78.209 with HTTP; Sun, 13 Mar 2011 16:09:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1103120930250.15442@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168982>

[Also quoted text from On Sun, Mar 13, 2011 at 4:14 AM, Martin von
Zweigbergk <martin.von.zweigbergk@gmail.com>]

On Sat, Mar 12, 2011 at 10:15 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Thu, 17 Feb 2011, Santi B?jar wrote:
>
>> On Wed, Feb 16, 2011 at 5:45 PM, Martin von Zweigbergk
>> <martin.von.zweigbergk@gmail.com> wrote:
>> > On Wed, 16 Feb 2011, Santi B?jar wrote:
>> >
>> >> On Wed, Feb 16, 2011 at 3:03 AM, Martin von Zweigbergk
>> >> <martin.von.zweigbergk@gmail.com> wrote:
>> >> >
>> >> > =A0 =A0 =A0 =A0.-u@{0}
>> >> > =A0 =A0 =A0 /
>> >> > =A0 =A0 =A0.---u@{1}
>> >> > =A0 =A0 /
>> >> > x---y-----u@{2}
>> >> > =A0 =A0 \
>> >> > =A0 =A0 =A0.---u@{3}---b
>> >> > =A0 =A0 =A0 \
>> >> > =A0 =A0 =A0 =A0.-u@{4}
>> >> >
>> >> >
>> >> > I have an idea inspired by bisection, Thomas's exponential stri=
de, and
>> >> > what someone (you?) mentioned the other day about virtual merge
>> >> > commits. I haven't tried it out, but let me know what you think=
=2E I'll
>> >> > try to explain it using an example only:
>> >> >
>> >> > Exponential stride phase:
>> >> > 1. candidates=3D{ u@{0} }
>> >> > =A0 merge-base b $candidates -> y, _not_ in $candidates
>> >> > 2. candidates=3D{ u@{1} u@{2} }
>> >> > =A0 merge-base b $candidates -> y, _not_ in $candidates
>> >> > 3. candidates=3D{ u@{3} u@{4} u@{5} u@{6} }
>> >> > =A0 merge-base b $candidates -> u@{3}, in $candidates
>> >>
>> >> Doesn't it indicate that u@{3} is the commit we are looking for? =
I
>> >> haven't found a counterexample...
>> >
>> > Yes, of course. Stupid me ;-). Forget about the other half. (I thi=
nk
>> > that's what I did manually to match the sha1 back to the ref name,=
 but
>> > that is of course complete non-sense to do in the script.)
>> >
>> >> If this is true the following patch can implement it for git-pull=
=2Esh and
>> >> git-rebase.sh (sorry if it is space damaged):
>> >
>> > Thanks! Will have a closer look at it later today. If I understand
>> > correctly, you simply call merge-base with the _entire_ reflog. I
>>
>> Yes, that is the idea (plus the old remote hash in case of git-pull)
>>
>> > would have thought that would be slow, but it's great if that is f=
ast
>> > enough.
>>
>> Yes, I think it is fast enough in the normal case. Even feeding the
>> entire git.git's master, ~25000 revisions, it takes around 2-4 secon=
ds
>> only:
>>
>> $ git rev-list origin/master | wc -l
>> 24380
>> $ time git merge-base $(git rev-list origin/master)
>> 9971d6d52c5afeb8ba60ae6ddcffb34af23eeadd
>>
>> real =A00m4.014s
>> user =A00m1.520s
>> sys =A0 0m2.284s
>>
>> (2.5GHz CPU)
>
>
> I finally got around to doing some tests on this myself. I used
> git.git as of mid Feb, which at that time had 10010 commits in master=
,
> following only the first parent. I took the first 563 commits from th=
e
> todo branch and transplanted onto master~10000 (there were some
> conflicts after about 563 commits and I figured that would be enough
> anyway). I then rebased the resulting branch (let's call it 'u')
> against master~9990, then against master~9980 and so on to get a
> reflog with 1001 entries for u. I then created another branch 'b'
> based on u@{10}, u@{100} and @{1000}, for different runs of the
> tests. I created one additional commit on b in each case. I then
> rebased b with master, using the following algorithms to find the bas=
e
> to rebase from:
>
> =A0manual: simply calling 'git rebase --onto u b~1'
>
> =A0linear: same algorithm as in 'git pull', which linearly walks the
> =A0reflog until a commit that b contains is found
>
> =A0merge-base: the base will be calculated as 'git merge-base b $(git
> =A0ref-list -g u)'
>
> =A0exponential: like merge-base, but start with only u@{0}, then
> =A0{u@{1},u@{2}} and so on until a commit that b contains is found

exp(n,m): like merge-base, but start with n candidates {u@{0},
=2E.., u@{n-1}}, then n*m candidates and so on until a commit that b
contains is found.

>
> These are the results:

These are best timing out of three runs, mean, only the first one? Hot-=
cache
for all tests?

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u@{10} =A0 =A0 u@{100} =A0 =A0u@{1000=
}
> manual =A0 =A0 =A0 =A0 0m0.535s =A0 =A00m1.164s =A0 =A00m1.415s
> linear =A0 =A0 =A0 =A0 0m1.245s =A0 0m37.367s =A0 5m10.068s
> merge-base =A0 =A00m14.490s =A0 0m15.409s =A0 0m15.508s
> exp(1,2)       0m1.056s    0m6.175s   0m27.221s
> exp(10,10)     0m1.950s   0m20.031s   0m18.215s
> exp(7,7)       0m1.310s    0m6.851s   0m16.757s
>
> (1.8 GHz Athlon 64).
>
> This clearly shows that the linear algorithm from git pull is not goo=
d
> enough when rebasing older branches (i.e. branches whose upstream has
> many reflog entries created after the branch itself was created).
>
> The time it takes the "merge-base" algorithm is quite independent on
> how old the branch is, but with this quite long and branchy reflog
> (but not too dissimilar from git.git's pu?), it takes quite a while t=
o
> calculate it. I think this is also too slow to be acceptable as a
> default.
>
> I would personnally be happy if the "exponential" algorithm was used
> by git rebase default. I suppose not everyone would agree that the
> convenience outweighs the performance cost, though.

I don't agree with this. For the normal case there is no performance co=
st
(manual 0.5s, exp(7,7) 1.3s). There is performance cost (manual 1.4s, e=
xp(7,7)
16.7s) when you need it, when your upstream has been rebased a long ago=
 (in
reflog entries).

> OTOH, a slower
> algorithm has been used in git pull for a long time and it seems like
> not many people have really been bothered by that. Also see the
> following paragraphs.
>
> I also ran the same tests with an upstream branch that was never
> force-updated. For these test cases, I created a reflog such that
> u@{$i} =3D master~$((10 * $i)). Since the upstream branch was know ne=
ver
> to have been force-updated in this case, the "manual" test case was
> simply 'git rebase u'. These are the results:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u@{10} =A0 =A0 u@{100} =A0 =A0u@{1000=
}
> manual =A0 =A0 =A0 =A0 0m0.885s =A0 =A00m6.126s =A0 0m52.248s
> linear =A0 =A0 =A0 =A0 0m1.349s =A0 0m39.688s =A0 5m28.753s
> merge-base =A0 =A0 0m1.160s =A0 =A00m1.699s =A0 =A00m1.901s
> exp(1,2)       0m0.769s    0m4.342s    0m7.360s
> exp(10,10)     0m0.700s    0m2.535s    0m3.110s
> exp(7,7)       0m0.653s    0m2.332s    0m3.506s
>
> Not surprisingly, the linear algorithm is slow in these cases as well=
=2E
>
> What's more interesting here is that the last two algorithms are
> actually faster than the plain 'git rebase u'. This is caused by
> --ignore-if-in-upstream flag to format-patch. Since the other three
> algorithms try to figure out what the base was and pass the range fro=
m
> the guessed base to the branch (e.g. u@{100}..b) to format-patch, the
> --ignore-if-in-upstream to that command effectively becomes a no-op.
>
> Although this makes rebase faster in the case of a non-force-updated
> upstream, it may also be a problem in some cases. This was something
> that I had not thought about until I started timing the calls. One
> reason I can think of when the --ignore-if-in-upstream is useful is
> when the upstream branch has been rebased, but this is exactly the
> case when guessing the old base is useful and solves the problem in a
> better way anyway. However, if a commit on the upstream branch was
> cherry-picked from some commit on the current branch above its base
> (i.e. in u@{x}..b), then that would not be detected by
> --ignore-if-in-upstream and could result in unnecessary merge
> conflicts. I don't know how common this case is.
>
> The above also applies to 'git pull', of course, but the ways of
> getting identical patches in upstream are probably different (more
> likely by 'git am' than 'git cherry-pick' perhaps).
>
> I think this is a useful feature. I'm just not sure how to balance th=
e
> performance vs convenience. Worst case, this could probably become a
> command line option and configuration. I guess 'git pull' should use
> the same algorithm. If we decide to use configation, maybe git-pull's
> default would need to be different to be backward compatible.
>
> Any thoughts?

I think it is worth, as it looks like it only affects those who need
the feature.
The exp(7,7) or similar seems a good candidate.

HTH,
Santi
