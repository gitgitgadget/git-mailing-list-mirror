From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Mon, 6 Feb 2012 21:16:27 +0100
Message-ID: <CALKQrgcUdigB5zB_bqgpW8=o-TuGChs+q2nYoXu5YdyWu+oWZw@mail.gmail.com>
References: <201202042045.54114.jnareb@gmail.com>
	<201202061544.14417.jnareb@gmail.com>
	<CALKQrgcN9Miq7SN_ETvjboRkHRFzcZejrQfy36BQFxYDnVPP6w@mail.gmail.com>
	<201202061814.58346.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 21:16:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuUzO-0000XR-Q3
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 21:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508Ab2BFUQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 15:16:33 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:62185 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab2BFUQc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 15:16:32 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1RuUzG-000Kw7-W6
	for git@vger.kernel.org; Mon, 06 Feb 2012 21:16:31 +0100
Received: by ghrr11 with SMTP id r11so2806172ghr.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 12:16:27 -0800 (PST)
Received: by 10.50.213.41 with SMTP id np9mr20331791igc.21.1328559387388; Mon,
 06 Feb 2012 12:16:27 -0800 (PST)
Received: by 10.42.226.9 with HTTP; Mon, 6 Feb 2012 12:16:27 -0800 (PST)
In-Reply-To: <201202061814.58346.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190096>

On Mon, Feb 6, 2012 at 18:14, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 6 Feb 2012, Johan Herland wrote:
>> On Mon, Feb 6, 2012 at 15:44, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> > Relying on (default) hooks to implement this feature has the disad=
vantage
>> > that it wouldn't be turned on by default... while this feature wou=
ld be
>> > most helpful for users new to git (scared by refuse to push).
>>
>> True. I too believe that this will be most helpful if it is enabled =
by
>> default. That said, the easiest way to get there might be through
>> first demonstrating that it works in practice when implemented as
>> hooks.
>
> Yes, starting with prototype implementation using existing infrastruc=
ture
> (hooks) would be a very good idea. =C2=A0(That's how first versions o=
f what
> became submodules were implemented.)
>
> OTOH we should be aware of limitations of said prototype due to the f=
act
> that it is a prototype...

Agreed, but AFAICS (and modulo the addition of pre-rewrite and
pre/post-push hooks mentioned earlier) all of the things discussed so
far in this thread can be implemented as hooks.

