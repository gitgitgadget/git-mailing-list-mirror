From: Jeff Licquia <jeff@licquia.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 18:13:36 -0400
Message-ID: <1161382416.9241.19.camel@localhost.localdomain>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	 <200610201821.34712.jnareb@gmail.com>
	 <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
	 <Pine.LNX.4.64.0610201133260.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jan Hudec <bulb@ucw.cz>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 00:13:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb2ci-0003kW-5I
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 00:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992867AbWJTWNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 18:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWJTWNq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 18:13:46 -0400
Received: from jeffindy.licquia.org ([216.37.46.185]:8583 "EHLO
	jeffindy.licquia.org") by vger.kernel.org with ESMTP
	id S1422748AbWJTWNp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 18:13:45 -0400
Received: from server1.internal.licquia.org (unknown [192.168.50.3])
	by jeffindy.licquia.org (Postfix) with ESMTP id F159B6FD88;
	Fri, 20 Oct 2006 18:13:43 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.52.6])
	by server1.internal.licquia.org (Postfix) with ESMTP id 50171980DA;
	Fri, 20 Oct 2006 18:13:38 -0400 (EDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 55D434E4025; Fri, 20 Oct 2006 18:13:37 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201133260.3962@g5.osdl.org>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29544>

On Fri, 2006-10-20 at 11:48 -0700, Linus Torvalds wrote:
> Here's a real-life schenario that we hit several times with BK over the 
> years:
> 
>  - take a real repository, and a patch that gets discussed that adds a new 
>    file.
>  - take two different people applying that patch to their trees (or, do 
>    the equivalent thing, which is to just create the same filename
>    independently, because the solution is obvious - and the same - to 
>    both developers).
>  - now, have somebody merge both of those two peoples trees (eg me)
>  - have the two people continue to use their trees, modifying it, and 
>    getting merged.
> 
> Trust me, this isn't even _unlikely_. It happens. And it's a serious 
> problem for a file-ID case. Why? Because you have two different file ID's 
> for the same pathname. 

I tried this to see what bzr would do.  Here's the critical point where
the first merges are done ("a" is mainline, "b" and "c" are external
branches being merged into "a").

---
jeff@lsblap:~/tmp/linus-file-id/a$ bzr pull ../b
All changes applied successfully.
1 revision(s) pulled.
jeff@lsblap:~/tmp/linus-file-id/a$ bzr pull ../c
bzr: ERROR: These branches have diverged.  Use the merge command to reconcile them.
jeff@lsblap:~/tmp/linus-file-id/a$ bzr merge ../c
Conflict adding file file2.  Moved existing file to file2.moved.
1 conflicts encountered.
jeff@lsblap:~/tmp/linus-file-id/a$ bzr status
added:
  file2
renamed:
  file2 => file2.moved
conflicts:
  Conflict adding file file2.  Moved existing file to file2.moved.
pending merges:
  Jeff Licquia 2006-10-20 commit c of file2
---

file2 and file2.moved have identical contents at this point.  I fixed it
by deleting file2.moved, "bzr resolve file2", and committing.

After this conflict is resolved, merging from b causes conflicts, while
merging from c appears to work fine.  This continues until b merges from
a (and resolves a conflict in a similar manner to a), at which time
merging/pulling works as you'd expect between the branches.  Whenever b
is marked as conflicting before it merges from a, bzr preserves b's
changes by moving b's modified file.

All in all, not ideal, but it seems bzr handles this better than bk.
Certainly, bzr doesn't silently drop anyone's changes, at least.  I
suspect that bzr could improve its handling of this use case, but not,
I'm sure, to Linus's specifications; some of the fun and games does seem
to come from the use of file IDs.
