From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git rescue mission
Date: Thu, 08 Feb 2007 16:56:06 +0100
Organization: At home
Message-ID: <eqfh3l$unn$1@sea.gmane.org>
References: <17866.27739.701406.722074@lisa.zopyra.com> <7vr6t13251.fsf@assigned-by-dhcp.cox.net> <17867.16740.875694.789664@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 16:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFBdU-0004x9-VW
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 16:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423106AbXBHP4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 10:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423111AbXBHP4d
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 10:56:33 -0500
Received: from main.gmane.org ([80.91.229.2]:54933 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423106AbXBHP4c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 10:56:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFBcc-0000kv-D9
	for git@vger.kernel.org; Thu, 08 Feb 2007 16:55:42 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 16:55:42 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 16:55:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39060>

Bill Lear wrote:
> On Wednesday, February 7, 2007 at 16:48:42 (-0800) Junio C Hamano writes:
>> Bill Lear <rael@zopyra.com> writes:
>>
>>> 2) Why does git pull do the right thing when on master, but seemingly
>>> changes behavior when on topic?
>>
>> Because you told it to.
>>
>>      %  cat .git/remotes/origin
>>      URL: /repos/git/project
>>      Pull: refs/heads/master:refs/heads/origin
>>      Pull: refs/heads/topic:refs/heads/topic
>>
>> It tells "git pull" to drive "git fetch" to copy their master to
>> your origin and overwrite your topic with their topic, and then
>> merge their master to whatever branch you are currently on.
>>
>> The sane/safe thing to do in the traditional layout (I'll talk
>> about non-traditional one in a second) is:
>>
>> - do your 'pull' only and always while on your 'master' and not
>>   anywhere else.
> 
> This I understand, and can follow.  Sorry, but there my comprehension
> stops.  Lots of confusion and befuddlement follow.  Thank you in
> advance for being patient.
> 
>> - never build on a branch that appears on the RHS of ':'.
> 
> This I don't quite understand.  So, if it is on the LHS, it is ok?
> But, if it is ALSO on the RHS it is not?

RHS = right hand side (of refspec). You should not "build" on branches
which appear on the right hand side of ':' in the "Pull:" lines, in
this example they are 'origin' and 'topic'.

> So, this:
> 
>       Pull: refs/heads/topic:refs/heads/topic
> 
> really means don't don't work on a branch named topic in this
> repository?

Yes, with this line you should not work on a branch named 'topic';
otherwise badness might follow.

> I assume by "build on" you mean "work, compile, check stuff in,
> etc."?.  Did you have something else in mind when you said "build on"?

By "build on" we mean build in SCM (in version control) sense, i.e.
adding commits on top of given branch (committing when on given branch).
Well, also do not rewind the branch (reset, rebase,...).

>> This layout is convenient when you always do fetches and pulls
>> while on 'master', but has burned enough people.  So what people
>> on the list seem to recommend is to use a separate remote layout
>> in the repository.
>>
>> The principle is:
>>
>>  * The branches you work on in the repository are kept in refs/heads/
>>
>>  * Copies of branches from other repositories (it does not
>>    matter who is in control of them -- some of them may be your
>>    repository) are kept in refs/remotes/<symbolic name>.
> 
> I don't currently have any 'refs/remotes' of any sort, so I guess you
> mean that the new principle, using git clone --use-separate-remote
> will effect this.

In git 1.4.4 series, "git clone --use-separate-remote"; in git 1.5.0
this layout is default when making non-bare clone (the only layout,
I think; were --use-separate-remote and --no-separate-remote removed,
or only removed from Documentation, by the way? this affects backwards
compatibility a bit).

>> So the current "git clone" (if you are using 1.4.4 series, you
>> can say "git clone --use-separate-remote") creates something
>> like this instead:
>>
>>      URL: /repos/git/project
>>      Pull: refs/heads/master:refs/remotes/origin/master
>>      Pull: refs/heads/topic:refs/remotes/origin/topic
>>
>> (git-clone from 1.5.0 does not actually make remotes/origin file
>> in .git/ that has the above -- it creates the moral equivalent
>> in .git/config).
> 
> So, using 1.4.4 series, or 1.5, the "sane" way to work in git
> is to use clone --use-separate-remotes.
> 
>> So whatever you do the first step of "git pull", which is "git
>> fetch", will _not_ overwrite the current branch.
> 
> I assume by this you mean that if I do the separate remote trick, I
> will not shoot myself by doing a 'git pull' while on my topic branch,
> as the setup will cause git to refuse to do it.

