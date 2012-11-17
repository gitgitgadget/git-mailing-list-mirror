From: Aske Olsson <askeolsson@gmail.com>
Subject: Re: [PATCH] Add support for a 'pre-push' hook
Date: Sat, 17 Nov 2012 09:47:58 +0100
Message-ID: <CAJwKrPZC_9h5N8+zX8a0vhDQkv8e4y98+PWb=ygKfVc5CH3Qzw@mail.gmail.com>
References: <CAJwKrPYwCE4ExmK09PURMfjYezn6vdCH_BBXU4WCwrnotyV9CA@mail.gmail.com>
	<7vvcd5l290.fsf@alter.siamese.dyndns.org>
	<50A73120.9040301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 17 09:48:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZe4T-0005Bv-DL
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 09:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab2KQIsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 03:48:01 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:40920 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294Ab2KQIr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 03:47:59 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1362125eaa.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 00:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sj+/QuXtpoOFmT8HGjBCQFwlLvPpj19jNxb4O9+e7Gw=;
        b=KS/5KndlU6IZ7tZi+ddReuy7+chPIl3ENqoTJ0ow/Lfdli7DtJg7MC1fwfm+zB5PbP
         4A9o72j9PG3q42gSYwkNQUkDKm7l+1I+A8qz25+MLslaPO2B7ObmPsh62BVpF4Ck/utl
         Uk7+ZuWRh95tbpSJpGJbwRiK/bWUzhhz7zxZNe2xGKyR/fRtcFGfeBJAdKIYqKyPOrMs
         9p2FCTwmDQAoFM6jw8gxdNoFwPslYQ73vtxgqlO94ePaHNjuALAtArl5JF+P7Ptk5DCd
         LwPXTr9rDcn2oARWYpus/20rwWZzwVuSLUZCZ34g1Icg6Mxw5ToHgDr+GuYUru0Xmnue
         dl0g==
Received: by 10.14.205.3 with SMTP id i3mr5369377eeo.18.1353142078362; Sat, 17
 Nov 2012 00:47:58 -0800 (PST)
Received: by 10.14.187.131 with HTTP; Sat, 17 Nov 2012 00:47:58 -0800 (PST)
In-Reply-To: <50A73120.9040301@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209933>

On Sat, Nov 17, 2012 at 7:39 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> On 11/16/2012 09:30 PM, Junio C Hamano wrote:
> > Aske Olsson <askeolsson@gmail.com> writes:
> >
> >> If the script .git/hooks/pre-push exists and is executable it will be
> >> called before a `git push` command, and when the script exits with a
> >> non-zero status the push will be aborted.
> >> The hook can be overridden by passing the '--no-verify' option to
> >> `git push`.
> >>
> >> The pre-push hook is usefull to run tests etc. before push. Or to make
> >> sure that if a binary solution like git-media, git-annex or git-bin is
> >> used the binaries are uploaded before the push, so when others do a
> >> fetch the binaries will be available already. This also reduces the
> >> need for introducing extra (git) commands to e.g. sync binaries.
> >>
> >> Signed-off-by: Aske Olsson <askeolsson@gmail.com>
> >> ---
> >> ...
> >> +[[pre-push]]
> >> +pre-push
> >> +~~~~~~~~
> >> +
> >> +This hook is invoked by 'git push' and can be bypassed with the
> >> +`--no-verify` option. It takes no parameter, and is invoked before
> >> +the push happens.
> >> +Exiting with a non-zero status from this script causes 'git push'
> >> +to abort.
> >> ...
> >> + if (!no_verify && run_hook(NULL, "pre-push")) {
> >> + die(_("pre-push hook failed: exiting\n"));
> >> + }
> >
> > NAK, at least in the current form.  At least the system should tell
> > the hook where it is pushing and what is being pushed.
>
> I agree.

Yes, I also agree that is a nice piece of information to pass to the hook.
Will work on that.


> > Besides, there are five valid reasons to add a new hook to the
> > system, but your version of pre-push does not satisfy any of them:
> >
> >      http://thread.gmane.org/gmane.comp.version-control.git/94111/focus=71069
>
> Here I disagree.  I think it satisfies (1):
>
> >  (1) A hook that countermands the normal decision made by the
> >      underlying command.  Examples of this class are the update
> >      hook and the pre-commit hook.
>
> pre-push would be very similar in spirit to pre-commit: pre-commit is a
> filter that can prevent a "bad" commit from getting into the local
> repository; pre-push is similarly a filter between the local repo and
> remote repositories.

Yes, I was thinking of a pre-push hook in the same way, preventing bad
commits from leaving the repo, but I guess you could argue that a bad
commit shouldn't happen in the first place due to the pre-commit hook.

> I also think it satisfies (2) and/or (5b):
>
> >  (2) A hook that operates on data generated after the command
> >      starts to run.  [...]
>
> >  (5) [...]  Another example is the post-checkout
> >      hook that gets information that is otherwise harder to get
> >      (namely, if it was a branch checkout or file checkout --
> >      you can figure it out by examining the command line but
> >      that already is part of the processing git-checkout does
> >      anyway, so no need to force duplicating that code in the
> >      userland).
>
> It would not be trivial for a wrapper script to figure out what branches
> and commits are about to be pushed.  But "git push" could tell the hook
> script what branches are to be pushed.  And if the pre-push hook is run
> after negotiation between client and server of what commits need to be
> transfered, the hook could also be provided that information and use it
> to figure out which commits it should vet.
>
>
> Although a pre-receive script on the remote repository could do most of
> the same things as a pre-push script, the latter would sometimes have
> advantages because it is run "client-side":
>
> * When the user doesn't have the ability to change the pre-receive
> script on the server (think public git hosting services).

Yeah, and for my case I would like to sync some binaries to a remote
storage before pushing the commits that contains references to these.
I know a wrapper script could easily do this, but I'm not to sure that it will
work in an organization with a lot of developers. Sooner or later one of them
will have some git problem and search the net, find an answer which (of
course) doesn't include the commands in the wrapper script. Then he might
end up pushing something that none of the other devs can get hold of and
that might cause builds to break etc.
And we can't currently run pre-receive hooks to deny the commit.

> * For user-specific actions that are not wanted by all users pushing to
> the same server (for example, maybe I add the string "WIP" to commit
> messages for commits that are not ready to be pushed; my pre-push script
> could verify that I don't push such a commit by accident).
>
> * Preventing "secret" info (password files, proprietary branches) from
> being pushed.  Even if the remote repo were taught to reject them, they
> would have already traversed the internet.

Yes we have also seen a couple of these, would be nice to have a way
do deny them.

-Aske
