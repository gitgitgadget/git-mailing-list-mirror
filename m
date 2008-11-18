From: Andreas Ericsson <ae@op5.se>
Subject: Re: git tree browsing in redmine
Date: Tue, 18 Nov 2008 09:02:01 +0100
Message-ID: <49227679.7010709@op5.se>
References: <b8f2e1780811172034w6828ddc8n62cf85b5fa366e22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Burt Culver <burt@fishpond.co.nz>
X-From: git-owner@vger.kernel.org Tue Nov 18 09:03:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2LYP-0005xh-QT
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 09:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbYKRICH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 03:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbYKRICG
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 03:02:06 -0500
Received: from mail.op5.se ([193.201.96.20]:38725 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbYKRICE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 03:02:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B86041B8116A;
	Tue, 18 Nov 2008 08:56:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jDZcpAHjcB1; Tue, 18 Nov 2008 08:56:54 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 2DDE31B81169;
	Tue, 18 Nov 2008 08:56:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <b8f2e1780811172034w6828ddc8n62cf85b5fa366e22@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101264>

Burt Culver wrote:
> Hi,
> 
> I'm trying to find some ideas for a better way to implement browsing
> of a git repository within the redmine application.
> 
> My top level directory in my git repository has 300 files. Redmine
> wants to display each file name, its most recent revision, and the
> comment for that revision. Currently it does a git log -1 on each file
> to find the latest revision.  Is there a quicker way of doing this for
> a whole directory?

Not yet, but if you clone libgit2 and start helping out on that, things
like this will become fairly trivial to do in a single pass instead of,
as redmine does it today, using one call to "git log" for every file in
the directory (which is just insane).

You should be aware that git is fully snapshot based though, while svn
is file-revision based (a bunch of file-revisions make up a "changeset"),
so it's fundamentally easy to get the file-revisions for a particular
changeset in svn and fundamentally hard to get it in git.

>  git log runs from .2 seconds to 3 seconds
> depending on the file on my server.
> 

That's because the command used by redmine ("git log <cruft> -1 -- $path")
stops as soon as it finds the first commit that touches the path. Some
paths haven't been touched in a long time, so more revisions have to
be loaded, parsed, analyzed and discarded before the correct one is
found.

> Here is the open issue at redmine.org which has more details:
> http://www.redmine.org/issues/show/1435
> 
> A fix for this would help a whole bunch of redmine / git users including myself.
> 

I have no idea what redmine is, but one solution for them would be to
run "git log --pretty=fuller -p $branch" and then parse the diffs to get
the latest commit that touched all files (in one go). This would be
slightly slower for small repos (where it shouldn't matter anyway), but
time should increase linearly with the number of commits in the repository.
It's almost certainly required to be able to turn this feature off, btw,
as it won't work at all for super-huge repositories (think kde or OO.org).

You should also make sure to have your repository properly packed. Run
"git gc" on it every once in a while.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
