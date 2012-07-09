From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v2 1/2] test: git-stash conflict sets up rerere
Date: Mon, 9 Jul 2012 10:41:32 -0400
Message-ID: <CABURp0rrTvQcjHLsVwXC5hfBOuRmFG4AzSj6ZQwM=MXn0FAUCQ@mail.gmail.com>
References: <CABURp0oXhZ5ysm4b3Z=7o+2TB+3wFdMjj4oEwxafApjD4c7ozA@mail.gmail.com>
 <1341693962-17090-1-git-send-email-hordp@cisco.com> <1341693962-17090-2-git-send-email-hordp@cisco.com>
 <7v8vetmzgz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 16:42:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoFA8-0003TB-OW
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 16:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545Ab2GIOly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 10:41:54 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38879 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab2GIOlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 10:41:52 -0400
Received: by yenl2 with SMTP id l2so10114876yen.19
        for <git@vger.kernel.org>; Mon, 09 Jul 2012 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=guaJH3HCggpS0keJNbUrZ4wUVqNNQOU0g2SffSnBaV8=;
        b=ZxZmKuMm0fAY3eeadm+RQpx5ddrtvIW5aX071xf62xNmLndZiJaWKfrBcC5knqwPih
         ipDatE49Bu68KzOEZORm3TG/75jzTa6LQ41ReffXALHB4icyq/GaMEOt/A5HBNzxGuUf
         v2V3ahZe9+C/yzXflzulUHPMWYTeV8ZfORCymITKI/d/yQFqmqu3e7JIc/ink2XRWkAb
         2FfCGUO7bcopPh+5ilB9nDB/liXY4z1apGDG4N95oNTZRFyKFgTMz0JIL98KESlwNVbd
         EA9l145yXoNOmO+7f5m5/stz9MZ2PDWTnmWPIxBBXElHcGM+bPTEZVcIrVWIgENQxD/R
         LDSQ==
Received: by 10.236.197.65 with SMTP id s41mr10996236yhn.122.1341844912183;
 Mon, 09 Jul 2012 07:41:52 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Mon, 9 Jul 2012 07:41:32 -0700 (PDT)
In-Reply-To: <7v8vetmzgz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201205>

Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <hordp@cisco.com> writes:
>
> > Add a failing test to confirm a conflicted stash apply invokes
> > rerere to record the conflicts and resolve the the files it can.
>
> OK.
>
> > In this failing state, mergetool may be confused by a left-over
> > state from previous rerere activity.
>
> It is unclear to me what relevance this has to this patch.  Does it
> have this sequence:
>
>     "previous rerere activity" (whatever that is)
>     test_must_fail git stash apply &&
>     git mergetool
>
> and demonstrate that "git mergetool" fails because there is a wrong
> rerere state in the repository after "git stash apply" returns?
>
> Or perhaps you are relying on the state that is left by the previous
> test piece?

The previous edition of this patch explicitly created the condition
which would confuse mergetool by creating a conflict and resolving it.
 The mergetool confusion is what I was testing and is what lead to
this patch series.

But I have since learned that rerere _can_ be effective after a stash
conflict, but it was not invoked automatically. This series aims to
fix that instead of simply forcing rerere to clean up in the stash
conflict case.

I left the concern in the commit message because this is more than a
missing feature; under certain conditions, it is a bug.  But I could
have reworded it to be more clear.

I am not relying on a prior condition to exist.  In fact the 'git
reset' at the start of this test will clear the previous rerere state
that I am testing for in this test.

In the previous edition, the test was this:
  Verify mergetool is (not) confused by unclean rerere behavior:
        1. Set up a normal merge-conflict with rerere so that MERGE_RR exists
        2. Set up a conflicted stash-pop
        3. Confirm/test the aberrant behavior of mergetool

In this edition, the aim of the test is different:
  Verify rerere is (not) called by a conflict stash-apply:
        1. Set up a conflicted stash-pop
        2. Confirm/test whether rerere tracks the result

> > Also, the next test expected us to finish up with a reset, which
> > is impossible to do if we fail (as we must) and it's an
> > unreasonable expectation anyway.  Begin the next test with a reset
> > of his own instead.
>
> Yes, it is always a good discipline to start a new test piece from a
> known state.
>
> > @@ -193,7 +203,37 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
> >      git reset --hard
> >  '
> >
> > +test_expect_failure 'conflicted stash sets up rerere'  '
> > +    git config rerere.enabled true &&
> > +    git checkout stash1 &&
> > +    echo "Conflicting stash content" >file11 &&
> > +    git stash &&
> > +
> > +    git checkout --detach stash2 &&
> > +    test_must_fail git stash apply &&
> > +
> > +    test -e .git/MERGE_RR &&
> > +    test -n "$(git ls-files -u)" &&
> > +    conflicts="$(git rerere remaining)" &&
>
> Checking that the index is conflicted with "ls-files -u" and asking
> the public API "git rerere remaining" to see what paths rerere
> thinks it did not touch, like you do in the second and third lines,
> are very sensible, but it is probably not a good idea for this test
> to check implementation details with "test -f .git/MERGE_RR".

I tend to agree.  However, it is the presence of .git/MERGE_RR which
will cause mergetool to take the 'rerere remaining' path.  I wanted to
ensure that mergetool is going to go the way I expected.  In light of
the later actions in this test, that is probably overkill.  I can
remove it.

> > +    test "$conflicts" = "file11" &&
> > +    output="$(git mergetool --no-prompt)" &&
> > +    test "$output" != "No files need merging" &&
> > +
> > +    git commit -am "save the stash resolution" &&
> > +
> > +    git reset --hard stash2 &&
> > +    test_must_fail git stash apply &&
> > +
> > +    test -e .git/MERGE_RR &&
> > +    test -n "$(git ls-files -u)" &&
> > +    conflicts="$(git rerere remaining)" &&
>
> Likewise.

And ditto.


> > +    test -z "$conflicts" &&
> > +    output="$(git mergetool --no-prompt)" &&
> > +    test "$output" = "No files need merging"
> > +'
> > +
> >  test_expect_success 'mergetool takes partial path' '
> > +    git reset --hard
> >      git config rerere.enabled false &&
> >      git checkout -b test12 branch1 &&
> >      git submodule update -N &&

So, the next roll will remove the tests for MERGE_RR and will be more
explicit about the potential for mergetool confusion and/or the fact
that it is not explicitly tested here.

I'll wait a little longer for any further comments.

Phil
