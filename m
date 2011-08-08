From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 37/48] merge-recursive: Fix modify/delete resolution in
 the recursive case
Date: Mon, 8 Aug 2011 16:09:08 -0600
Message-ID: <CABPp-BFHo0NK9Y+QGfDw-=zBBbNUQtfO9Fr4qUmdxyZEy0_7Mw@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<1307518278-23814-38-git-send-email-newren@gmail.com>
	<7voc0n1nl8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:09:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqY0a-0001KM-Qg
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243Ab1HHWJL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 18:09:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43554 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab1HHWJK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 18:09:10 -0400
Received: by fxh19 with SMTP id 19so5803669fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3tzaCJPuQtyALpqrNu42jecz9fTIKYCGxPqwIDpSiNk=;
        b=TB61vSM9e8oF3mtGyMOy/8j2R84UgPpkQr+f/4pCbgluwX6rgYrQkCmOpN+LT+9IIv
         3SG0D1bjXlhEX5sXD8zXzhkdENIDE05PFBbZtrEwdRQpwglMvNoVcM61DFA+ocStuX/7
         AfavgTzAYYM5G+dYXNzs/k+n4lg0Jn6JaokBQ=
Received: by 10.223.160.131 with SMTP id n3mr8096386fax.111.1312841348943;
 Mon, 08 Aug 2011 15:09:08 -0700 (PDT)
Received: by 10.223.123.13 with HTTP; Mon, 8 Aug 2011 15:09:08 -0700 (PDT)
In-Reply-To: <7voc0n1nl8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178993>

On Thu, Jul 21, 2011 at 12:43 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Elijah Newren <newren@gmail.com> writes:
>
>> When o->call_depth>0 and we have conflicts, we try to find "middle g=
round"
>> when creating the virtual merge base. =C2=A0In the case of content c=
onflicts,
>> this can be done by doing a three-way content merge and using the re=
sult.
>> In all parts where the three-way content merge is clean, it is the c=
orrect
>> middle ground, and in parts where it conflicts there is no middle gr=
ound
>> but the conflict markers provide a good compromise since they are un=
likely
>> to accidentally match any further changes.
>>
>> In the case of a modify/delete conflict, we cannot do the same thing=
=2E
>> Accepting either endpoint as the resolution for the virtual merge ba=
se
>> runs the risk that when handling the non-recursive case we will sile=
ntly
>> accept one person's resolution over another without flagging a confl=
ict.
>> In this case, the closest "middle ground" we have is actually the me=
rge
>> base of the candidate merge bases. =C2=A0(We could alternatively att=
empt a
>> three way content merge using an empty file in place of the deleted =
file,
>> but that seems to be more work than necessary.)
>
> What did we use before this patch as the "middle ground"?

We used precisely what you seem to suggest at the end of your email.
It's a trade-off, and I agree with you about the cases where my new
choice is suboptimal, but I personally think the original choice has
worse trade-offs.

> Doesn't the "middle ground" also need to contain information from bot=
h
> sides? =C2=A0At the content level, The half-merge result with conflic=
t marker
> contains all the necessary information on what both sides agreed to d=
o
> outside the marker area, while showing what each side wished to do in=
side,
> so as you describe, it is a good "middle ground".
>
> Using the merge-base would mean that at the tree-structural level of =
this
> merge you ignore the wish of one side that wanted to delete the path,=
 and
> then at the content level you also ignore the wish of both sides (the=
 side
> that wanted to delete the path wanted to leave zero content, while th=
e
> other side wanted to modify from the version in merge-base, all of wh=
ich
> is ignored by the above argument).

I think it is optimal if the "middle ground" can contain information
from both sides, but I simply do not see how it is possible in either
a modify/delete or rename/delete case.  That is, at least not without
some kind of significant change to the index data structures or
allowing a "virtual merge base" to be an index with higher stage merge
entries instead of just a tree (though that would introduce several
new complications).

And yes, I am essentially ignoring the intents of both sides, and
intentionally so.  I thought I addressed that in the arguments above,
but perhaps I could have been more clear and explicit about that.
Your explanation below provides a great framework for clarifying why I
made this change, so let me respond below using the framework you have
beautifully illustrated and explained.

> When you want to make a criss-corss merge between E and F that looks =
like
> this:
>
> =C2=A0 =C2=A0 =C2=A0A---C---E---?
> =C2=A0 =C2=A0 / \ / =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0O =C2=A0 . =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0 \ / \ =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0 =C2=A0B---D---F
>
> if there is no deletion, we run a content level merge between C and D=
 by
