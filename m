From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
Date: Sat, 22 Dec 2012 22:24:41 -0800
Message-ID: <CANiSa6i0-Z=FkPnSJxgT+3ABHTzgOTNNNUb=wHQpm2DKAN_UOw@mail.gmail.com>
References: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
	<1356117013-20613-2-git-send-email-martinvonz@gmail.com>
	<7vr4mhpi0l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 07:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tmf8s-0003OQ-AZ
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 07:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab2LWGYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 01:24:43 -0500
Received: from mail-ia0-f182.google.com ([209.85.210.182]:53127 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab2LWGYm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 01:24:42 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so5227889iad.27
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 22:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DT3ELc88nqEROBmUWebC6idI75zo1mMCENZ95Vc+ro8=;
        b=tRqSeU2GXwyrNUru7Ezgk23Do39ViDqYu3pV8vjYlqH6pwCNhAn7HEk4PzZ0CN95BK
         RgKIQHr9DohyONeTItRIR476RwjCFQQNstACUtOUuSV/8Ar0lbHD1TFcejqrw6OYnCFi
         NRS1NSSBs+h8FP/ihqZ7AkIFZCWPdrb6Wo1ueNQsIgkf6qrefYAd6Qjc6+rkm1Y+13KA
         bNKxUuFr71epHTsSJlHtfRCSuRvB4TyL4+EZBwYb78CeBDE7RF/UZPPFgFWt6+/ZvhLr
         B0h8hEDPVCx35wchsyAq0j85tPSLgov5cBsqwRHoCRBGeX1u4RUVJizoUb8WPDbCqm7s
         lqgA==
Received: by 10.50.42.169 with SMTP id p9mr17156131igl.17.1356243881734; Sat,
 22 Dec 2012 22:24:41 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Sat, 22 Dec 2012 22:24:41 -0800 (PST)
In-Reply-To: <7vr4mhpi0l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212081>

On Sat, Dec 22, 2012 at 7:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>>>From the user's point of view, it seems natural to think that
>> cherry-picking into an unborn branch should work, so make it work,
>> with or without --ff.
>
> I actually am having a hard time imagining how that could ever be
> natural.

Fair enough. What's natural is of course very subjective. In my
opinion, whenever possible, operations on an unborn branch should
behave exactly as they would on an arbitrary commit whose tree just
happens to be empty. Of course, pretty much any operation that needs
more than the tree (indirectly) pointed to by HEAD would fail the
"whenever possible" clause. I realize that cherry-pick _does_ need the
current commit to record the parent of the resulting commit, but that
almost seems like an implementation detail, i.e whether we're adding a
parent or adding no parent (when on unborn branch) to the list of
parents.

In the same way, I think "git reset" should work on an unborn branch,
even though there is no commit that we can be "modifying index and
working tree to match" (from man page). I think many users, like me,
think of unborn branches as having an empty tree, rather than being a
special state before history is created. Sure, such thinking is not
technically correct, but it still seems to be some people's intuition
(including mine).

>> Cherry-picking anything other than a commit that only adds files, will
>> naturally result in conflicts. Similarly, revert also works, but will
>> result in conflicts unless the specified revision only deletes files.
>
> You may be able to make it "work" for some definition of "work", but
> I am not sure how useful it is.

As for use cases, I didn't consider that much more than that it might
be useful for implementing "git rebase --root". I haven't implemented
that yet, so I can't say for sure that it will work out.

One use case might be to rewrite history by creating an new unborn
branch and picking the initial commit and a subset of other commits.
Anyway, I didn't implement it because I thought it would be very
useful, but mostly because I just thought it should work (for
completeness).

I could resend as part of my rebase series (called mz/rebase-range at
some point) once that's done. Then we can discuss another solution in
the scope of that series if we don't agree on allowing on cherry-pick
on an unborn branch.

Btw, I have another series, which I'll send after 1.8.1, that teaches
"git reset" to work on an unborn branch (among other things). We might
want to decide to support both or neither of the commands on an unborn
branch.

On Sat, Dec 22, 2012 at 7:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>>>From the user's point of view, it seems natural to think that
>> cherry-picking into an unborn branch should work, so make it work,
>> with or without --ff.
>
> I actually am having a hard time imagining how that could ever be
> natural.
>
> When you are on an unborn branch, you may have some files in your
> working tree, and some of them may even be registered to the index,
> but the index is merely for your convenience to create your first
> commit, and as far as the history is concered, it does not matter.
>
> By definition you do not have any history in such a state.  What
> does it even mean to "cherry-pick" another commit, especially
> without the --no-commit option?  The resulting commit will carry the
> message taken from the original commit, but does what it says match
> what you have done?
>
> I can understand that it may sometimes make sense to do
>
>   $ git show --diff-filter=A $that_commit | git apply
>
> as a way to further update the uncommitted state you have in the
> working tree, so I can sort of buy that --no-commit case might make
> some sense (but if you make a commit after "cherry-pick --no-commit",
> you still get the log message from that commit, which does not
> explain the other things you have in your working tree) in a limited
> situation.
>
> It seems to me that the only case that may make sense is to grab the
> contents from an existing tree, which might be better served with
>
>   $ git checkout $that_commit -- $these_paths_I_am_interested_in
>
>> Cherry-picking anything other than a commit that only adds files, will
>> naturally result in conflicts. Similarly, revert also works, but will
>> result in conflicts unless the specified revision only deletes files.
>
> You may be able to make it "work" for some definition of "work", but
> I am not sure how useful it is.
>
> Puzzled...
>
