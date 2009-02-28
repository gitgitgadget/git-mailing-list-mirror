From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn and repository hierarchy?
Date: Sat, 28 Feb 2009 18:59:22 +0100
Message-ID: <49A97B7A.8010005@drmicha.warpmail.net>
References: <20090224223412.GA4573@raven.wolf.lan> <49A50EB2.80300@drmicha.warpmail.net> <20090227171248.GB14187@raven.wolf.lan> <49A826C8.1060300@drmicha.warpmail.net> <20090227220512.GC14187@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 19:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdTUn-0007Ck-QR
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 19:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbZB1R7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 12:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbZB1R7f
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 12:59:35 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53440 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752749AbZB1R7e (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 12:59:34 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 693F12CB582;
	Sat, 28 Feb 2009 12:59:31 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 28 Feb 2009 12:59:31 -0500
X-Sasl-enc: oL1L8Sifx0VG25sETfi46UGnWWIa4dD/HhuSDojBWxlQ 1235843970
Received: from localhost.localdomain (p4FC60B84.dip0.t-ipconnect.de [79.198.11.132])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 519B423505;
	Sat, 28 Feb 2009 12:59:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090227 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090227220512.GC14187@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111782>

Josef Wolf venit, vidit, dixit 27.02.2009 23:05:
> Thanks for your patience, Michael!
> 
> On Fri, Feb 27, 2009 at 06:45:44PM +0100, Michael J Gruber wrote:
>> Josef Wolf venit, vidit, dixit 27.02.2009 18:12:
>>> On Wed, Feb 25, 2009 at 10:26:10AM +0100, Michael J Gruber wrote:
>>>> Josef Wolf venit, vidit, dixit 24.02.2009 23:34:
> 
> [ ... ]
>>>   (cd git-svn-repos; git pull ../clone1)
>> Gives you 1-2-3-4
>>
>>>   (cd git-svn-repos; git svn rebase)
>> Does nothing here (but is good practice)
>>
>>>   (cd git-svn-repos; git svn dcommit)
>> Creates 2-3-4 on the svn side. *Then rebases* your master, which creates
>> 1-2'-3'-4' on master. Note that 2 is different from 2' (git-svn id).
> 
> So the sha1 is not preserved when it goes through svn?

No. Once your commits come back from svn through git-svn they have an
additional line in the commit. Also, the commit time time will be
different, and the author name might be depending on your name remapping.

The patch-id (which only looks at the actual diff being introduced)
should be the same.

>>>   (cd git-svn-repos; git pull ../clone1)  # if this line is executed,
>> That's the problem. This creates a merge after which you 1-2-3-4 and
>> 1-2'-3'-4' plus the merge of 4 and 4'.
> 
> --verbosity=on please ;-)

No such option "--verbosity". ;)

Uhm, I'm just not good at diagramms in ascii. You had 1-2-3-4 in
git-svn-repo. 2, 3 and 4 were dcommit to svn and came back as 2', 3',
4', such that git-svn rebased your master branch in git-svn-repo and
master looked like 1-2'-3'-4'. The primed version are the one with an
additional git-svn-id line in the commit: different sha1 from the
unprimed version, same patch-id.

Now, if you say pull ../clone1, you fetch from there and merges
FETCH_HEAD, i.e. the tip of ../clone1, which is 4. So you get

1-2'-3'-4'-o
 \        /
  2 -3 -4

with o being the tip (HEAD) of master. And that is the problem, because
no history is not linear in master, and the next git-svn dcommit won't
know what to do.

>> Instead, use git pull --rebase here. You don't want merges in the branch
>> from which you dcommit.
> 
> Yeah, "pull --rebase" seems to help a lot.  So I've come up with the next
> version of my workflow-test-script:
> 
> (
>   set -ex
> 
>   # create test directory
>   #
>   TESTDIR=`mktemp --tmpdir=. git-svn-hierarchy-test-XXXXXXXX`
>   rm -rf $TESTDIR
>   mkdir -p $TESTDIR
>   cd $TESTDIR
> 
>   SUBVERSION_REPOS=file://`pwd`/subversion-repos
> 
>   # create subversion repos with some history
>   #
>   svnadmin create subversion-repos
>   svn -m "create standard layout" mkdir \
>       $SUBVERSION_REPOS/trunk \
>       $SUBVERSION_REPOS/branches \
>       $SUBVERSION_REPOS/tags
>   svn co $SUBVERSION_REPOS/trunk subversion-wc
>   echo change1 >>subversion-wc/test
>   svn add subversion-wc/test
>   svn ci -m "commit 0" subversion-wc
> 
>   # create git-svn-repos
>   #
>   git svn init --stdlayout $SUBVERSION_REPOS git-svn-repos
>   (cd git-svn-repos; git svn fetch)
> 
>   # create clones
>   #
>   git clone git-svn-repos clone1
>   git clone git-svn-repos clone2
>   git clone git-svn-repos clone3
> 
>   # now go several times to every clone, do some work on it, and sync
>   # the results
>   #
>   for cycle in 1 2 3; do
>     for clone in 1 2 3; do
>       for commit in 1 2 3; do
>         (
>           cd clone$clone
>           git pull --rebase
>           echo change $clone $commit >>test
>           git commit -a -m "commit $clone $commit"
>         )
>       done
>       (cd git-svn-repos; git pull --rebase ../clone$clone)
>       (cd git-svn-repos; git svn rebase)
>       (cd git-svn-repos; git svn dcommit)
>     done
>   done
> )
> 
> At least, this seems to not creating collisions any more.  But I'm still
> not sure I fully understand what's going on here.  Guess, I'll have to
> get into the learning-by-doing mode :)

Yes, be sure to check the DAG (the graph of commits which you produced)
using something like gitk or git log --graph with the "--all" argument
so that you see all branches!

>> Borrowing from some other vcs:
>>
>> Repeat the soothing mantra: a merge is no merge is no merge - it it's in
>> svn ;)
> 
> Huh?

I meant "if it's", sorry for the typo.
If you don't get the plug don't worry (or look up hg) ;)

>>> Obviously, I'm doing something wrong.  But I can't figure what.  Any hints?
>> I guess when we said integrated we should have said rebase. Haven't we?
> 
> You like to talk in riddles? Aren't you?

No, I'm not ;)

Michael
