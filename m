From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn: Supporting multiple branch subdirs?
Date: Wed, 17 Jun 2009 16:25:50 +0200
Message-ID: <4A38FCEE.2020002@drmicha.warpmail.net>
References: <4A32CCA5.7040404@xiplink.com> <4A339182.1090204@drmicha.warpmail.net> <4A368509.9070801@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, normalperson@yhbt.net
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 16:26:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGw62-0000Sp-PU
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 16:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762208AbZFQO0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 10:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758316AbZFQO0M
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 10:26:12 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43631 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755543AbZFQO0L (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 10:26:11 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id CDCC33626DD;
	Wed, 17 Jun 2009 10:26:12 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 17 Jun 2009 10:26:12 -0400
X-Sasl-enc: cDZFWN+Mw6tlisksMBBTWyWb5v7zlW0LchXmUX/xOnFY 1245248772
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0E1933CEBE;
	Wed, 17 Jun 2009 10:26:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090617 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A368509.9070801@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121749>

Marc Branchaud venit, vidit, dixit 15.06.2009 19:29:
> Michael J Gruber wrote:
>>
>> After doing the init with "--branches=stable" (without releng), do
>> git config --add svn-remote.svn.branches 'releng/*:refs/remotes/*'
>>
>> This gives you two branches refspecs in .git/config (feel free to put
>> them in different dirs under remotes if there may be name clashes
>> between stable and releng branches).
> 
> That doesn't seem to work...

No, it doesn't I'm sorry. I knew that git-svn lumps multiple command
line arguments into one, but it does so also for config lines. I didn't
know that but confirmed from a test (and the source).

Now, one last resort would be a more complicated regexp. Unfortunately,
something like

branches = (releng|stable)/*:refs/remotes/*/*

does not work (regexps don't work, only globs)

and something like

branches = */*:refs/remotes/*/*

works in principle but gets everything under head wrong.

> 
> Here's my .git/config file before the first fetch:
> 
> [svn-remote "svn"]
>         useSvnsyncProps = 1
>         ignore-paths = ^[^/]+/(?:cvs2svn|projects|svnadmin|user|vendor.*)
>         url = file:///home/marcnarc/Code/FreeBSD-all-mirror/base
>         fetch = head:refs/remotes/trunk
>         branches = stable/*:refs/remotes/stable/*
>         branches = releng/*:refs/remotes/releng/*
>         tags = release/*:refs/remotes/tags/*
> 
> (Shouldn't that fetch line be head:refs/remots/head, since there's nothing called "trunk" in the svn repo?  I used git-svn init --trunk=head ...)

The left hand side of the refspec refers to the svn repo, the right hand
side only names your local ref. Feel free to put "head" there, although
this can be confused very easily with "HEAD" which has special meaning
in git.

>> I assume that git-svn converts such an svn commit into several git
>> commits, one for each affected branch. Since you have a local mirror
>> it's easy to try out.
> 
> Yep, git-svn does just that.  Nice!
> 
> 		M.

At least I got one thing right :)

I've used multiple svn-remote sections before (in cases where the repo
structure changed) but I'm afraid this is of no use here. Looking at the
source of git-svn, one sees that "tags" and "branches" are basically
treated the same way, they are simply members of a "remote"
struct/object/whatever it's called in perl and only differ in their
standard refspec. Noone keeps us from adding "branches2" for a quick
hack and checking whether everything stays sane... (git-svn perl often
loops over "branches tags", that needs to be replaced).

In fact, I think the way to go would be replacing the two by an array.
As a next step, the command line parsing and config reading needs to be
changed so that multiple branches or tags entries end up generating
multiple members of that array. Now this only needs to be implemented ;)

Michael

P.S.: Let me know if you give it a shot, so that we don't duplicate our
waste of time...
