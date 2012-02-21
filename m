From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] pre-rebase: Refuse to rewrite commits that are reachable
 from upstream
Date: Tue, 21 Feb 2012 01:03:09 +0100
Message-ID: <CALKQrgcDDVH8rxn80ZTMyR3y3n3Vs1LSCtH=ZiwG7it_LE2wgQ@mail.gmail.com>
References: <201202111445.33260.jnareb@gmail.com>
	<1329772071-11301-1-git-send-email-johan@herland.net>
	<7vobstjfcs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, philipoakley@iee.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 01:44:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzdpr-0006iF-Mg
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 01:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab2BUAnd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 19:43:33 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:49784 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779Ab2BUAnc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2012 19:43:32 -0500
X-Greylist: delayed 1991 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Feb 2012 19:43:31 EST
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Rzd8X-00027L-7m
	for git@vger.kernel.org; Tue, 21 Feb 2012 00:59:17 +0100
Received: by iacb35 with SMTP id b35so8161042iac.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 16:10:16 -0800 (PST)
Received-SPF: pass (google.com: domain of johan@herland.net designates 10.50.6.202 as permitted sender) client-ip=10.50.6.202;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of johan@herland.net designates 10.50.6.202 as permitted sender) smtp.mail=johan@herland.net
Received: from mr.google.com ([10.50.6.202])
        by 10.50.6.202 with SMTP id d10mr16184710iga.16.1329783016100 (num_hops = 1);
        Mon, 20 Feb 2012 16:10:16 -0800 (PST)
Received: by 10.50.6.202 with SMTP id d10mr13073626iga.16.1329782589670; Mon,
 20 Feb 2012 16:03:09 -0800 (PST)
Received: by 10.42.170.3 with HTTP; Mon, 20 Feb 2012 16:03:09 -0800 (PST)
In-Reply-To: <7vobstjfcs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191129>

On Mon, Feb 20, 2012 at 23:43, Junio C Hamano <gitster@pobox.com> wrote=
:
> Johan Herland <johan@herland.net> writes:
>> Teach the pre-rebase sample hook to refuse rewriting commits on a br=
anch
>> that are present in that branch's @{upstream}. This is to prevent us=
ers
>> from rewriting commits that have already been published.
>
> If the user has configured an option to always create @{u} when creat=
ing a
> branch from somewhere else, transplanting $n good commits from his ma=
ster
> that is forked from the shared master onto his maint would be done li=
ke
> this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git checkout -b copy master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git rebase -i --onto maint HEAD~$n
>
> If these good commits have been published to 'master', because the
> upstream of 'copy' is set to the local 'master', would the new mechan=
ism
> hinder this attempt to backport good fixes? =C2=A0Perhaps it is safer=
 to
> trigger only when @{u} exists and it is not local?

Ah, you're talking about setting branch.autosetupmerge =3D always. I
didn't know about that until I looked it up, just now. My first
impression is "who would want to use that?", but since it's there, we
should not break it. So, yes, we should probably apply the check when
@{u} exists, and refers to a remote-tracking branch. (One could argue
that this is also unsafe, since the current repo is a perfectly valid
remote, but if you do that, I'd be inclined to let you shoot yourself
in the foot.)

Also, if this check becomes part of core git, we obviously want some
config option to en/disable it. Preferably at multiple levels, as
discussed earlier in this thread:

  core.rewriteUpstream =3D refuse/false, warn, allow/true
(en/disables the check for the entire repo, but may be overridden by:)

  remote.<name>.rewriteUpstream =3D refuse/false, warn, allow/true
(en/disables the check for branches whose upstream is the given
remote, but may be overridden by:)

  branch.<name>.rewriteUpstream =3D refuse/false, warn, allow/true
(en/disables the check for the given local branch)

This allows fine-grained control of which branches/remotes you
consider 'public', and which are ok to rewrite.

