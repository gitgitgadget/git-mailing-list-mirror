From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Again with git-svn: File was not found in commit
Date: Sat, 25 Apr 2009 18:53:00 -0700
Message-ID: <20090426015300.GA17212@dcvr.yhbt.net>
References: <747CFDA3-AC27-44EB-A69C-BF9C29B05A31@kineticode.com> <20090421180231.GB16642@dcvr.yhbt.net> <8EDD65AC-9C25-4281-86F6-E52A41331B00@kineticode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David E. Wheeler" <david@kineticode.com>
X-From: git-owner@vger.kernel.org Sun Apr 26 04:02:12 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxtgZ-0005Sz-0T
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 04:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbZDZBxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 21:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbZDZBxD
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 21:53:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34100 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbZDZBxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 21:53:01 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C8511F79E;
	Sun, 26 Apr 2009 01:53:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8EDD65AC-9C25-4281-86F6-E52A41331B00@kineticode.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117581>

"David E. Wheeler" <david@kineticode.com> wrote:
> On Apr 21, 2009, at 11:02 AM, Eric Wong wrote:
>
>>>    bricolage/branches/rev_1_8/lib/Bric/App/ApacheConfig.pm was not
>>> found in commit
>>>    e5145931069a511e98a087d4cb1a8bb75f43f899 (r5256)
>>>
>>> This seemed strange to me, so I had a look at SVN:
>>>
>>>    svn list -r5256 http://svn.bricolage.cc/bricolage/branches/rev_1_8/lib/Bric/App/ApacheConfig.pm
>>>    ApacheConfig.pm
>>>
>>> So the file *is* there in that revision. I had been running 1.6.1.2, 
>>> so I
>>> upgraded to 1.6.2.2 and ran `git svn fetch` again to see if it would 
>>> pick
>>> up where it left off, but it returned the same error (please don't  
>>> tell
>>> me I have to start over!).
>>
>> Interesting.  I finally managed to reproduce it over the weekend.   
>> I'll
>> try to look into it later tonight.
>
> Thanks, appreciate it. I've gotten around it by going back to the old  
> CVS repository on SourceForge and migrating that, and then migrating the 
> SVN repo only from after we moved to SVN. Then I'll just have to stitch 
> the CVS and SVN migrations together and I'll be done.

Hopefully the workaround is working out for you.

The problem with r5256 is quite nasty and I can't think of a good
automated solution right now involving --stdlayout/branches/tags

------------------------------------------------------------------------
r5256 | theory | 2004-05-09 19:17:49 -0700 (Sun, 09 May 2004) | 2 lines
Changed paths:
   A /bricolage/branches/rev_1_8 (from /bricolage/branches/rev_1_8_temp/bricolage:5255)
   D /bricolage/branches/rev_1_8_temp/bricolage

Permanent home.

------------------------------------------------------------------------

The problem is that the "bricolage" subdirectory became the top-level
tree and git-svn doesn't have a way of detecting that.  This is
occasionally a problem with other repos, too

Overall, this repo is very nasty given the amount of times follow-parent
needs to be used (refs with a "@<revno>" suffix).  The --stdlayout
switch is really for the common repositories with a consistent depth for
branches/tags.  Unfortunately, SVN is way too freeform in this regard
and mixed-depth branches/tags hierarchies have always been a problem :<

It might be a bit easier to write (or script) the "fetch" lines
(like the one --stdlayout generates for trunk) for each tag/branch
and maybe use --no-follow-parent.

-- 
Eric Wong
