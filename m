From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 3/5] tree-walk: micro-optimization in tree_entry_interesting
Date: Tue, 30 Aug 2011 14:51:32 -0500
Message-ID: <CAEik5nNaDkAa2+63g1z3c1JUB8sLuTLfYP3jLKZJg2=yKqyzDg@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
	<1301535481-1085-3-git-send-email-dpmcgee@gmail.com>
	<7vaag7dv0z.fsf@alter.siamese.dyndns.org>
	<BANLkTi=yVrS9MsBF1YR9D-QWej-n1uDQyQ@mail.gmail.com>
	<CAEik5nOKrpFycZYVnSu4_5LYWxn0JS_hVXyiQH-80Bu-C4k8VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 21:51:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyULU-0003cS-LJ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 21:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267Ab1H3Tvd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 15:51:33 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55344 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232Ab1H3Tvc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 15:51:32 -0400
Received: by pzk37 with SMTP id 37so10805258pzk.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=2Gj8s+rbEF9PDM+tlNFgKfs9Z99XLpo/A/k+pOx8YrE=;
        b=RcrbrpbfKw4DbCKUjx2WbovM9ue7n61mcCDVaFY0r1uC2yxo2J2W7b9jfJTy+jNkiQ
         B81t9+XEIEgyX5yFsUYpVZ9ARHGT2cZpkhvuUDFfm4puG41WbMBbS/XYKTdLwy4WtXwS
         b4I00djDuLKH/LYXf6AVTW3zTCPldW5cJNxAU=
Received: by 10.142.162.8 with SMTP id k8mr477983wfe.242.1314733892152; Tue,
 30 Aug 2011 12:51:32 -0700 (PDT)
Received: by 10.68.40.34 with HTTP; Tue, 30 Aug 2011 12:51:32 -0700 (PDT)
In-Reply-To: <CAEik5nOKrpFycZYVnSu4_5LYWxn0JS_hVXyiQH-80Bu-C4k8VQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180437>

On Mon, Apr 4, 2011 at 7:22 PM, Dan McGee <dpmcgee@gmail.com> wrote:
> On Sun, Apr 3, 2011 at 1:55 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Dan McGee <dpmcgee@gmail.com> writes:
>>
>>> In the case of a wide breadth top-level tree (~2400 entries, all tr=
ees
>>> in this case), we can see a noticeable cost in the profiler calling
>>> strncmp() here. Most of the time we are at the base level of the
>>> repository, so base is "" and baselen =3D=3D 0, which means we will=
 always
>>> test true. Break out this one tiny case so we can short circuit the
>>> strncmp() call.
>>
>> This sounds as if the patch helps only when you have a superfat tree=
 at
>> the "top-level" of the project, but wouldn't this benefit any superf=
at
>> tree at _any_ level while we recursively descend into it?
>
> Correct. I looked at the fact that more often than not, we wouldn't
> have to descend into subtrees unless searching for a path underneath
> it, so that is why I phrased it that way. So the "in the case of" was
> quite literally the case I was testing, but didn't mean to exclude
> other potential test cases.
>
>>> This resulted in an ~11% improvement (43 to 38 secs) for a reasonab=
le
>>> log operation on the Arch Linux Packages SVN clone repository, whic=
h
>>> contained 117220 commits and the aforementioned 2400 top-level obje=
cts:
>>> =C2=A0 =C2=A0 git log -- autogen/trunk pacman/trunk/ wget/trunk/
>>>
>>> Negligible slowdown was noted with other repositories (e.g. linux-2=
=2E6).
>>
>> It would have been easier to swallow if the last sentence were "This=
 could
>> lead to a slowdown in repositories without directories that are too =
wide,
>> but in practice it was not even measurable." =C2=A0"Negligible" soun=
ds as if it
>> had still measurable downside, and as if you decided that the slowdo=
wn can
>> be ignored---but obviously you are not an unbiased judge.
>
> Perhaps I was too cautious with my words- but I was also trying to no=
t
> be biased. Considering this same operation takes < 1 second in
> linux-2.6, I only wanted to mention it could have a slight effect. In
> reality I saw nothing more than an extra 0.01s or so, and definitely
> nothing significant. Let me know if you see otherwise.
>
> dmcgee@galway ~/projects/linux-2.6 (master)
> $ time ../git/git-log -- zzzzz_not_exist > /dev/null
>
> real =C2=A0 =C2=A00m0.945s
> user =C2=A0 =C2=A00m0.857s
> sys =C2=A0 =C2=A0 0m0.083s
>
>> There is nothing wrong in the patch per-se, but I really wish we did=
n't
>> have to do this; it feels like the compiler should be helping us in =
this
>> case.

If I resurrect this with an updated commit message reflecting concerns
raised, can it be merged? Given that it is a noticeable performance
boost on real-life repositories and I can show it has little (<1%) to
no impact on most repos, it is a definite win.

>>> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
>>> ---
>>> =C2=A0tree-walk.c | =C2=A0 =C2=A04 ++--
>>> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tree-walk.c b/tree-walk.c
>>> index 9be8007..f386151 100644
>>> --- a/tree-walk.c
>>> +++ b/tree-walk.c
>>> @@ -591,8 +591,8 @@ int tree_entry_interesting(const struct name_en=
try *entry,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ps->max_depth);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Does the base match?=
 */
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strncmp(base_str, =
match, baselen)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Either there must be=
 no base, or the base must match. */
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (baselen =3D=3D 0 ||=
 !strncmp(base_str, match, baselen)) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (match_entry(entry, pathlen,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 match +=
 baselen, matchlen - baselen,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &never_=
interesting))
>>
>
