From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Thu, 17 Feb 2011 11:24:11 +0100
Message-ID: <AANLkTik-JGZFCE+m7g__mwfQhRReOM=Qe_EO3otw50XC@mail.gmail.com>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian>
 <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com> <alpine.DEB.2.00.1102161122350.14950@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 11:24:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq12M-0003Vd-GE
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 11:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab1BQKYe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 05:24:34 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52050 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1BQKYc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 05:24:32 -0500
Received: by qwa26 with SMTP id 26so2233068qwa.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 02:24:31 -0800 (PST)
Received: by 10.229.186.7 with SMTP id cq7mr2063550qcb.239.1297938271481; Thu,
 17 Feb 2011 02:24:31 -0800 (PST)
Received: by 10.229.225.8 with HTTP; Thu, 17 Feb 2011 02:24:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102161122350.14950@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167063>

On Wed, Feb 16, 2011 at 5:45 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Wed, 16 Feb 2011, Santi B?jar wrote:
>
>> On Wed, Feb 16, 2011 at 3:03 AM, Martin von Zweigbergk
>> <martin.von.zweigbergk@gmail.com> wrote:
>> > On Tue, 15 Feb 2011, Junio C Hamano wrote:
>> >
>> >> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>> >>
>> >> > diff --git a/git-rebase.sh b/git-rebase.sh
>> >> > index 5abfeac..1bc0c29 100755
>> >> > --- a/git-rebase.sh
>> >> > +++ b/git-rebase.sh
>> >> =A0 =A0 =A0 test -n "$upstream_name" &&
>> >> =A0 =A0 =A0 =A0 for reflog in $(git rev-list ...)
>> >> =A0 =A0 =A0 =A0 do
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>> >> =A0 =A0 =A0 done
>> >>
>> >> Don't you need to make sure $upstream_name is a branch (or a ref =
in
>> >> general that can have a reflog), or does it not matter because th=
e
>> >> "rev-list -g" will die without producing anything and you are dis=
carding
>> >> the error message?
>> >
>> > Exactly as you suspect. Is it too ugly?
>>
>> I also prefer Junio's version.
>
> I fixed the test + for loop, if that's what you mean by "Junio's
> version". Or did you mean "make sure $upstream_name is a branch"? I
> could do that as well if you like. I have no preference.

I meant the test + loop, but I would also "make sure $upstream_name is
a branch", as done in git-pull.sh with:

git rev-parse -q --verify "$remoteref"

>
>> > =A0 =A0 =A0 =A0.-u@{0}
>> > =A0 =A0 =A0 /
>> > =A0 =A0 =A0.---u@{1}
>> > =A0 =A0 /
>> > x---y-----u@{2}
>> > =A0 =A0 \
>> > =A0 =A0 =A0.---u@{3}---b
>> > =A0 =A0 =A0 \
>> > =A0 =A0 =A0 =A0.-u@{4}
>> >
>> >
>> > I have an idea inspired by bisection, Thomas's exponential stride,=
 and
>> > what someone (you?) mentioned the other day about virtual merge
>> > commits. I haven't tried it out, but let me know what you think. I=
'll
>> > try to explain it using an example only:
>> >
>> > Exponential stride phase:
>> > 1. candidates=3D{ u@{0} }
>> > =A0 merge-base b $candidates -> y, _not_ in $candidates
>> > 2. candidates=3D{ u@{1} u@{2} }
>> > =A0 merge-base b $candidates -> y, _not_ in $candidates
>> > 3. candidates=3D{ u@{3} u@{4} u@{5} u@{6} }
>> > =A0 merge-base b $candidates -> u@{3}, in $candidates
>>
>> Doesn't it indicate that u@{3} is the commit we are looking for? I
>> haven't found a counterexample...
>
> Yes, of course. Stupid me ;-). Forget about the other half. (I think
> that's what I did manually to match the sha1 back to the ref name, bu=
t
> that is of course complete non-sense to do in the script.)
>
>> If this is true the following patch can implement it for git-pull.sh=
 and
>> git-rebase.sh (sorry if it is space damaged):
>
> Thanks! Will have a closer look at it later today. If I understand
> correctly, you simply call merge-base with the _entire_ reflog. I

Yes, that is the idea (plus the old remote hash in case of git-pull)

> would have thought that would be slow, but it's great if that is fast
> enough.

Yes, I think it is fast enough in the normal case. Even feeding the
entire git.git's master, ~25000 revisions, it takes around 2-4 seconds
only:

$ git rev-list origin/master | wc -l
24380
$ time git merge-base $(git rev-list origin/master)
9971d6d52c5afeb8ba60ae6ddcffb34af23eeadd

real	0m4.014s
user	0m1.520s
sys	0m2.284s

(2.5GHz CPU)

But, as Junio showed, it has problems when the reflog lenght is too
large. Maybe git-merge-base can learn the --stdin flag, or we could
process the reflog in batches of 1000 (?) entries, ... but the nice
property of using the entire reflog is that the output is what you are
looking for, if you take the first 1000 entries you have to check if
the output is one of these entries.

> The resulting code looks very nice and short. Thanks again.

No, thanks to you for the nice idea!

HTH,
Santi