>> > I am not sure either if everything (wrt. safety net) can be implem=
ented
>> > via hooks. =C2=A0One thing that I forgot about is preventing rewin=
ding of
>> > branch past the published commit using e.g. "git reset --hard <com=
mit>".
>> > Unless `pre-rewrite` hook could be used for that safety too...
>>
>> Hmm. I don't think we'll be able to "plug" all the holes that might
>> leave the user in a rewritten state (e.g. what if the user (possibly
>> with the help of some tool) does an "echo $SHA1 >
>> .git/refs/head/master"?).
>
> First, I was thinking about having safety net against rewriting publi=
shed
> commits being present only in porcelain. =C2=A0Plumbing would be not =
affected
> (perhaps there would be need to extend or add new plumbing to query "=
phase"
> state, though).

I also think this is very much a porcelain-only feature. I'd be more
worried if plumbing changes were needed.

>> And trying to plug too many holes might end
>> up annoying more experienced users who "know what they're doing".
>
> Second, forcing via command line parameter should always be an option=
=2E

Obviously, but if a large portion of the Git community felt the need
to always disable this feature, I'd say that we'd failed. The best
features are those that Just Work(tm).

>> Instead we might want to add a client-side check at push time. I
>> realize that this check is already done by the remote end, but the
>> client-side might be able to give a more helpful response along the
>> lines of:
>
> [...]
>
> Explanation is good, but the whole idea of rewriting safety is that y=
ou
> are informed (warned or denied) _before_ attempting rewrite and doing=
 much
> work.

True, but there may be cases where the rewrite is not apparent until
after it has happened. E.g. a novice user may use 'git reset --hard'
in order to get to an earlier state for testing purposes, and then -
after completing the test - 'git reset --hard' back to the starting
point. I know this is not best practice, but is it bad enough that we
want to refuse it?

>> First, we don't need to annotate _all_ commits. For the 'public'
>> state, we only annotate the last/tip commit that was pushed/publishe=
d.
>> From there, we can defer that all ancestor commits are also 'public'=
=2E
>
> Right.
>
>> For the 'secret' state, we do indeed annotate _all_ secret commits,
>> but I believe this will be a somewhat limited number of commits. If
>> your workflow forces you to annotate millions of commits as 'secret'=
,
>> I claim there is something wrong with your workflow.
>
> Well, for the 'secret' we can rely on the fact that child of 'secret'
> commit must also be 'secret' (non-publishable) if secret is to stay
> secret. =C2=A0Still marking all 'secret' commits might be better idea=
 from
> UI and from performance point of view.

I don't think we should automatically assume that all children of a
'secret' commit are also 'secret'. First of all, the git DAG was not
made for iterating forwards in history, so given a 'secret' commit, it
is computationally expensive to enumerate all its implied-'secret'
descendants. More importantly though, I don't agree with the premise.
I would typically use the 'secret' state as follows: While debugging a
piece of code, I might commit a few debug print statements, and I
would typically mark this debug commit as 'secret', in order to
prevent myself from accidentally pushing this. Although it probably
doesn't matter in practice, I think it is wrong for the commits made
(temporarily) on top of this debug commit to be also considered
'secret'. They are only unpublishable as a consequence of being based
on the debug commit, and only until I get around to rebasing away the
'secret' debug commit.

>> > Second, I have doubts if "phase" is really state of an individual =
commit,
>> > and not the feature of revision walking.
>
> It matters to presentation: can commit be simultaneously 'public' bec=
ause
> of one branch, and 'draft' because of other.
>
>> I believe the 'public' state is a "feature of revision walking" (i.e=
=2E
>> one annotated 'public' commit implies that all its ancestors are als=
o
>> 'public'). However, the 'secret' state should be bound to the
>> individual commit, IMHO.
>
> Good call, otherwise 'secret' commit could have been "side-leaked"
> by other refs being pushed.
>
> This means though that 'public' / 'draft' while looking similar to 's=
ecret'
> are in fact a bit different things. =C2=A0In other words 'immutable' =
and
> 'impushable' traits are quite a bit different in behavior...
>
> Especially that one acts at pre-rewrite time, and second pre-push tim=
e.

Exactly. I find Mercurial 'phase' language confusing, precisely for
the reason that 'public' and 'secret' are DIFFERENT concepts. One
hinders rewrite and naturally applies to a commit AND its ancestors,
while the other hinders push and only applies to the commit itself.
The fact that they could be implemented by the same mechanisms (hooks
and notes) does not make them the same thing.

>> > Take for example the situation where given commit is reference by
>> > remote-tracking branch 'public/foo', and also by two local branche=
s:
>> > 'foo' with upstream 'public/foo', and local branch 'bar' with no u=
pstream.
>> >
>> > Now it is quite obvious that this feature should prevent rewriting=
 'foo'
>> > branch, for which commits are published upstream. =C2=A0But what a=
bout branch
>> > 'bar'? =C2=A0Should we prevent rewriting (e.g. rebase) here too? =C2=
=A0What about
>> > rewinding 'bar' to point somewhere else. =C2=A0What if 'bar' is re=
ally detached
>> > HEAD?
>> >
>> > These questions need to be answered...
>>
>> Good point. There are two questions we may need to answer: "Has comm=
it
>> X ever been published?", and "Has commit X ever been published in th=
e
>> context of branch Y?". In the latter case, we do indeed need to take
>> the upstream branch into account.
>
> I think the second one is more interested for rewrite safeties.
>
>> Basically, there are three different "levels" for this rewrite/publi=
sh
>> protection to run at:
>>
>> 1. Do not meddle at all. This is the current behavior, and assumes
>> that if the user rewrites and pushes something, the user knows what
>> he/she is doing, and Git should not meddle (obviously unless the
>> server refuses the push).
>
> I think that there should be some easy way to force such behavior,
> i.e. to discard rewrite safeties.

Indeed. We should probably have a simple config flag to enable the
rewrite protection. In fact I would argue that the flag should default
to false (disable protection) when unset, and then we should let
init/clone set the config flag to true (enable protection) in newly
created repos (unless explicitly disabled in the user/system configs).
This way, behavior does not change for existing repos, but new repos
are protected by default (with only a single command needed to disable
the protection).

>> 2. Warn/refuse rewriting commits in your upstream. This would only
>> check branch X against its registered upstream. Only if there is a
>> registered upstream, and you're about to rewrite commits that are
>> reachable from the upstream remote-tracking branch, should Git
>> intervene and warn/refuse the rewrite. This level would IMHO provide
>> most of the benefit, and little or no trouble (i.e. false positives)=
=2E
>
> Right. =C2=A0I wonder if we can get usage statistics from Mercurial u=
sers
> about usage of their "phases" feature... though mapping terminology
> for example 'upstream' from Git to Mercurial and vice versa can be
> a pain, I guess.

I'm unsure how useful it would be. IMHO Git and Mercurial are
different enough (and promote sightly different workflows) that I
don't trust the the average Mercurial user's preference for
Mercurial's 'phase' behavior to be transferable to the average Git
user's preference for a similar behavior in Git.

>> 3. Warn/refuse rewriting _any_ 'public' commit. Refuse to rewrite an=
y
>> commit that is reachable from any remote-tracking branch. Some would
>> say that this is a Good Thing(tm), since it prevents a commit from
>> being _copied_ (i.e. rebased or cherry-picked) between branches (you=
'd
>> be in this camp if you run a tightly-controlled workflow, where you
>> e.g. mandate upmerging patches from the oldest applicable branch
>> instead of cherry-picking patches from a newer branch). However, oth=
er
>> people would say that this is too limiting, and imposes unnecessary
>> rules on the workflow of the project (where e.g. copying (by way of
>> git-rebase) a topic branch from one place to another would cause an
>> annoying false positive).
>
> Well, we could always 'deny' on 2nd, and just 'warn' on 3rd...

Good idea.


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
