From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sun, 5 Feb 2012 23:49:59 +0100
Message-ID: <CALKQrgcAsPXziQCTReZkCKnnXTX=rwPFrzp0wJ3ZYwn0b_M5Tw@mail.gmail.com>
References: <201202042045.54114.jnareb@gmail.com>
	<201202051715.38896.jnareb@gmail.com>
	<CALKQrgcPW5VnVtGYDo6i00bvmWr6PvnWfEdWW+9ttG4hVQm58A@mail.gmail.com>
	<201202052146.56458.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 23:50:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuAud-00018J-NH
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 23:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab2BEWuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 17:50:07 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:53789 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2BEWuE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 17:50:04 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1RuAuI-000IH1-Jr
	for git@vger.kernel.org; Sun, 05 Feb 2012 23:50:02 +0100
Received: by iacb35 with SMTP id b35so7568732iac.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 14:49:59 -0800 (PST)
Received: by 10.50.222.132 with SMTP id qm4mr7710027igc.21.1328482199314; Sun,
 05 Feb 2012 14:49:59 -0800 (PST)
Received: by 10.42.226.9 with HTTP; Sun, 5 Feb 2012 14:49:59 -0800 (PST)
In-Reply-To: <201202052146.56458.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189981>

On Sun, Feb 5, 2012 at 21:46, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 5 Feb 2012, Johan Herland wrote:
>> 2012/2/5 Jakub Narebski <jnareb@gmail.com>:
>> > > Being able to mark temporary, out of sequence or other hacks as =
Secret could
>> > > be useful, as would recording where Public commits had been sent=
=2E
>> >
>> > Marking as 'secret' must I think be explicit, but I think 'public'=
 phase
>> > should be inferred from remote-tracking branches. =C2=A0The idea o=
f phases is
>> > to allow UI to ask about status of commits: can we amend / rebase =
it or
>> > not, can we push it or not.
>>
>> I agree that the 'public' state should (by default) be automatically
>> inferred from remote-tracking branches. As it stands, we can do this
>> with current git, by writing a pre-rebase hook that checks if any of
>> the commits to-be-rebased are reachable from any remote-tracking
>> branch.
>
> It is nice that we can achieve a large part of this feature with exis=
ting
> infrastructure. =C2=A0It would be nice if we ship such pre-rebase hoo=
k with
> git, so people can just enable it if they want to use this functional=
ity,
> like the default pre-commit hook that checks for whitespace errors.

Yeah. As it is, the pre-rebase hook shipped with v1.7.9 (when
activated) does something similar (i.e. prevent rewriting 'public'
commits). However, it's highly workflow-specific, since it determines
whether the branch being rebased has been merged into "next" or
"master". IMHO, a hook that tested for reachability from
remote-tracking refs would be more generally useful. Obviously, the
two can be combined, and even further combinations may be desirable
(e.g. also checking for reachability from commits annotated in
refs/notes/public).

>> Unfortunately, the pre-rebase hook only affects 'git rebase', and in
>> order to do the same check on 'git commit --amend' you'd have to wri=
te
>> a similar pre-commit hook (don't know how easy it is to find the
>> amended commit from within the hook). Maybe we should add a
>> pre-rewrite hook that trigger in the same situations as the
>> post-rewrite hook.
>
> pre-rewrite hook would be a really nice to have, especially that it w=
ould
> (I hope) cover third party tools like various GUIs for git; and also
> git-filter-branch.
>
> Note however that the safety net, i.e. refusing or warning against at=
tempted
> rewrite of published history is only part of issue. =C2=A0Another imp=
ortant part
> is querying and showing "phase" of a commit. =C2=A0What I'd like to s=
ee is
> ability to show among others in "git log" and "git show" output if co=
mmit
> was already published or not (and if it is marked 'secret').

Today, you can use --decorate to display remote-tracking refs in the
log/show output. However, only the tip commits are decorated, so if
the commits shown are not at the tip, you're out of luck. I believe
teaching log/show to decorate _all_ commits that are reachable from
some given ref(s) should be fairly straightforward.

If you use 'git notes' to annotate 'public' and 'secret' states, then
you can also use the --show-notes=3D<ref> option to let show/log displa=
y
the annotations on 'public'/'secret' commits.

>> This should take care of the simplest 'public' use case in a
>> push-based workflow. If you publish commits by other means
>> (send-email, bundles, pulling directly from your repo), you need som=
e
>> other way to mark the 'public' commits. One solution would be using
>> 'git notes' to annotate the 'public' commits on a 'refs/notes/public=
'
>> notes ref. Your pre-rebase/pre-rewrite hook should then check if any
>> of the commits to-be-rewritten are reachable from any commit annotat=
ed
>> as 'public'.
>
> Another solution would be to create "fake" remote-tracking branches
> by git-bundle and git-send-email.

Good point. Creating such "fake" remote-tracking branches might be a
good idea in those workflows anyway, simply to keep track of what has
been shared, and where.

>> Also, if you want to record where 'public' commits have been sent
>> (other than what can be inferred from the remote-tracking branches),
>> you could write this into the refs/notes/public annotation.
>
> I wonder if this too can be done by hook...

You're looking for someting like a post-push hook that runs on the
_client_ after a successful push. AFAIK, that doesn't exist yet. (Not
to be confused with the receive/update hooks that run on the
_server_.)

>> As for 'secret' commits, you could annotate these on a
>> refs/notes/secret notes ref, and then teach 'git push' (or whatever
>> other method for publishing commits you use) to refuse to publish
>> commits annotated on this notes ref. Possibly we would want to add a
>> "pre-push" or "pre-publish" hook.
>
> Well, addition of pre-push / pre-publish was resisted on the grounds
> that all it does is something that can be as easy done by hand before
> push. =C2=A0Perhaps this new use case would help bring it forward, do=
n't
> you think?

Maybe. I didn't follow the original discussion. From my POV, you could
argue that instead of another hook, you could always write a script
that does the 'secret' check before invoking 'git push', and then
you'd use that script instead of 'git push'. But you could argue the
same point for pretty much all of the other existing hooks (e.g.
instead of a pre-commit hook you could have your own commit wrapper
script). So I don't think that's a sufficient argument to refuse the
existence of a pre-push/publish hook.


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
