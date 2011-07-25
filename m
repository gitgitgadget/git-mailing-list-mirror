From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos
 containing damaged trees.
Date: Tue, 26 Jul 2011 09:27:51 +1000
Message-ID: <CAH3Anrrq8xiYVwM-U6OMX7834ey_BxWBXj97bqWA=u8PZ2shjA@mail.gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
	<7v1uxfwmq3.fsf@alter.siamese.dyndns.org>
	<CAH3AnrrVwodvtwWfaJCJqjuHThtv75jaWeDjvwRgdFbgXA3ziA@mail.gmail.com>
	<7vhb6arzvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 01:27:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlUZ3-0000Nr-JF
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 01:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab1GYX1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jul 2011 19:27:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60859 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab1GYX1w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 19:27:52 -0400
Received: by vws1 with SMTP id 1so3338942vws.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lYpWYRjOApbwACJOFUeQH7if5s6t5vSd8xa1Xkb3z6w=;
        b=P+vxYZGBO9pSGOaa9FeXc+kD/R3ewIIb/GkGWoqLAmblNA1uoKM9lMKOUGwddqj5JU
         MSBVDNCvt3Gy9aT3jk7DwO4XqchkBbypzCVhtDqflqW1xvpllaYiA0uB+rc1bdmpCStW
         hY+pKNfiQh+5jwInPmXp1UMZzKUjBs/iSMmAw=
Received: by 10.52.89.194 with SMTP id bq2mr4942279vdb.374.1311636471515; Mon,
 25 Jul 2011 16:27:51 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Mon, 25 Jul 2011 16:27:51 -0700 (PDT)
In-Reply-To: <7vhb6arzvj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177833>

On Tue, Jul 26, 2011 at 4:14 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> I don't think you understood my intention. Suppose, I have
>>
>> B4 - B5 - B6' - B7' - B8' - B9
>>
>> such that B6 and B7 and B8 all contain a damaged tree, but B4, B5 an=
d B9 don't
>> since it contains a different tree, then:
>
> What prevents your disk from corrupting a blob that was in B6, modifi=
ed by
> commit B7, and then _reverted_ by commit B8? Then your checkout would=
 fail
> at B6 and B8 but B7 will be fine.

But that's ok.

If B7's tree is fine, then the tree at B7 (if not the exact history
leading to the tree)
can be recovered by suitable grafts.

Also, the intent was not to use failure of git checkout as the test -
the intent was merely
to prevent a failure of git checkout from progressing the bisection.

The test for badness is something that would be run at each point in
the process.

I admit that git status is not a good test, since it is possible that
git update-ref --no-deref <target>
 && git checkout <target> will not restore a clean working tree and
index at each step,
even for good commits.

Of course, this is all rather academic since I agree your suggestion
of a --no-checkout option is a more general purpose solution
which can do all that --ignore-checkout-failure does and more.

>
> As I wrote in my footnote, if your test is to find the most recent co=
mmit,
> starting from which all the objects reachable from it are not corrupt=
 (by
> using "rev-list --objects $commit | pack-objects"), you could run you=
r
> bisect by somehow first finding a good commit (B5) that passes the te=
st,
> and after knowing a bad commit (B8) that does not pass (because it is
> missing the single blob that is unreadable for B6 and B8), and then b=
isect
> using a slightly less expensive test
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rev-list --objects B5..$commit | pack-obje=
cts
>
> to find it in theory, but "Being unable to check-out" is not an isola=
ted
> event and cannot be used as the check as you seem to think.
>

I agree - a test that actually traverses the graph reachable from the
commits each tree and visits each object is better.

I'd tweak your snippet with --max-count=3D1, so that amount of work per
commit is limited.

Note that running git bisect --no-checkout will still be useful here
since it will limit the number of iterations that need to
be tested in order to find B5, for example.

>
> Pros of using HEAD (i.e. the only change under the new mode would be =
that
> we do not touch the index nor the working tree) is that the test you =
would
> need to run in each step of bisection can use the familiar HEAD ref
> instead of a strange BISECT_CURSOR, "bisect reset" will take you back=
 from
> the tentative detached HEAD state the usual way, and most likely the
> necessary change to git-bisect.sh would be smaller. Cons of using HEA=
D
> would be that the index and the working tree will be totally out-of-s=
ync
> with respect to HEAD during the bisection (by definition---as that is=
 the
> point of this new mode). One could argue that a na=C3=AFve user might=
 get
> confused, but I am not sure how big a practical downside it would be.
>
>

How about a compromise such as:

    --no-checkout[=3D<ref>]

which defaults to HEAD, but can be specified as something else?

jon.
