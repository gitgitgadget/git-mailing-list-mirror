From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git binary directory?
Date: Sat, 5 Nov 2005 20:25:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511052013550.3316@g5.osdl.org>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
 <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 05:26:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYc63-00051B-Fe
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 05:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVKFEZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 23:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVKFEZc
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 23:25:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932282AbVKFEZb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 23:25:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA64PQnO010144
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 5 Nov 2005 20:25:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA64PPkR011980;
	Sat, 5 Nov 2005 20:25:26 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11190>



On Sat, 5 Nov 2005, Junio C Hamano wrote:
> 
> My purist half, however, says that it is a wrong solution to the
> problem.  If having many files in /usr/bin hurts performance,
> you should be using a filesystem that handles large directory
> better.

I disagree with your arguments, even though I'm not convinced we 
necessarily need a directory of its own for git.

We have directories for a reason. You might as well argue that everybody 
should have a flat namespace, since it should be efficient.

The performance reason for directories is only secondary. The _real_ 
reason for directories is to keep related things together, and track them 
better. Havign a nice directory structure where programs keep their own 
files instead of putting them all in the same place is a good thing from 
an organization standpoint.

> Modern shells already know how to hash command names
> found in $PATH.

Right. And we could add the git directory to the path. In fact, that's 
exactly what the git wrapper script does: this allows the low-level git 
shell scripts to avoid havign to go through the wrapper, since they can 
now use the native programs directly.

(In fact, that PATH part of the patch is probably a bug-fix regardless: if 
I have two different versions of "git", and I ask for the one that isn't 
in my path explicitly, then it should use _its_ git programs, not the 
other versions).

> It is just your gnome executable finder that is
> lacking the knowledge of which binaries are appropriate for what
> mimetype;

The gnome file chooser is horrid, but even in the presense of a _nice_ 
file manager it's actually not very pleasant to have directories with 
thousands of files. 

> Since we do not have enough clout to have /usr/bin/git/ and ask
> the users to put that in their PATH like X11 does, we need to
> teach some of our commands that use other git commands to
> prepend /usr/lib/git/ (or /usr/libexec/git) on their PATH while
> they run.

Did you miss that part of my patch? That's exactly what this hunk of it 
does:

	diff --git a/git.sh b/git.sh
	index 94940ae..9ba1608 100755
	--- a/git.sh
	+++ b/git.sh
	@@ -1,7 +1,8 @@
	 #!/bin/sh
	 
	 cmd=
	-path=$(dirname "$0")
	+path="@@GITDIR@@"
	+export PATH="$path:$PATH"
	 case "$#" in
	 0)	;;
	 *)	cmd="$1"

and as mentioned, I actually think it's a bugfix regardless of anything 
else (do a "./git log", and it will _not_ execute "./git-rev-parse" and 
"./git-rev-list": it will execute whatever was in the path, usually 
/usr/bin/git-rev-xyzzy).

Now, gitk didn't do that, which is a bug.

> Although many of the Porcelainish commands include
> git-sh-setup, git-sh-setup itself is a prime candidate to be
> kicked out of /usr/bin, which means essentially everything needs
> to have that PATH trick.

Yes. All porcelain would need to do the PATH thing, I think.

> This also is a bit inconvenient for our in-source-tree tests.
> We need to be testing what we just built and are about to
> install, not what is already installed, so every script needs to
> start with something like this:

No, the actual programs and scripts themselves shouldn't change. Nothing 
that uses git-sh-setup should change, only the programs that are installed 
in /usr/bin would need to know that the helper programs are _not_ there, 
and set up the path properly.

But if we do that right, that should be just a couple of executables, 
which is the whole point of splitting this up.

But yes, you're right that right now we're not always set up for this, and 
git-upload-pack etc that execute directly from the shell would need help.

		Linus