You would _never_ shoot yourself in foot doing "git fetch".

"git pull" would refuse merge wwhen not on correct branch only if you
use new 1.5.0 globbing (as described below).

But it is fairly easy to recover from errorneous pull. 
"git reset --hard" should be enough (if fetch screwed something
"git reset --hard ORIG_HEAD" should be enough).

>> In order to prevent merging their 'master' into your 'topic'
>> when you are on 'topic', git-fetch/git-pull from 1.5.0 uses
>> further safety which is left by 'git clone'.  The real
>> configuration created by 'git clone' looks like this:
>>
>>      [remote "origin"]
>>              url   = /repos/git/project
>>              fetch = refs/heads/*:refs/remotes/origin/*
>>      [branch "master"]
>>              remote = origin
>>              merge  = refs/heads/master
>>
>> The 'fetch' lines correspond to 'Pull' in .git/remotes/origin file;
>> it uses globbing pattern so if there are new branches on the
>> remote side you can automatically track them, which is a plus.
>>
>> But more importantly, when 'fetch' lines only do the globbing
>> pattern, 'git pull' without explicitly saying which remote
>> branch you want to merge to the current branch (perhaps by
>> mistake) refuses to do a merge, if there is no branch.*.merge
>> configuration ("refs/heads/master" in the above example).  So
>> with the above configuration, 'git pull' from 1.5.0 will fetch
>> two remote branches and keep them in remotes/origin/master and
>> remotes/origin/topic, and if you are on 'master' their
>> refs/heads/master is merged into your current branch, but if you
>> are on 'topic', it will not do the merge step (this only applies
>> to "git pull" without any refspec parameters).

We assume for later discussion that we use git 1.5.0 (well, 1.5.0-rc4)
in the situation below.

> Ok, so if I am on master, I do this:
> 
> [master] % git pull
> 
> and this will fetch the remote master and merge it to my master, and
> fetch the remote topic and merge it to my local topic.

This would fetch remote master (refs/heads/master) into your local
tracking branch origin/master (refs/remotes/origin/master), and fetch
remote topic into origin/topic. Then it would merge remote master
(which is equivalent to merging local origin/master) into your local
master branch.

> While, if I am on my topic branch, if I do this:
> 
> [topic] % git pull
> 
> it sill fetches from the remote master and the remote topic, but will
> not merge at all.

True, it would fetch but refuse to merge.

> If I am, this still seems bizarre.  I really just want a way to sync
> two repos that works consistently, and is invoked consistently, no
> matter what branch I am currently on.  And, again, by "sync", I just
> mean no cross-branch merging --- no "crossing of the streams".  Even
> if it were limited to syncing the current branch only, that would be
> ok, but this variable behavior seems rather odd and confusing.  In
> other words, I just want to type the equivalent of 'git sync' and have
> it work, and not have to give a branch name, or be in the "right
> place" for it to work as I expect.

"Crossing of the streams" is _required_ if you do parallel work. If you
work only on one repository or the other, never doing parallel work, it
would be easier to just use 1:1 mapping (like in bare repository), and
use only "git fetch" and "git push".
 
If you do parallel work (well, unless you send changes via patches), then
you have to do merges. BTW git would detect if only one side made any
changes: this would result in so called fast-forward case, and no true
merge at all.

BTW. what had happened to git merge strategy "subordinate" (later renamed to
more proper "rebase" strategy)?

> Thus, I don't want to have to think "oh, I'm on my topic branch, and
> if I really want to sync from my remote repo, I need to get on my
> master branch".  It seems that the only difference in the "insane" way
> I was doing things and the "sane" way you propose is that in my way, I
> had to make this mental leap or get burned by a cross-branch merge,
> but in the new way, I still have to make this mental leap if I want it
> to work, but if I don't, at least I don't get burned.

Parallel distributed development is intrinsically difficult, but also much
more elastic than rigid centralized CVS-like development.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
