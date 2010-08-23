From: Eric Wong <normalperson@yhbt.net>
Subject: Re: using git-svn with --no-metadata
Date: Mon, 23 Aug 2010 02:22:58 +0000
Message-ID: <20100823022258.GA19818@dcvr.yhbt.net>
References: <E1OmnCj-0001Z7-2U@smtp.tt-solutions.com> <20100821183711.GA14986@dcvr.yhbt.net> <20100821190711.GA19129@dcvr.yhbt.net> <E1OmuVR-0001qE-H7@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vadim Zeitlin <vz-git@zeitlins.org>
X-From: git-owner@vger.kernel.org Mon Aug 23 04:23:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnMgk-0003qw-L7
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 04:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488Ab0HWCXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 22:23:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41180 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab0HWCW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 22:22:59 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220441F541;
	Mon, 23 Aug 2010 02:22:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <E1OmuVR-0001qE-H7@smtp.tt-solutions.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154202>

Vadim Zeitlin <vz-git@zeitlins.org> wrote:
>  Just in case you're curious, let me describe the problem I have with
> commit rewriting. First, my setup is such that I have a single git-svn
> clone (under Linux) but as most of the projects I'm working on are
> cross-platform I also have git clones of this repository under Windows, Mac
> &c. And when I implement some feature under, say, Windows, on a branch
> win-work I then push it to Linux machine (where I can test that it didn't
> break anything under Unix) and then use "git svn dcommit" from there. So
> far all is well but the problem is that when I update my Windows repository
> master branch, it has different commits from the ones on win-work branch.
> So I can't e.g. "git branch -d win-work" but need to use "branch -D" (if I
> am perfectly sure I committed everything) or, usually, "git rebase master
> win-work" and only then delete the branch after git tells me that there are
> no differences left.
> 
>  All this is hardly catastrophic but if I could avoid it somehow it would
> be even better. Now that I know that "svn clone --no-metadata" won't help
> me with this I wonder if the others have any better ways of working in such
> setup?

I've favored a rebase-heavy workflow for many years now.  When working
with SVN, I found "git svn rebase" much more convenient to use than
normal "git rebase".  I'm not at all hesitant with "branch -D" since I
know reflogs/fsck will protect me from mistakes.

On pure git workflows, I still use rebase often and mail patches to
myself to transfer works-in-progress between machines.  If the machines
don't have a properly configured MTA, then I use format-patch and scp
patches/mboxes around.

>  Sorry if I sound like a broken record but this still seems to be unclear
> to me for the same reasons as the original text, i.e. because there is
> still the "if you lose ... then you won't be able to fetch again"
> implication (at least to me). Wouldn't something like
> 
> 	This option can only be used for one-shot imports as 'git svn'
> 	will not be able to fetch again without metadata. Additionally,
> 	if you lose your .git/svn/**/.rev_map.* files, 'git svn' will not
> 	be able to rebuild them.
> 
> be more clear?

Yes, much better.  I'll use your words instead :>

>From b7ddc7100f897d5b6a661a4aa57948608e4c3585 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 21 Aug 2010 18:52:14 +0000
Subject: [PATCH] Documentation/git-svn: discourage "noMetadata"

"noMetadata" is a sometimes harmful option, so better document
its behavior and limitations.

Suggested-by: Vadim Zeitlin
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4b84d08..be8a51f 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -56,6 +56,8 @@ COMMANDS
 	as well, they take precedence.
 --no-metadata;;
 	Set the 'noMetadata' option in the [svn-remote] config.
+	This option is not recommended, please read the 'svn.noMetadata'
+	section of this manpage before using this option.
 --use-svm-props;;
 	Set the 'useSvmProps' option in the [svn-remote] config.
 --use-svnsync-props;;
@@ -597,13 +599,22 @@ svn.noMetadata::
 svn-remote.<name>.noMetadata::
 	This gets rid of the 'git-svn-id:' lines at the end of every commit.
 +
-If you lose your .git/svn/git-svn/.rev_db file, 'git svn' will not
-be able to rebuild it and you won't be able to fetch again,
-either.  This is fine for one-shot imports.
+This option can only be used for one-shot imports as 'git svn'
+will not be able to fetch again without metadata. Additionally,
+if you lose your .git/svn/**/.rev_map.* files, 'git svn' will not
+be able to rebuild them.
 +
 The 'git svn log' command will not work on repositories using
 this, either.  Using this conflicts with the 'useSvmProps'
 option for (hopefully) obvious reasons.
++
+This option is NOT recommended as it makes it difficult to track down
+old references to SVN revision numbers in existing documentation, bug
+reports and archives.  If you plan to eventually migrate from SVN to git
+and are certain about dropping SVN history, consider
+linkgit:git-filter-branch[1] instead.  filter-branch also allows
+reformating of metadata for ease-of-reading and rewriting authorship
+info for non-"svn.authorsFile" users.
 
 svn.useSvmProps::
 svn-remote.<name>.useSvmProps::
-- 
Eric Wong
