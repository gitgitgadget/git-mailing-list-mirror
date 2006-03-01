From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: impure renames / history tracking
Date: Wed, 1 Mar 2006 09:13:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603010859200.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
 <4405C012.6080407@op5.se> <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 18:14:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEUtr-0006w5-FW
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 18:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWCAROD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 12:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWCAROB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 12:14:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751402AbWCAROB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 12:14:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k21HDtDZ014234
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Mar 2006 09:13:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k21HDrt4007446;
	Wed, 1 Mar 2006 09:13:54 -0800
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16990>



On Wed, 1 Mar 2006, Paul Jakma wrote:
> 
> FWIW, I think git's rename handling is really nice. It's just I suspect, being
> a heuristic, it won't be able to follow history reliably across 'very impure'
> renames.

The thing is, it does better than anything that _tries_ to be "reliable".

I can pretty much _guarantee_ that you can't do it better.

Tracking "inodes" - aka file identities - (which is what BK does, and I 
assume what SVN does) is fundamentally problematic. I particular, it's a 
horrible problem when two inodes "meet" under the same name. You now have 
two identities for the same file, and you're fundamentally screwed.

And don't tell me it doesn't happen. It _does_ happen, and it did happen 
with the kernel under BK.

It doesn't even need renames to be a problem. JUST THE FACT THAT YOU TRY 
TO TRACK FILE "IDENTITY" HISTORY IS BROKEN. For example, take CVS, which 
doesn't actually try to do renames, but _does_ try to track the identity 
of a file, since all the history is tied into that identity: think about 
what happens in Attic when a file is deleted. Completely broken model.

Now, CVS doesn't tend to show the problems very much, because people don't 
actually use branches that much (they are a pain in the neck), and they 
sure as hell try to avoid deleting and creating the same filename under a 
branch and on HEAD. I'm sure you can do it, but I'm also pretty sure 
there's a lot of old projects around that have ended up moving the ,v 
files around to play rename/delete games.

And that's really fundamental. CVS doesn't show the problems so much, 
because CVS actively tries to make it hard to do these things.

With renames-tracking-file-identities, it's _really_ easy to get some 
major confusion going. What happens when one branch creates a file, and 
another one renames a file to that same name, and they merge?

Don't tell me it doesn't happen. It happened under BK. The way BK "solved" 
it was to keep the two separate identities: one of them got resolved to 
the new filename, the other one went into the "deleted" directory. Guess 
what happens when the side that got merged into "deleted" continues to 
edit the file? That's right - their edits happen on the deleted file, and 
never show up in the real tree in a subsequent merge ever again.

And as far as I can tell, BK really did the best you can do. Following 
file identities really _is_ fundamentally broken. It sounds like a nice 
idea, but while you migth solve a few problems, you create a whole raft of 
much more fundamental problems.

So next time you think about a merge that migt have been improved by 
tracking renames, please also think about a merge where one of the 
filenames came from two or more different sources through an earlier 
merge, and thank your benevolent Gods that they instructed me to make git 
be based purely on file contents.

		Linus
