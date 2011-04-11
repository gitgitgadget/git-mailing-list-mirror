From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Sun, 10 Apr 2011 21:16:44 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1104102028240.14365@iabervon.org>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com> <20110410194739.GC28163@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 03:16:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q95kL-0002NA-3F
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 03:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663Ab1DKBQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 21:16:47 -0400
Received: from iabervon.org ([66.92.72.58]:43915 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab1DKBQq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 21:16:46 -0400
Received: (qmail 4575 invoked by uid 1000); 11 Apr 2011 01:16:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Apr 2011 01:16:44 -0000
In-Reply-To: <20110410194739.GC28163@elie>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171300>

On Sun, 10 Apr 2011, Jonathan Nieder wrote:

> > 3. From the format of the TODO and DONE files, one more thing should
> > be clear- I'm trying to stick to a slight variation of the 'rebase -i'
> > format.  This part will go into the sequencer.  Then I'll use a
> > cherry-pick specific file to keep the command-line options.  Yes, I'm
> > trying to work on Daniel's idea [3] from the very start.  Is this a
> > good idea?
> 
> This is still bouncing in my head.  I think I like it --- is the idea
> that some day you could put commands like
> 
> 	am topic.mbox
> 
> in your insn sheet, or do nested rebases with a --force-nested option?
> That does sound useful.  How would one request "skip to the next
> operation in the outer rebase" on the command line?  This is starting
> to feel like a debugger.

The most basic idea is that, in the case of a rebase where a patch fails 
to apply, there are actually two levels of operation that have to be 
deferred until after the human intervention: making the commit where the 
pick failed, and applying further patches. If there are going to be 
multiple higher-level operations (e.g., rebase and rebase -i), they should 
be able to share the completion of the pick operation, and a basic "git 
cherry-pick <sha1>" ought to be able to share it, too, so you can finish 
that up without having to remember what the command is. People should be 
able to implement custom higher-level operations (e.g., "cherry-pick all 
the commits attached to bugs in bugzilla that block the release tracker" 
or something), they should be able to rely on library code that knows how 
to finish the conflicted cherry-pick. (Another interesting example might 
be "reconstruct the linux-next tree", which is a series of merges, and 
which should have --continue share the post-intervention code from the 
single merge process before going on to do the custom higher-level thing.)

My feeling is that "--skip" is actually "abort the pick, but continue the 
rebase". I suppose there could be more than two levels, and people could 
want to skip a higher-level chunk, but that's something to get to when 
someone actually wants it; we've obviously already got the two-level 
situation now, so we can implement that.

	-Daniel
*This .sig left intentionally blank*
