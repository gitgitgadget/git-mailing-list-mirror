From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn intermittent issues with absent_file
Date: Thu, 27 Aug 2009 12:19:02 -0700
Message-ID: <20090827191902.GA3185@dcvr.yhbt.net>
References: <op.uzbs4bsq3myrm3@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@uni-paderborn.de>
X-From: git-owner@vger.kernel.org Thu Aug 27 21:19:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgkV7-0003gh-LQ
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 21:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbZH0TTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 15:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZH0TTD
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 15:19:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43895 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbZH0TTB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 15:19:01 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 751371F5F7;
	Thu, 27 Aug 2009 19:19:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <op.uzbs4bsq3myrm3@balu.cs.uni-paderborn.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127199>

Matthias Andree <matthias.andree@uni-paderborn.de> wrote:
> Greetings,
>
> we seem to have issues with checking out files from an SVN server via  
> https://. The problem is hard to reproduce, and shows as "absent_file"  
> warnings, i. e. files that are in the SVN checkout don't make it to the  
> Git checkin.
>
> Perhaps this rings a bell with someone or there are similar reports that  
> relate to our issues...

Hi Matthias,

I don't recall any issues with the "absent_file" callback ever being
reported to me.  I don't think I've ever touched a repo that triggered
it, either...

> ## ISSUE ## Once in a while, a git-svn clone or rebase fails with files  
> missing from commits, as mentioned above. We haven't been able to figure  
> out under what circumstances this happens. If we try to reproduce this 
> (i. e. kill the directory completely and re-run the git svn clone), 
> another revision (for instance 170) might show this, or the clone may 
> succeed.
>   This was observed with Git 1.6.0.4 under Ubuntu Linux Jaunty Jackalope  
> (9.04) and on a different computer with Git 1.6.4.1.196.g31f0b (from the  
> master branch) under a fully updated Cygwin 1.5.

I assume this happens with the latest git under Ubuntu Linux, too; but
can you give that a try just in case?

There have been a few odd bugs fixed since 1.6.0.4, but nothing rings a
bell here.  This doesn't seem to be a Cygwin/Win32-related issue, but
I'd like to minimize the number of variables since I can't support
Cygwin/Win32 directly.

> Example log of failed data (sorry, we are not allowed to let you access  
> the repository, so we must debug by proxy).
> I'm replacing substrings in the log below to maintain corporate  
> confidentiality levels:
>
> $ git svn clone --no-checkout https://svnserver.example.edu/project/
> Initialized empty Git repository in /tmp/compnet/.git/
> W: +empty_dir: branches
> W: +empty_dir: tags
> W: +empty_dir: trunk
> r1 = a1b0e99e3986da4d8d461944b623b6abb2460de4 (refs/remotes/git-svn)
> ...
> r135 = 294077e62ee5f463b8ab97d961d9742ef89ae662 (refs/remotes/git-svn)
>         A       ... (~100 PDF files)
>       ...
>         A       d1/u1/2009_06/f1.pdf
> W: +empty_dir: d1/u2/slides/2009_06
> W: absent_file: d1/u1/2009_06/d1/u1/2009_06/f2.pdf Insufficient  
> permissions?
> W: absent_file: d1/u3/06_2009/f1/u3/2009_06/f3.pdf Insufficient  
> permissions?
> W: absent_file: d1/u2/slides/2009_06/d1/u2/slides/2009_06/f4.pdf  
> Insufficient permissions?
> r136 = 58523cf1fa867d33a74080dabdcbc85ae0ba99ec (refs/remotes/git-svn)
> ...
> r139 = 2fb1647bc40d3815a5eefb32d43a375e03d2e871 (refs/remotes/git-svn)
> Incomplete data: Delta source ended unexpectedly at  
> /usr/local/libexec/git-core/git-svn line 4605
>
>
> Just re-running "git svn fetch" reproduces the "Incomplete data:" error  
> and aborts, but re-fetching an older version succeeds. No fiddling with  
> permissions needed.
>
>
> ## WORKAROUND ##
>
> If this happens, I can force a checkout with, say, "git checkout -t -b  
> master remotes/git-svn", revert to the last good revision with "git svn  
> reset -r135" (this doesn't work without prior checkout) and then re-run  
> git svn fetch, which will usually succeed then.
>
>
> The three absent_file lines are also recorded in  
> .git/svn/refs/remotes/git-svn/unhandled.log for r136.
>
>
> Questions:
>
> 1. What causes these absent_file issues? How can we assist with debugging 
> this?

Permissions would be my first (and only) guess as I have no experience
with this condition...

Are you using anything weird in ~/.subversion/config by any chance?
And you're sure you're using the same user/account in all cases?

Are the files you're hitting absent_file on unusually large and
hitting some limit on the server side?

> 2. What does "Delta source ended unexpectedly" mean? (the line number is  
> bogus, it's just the finish_report call)

Sometimes the server can just shut down/drop connections.  Do you have
access to the server logs?  How many simultaneous connections can
it accept?  Which version of the Subversion server is running?
How reliable is your network connection to the server?

Anything weird with the network configuration?  Mismatched MTU, odd
firewall rules, non-standard TCP stack configuration, VPN, proxies...

> 3. Is this or a similar issue known? Is this an issue with the SVN 
> server, the SVN bindings, or the git svn adaptor?

The "Incomplete data: Delta source ended unexpectedly" happens
from time to time on a few odd servers, but I've never found it
reproducible and retrying "git svn fetch" always fixes it.
This is more than likely the fault of the network or server.

The "absent_file" issue I've never seen...

> 4. How can we avoid or fix this?

Other than your workaround, I don't know...

> We're happy to test patches.

Cool.  I don't have any ideas for patches right now, but does this
problem happen with other SVN clients?  Even svk/svm could be
worth a shot for testing...

-- 
Eric Won
