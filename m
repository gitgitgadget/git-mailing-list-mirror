From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn and repository hierarchy?
Date: Fri, 27 Feb 2009 18:45:44 +0100
Message-ID: <49A826C8.1060300@drmicha.warpmail.net>
References: <20090224223412.GA4573@raven.wolf.lan> <49A50EB2.80300@drmicha.warpmail.net> <20090227171248.GB14187@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 18:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld6o4-0007jf-Pe
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 18:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbZB0Rpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 12:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbZB0Rpy
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 12:45:54 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39741 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752464AbZB0Rpy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 12:45:54 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 127C82A5FFF;
	Fri, 27 Feb 2009 12:45:52 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 27 Feb 2009 12:45:52 -0500
X-Sasl-enc: F+hxexmEw5+RLd1m72bs8Du6E2oYKvYeQJbiz1chnR2q 1235756751
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7BB31229DB;
	Fri, 27 Feb 2009 12:45:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090227 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090227171248.GB14187@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111688>

Josef Wolf venit, vidit, dixit 27.02.2009 18:12:
> On Wed, Feb 25, 2009 at 10:26:10AM +0100, Michael J Gruber wrote:
>> Josef Wolf venit, vidit, dixit 24.02.2009 23:34:
> 
>>> I have set up a repository hierarchy like this:
>>>
>>>
>>>          subversion-repos
>>>                 |
>>>            git-svn-repos
>>>           /     |     \
>>>       clone1  clone2  clone3
>> Recent enough git should even warn you against doing that, "that" being
>> pushing into checked out branches.
> 
> I've now tried to synchronize via pull instead of push, but I still
> get conflicts.
> 
>> Your diagram above is missing important info, namely which branches you
>> are pushing into. But the problem indicates that you are pushing into a
>> checked out branch.
> 
> In order to get a better understanding what's going on, I've written a
> small script which can be copy-pasted into some terminal window:
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
>   svn ci -m "commit 1" subversion-wc
> 
>   # create git-svn-repos
>   #
>   git svn init --stdlayout $SUBVERSION_REPOS git-svn-repos
>   (cd git-svn-repos; git svn fetch)
> 
>   # create a clone and do some work on it
>   #
>   git clone git-svn-repos clone1
>   for i in 2 3 4; do
>     ( cd clone1; echo change$i >>test ; git commit -a -m "commit $i")
>   done
> 
>   (cd git-svn-repos; git pull ../clone1)

Gives you 1-2-3-4

>   (cd git-svn-repos; git svn rebase)

Does nothing here (but is good practice)

>   (cd git-svn-repos; git svn dcommit)

Creates 2-3-4 on the svn side. *Then rebases* your master, which creates
1-2'-3'-4' on master. Note that 2 is different from 2' (git-svn id).

>   (cd git-svn-repos; git pull ../clone1)  # if this line is executed,

That's the problem. This creates a merge after which you 1-2-3-4 and
1-2'-3'-4' plus the merge of 4 and 4'.

Instead, use git pull --rebase here. You don't want merges in the branch
from which you dcommit.

Borrowing from some other vcs:

Repeat the soothing mantra: a merge is no merge is no merge - it it's in
svn ;)

>   (cd git-svn-repos; git svn rebase)      # this command gives the conflict
> )
> 
> When I comment out the second "git pull ../clone1", the conflict does
> not happen on the last "git svn rebase", but on some later pull, rebase
> or dcommit command.
> 
> Obviously, I'm doing something wrong.  But I can't figure what.  Any hints?

I guess when we said integrated we should have said rebase. Haven't we?

Cheers,
Michael
