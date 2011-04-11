From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Mon, 11 Apr 2011 01:30:20 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1104110031530.14365@iabervon.org>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com> <201104110518.04413.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 07:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q99hj-0006Zd-Lu
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 07:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab1DKFaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 01:30:22 -0400
Received: from iabervon.org ([66.92.72.58]:54731 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144Ab1DKFaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 01:30:22 -0400
Received: (qmail 25698 invoked by uid 1000); 11 Apr 2011 05:30:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Apr 2011 05:30:20 -0000
In-Reply-To: <201104110518.04413.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171304>

On Mon, 11 Apr 2011, Christian Couder wrote:

> > 3. From the format of the TODO and DONE files, one more thing should
> > be clear- I'm trying to stick to a slight variation of the 'rebase -i'
> > format.  This part will go into the sequencer.  Then I'll use a
> > cherry-pick specific file to keep the command-line options.  Yes, I'm
> > trying to work on Daniel's idea [3] from the very start.  Is this a
> > good idea?
> 
> I think that the TODO and DONE file format will need at one point to include 
> options and it is simpler if this change is done early. Using a cherry-pick 
> specific file to keep the options is not very generic for a sequencer that could 
> be used for many things.

My idea is that cherry-pick (or merge, or whatever) would have its own 
state to store what it was trying to do when it got a conflict. This is to 
enable the cherry-pick (etc) to complete without needing to know anything 
about what called it. The sequencer's information would keep track of 
what was left to do, what was already complete, and how to abort the whole 
sequence.

It would be nice to get the following commands to work:

$ git cherry-pick <sha1>
Automatic cherry-pick failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' or 'git rm <paths>' and 
run 'git continue'
$ (resolve conflicts)
$ git continue
Finished one cherry-pick.
[master sha1b] Subject
 2 files changes, 2 insertions(+)

And, of course, if this happened as a step in a rebase, the rebase would 
continue after the cherry-pick finished. But it's annoying that, in order 
to finish a conflicted "git cherry-pick <branch>", you currently need to 
go back and find the instruction that says to commit it yourself, with the 
option "-c <sha1>" to retain authorship and message. And if you want to 
abort it, you need to remember "git reset --hard HEAD" (and maybe you also 
want "git rerere clear"). That's what cherry-pick should be keeping its 
own state for. This is also parallel to how "merge" works, with its 
information kept in private state files, including some things like the 
list of files that had conflicts which isn't trivial to reproduce after 
the user has resolved them.

	-Daniel
*This .sig left intentionally blank*
