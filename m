From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Tue, 15 Feb 2011 11:28:09 +0000
Message-ID: <AANLkTi=1WkZXBtQu71mELTBc6F7XrfBi+NWNWy-AxS79@mail.gmail.com>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 12:28:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpJ5B-0000TD-Au
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 12:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab1BOL2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 06:28:31 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43418 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab1BOL2a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 06:28:30 -0500
Received: by qwa26 with SMTP id 26so36118qwa.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 03:28:29 -0800 (PST)
Received: by 10.229.186.7 with SMTP id cq7mr3879394qcb.239.1297769309155; Tue,
 15 Feb 2011 03:28:29 -0800 (PST)
Received: by 10.229.225.8 with HTTP; Tue, 15 Feb 2011 03:28:09 -0800 (PST)
In-Reply-To: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166839>

On Mon, Feb 14, 2011 at 1:51 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> Since c85c792 (pull --rebase: be cleverer with rebased upstream
> branches, 2008-01-26), 'git pull --rebase' has used the reflog to try
> to rebase from the old upstream onto the new upstream.
>
> However, if, instead of 'git pull --rebase', the user were to do 'git
> fetch' followed by 'git rebase', the reflog would not be walked. This
> patch teaches "git rebase" the same reflog-walking tricks that 'git
> pull --rebase' already knows.
>
> This may be useful for rebasing one branch against another local
> branch that has been rebased. Currently, you would have to do that
> using 'git rebase --onto' or by configuring it on the branch.

It make sense.

>
> It might seem like most of the related code in git-pull.sh can be
> removed once git-rebase.sh supports reflog walking. Unfortunately, no=
t
> much of it can be removed, though. The reason is that git-pull.sh
> simulates one step of "reflog walking" by keeping track of the
> position of the remote-tracking branch before and after the fetch
> operation. This does not rely on reflogs. There are at least two case=
s
> where the reflog is not used: a) when it is disabled, b) when the
> remote branch was specified on the command line (as in 'git pull
> --rebase origin master'). =A0In both of these cases, git-pull.sh
> remembers the position of the reference before the fetch and uses tha=
t
> as a kind of '$upstream@{1}'.

I don't agree with point b). In line 190:

	remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&

It returns the local tracking branch for repo=3Dorigin and branch=3Dmas=
ter
and uses its reflog.

The end result is the same, there is one case where you need the old
value of the tracking branch, so it should be done in git-pull.

But I wonder if it is possible to write a function shared by
git-pull.sh and git-rebase.sh that computes the branch forking points,
the number of arguments could detect if it has the old-remote-hash or
not.

>
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com=
>
> ---

[...]

>
> =A0 =A0HOWEVER, this causes a very noticable delay in some cases. Wit=
h this
> =A0 =A0patch, 'git rebase' walks the reflog of the upstream ref until=
 it
> =A0 =A0finds a commit that the branch-to-rebase contains. If the upst=
ream ref
> =A0 =A0has moved a lot since the branch was last rebased, there may b=
e quite
> =A0 =A0a few commits to test before the old upstream commit is found.
>
> =A0 =A0The same thing can already occur with 'git pull --rebase' for =
exactly
> =A0 =A0the same reasons. For example, assume that your upstream remot=
e branch
> =A0 =A0changes quite frequently and that you often fetch from the rem=
ote so
> =A0 =A0that your origin/master gets a long reflog. If you then checko=
ut some
> =A0 =A0branch you had not been working on for a while, and run 'git p=
ull',
> =A0 =A0you get into the same situation. The delay is probably less li=
kely to
> =A0 =A0be noticed in the case of 'git pull --rebase', however, since =
most
> =A0 =A0users will probably assume it is a problem with the network or=
 the
> =A0 =A0server.
>
> =A0 =A0Of course, 'git pull --rebase' can also be used with a local b=
ranch
> =A0 =A0configured as upstream. In this case, the behavior today is ju=
st like
> =A0 =A0what this patch introduces for 'git rebase'.
>
> =A0 =A0What do you think? I think it's a useful feature, but how do w=
e handle
> =A0 =A0the delay problem? Maybe simply by making it configurable?
>
> =A0 =A0Should such a configuration variable apply to 'git pull --reba=
se' as
> =A0 =A0well? It would seem inconsistent otherwise, but maybe that's o=
k since
> =A0 =A0'git pull --rebase' is usually used with remote-tracking branc=
hes,
> =A0 =A0which probably change less frequently. Btw, is this a correct
> =A0 =A0assumption? It is definitely true for my own work on git, but =
I
> =A0 =A0actually think it's the other way around for my work at $dayjo=
b. Am I
> =A0 =A0missing some part to the puzzle that explains why I had not no=
ticed
> =A0 =A0the delay until I started using this patch?

I agree with you that it may add a long delay in some cases. I
normally rebase branches based on an upstream branch and this may
explain why I haven't seen the delay (or maybe I thought it was a
network delay).

I think the delay could be much shorter if the computation was not in
shell, but in C. Or maybe change the algorithm. So I don't think a
configuration item is the answer here.

Other than that I think the change make sense it include docs and
tests and works, thanks.

Santi
