From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Mon, 6 Feb 2012 16:59:34 +0100
Message-ID: <CALKQrgcN9Miq7SN_ETvjboRkHRFzcZejrQfy36BQFxYDnVPP6w@mail.gmail.com>
References: <201202042045.54114.jnareb@gmail.com>
	<201202052146.56458.jnareb@gmail.com>
	<CALKQrgcAsPXziQCTReZkCKnnXTX=rwPFrzp0wJ3ZYwn0b_M5Tw@mail.gmail.com>
	<201202061544.14417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 16:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuQyo-0006O3-06
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 16:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab2BFP7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 10:59:41 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:57257 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab2BFP7k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 10:59:40 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1RuQyg-0003jH-DT
	for git@vger.kernel.org; Mon, 06 Feb 2012 16:59:38 +0100
Received: by iacb35 with SMTP id b35so8683728iac.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 07:59:34 -0800 (PST)
Received: by 10.42.155.70 with SMTP id t6mr17681003icw.11.1328543974892; Mon,
 06 Feb 2012 07:59:34 -0800 (PST)
Received: by 10.42.226.9 with HTTP; Mon, 6 Feb 2012 07:59:34 -0800 (PST)
In-Reply-To: <201202061544.14417.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190075>

On Mon, Feb 6, 2012 at 15:44, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 5 Feb 2012, Johan Herland wrote:
> Relying on (default) hooks to implement this feature has the disadvan=
tage
> that it wouldn't be turned on by default... while this feature would =
be
> most helpful for users new to git (scared by refuse to push).

True. I too believe that this will be most helpful if it is enabled by
default. That said, the easiest way to get there might be through
first demonstrating that it works in practice when implemented as
hooks.

> I am not sure either if everything (wrt. safety net) can be implement=
ed
> via hooks. =C2=A0One thing that I forgot about is preventing rewindin=
g of
> branch past the published commit using e.g. "git reset --hard <commit=
>".
> Unless `pre-rewrite` hook could be used for that safety too...

Hmm. I don't think we'll be able to "plug" all the holes that might
leave the user in a rewritten state (e.g. what if the user (possibly
with the help of some tool) does an "echo $SHA1 >
=2Egit/refs/head/master"?). And trying to plug too many holes might end
up annoying more experienced users who "know what they're doing".
Instead we might want to add a client-side check at push time. I
realize that this check is already done by the remote end, but the
client-side might be able to give a more helpful response along the
lines of:

  You are trying to push branch X to remote Y, but remote Y already
has a branch X that is N commits in front of you. You may want to
rebase your work on top of the remote branch (see 'git pull
--rebase'), If you instead force this push (with --force), you will
remove those N commits, and replace them with the M last commits from
your branch X.

  (followed by a list of the remote N and local M commits, respectively=
)

[...]

>> If you use 'git notes' to annotate 'public' and 'secret' states, the=
n
>> you can also use the --show-notes=3D<ref> option to let show/log dis=
play
>> the annotations on 'public'/'secret' commits.
>
> First, in my opinion annotating _all_ commits with their phase is I t=
hink
> out of question, especially annotating 'public' commits. =C2=A0I don'=
t think
> git-notes mechanism would scale well to annotating every commit; but
> perhaps this was tested to work, and I am mistaken.

=46irst, we don't need to annotate _all_ commits. For the 'public'
state, we only annotate the last/tip commit that was pushed/published.
=46rom there, we can defer that all ancestor commits are also 'public'.
=46or the 'secret' state, we do indeed annotate _all_ secret commits,
but I believe this will be a somewhat limited number of commits. If
your workflow forces you to annotate millions of commits as 'secret',
I claim there is something wrong with your workflow.

Second, git-notes were indeed designed scale well to handle a large
number of notes, up to the same order of magnitude as the number of
commits in your repo. (When git-notes was originally written, I
successfully tested it on versions of a linux-kernel repo where every
single commit was annotated). In this case, the number of 'public'
annotations in your repo would be equal to the number of pushes you
do, and the number of 'secret' annotations would be equal to the
number of 'secret' commits in your repo. I'd expect both of these
numbers to be orders of magnitude smaller than the total number of
commits in your repo (given a fairly typical workflow in a fairly
typical repo).

> Second, I have doubts if "phase" is really state of an individual com=
mit,
> and not the feature of revision walking.

I believe the 'public' state is a "feature of revision walking" (i.e.
one annotated 'public' commit implies that all its ancestors are also
'public'). However, the 'secret' state should be bound to the
individual commit, IMHO.

> Take for example the situation where given commit is reference by
> remote-tracking branch 'public/foo', and also by two local branches:
> 'foo' with upstream 'public/foo', and local branch 'bar' with no upst=
ream.
>
> Now it is quite obvious that this feature should prevent rewriting 'f=
oo'
> branch, for which commits are published upstream. =C2=A0But what abou=
t branch
> 'bar'? =C2=A0Should we prevent rewriting (e.g. rebase) here too? =C2=A0=
What about
> rewinding 'bar' to point somewhere else. =C2=A0What if 'bar' is reall=
y detached
> HEAD?
>
> These questions need to be answered...

Good point. There are two questions we may need to answer: "Has commit
X ever been published?", and "Has commit X ever been published in the
context of branch Y?". In the latter case, we do indeed need to take
the upstream branch into account.

Basically, there are three different "levels" for this rewrite/publish
protection to run at:

1. Do not meddle at all. This is the current behavior, and assumes
that if the user rewrites and pushes something, the user knows what
he/she is doing, and Git should not meddle (obviously unless the
server refuses the push).

2. Warn/refuse rewriting commits in your upstream. This would only
check branch X against its registered upstream. Only if there is a
registered upstream, and you're about to rewrite commits that are
reachable from the upstream remote-tracking branch, should Git
intervene and warn/refuse the rewrite. This level would IMHO provide
most of the benefit, and little or no trouble (i.e. false positives).

3. Warn/refuse rewriting _any_ 'public' commit. Refuse to rewrite any
commit that is reachable from any remote-tracking branch. Some would
say that this is a Good Thing(tm), since it prevents a commit from
being _copied_ (i.e. rebased or cherry-picked) between branches (you'd
be in this camp if you run a tightly-controlled workflow, where you
e.g. mandate upmerging patches from the oldest applicable branch
instead of cherry-picking patches from a newer branch). However, other
people would say that this is too limiting, and imposes unnecessary
rules on the workflow of the project (where e.g. copying (by way of
git-rebase) a topic branch from one place to another would cause an
annoying false positive).

[...]


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