> But because you wanted to discuss more about the issues than the
> implementation, let me think aloud a bit, reviewing what I usually do=
=2E
>
> I keep things simpler by sticking to a very simple rule. I allow myse=
lf to
> rebase only what is not yet in 'next', so the logic becomes a simple =
"am I
> creating a new commit based on what is already in 'next'?"
>
> During the course of integration testing with 'next', however, I ofte=
n
> find a topic or two that I have merged to it is less than ideal, and =
of
> course, the whole point of doing integration testing with 'next' is t=
o
> find such problematic topics before pushing 'next' out. =C2=A0I rewin=
d 'next',
> rebuild the problematic topics, and then rebuild 'next', and all of t=
hese
> happen before 'next' is pushed out. =C2=A0The step that rewinds 'next=
' that
> acquired problematic versions of the topics makes the topics eligible=
 for
> rebase.
>
> That would mean that a configuration variable "rebase.bottomLimit =3D=
 next"
> is sufficient to implement such a check for me. =C2=A0No per-branch b=
ottom is
> needed, because everything is merged to 'next' and tested to see if t=
hey
> do not need further rebases for fixing them up before they are publis=
hed.

What  you are describing here may be a common workflow, but
"rebase.bottomLimit" is still very specific to that kind of workflow.
What I'm after is a much more workflow-agnostic concept of:

  "If I have pushed something, I should probably not rebase it"

I believe this rule is sufficiently common in most workflows to
warrant the addition of this safety-check to Git. (And making the
safety-check configurable caters to those that don't need/want it.)

> Perhaps "I mistakenly rebased something that I have already published=
" is
> a mere symptom a bigger problem. =C2=A0The issue may not be that we d=
o not give
> them a good tool to help them to be more careful with less effort on =
their
> part before they rebase. =C2=A0It may instead be that it is too easy =
to publish
> branches that are not ready to be pushed out, and that is the real ca=
use
> of the "I realized I need to fix the topic and I fixed it, but I did =
not
> realize that it was too late and I shouldn't have rebased" problem.
>
> I wonder if it would be a more direct solution to the issue you are
> raising to give them a good tool to help them to be more careful with=
 less
> effort on their part before they publish (not before they rebase).

Yes, in many cases, the user will probably agree that the rewrite
should ideally have happened _before_ the branch was first published.
However, I'm not sure how we can help the user _not_ publish the
branch until it's ready. We could throw in a warning (or even a stupid
"Are  you really sure you want to publish?") before pushing a branch,
but I don't think it would help at all.

I think the following decribes what often happens for many users:

 1. User A pushes the branch to a public repo.
 2. User B points out a simple mistake in the branch.
 3. User A makes a fix
 4. User A squashes the fix into the (already-published) history.
 5. User A attempts to push the "fixed" history (but is rejected by
the public repo because of non-fast-forward).

At this point, the damage is already done, since often neither of the
following alternatives are desirable:

 6a. (safe) User A realizes the error and undoes the history-rewrite
(this is not easy for novice users), leaving the fix on top of the
already-published history, and re-pushes a fast-forwarding history.
OR
 6b. (dangerous) User A reattempts the push with --force. User B (and
user C, D, ...) is left to clean up the mess.

You could say that User A should be more careful and push to a "less
public" repo in step #1 (thus allowing the fix to be squashed before
pushing to a "more public" repo in step #5), but how "public" is
"public" enough to have someone point out the bug, but still
"unpublic" enough to allow rebase?

In general, I really cannot see any opportunity before step #4 where
we can stop (or warn) the user from what is about to happen. And I
think that refusing rewrites of commits that are already present in
the @{upstream} remote-tracking branch is good enough to help most
users avoid steps #4 through #6 (in a push-based workflow[1]). In
fact, from a pedagogical POV, I think step #4 is probably the best
spot for novice users to learn exactly the distinction between
acceptable and unacceptable history rewrites (instead of having it
explained to them as a consequence of the step #5).


Thanks for your insight,

=2E..Johan


[1]: For non-push-based workflows (such as send-email, sharing
bundles, pulls from local repo, etc.) we will need other methods for
determining which commits have been published. This have been
discussed earlier in the thread, but is outside the scope of what I
want to accomplish for now.

--=20
Johan Herland, <johan@herland.net>
www.herland.net
