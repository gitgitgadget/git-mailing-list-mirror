From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC PATCH] add t3420-rebase-topology
Date: Fri, 21 Sep 2012 10:06:58 -0700
Message-ID: <CANiSa6iQsxWYHTRDGNg_h77rr3Y1cL_di-Z3zzR4gZvcRHtVqQ@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<7vzk4nojkd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:07:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF6h6-0002kG-U6
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 19:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518Ab2IURHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 13:07:00 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65381 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab2IURG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 13:06:59 -0400
Received: by ieak13 with SMTP id k13so6014876iea.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D0OzSsTCHhNcOEmG0e0x3DAnSgKwmsellfCyWoShI6E=;
        b=qa9LEzJTB8WJQOPCX7yCeeyYEthSRlvPNCt7seHLZy5ViwM/ofLckpBIVSkPMZhnCd
         /jePv3sHghI6K3BTv5cMTYq3nEJ/PDdosrVOyhCx5m5gH2+Udi/8RCj/gjpNZc+JsXq9
         clm4/ofxdKM6Y1OcbIAYPQFOSQYyv25gUIQMS7yusl51P381FwQKFXHtU/sjYmOMwEqJ
         q1mRM2v8R2c5US2Zv9ejS+v5G5WeteEDcqN4wkOJnLNlCXDiY6Zzy/oK88tM7rlrx0Yw
         hX9dMTjGrS2T9Z7FC4L5sEPlduFrbrCbrNhUKrHQMMUR4JfKT48lKtNu4ZS3VbQIPPPl
         7mbA==
Received: by 10.50.154.227 with SMTP id vr3mr2248316igb.43.1348247218850; Fri,
 21 Sep 2012 10:06:58 -0700 (PDT)
Received: by 10.64.103.5 with HTTP; Fri, 21 Sep 2012 10:06:58 -0700 (PDT)
In-Reply-To: <7vzk4nojkd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206136>

On Tue, Sep 18, 2012 at 12:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> do you agree
>> that 'rebase --onto does not re-apply patches in onto' is desirable?
>
> This depends on how you look at --onto.  Recall the most typical and
> the original use case of rebase:
>
>                                A'--C' your rebased work
>                               /
>   ---o---o---o---F---B'--o---T master
>      ^            \
>      v1.7.12       A---B---C your work
>
> You could view "git rebase master" as a short-hand for
>
>         $ git rebase --onto $(git merge-base master HEAD) master

Exactly. I frequently consider it a short-hand for that. It might
be worth pointing out that 'git pull --rebase', which might be
one of the most frequent uses of rebase, internally often does

  git rebase --onto upstream upstream@{...} branch

where upstream@{...} is the most recent upstream that is an
ancestor of "branch". For example, if your work is based on
origin/pu and you send the bottom-most patch ("B" in the figure
below) to the maintainer and and it gets applied to
pu. Running "git pull --rebase" would then lead to
"git rebase --onto T A". You would want this to drop B.

                               C' your rebased work
                              /
  ---o---o---o---F---B'--o---T origin/pu
                  \
                   A origin/pu@{1}
                    \
                     B---C your work


> The intended use case for "--onto", however, is primarily to replay
> a history to older base, i.e. [...] a moral equivalent of
>
>         $ git checkout v1.7.12
>         $ git cherry-pick A B C ;# or git cherry-pick master..HEAD

Yes, this is the alternative way of looking it at and exactly why
I, too, was not sure how it should behave.

> You could argue that you can compute the patch equivalence between
> the commits in "onto..master" and commits in "master..HEAD" and
> filter out the equivalent commits

I'm not sure if you meant "master..onto" rather
than "onto..master". Rebase (well, all flavors of rebase
but "-m") currently drops patches from "master..HEAD" that are
also in "HEAD..master". This is what the "rebase --onto does not
lose patches in upstream" test is about. It is also one of the
main problems that I try to fix in my long-stalled rebase-range
series. I think we should drop patches in "master..HEAD" that are
also in "HEAD..onto" (which is almost the same
as "master..onto").

> The "replay to an updated base" case (i.e. without "--onto")

Or _with_ --onto as in the above example from "git pull --rebase".

> On the other hand, when the user replays to an older base, she has
> some idea what constitutes "a series" that she is replaying (i.e.
> "$(git merge-base master HEAD)..HEAD").  It smells to go against the
> user's world model if the command silently filtered commits by patch
> equivalence.

If it's truly about rebasing onto an older base, there can't
possibly be any patches in "HEAD..onto", so assuming you agree
with my reasoning above that those are the patches we should
drop, rebasing onto older history would be safe.

> Besides, the whole point of a separate "onto" is to allow the user
> to specify a commit that does not have a straightforward ancestry
> relationship with the bottom of the series (i.e. either "master" or
> "F"), and computation of patch equivalence is expected to be much
> higher.  Given that it is unlikely to find any match, it feels
> doubly wrong to always run "git cherry" equivalent in that case.

Yes, this was my only concern (apart from it possibly being
conceptually wrong to do, depending on what the user meant by
issuing the command).

>> How about 'rebase --root is not a no-op'?
>
>   ---o---o---o---F---B'--o---T master
>      ^            \
>      v1.7.12       A---B---C your work
>
> If "git rebase F" when you are at C in the above illustration
> (reproduced only the relevant parts) is a no-op (and I think it
> should be), "git rebase --root" in the illustration below ought to
> be as well, no?
>
>                  F---B'--o---T master
>                   \
>                    A---B---C your work

Yeah, that's what I thought as well at first. I think my test
case even started out as "rebase --root _is_ a no-op".

When thinking about how to handle roots in general, I often
imagine a single virtual root commit (parent of all "initial"
commits), and that reasoning also implies that "git rebase
--root" should be a no-op. Then I saw that the test case
failed (or perhaps I remembered how it is implemented with the
clever fake root/initial commit) and started thinking about why
anyone would use "git rebase --root" if it was a no-op. I could
only think of using it to linearize history, but that doesn't
seem like a very likely use case. So it seems like weighing
purity/correctness against usefulness to me. I'm not sure which
way to go.

Thanks for quick and detailed feedback on an RFC patch.

Martin
