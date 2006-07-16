From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git merge performance problem..
Date: Sat, 15 Jul 2006 21:43:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607152136010.2438@evo.osdl.org>
References: <Pine.LNX.4.64.0607151445270.5623@g5.osdl.org>
 <7v7j2eme3u.fsf@assigned-by-dhcp.cox.net> <7vlkqukwhb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 16 06:42:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1ySo-0004y3-RO
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 06:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWGPEmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 00:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWGPEmY
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 00:42:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964834AbWGPEmY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jul 2006 00:42:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6G4gKnW007523
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 15 Jul 2006 21:42:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6G4gJPk018628;
	Sat, 15 Jul 2006 21:42:20 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkqukwhb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.641 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23945>



On Sat, 15 Jul 2006, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> >
> > The code is to cull redundant parents primarily in octopus and
> > is not strictly necessary.
> 
> Wrong.  The commit log says it was to remove redundant parents;
> I think this as a reaction after seeing a few incorrectly made
> merge commits in the kernel archive.

Arguing with yourself? ;)

But that should already have been handled by the fact that we did the 
merge-base improvements. So I don't really see why we'd need the extremely 
heavy git-show-branch.

I think the problems we had with rmk generating patches that had two 
parents but really were _meant_ to be regular patches were due to an 
independent problem, namely that we'd commit with a stale MERGE_HEAD from 
a previous (failed) merge that was never done.

I think. It's a long time ago.

> Disregard this request please.  I see a few commits that this
> step takes a long time to process in the kernel archive.  The
> last merge before you left to Ottawa was one of them.
> 
> b5032a5 48ce8b0

Yup.

And your patch will obviously fix it (by not calling git-show-branch at 
all), but I'm still left wondering why git-show-branch took that long in 
the first place. Half a minute when traversing the whole commit history 
only takes three seconds (as per my previous email)?

Now, as long as nothing I use actually ends up using git-show-branch, I 
won't care, but maybe a sign that something else can be improved?

Traditionally, what has made things _that_ slow has almost always been 
logic that traverses all sides of a merge, without having the logic to 
ignore already-seen commits (so each merge basically doubles the number of 
commits we will traverse, and the problem size goes from O(n+m) to O(m^2) 
where 'n' is number of commits, and 'm' is number of merges.

Or is git-show-branch doing something else really expensive?

		Linus
