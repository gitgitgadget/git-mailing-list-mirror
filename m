From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: New converstion tool: svn2git.py
Date: Thu, 20 Nov 2008 13:49:34 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811201329460.19665@iabervon.org>
References: <20081119191320.GA20870@arctrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Neil Schemenauer <nas@arctrix.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:50:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Ec7-0004RD-Mc
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 19:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbYKTStg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 13:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYKTStg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 13:49:36 -0500
Received: from iabervon.org ([66.92.72.58]:37931 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbYKTStg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 13:49:36 -0500
Received: (qmail 2091 invoked by uid 1000); 20 Nov 2008 18:49:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2008 18:49:34 -0000
In-Reply-To: <20081119191320.GA20870@arctrix.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101467>

On Wed, 19 Nov 2008, Neil Schemenauer wrote:

> Hi,
> 
> I'm working on a tool to do conversions from SVN to git using a SVN
> dump.  It's in early development but perhaps some people would be
> interested in it:
> 
>     http://python.ca/nas/python/svn2git.py
> 
> I would like to improve it so that it intelligently converts SVN
> branches and tags into git branches (when possible).  The basic idea
> is to map SVN paths into git branches, e.g. trunk -> master,
> branches/foo -> branch-foo, tags/bar -> tags-bar.  Next, specific
> SVN dump actions like:
> 
>     Node-path: branches/foo
>     Node-kind: dir
>     Node-action: add
>     Node-copyfrom-rev: 3
>     Node-copyfrom-path: trunk
> 
> need to be detected and the commit needs to performed with the
> correct parent.  One complication is that SVN can create a branch or
> tag from anywhere, for example, the action
> 
>     Node-path: tags/bar
>     Node-kind: dir
>     Node-action: add
>     Node-copyfrom-rev: 3
>     Node-copyfrom-path: trunk/subdir
> 
> would create tags/bar based on revision 3 of trunk/subdir.  There
> doesn't seem to be a good way to convert that into git.  I was
> thinking that the tags-bar branch in that case would have no parent.

Probably the best thing in git would be to have the parent of the initial 
commit on that branch be revision 3 of trunk; it will look like a big 
rename of everything from subdir/* into the project root directory, which 
is essentially what happened.

> Would git still efficently pack that or would you end up with extra
> blobs?

git will only ever store a single copy of identical file contents, 
regardless of anything at all. Furthermore, when making a pack, git 
compresses everything in the pack against everything else in the pack. Its 
heuristics also ignore the leading directory names in guessing which blobs 
are likely to help in compression (because there's a good chance that 
anything named "Makefile" anywhere is useful in compressing anything else 
named "Makefile").

	-Daniel
*This .sig left intentionally blank*
