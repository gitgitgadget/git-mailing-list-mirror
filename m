From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Wed, 31 Oct 2007 08:53:06 +0100
Message-ID: <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 08:52:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In8Mw-0005Vx-Km
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 08:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbXJaHvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 03:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbXJaHvw
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 03:51:52 -0400
Received: from mailer.zib.de ([130.73.108.11]:37068 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbXJaHvv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 03:51:51 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9V7phCd016934;
	Wed, 31 Oct 2007 08:51:43 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1be2b.pool.einsundeins.de [77.177.190.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9V7pgGx001103
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 31 Oct 2007 08:51:42 +0100 (MET)
In-Reply-To: <7vejfcl8aj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Oct 30, 2007, at 8:19 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> On Oct 30, 2007, at 9:29 AM, Junio C Hamano wrote:
>>
>>> It simply is insane to make this strange rule 10/10 introduces
>>> the default behaviour.  It is too specific to a particular
>>> workflow (that is, working with a shared central repository,
>>> having many locally tracking branches that are not often used
>>> and become stale, and working on only things to completion
>>> between pushes).
>>
>> I don't think its very strange behaviour if you see it in the
>> light of what the user wants to achieve. We are talking about
>> the case were only fast forward pushes are allowed. So, we
>> only talk about a push that has the goal of adding new local
>> changes to the remote. The user says "git push" and means
>> push my new local changes to the remote.
>
> If you want to push a specific subset of branches, you should
> not be invoking the "matching refs" to begin with.  And breaking
> the "matching refs" behaviour is not the way to fix it.

ok.

So, git push shall guarantee that all matching refs point
to the _same_ commit if a push was successful. Otherwise,
git push shall report an error.

Would it be acceptable if the error was less severe in the
case of local being a strict subset of remote?
Daniel proposed
"%s: nothing to push to %s, but you are not up-to-date and
may want to pull"
It would still be an error, but a less severe one.

It could also be a good idea to teach git push transactional
behaviour. It could check in advance ('--dry-run') if the
push will succeed. If not it should report the errors without
actually pushing. Then, _nothing_ would have been changed on
the remote. Only if everything is ok "git push" would modify
the remote. Well, I think it might be hard to avoid the race
condition when someone else pushes simultaneously to a shared
repo. But this hopefully rarely happens.


> You can rewind a wrong branch by mistake locally and run push.
> With your change you would not notice that mistake.
>
>         $ git checkout bar
>         $ work work work; commit commit commit
> 	$ git checkout test
>         $ git merge bar
> 	... integrate, build, test
>         ... notice that the tip commit of bar is not ready
>         $ git checkout foo ;# oops, mistake
>         $ git reset --hard HEAD^
> 	$ git push
>
> If you checked out foo instead of bar by mistake at the last
> "git checkout" step like this, your change will make 'foo' an
> ancestor of the other side of the connection, and push silently
> ignores it instead of failing.

Yes, there are many ways you can mess up ;)


> Also, the behaviour is too specific to your workflow of working
> on things only to completion between pushes.  If you work a bit
> on branch 'foo' (but not complete), and work much on branch
> 'bar', 'baz', and 'boo' making all of them ready to be
> published, you cannot say "git push" anyway.  Instead you have
> to say "git push $remote bar baz boo".

Ok and this is the root why I work only to completion between
pushes. I tried to figure out a "safe" workflow. If you
accidentally type "git push" nothing wrong should happen. I
am sure that people will sometimes type "git push" forgetting
to mention anything. At least, I am sure that _I_ will do this.

The only comfortable way to make "git push" safe with
the current behaviour is to work on local branches only to
completion. Then, you can push to any repository at any time
and nothing bad can happen.

Alternatives with existing git are

- never use "git push", but always tell git explicitly what you
   want. This is too dangerous for me because at some point I'll
   type "git push". The problem with "git push" is that it's
   really hard to undo. It's near to impossible if you pushed
   to a public remote. Therefore, I really want to avoid this danger.

- Configure specific push rules for remotes that switch off
   the "matching branches" default. You can for example 'switch'
   off the default by configuring
   "remote.$remote.push = nonexisting". But then I started
   to get annoyed by all the configuration work. I do not want
   to explain such details to people who get started with git.
   And you do not get reasonable messages either. And btw I'd
   prefer if git push just did the right thing.


Alternatives that require changing git push are

- git push would do _nothing_ by default. git push would ask
   "what do you mean? Need at least a remote, or better remote
    and branch."
   Options could be provided to push current branch (--current)
   or all matching branches (--matching).

- git push _by default_ would only push the current branch. This
   would at least be a "safer" default.

- git push would first run --dry-run and then ask for
   confirmation. Something like:
   "Do you really want to push this to that remote? Here is
   the URL and the branches. Did you really mean this?
   WARNING: you can't undo this operation. And btw if you say
   yes, I'll report errors anyway because some remotes are not
   strict subsets. So maybe you want to fix things first."

- git push can be configuration to push only the current
   branch, as outlined below. This would certainly work. What
   I do not like is that you first need to do some configuration
   before you get a safe working environment.


> This discourages people from making commits that are not ready
> to be published, which is a very wrong thing to do, as a major
> selling point of distributed revision control is the
> dissociation between committing and publishing.

Yes, the current default behaviour of git push discourages me
to work that way.


> You work and commit freely, and at any point some of your
> branches are ready to be published while some others
> aren't. Inconvenience of "matching refs" may need to be worked
> around.  I liked your "current branch only", with "git push
> $remote HEAD" (I presume that "remote.$remote.push = HEAD" and
> "branch.$current.remote = $remote" would let you do that with
> "git push"), exactly because the way it specifies which branch
> is to be published is very clearly defined and easy to
> understand.  This "matching but only ff" does not have that
> attractive clarity.

In my view, that would be safer than what we have now.

	Steffen
