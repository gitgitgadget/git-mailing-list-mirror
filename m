From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Adding push configuration to .git/config
Date: Thu, 22 Nov 2007 09:54:21 +0100
Message-ID: <7E8CB606-6CBD-4736-A2CB-0A1E1BD219D3@zib.de>
References: <20071121105517.GA11875@denkbrett.schottelius.org> <7vabp79hjt.fsf@gitster.siamese.dyndns.org> <C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de> <7vd4u28z90.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 09:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv7oW-0004k6-KL
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 09:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbXKVIxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 03:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbXKVIxT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 03:53:19 -0500
Received: from mailer.zib.de ([130.73.108.11]:34021 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbXKVIxS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 03:53:18 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAM8r6b7011719;
	Thu, 22 Nov 2007 09:53:14 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAM8r68n025287
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 22 Nov 2007 09:53:06 +0100 (MET)
In-Reply-To: <7vd4u28z90.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65758>


On Nov 22, 2007, at 9:23 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> On Nov 22, 2007, at 2:48 AM, Junio C Hamano wrote:
>> ...
>>> An alternative could be to split [remote "name"] url into two
>>> variants, fetch-url and push-url.  While fetching by default
>>> from two places without telling from which one does not make any
>>> sense, pushing by default to two different places is quite a
>>> normal thing to do, and we already do support more than one url
>>> entries in [remote "name"] section used for pushing.
>>>
>>> If we were to do this, it might also make sense to rename the
>>> word 'origin' we use for the default remote name to 'default' or
>>> something.  People with shared repository workflow would fetch
>>> from one repository and push back to the same repository, so the
>>> distinction would not matter, but for others who need something
>>> like you suggest, the default repository for fetching and
>>> pushing are different, and while you may still consider where
>>> you fetch from your 'origin', where you push into is not your
>>> 'origin' anymore.
>>
>> I like this idea.
>>
>> But in addition, we should have a branch.$name.push line that
>> can contain a remote head to push to.
>
> Yes, but.
>
> At that point, I think you would introduce a mismatch between
> the traditional semantics of refspec and what you are trying to
> do, unless you are careful.
>
> The traditional semantics of refspecs-tied-to-remote is strongly
> based on the assumption: "I will push to this remote when these
> local branches are all ready to be pushed out, and they will all
> go there together as an atomic update.  When I am _that_ ready
> to push, it does not matter which local branch I am on.  The
> branches that matter are all in good shape when I push."
>
> You are making the behaviour of push dependent on which branch
> you are on.  During such a push, it is safe to assume that the
> current branch is ready to be pushed out, but other ones can be
> very much un-ready.  The user needs a safety valve to prevent
> other branches from being pushed out.  Otherwise the user would
> not be adding branch.$name.push to begin with.

This is not the only reason.  If I'm thinking of a workflow
based on a shared repo, I see two more reasons

The user wants to limit the push to the current branch
because different branches in the remote (shared) repo may
have advanced.  The user does not want to the see errors by
"git push" that complain about non-fast-forwards.  The safety
valve is needed to protect from changes in the remote repo
(not for changes in the local one).

The second use case is to have multiple local branches that
refer to the same (shared) remote branch.  If you want to push
the changes directly to the (shared) remote branch, you need to
"rename" the branch during the push.  But you want to push only
a single branch: the current branch you're on.  Hence you need
a per-branch configuration if you want "git push" to to the
work for you automatically.  It would be nice if "git branch"
could be asked to set up branch.$name.push to point to the
correct remote branch (similar to "--track").

With what I have in mind in the longterm you could do

	git checkout -b foo origin/master
         work work work
	git checkout -b bar origin/master
	work work work
	git checkout foo
	git pull   # or git fetch; git rebase
	git push
	git checkout bar
	git branch -d foo
         work work, ... and later push bar, too

Note, there are several other changes needed before this would
work:
- "git checkout" would have to set branch.$name.push.
- "-d" would needs to be accept deletion if all changes are on
   shared remote branch.


> It would probably need to become a target ref or a list of <URL,
> target ref>, not a list of general refspecs like the value for
> remote.$there.push variable.  For example, you would want to say
> "while on master, push it to repository A as refs/heads/master
> and to repository B as refs/remotes/satellite/master", which
> would be a typical arrangement if you are working on a satellite
> machine, A is the shared central repository and B is mothership
> to your satellite machine.  The specification would talk only
> about the target ref (not just "'can contain' a remote head to
> push to"), and the source ref would always be the current
> branch.
>
> I guess you could use general refspec on branch.$name.push and
> implement the safety by requiring (1) only one refspec appears
> for such a variable, and (2) the LHS of the refspec matches the
> $name of the branch, in order to make the parsing easier and to
> keep the syntax uniform.
>
> Or maybe I am being overly cautious again not to introduce any
> more unnecessary user confusion, and just should give them even
> longer rope to hang themselves.  I dunno.

Yes.

In the simplest version, branch.$name.push should only contain
the remote part of the refspec.  It should be symmetric to
branch.$name.merge.

So if branch.$name.push is set, "git push" means

    git push <url-from-remote> $name:<value of branch.$name.push>

This is what I proposed earlier.

	Steffen
