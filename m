From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-init: set core.worktree if GIT_WORK_TREE is specified
Date: Wed, 04 Jul 2007 10:07:28 -0700
Message-ID: <7vsl84gkrz.fsf@assigned-by-dhcp.cox.net>
References: <20070703224919.GA22578@moooo.ath.cx>
	<20070704092915.GA18597@moooo.ath.cx>
	<alpine.LFD.0.98.0707040920520.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 19:07:40 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I68KE-0006jw-8F
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 19:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbXGDRHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 13:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbXGDRHb
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 13:07:31 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62326 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbXGDRHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 13:07:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704170730.NGXC22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 13:07:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KV7U1X00c1kojtg0000000; Wed, 04 Jul 2007 13:07:29 -0400
In-Reply-To: <alpine.LFD.0.98.0707040920520.9434@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 4 Jul 2007 09:23:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51627>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 4 Jul 2007, Matthias Lederhofer wrote:
>
>> > +	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
>> > +		die("Unable to read current working directory");
>> 
>> Dscho just pointed out that this causes problems on windows.  The same
>> is also in setup_git_directory_gently and was there before I touched
>> it, introduced by Linus in d288a700.  What was the original reason to
>> do this?  Are there implementations of getcwd which return a relative
>> path?
>
> Just remove the check for cwd[0] being '/'.

Ok, will do this.

-- >8 --
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Jul 2007 09:23:17 -0700 (PDT)
Subject: Do not check if getcwd() result begins with a slash

It's just me being too kernel-oriented - inside the kernel, a d_path() 
return value pathname can be either a real path, or something like 
"pipe:[8003]", and the difference is the '/' at the beginning.

In user space, and for getcwd(), the check doesn't make sense. So please 
just remove it, and sorry for my idiotic "I've worked with the kernel for 
too damn long" programming mistakes.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Forged-signature-by: Junio C Hamano <gitster@pobox.com>

---

 setup.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 01f74d4..bb26f3a 100644
--- a/setup.c
+++ b/setup.c
@@ -211,7 +211,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	if (!gitdirenv) {
 		int len, offset;
 
-		if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
+		if (!getcwd(cwd, sizeof(cwd)-1))
 			die("Unable to read current working directory");
 
 		offset = len = strlen(cwd);
@@ -271,7 +271,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die("Not a git repository: '%s'", gitdirenv);
 	}
 
-	if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
+	if (!getcwd(cwd, sizeof(cwd)-1))
 		die("Unable to read current working directory");
 	if (chdir(gitdirenv)) {
 		if (nongit_ok) {
@@ -281,7 +281,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die("Cannot change directory to $%s '%s'",
 			GIT_DIR_ENVIRONMENT, gitdirenv);
 	}
-	if (!getcwd(gitdir, sizeof(gitdir)-1) || gitdir[0] != '/')
+	if (!getcwd(gitdir, sizeof(gitdir)-1))
 		die("Unable to read current working directory");
 	if (chdir(cwd))
 		die("Cannot come back to cwd");
@@ -340,7 +340,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			die("Cannot change directory to working tree '%s'",
 				gitworktree);
 	}
-	if (!getcwd(worktree, sizeof(worktree)-1) || worktree[0] != '/')
+	if (!getcwd(worktree, sizeof(worktree)-1))
 		die("Unable to read current working directory");
 	strcat(worktree, "/");
 	inside_work_tree = !prefixcmp(cwd, worktree);
