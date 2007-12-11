From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 10:40:36 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:41:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2A2Y-00025q-Dv
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 19:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbXLKSks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 13:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbXLKSks
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 13:40:48 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57543 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751577AbXLKSkr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 13:40:47 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBIebp1022362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 10:40:38 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBIea6m003430;
	Tue, 11 Dec 2007 10:40:37 -0800
In-Reply-To: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67901>



On Tue, 11 Dec 2007, Daniel Berlin wrote:
>
> This seems to be a common problem with git. It seems to use a lot of
> memory to perform common operations on the gcc repository (even though
> it is faster in some cases than hg).

The thing is, git has a very different notion of "common operations" than 
you do.

To git, "git annotate" is just about the *last* thing you ever want to do. 
It's not a common operation, it's a "last resort" operation. In git, the 
whole workflow is designed for "git log -p <pathnamepattern>" rather than 
annotate/blame.

In fact, we didn't support annotate at all for the first year or so of 
git.

The reason for git being relatively slow is exactly that git doesn't have 
"file history" at all, and only tracks full snapshots. So "git blame" is 
really a very complex operation that basically looks at the global history 
(because nothing else exists) and will basically generate a totally 
different "view" of local history from that one.

The disadvantage is that it's much slower and much more costly than just 
having a local history view to begin with.

However, the absolutely *huge* advantage is that it isn't then limited to 
local history.

So where git shines is when you actually use the global history, and do 
merges or when you track more than one file (which others find hard, but 
git finds much more natural).

An examples of this is content that actually comes from multiple files. 
File-based systems simply cannot do this at all. They aren't just slower, 
they are totally unable to do it sanely. For git, it's all the same: it 
never really cares about file boundaries in the first place.

The other example is doing things like "git log -p drivers/char", where 
you don't ask for the log of a single file, but a general file pattern, 
and get (still atomic!) commits as the result.

And perhaps the best example is just tracking code when you have two files 
that merge into one (possibly because the "same" file was created 
independently in two different branches). git gets things like that right 
without even thinking about it. Others tend to just flounder about and 
can't do anything at all about it.

That said, I'll see if I can speed up "git blame" on the gcc repository. 
It _is_ a fundamentally much more expensive operation than it is for 
systems that do single-file things.

			Linus