> using X that is a potentially conflicting merge between A and B as a
> "virtual" ancestor.
>
> =C2=A0 =C2=A0 =C2=A0A---C---E---?
> =C2=A0 =C2=A0 / \ / =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0O =C2=A0 X =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0 \ / \ =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0 =C2=A0B---D---F
>
> X would contain both what both A and B agreed to do on top of O, and =
what
> A and B wanted to do that they do not agree with. The differing opini=
on of
> A and B are recorded inside the conflict markers. =C2=A0The change th=
at turns X
> into E contains C's opinion (i.e. it would likely agree to take what =
both
> A and B agreed to do, and it may agree with A and the result in E wou=
ld
> resemble what A wanted to bring to the result despite B's objection).=
 If C
> and D both agree how to resolve the conflict, then B's "objection" wi=
ll
> cancel out from the three-way merge between E and F that uses X as th=
e
> ancestor.
>
> In a delete/modify situation (e.g. A modified while B deleted), there=
 are
> three possibilities:
>
> =C2=A0* C and D both agree to delete the path;
>
> =C2=A0* C and D both agree to keep the path, with modifications that =
may or may
> =C2=A0 not conflict (which can be handled by the usual content-level =
merge);
>
> =C2=A0* C decides to delete, while D decides to modify (or vice versa=
).

This is a really nicely written explanation.  I particularly like this
list of three cases.  Let me augment this list of situations (which
I'll number (1)-(3)) with a list of four choices for virtual merge
base X:

(J) Make X not have any content at the path (i.e. accept the deletion i=
n B)

(K) Make X have the content from O at path (i.e. what my patch does)

(L) Make X have the content from A at path (which we did before)

(M) Make X have some other content at path

I'll get back to these 12 situations (3 cases each with how any of 4
choices could affect them) in a minute...

> And in the last case, the outer merge ? needs to decide if it wants t=
o
> keep or delete the path anyway, so a simplest solution is to punt the
> whole recursive business and make it the responsibility of the user t=
o
> resolve it as a merge between E and F using O as the common ancestor.
> This patch does so in all three cases.
>
> I however wonder if we can do better in the second case (I do not thi=
nk
> the first case would come into the picture, as we would not see such =
a
> path when merging E and F as it would have been long gone from both
> branches). We wouldn't know which commits C and D are exactly, but we=
 do
> have E and F. If A modified the path and B deleted it, and C and D bo=
th
> decided to keep the path and E and F both inherited that path, wouldn=
't it
> be fair to say that what both branches wanted to do is closer to what=
 A
> did than what B did? In other words, instead of using O, wouldn't it =
give
> us a better result if we used A (the side that did not delete) as the
> common ancestor for the content level merge when both E and F has the
> path?

Yes, absolutely.  In the second case, using the content of the path
from A for the virtual merge ancestor would be a slight improvement
over using the content for path from O.  But let's look at all three
cases you specified and how different choices for the virtual merge
base affect it.  Here are my goals for any merge, in priority order:

1st goal: detect real conflicts and notify the user
2nd goal: avoid conflicts in cases where we should be able to
reasonably confidently merge cleanly
3rd goal: make it easy for the user to figure out how to resolve proble=
ms

Obviously, we can't always meet these goals, particularly due to
"semantic" conflicts that may be present.  But they're useful to keep
in mind.  Here is how I broke down the three cases:



Case 1: C and D both agree to delete the path

In this case, regardless of the choice (J)-(M), the merge will be
resolved correctly.


Case 2: C and D both agree to keep the path, with modifications that
may or may not conflict (which can be handled by the usual
content-level merge);

In this case, choice (J) would cause content conflicts whenever C & D
had different content at path and would treat it as a two-way content
merge.  That makes choice (J) particularly problematic as it breaks
the first goal.  In order to get the merge right, we really need to do
a three-way content merge, using content that can serve as a
reasonable merge-base for the contents chosen at C & D.  That makes
choice (M) for X a poor one.  Both choices (K) and (L) are reasonable,
with (L) being a better choice (as you also point out above) to
optimize the 2nd goal.


Case 3: C decides to delete, while D decides to modify (or vice versa)

It is worth noting here that the most likely choice for the content at
path for D is exactly the content that is at A.  git is designed for
trees of slowly changing data after all.

This is a case where git should detect the modify/delete conflict and
alert the user.  In this case, choice (J) is particularly bad.
Regardless of the content that D has for path, the merge conflict
won't even be detected and git would silently resolve this by
recording the content from D at path.  That's a fail for the first
goal.

Another choice that is likely to fail the first goal is (L).  If the
content at path D is the same as at A (the most likely case), then git
would not detect the conflict and would simply silently delete the
path.

In fact, any choice here for the merge base could cause the conflict
to go silently undetected (whenever the content at D matched our
choice for X), meaning that no choice for the merge base will be
perfect.  That would mean of the four choices, (M) would be best as it
would be least likely to match the choice made at D, but (K) would be
pretty reasonable.


So, as I view it: choice (J) is horrible in two of the three cases;
choice (M) is really bad in the second case for goal 2; and choice (L)
is likely to be bad in the third case for goal 1.  Choice (K) is
pretty reasonable in all three cases, and that choice is what this
patch implements.
