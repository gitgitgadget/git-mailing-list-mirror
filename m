From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Wed, 17 Mar 2010 11:56:55 -0400
Message-ID: <4BA0FBC7.3080305@xiplink.com>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com> <1268768556-32176-1-git-send-email-marcnarc@xiplink.com> <20100316214717.GA24880@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 16:55:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrval-0003TW-24
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 16:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab0CQPzZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 11:55:25 -0400
Received: from smtp122.dfw.emailsrvr.com ([67.192.241.122]:59566 "EHLO
	smtp122.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab0CQPzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 11:55:24 -0400
Received: from relay2.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay2.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id BC815E22132;
	Wed, 17 Mar 2010 11:55:23 -0400 (EDT)
Received: by relay2.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C591CE22141;
	Wed, 17 Mar 2010 11:55:22 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20100316214717.GA24880@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142403>

Jonathan Nieder wrote:
> Hi Marc,
>=20
> Marc Branchaud wrote:
>=20
>> This option tells rebase--interactive to cherry-pick all the commits=
 in the
>> rebased branch, instead of fast-forwarding over any unchanged commit=
s.
>>
>> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> [...]
>> This offers an alterntive way to deal with reverted merges (the
>> revert-a-faulty-merge.txt howto recommends reverting the initial rev=
ersion
>> before re-merging a modified topic branch).
>>
>> With this change, you can instead use the --no-ff option to recreate=
 the
>> branch with entirely new commits (they're new because at the very le=
ast the
>> committer time is different).  This obviates the need to revert the
>> reversion, as you can re-merge the new topic branch directly.
>=20
> I think this rationale should go in the commit message, for the sake =
of
> future readers studying the code you=E2=80=99ve changed.

Easy to do, but how necessary?  The rationale is already in the descrip=
tion
of --no-ff in rebase's man page.

There's an extra aspect to my motivation that I failed to mention, whic=
h is
that I would like the topic branch to stay rooted at its original commi=
t.
This is because in our workflow that original commit is a synchronizati=
on
point for several maintenance and "next"-style branches, and keeping th=
e
topic rooted there makes it easy to merge into different branches.

> But let me make sure I understand it.
>=20
> If I am understanding properly, your idea is that this would be used =
on
> a branch after =E2=80=9Cunmerging=E2=80=9D it from master:
>=20
>     B --- C --- D [topic]
>   /              \
>  A ---  ...   --- M ... --- U [master]
>=20
> Here M is a merge commit and U a commit reverting the change from M^
> to M.
>=20
> As howto/revert-a-faulty-merge explains, this is an accident waiting =
to
> happen: if you merge master into topic, then it will pull in the reve=
rt
> along with the rest of the changes.  Similarly, if you merge topic in=
to
> master, it will be a no-op (=E2=80=9Calready up to date=E2=80=9D).
>=20
> Your solution, to rewrite the branch, should address both of these
> problems.  The new history looks like this:
>=20
>     B' --- C' --- D' [topic]
>   /
>  |  B --- C --- D
>  |/              \
>  A ---   ...  --- M ... --- U [master]
>=20
> What happens now if you merge topic into master (or master into topic=
)?
>=20
> Git will try to reconcile the changes from the two branches since whe=
n
> they diverged.  master gained the changes from the old topic branch a=
nd
> then reverted them since it diverged from topic; since merge algorith=
m
> is a simple three-way merge, all that history is ignored and Git will
> just combine any new changes from master with the changes from topic.
> Success.

Yup, you got it!

> Side note:
>=20
> After this maneuver, I would want to merge =E2=80=98master=E2=80=99 i=
nto =E2=80=98topic=E2=80=99 as
> soon as possible.

Well, I wouldn't want to do that because it would make it impossible to=
 merge
the topic into some other branch without also bringing in all of master=
=2E

> Why?  Because there is still a failure mode possible
> after this: if you merge any commits from the old topic into the new
> one before then, you=E2=80=99re back in trouble.  This could happen i=
f some
> topic2 that topic ends up needing is based on a point in master after=
 M
> and before U.

If the re-cast topic1 doesn't rewrite those commits, then the merge wil=
l
simply succeed because the code is already identical in both branches.

But if topic1 does rewrite those commits then there'll be a conflict.  =
IMO
that's correct, because with the merging of topic2 the code in master r=
eally
did diverge in a relevant way from what's in topic1, so that conflict s=
hould
get resolved in the normal way.

> After merging master into topic, the _meaning_ of the history is much
> clearer: by making U an ancestor, we are saying that as far as this
> branch is concerned, the state at the tip of the topic branch is to b=
e
> preferred over the reverted state.

Yes, but it also means that all the history of master since commit A is=
 now
part of the topic, which isn't acceptable to me.

> This suggests an alternative method to achieve your goal:
>=20
>  git checkout master
>  git revert -m 1 M;	# (1)
>  git checkout topic
>  git merge master^;	# (2)
>  git merge -s ours master;	# (3)
>=20
> 1. Add a commit U removing the changes introduced by topic from maste=
r.
>=20
> 2. Merge all changes from master before the revert into topic.
>=20
> 3. Declare the changes from topic to supersede the master branch.
>    This way, if topic is ever merged back to master, the changes will=
 be
>    reintroduced again.
>=20
> Resulting history:
>=20
>     B --- C --- D --- ... --- T^ --- T [topic]
>   /              \            /     /
>  A ---   ...  --- M ... --- U^ --- U [master]

I understand how this achieves your goal but, aside from dragging all o=
f
master into the topic, this is way more complicated than recreating the=
 topic
or even doing the double-revert.  By creating T with "-s ours" U become=
s like
a surrogate ancestor of the topic -- it's there, but it doesn't share a=
ny
genetic material with the topic.  I think that's a recipe for confusion=
 to
future explorers of the repo's history.

Besides, I do expect at least one of the topic's original commits to ac=
tually
be different in the recast topic -- the original merge was reverted bec=
ause
the topic was faulty in some way, so there needs to be a real change ma=
de
somewhere.  If the topic could simply be fixed with an extra commit or =
two
after D then re-merged, there wouldn't be a need to revert the original=
 merge
in the first place.

> You can avoid the perhaps pointless commit T^ by using --no-commit in
> the command (2).  If not all changes from M..master are suitable for
> merging into topic, you can use the same trick on a temporary side
> branch:
>=20
>  git checkout -b revert-topic M
>  git revert -m 1 M
>  git checkout topic
>  git merge --no-commit revert-topic^
>  git merge -s ours revert-topic
>  git checkout master
>  git merge revert-topic
>=20
> If not all changes from topic..M are suitable for merging into topic,
> then things are harder.  I=E2=80=99d suggest making a special unrever=
t-topic
> branch as above to keep in the wings until its time.

This still brings all of the master's A..M^ commits into the topic.

>> (Honestly, I wouldn't say that this approach is vastly superior to
>> reverting the reversion.  I just find it a little less messy and a l=
ittle
>> more intuitive.  It's also a bit easier to explain to people to "use=
 --no-ff
>> after reverting a merge" instead of making sure they get the double-
>> reversion right.)
>=20
> Hope this helps clarify things.
>=20
> Your patch itself might still be a good idea.  I think plain
> =E2=80=98git rebase=E2=80=99 already has something like it, in the fo=
rm of the
> --force-rebase option.  I have used it before, though I don=E2=80=99t=
 remember
> why.

No, the man page says --force-rebase does something else.

Thanks for the feedback!

		M.
