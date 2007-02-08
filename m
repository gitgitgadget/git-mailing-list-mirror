From: Bill Lear <rael@zopyra.com>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 09:27:32 -0600
Message-ID: <17867.16740.875694.789664@lisa.zopyra.com>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<7vr6t13251.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 16:27:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFBBa-00005E-IA
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 16:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbXBHP1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 10:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbXBHP1m
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 10:27:42 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61055 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333AbXBHP1l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 10:27:41 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l18FRcW24103;
	Thu, 8 Feb 2007 09:27:38 -0600
In-Reply-To: <7vr6t13251.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39059>

On Wednesday, February 7, 2007 at 16:48:42 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> 2) Why does git pull do the right thing when on master, but seemingly
>> changes behavior when on topic?
>
>Because you told it to.
>
>      %  cat .git/remotes/origin
>      URL: /repos/git/project
>      Pull: refs/heads/master:refs/heads/origin
>      Pull: refs/heads/topic:refs/heads/topic
>
>It tells "git pull" to drive "git fetch" to copy their master to
>your origin and overwrite your topic with their topic, and then
>merge their master to whatever branch you are currently on.
>
>The sane/safe thing to do in the traditional layout (I'll talk
>about non-traditional one in a second) is:
>
> - do your 'pull' only and always while on your 'master' and not
>   anywhere else.

This I understand, and can follow.  Sorry, but there my comprehension
stops.  Lots of confusion and befuddlement follow.  Thank you in
advance for being patient.

> - never build on a branch that appears on the RHS of ':'.

This I don't quite understand.  So, if it is on the LHS, it is ok?
But, if it is ALSO on the RHS it is not?

So, this:

      Pull: refs/heads/topic:refs/heads/topic

really means don't don't work on a branch named topic in this
repository?

I assume by "build on" you mean "work, compile, check stuff in,
etc."?.  Did you have something else in mind when you said "build on"?

>This layout is convenient when you always do fetches and pulls
>while on 'master', but has burned enough people.  So what people
>on the list seem to recommend is to use a separate remote layout
>in the repository.
>
>The principle is:
>
> * The branches you work on in the repository are kept in refs/heads/
>
> * Copies of branches from other repositories (it does not
>   matter who is in control of them -- some of them may be your
>   repository) are kept in refs/remotes/<symbolic name>.

I don't currently have any 'refs/remotes' of any sort, so I guess you
mean that the new principle, using git clone --use-separate-remote
will effect this.

>So the current "git clone" (if you are using 1.4.4 series, you
>can say "git clone --use-separate-remote") creates something
>like this instead:
>
>      URL: /repos/git/project
>      Pull: refs/heads/master:refs/remotes/origin/master
>      Pull: refs/heads/topic:refs/remotes/origin/topic
>
>(git-clone from 1.5.0 does not actually make remotes/origin file
>in .git/ that has the above -- it creates the moral equivalent
>in .git/config).

So, using 1.4.4 series, or 1.5, the "sane" way to work in git
is to use clone --use-separate-remotes.

>So whatever you do the first step of "git pull", which is "git
>fetch", will _not_ overwrite the current branch.

I assume by this you mean that if I do the separate remote trick, I
will not shoot myself by doing a 'git pull' while on my topic branch,
as the setup will cause git to refuse to do it.

>In order to prevent merging their 'master' into your 'topic'
>when you are on 'topic', git-fetch/git-pull from 1.5.0 uses
>further safety which is left by 'git clone'.  The real
>configuration created by 'git clone' looks like this:
>
>	[remote "origin"]
>        	url = /repos/git/project
>                fetch = refs/heads/*:refs/remotes/origin/*
>	[branch "master"]
>        	remote = origin
>                merge = refs/heads/master
>
>The 'fetch' lines correspond to 'Pull' in .git/remotes/origin file;
>it uses globbing pattern so if there are new branches on the
>remote side you can automatically track them, which is a plus.
>
>But more importantly, when 'fetch' lines only do the globbing
>pattern, 'git pull' without explicitly saying which remote
>branch you want to merge to the current branch (perhaps by
>mistake) refuses to do a merge, if there is no branch.*.merge
>configuration ("refs/heads/master" in the above example).  So
>with the above configuration, 'git pull' from 1.5.0 will fetch
>two remote branches and keep them in remotes/origin/master and
>remotes/origin/topic, and if you are on 'master' their
>refs/heads/master is merged into your current branch, but if you
>are on 'topic', it will not do the merge step (this only applies
>to "git pull" without any refspec parameters).

Ok, so if I am on master, I do this:

[master] % git pull

and this will fetch the remote master and merge it to my master, and
fetch the remote topic and merge it to my local topic.

While, if I am on my topic branch, if I do this:

[topic] % git pull

it sill fetches from the remote master and the remote topic, but will
not merge at all.

Could you verify if I have stated your position correctly?

If I am, this still seems bizarre.  I really just want a way to sync
two repos that works consistently, and is invoked consistently, no
matter what branch I am currently on.  And, again, by "sync", I just
mean no cross-branch merging --- no "crossing of the streams".  Even
if it were limited to syncing the current branch only, that would be
ok, but this variable behavior seems rather odd and confusing.  In
other words, I just want to type the equivalent of 'git sync' and have
it work, and not have to give a branch name, or be in the "right
place" for it to work as I expect.

Thus, I don't want to have to think "oh, I'm on my topic branch, and
if I really want to sync from my remote repo, I need to get on my
master branch".  It seems that the only difference in the "insane" way
I was doing things and the "sane" way you propose is that in my way, I
had to make this mental leap or get burned by a cross-branch merge,
but in the new way, I still have to make this mental leap if I want it
to work, but if I don't, at least I don't get burned.


Bill
