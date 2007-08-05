From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix install-doc-quick target
Date: Sun, 5 Aug 2007 14:12:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051344430.14781@racer.site>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
 <46B4A2B0.9080208@gmail.com> <Pine.LNX.4.64.0708041704040.14781@racer.site>
 <46B4A5FD.3070107@gmail.com> <Pine.LNX.4.64.0708041719490.14781@racer.site>
 <46B4BDCF.9060809@gmail.com> <Pine.LNX.4.64.0708042229130.14781@racer.site>
 <46B4F91D.1070907@lsrfire.ath.cx> <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 15:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHfvU-0000DT-AK
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 15:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXHENN3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 09:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbXHENN3
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 09:13:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:53698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751135AbXHENN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 09:13:28 -0400
Received: (qmail invoked by alias); 05 Aug 2007 13:13:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 05 Aug 2007 15:13:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wlPVBzbkwPKNUiEk9nfLOdmyP/Fzi3iLGSuxFzM
	Hwg3/d31JxVBmF
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55014>

Hi,

On Sun, 5 Aug 2007, Junio C Hamano wrote:

>  * I am getting the impression that the semantics of the updated
>    work-tree support is as broken as the original, although the
>    code that implements it is easier to read.  
> 
>    Admittedly, this is an unorthodox corner case usage, that
>    deals with a tree structure that does not have any relation
>    with the current project state, and the script is started
>    with a subdirectory of the current project.

I do not like the behaviour "be stupid and assume cwd to be the working 
tree root, if GIT_DIR is set and GIT_WORK_TREE is not".

It bears _all_ kind of stupid connotations.  Just imagine what would 
happen with "git --git-dir=. add .".

IMHO the new behaviour is _better_, since you can not shoot yourself in 
the foot so easily.  Being able to safeguard against doing a work tree 
operation inside the git directory is a direct and elegant consequence of 
defaulting to $GIT_DIR/.. in case $GIT_DIR ends in "/.git", and no work 
tree if $GIT_DIR does _not_ end in "/.git".

The semantics "if GIT_DIR is set, just assume the cwd to be the work tree 
root unilaterally" is _broken_ as far as I am concerned.

NOTE: this change in semantics will _only_ _ever_ burn you if you set 
GIT_DIR, but not GIT_WORK_TREE, in a _subdirectory_ of $GIT_DIR/.. (if it 
ends in /.git, and $GIT_DIR otherwise).

So the _common_ use of setting GIT_DIR, namely something like

	$ git --git-dir=/some/where/completely/different bla

is _not_ affected.

So I really think that the code in install-doc-quick.sh is not only ugly, 
but also wrong.  It sets the GIT_DIR to _the same_ value as the default, 
to change git's idea of the _work tree_!  All at the same time as it is 
utterly clear that it wants to write to $HOME/share/man, but it does not 
make this its working tree.  No, sir.  It has to play cute games with the 
prefix.

However, you are the maintainer, and it is your decision.  If you want the 
old semantics (without sanity checks for work-tree operations inside the 
git directory), here is a patch.  I don't like it, but if you take it, 
I'll learn to live with it.

Ciao,
Dscho

-- snipsnap --
Reinstate the old behaviour when GIT_DIR is set and GIT_WORK_TREE is unset

The old behaviour was to unilaterally default to the cwd is the work tree 
when GIT_DIR was set, but GIT_WORK_TREE wasn't, no matter if we are inside 
the GIT_DIR, or if GIT_DIR is actually something like ../../../.git.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Feel free to change the commit message.

 setup.c |   50 +++++++++-----------------------------------------
 1 files changed, 9 insertions(+), 41 deletions(-)

diff --git a/setup.c b/setup.c
index 4945eb3..7bcf4eb 100644
--- a/setup.c
+++ b/setup.c
@@ -189,53 +189,21 @@ int is_inside_work_tree(void)
 }
 
 /*
- * If no worktree was given, and we are outside of a default work tree,
- * now is the time to set it.
- *
- * In other words, if the user calls git with something like
- *
- *	git --git-dir=/some/where/else/.git bla
- *
- * default to /some/where/else as working directory; if the specified
- * git-dir does not end in "/.git", the cwd is used as working directory.
+ * set_work_tree() is only ever called if you set GIT_DIR explicitely.
+ * The old behaviour (which we retain here) is to set the work tree root
+ * to the cwd, unless overridden by the config, the command line, or
+ * GIT_WORK_TREE.
  */
 const char *set_work_tree(const char *dir)
 {
-	char dir_buffer[PATH_MAX], *rel = NULL;
-	static char buffer[PATH_MAX + 1];
-	int len, suffix_len = strlen(DEFAULT_GIT_DIR_ENVIRONMENT) + 1;
-
-	/* strip the variable 'dir' of the postfix "/.git" if it has it */
-	len = strlen(dir);
-	if (len > suffix_len &&
-	    !strcmp(dir + len - suffix_len, "/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
-		if ((len - suffix_len) >= sizeof(dir_buffer))
-			die("directory name too long");
-		memcpy(dir_buffer, dir, len - suffix_len);
-		dir_buffer[len - suffix_len] = '\0';
-
-		/* are we inside the default work tree? */
-		rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);
-	}
+	char buffer[PATH_MAX + 1];
 
-	/* if rel is set, the cwd is _not_ the current working tree */
-	if (rel && *rel) {
-		if (!is_absolute_path(dir))
-			set_git_dir(make_absolute_path(dir));
-		dir = dir_buffer;
-		if (chdir(dir))
-			die("cannot chdir to %s: %s", dir, strerror(errno));
-		else
-			strcat(rel, "/");
-		inside_git_dir = 0;
-	} else {
-		rel = NULL;
-		dir = getcwd(buffer, sizeof(buffer));
-	}
-	git_work_tree_cfg = xstrdup(dir);
+	if (!getcwd(buffer, sizeof(buffer)))
+		die ("Could not get the current working directory");
+	git_work_tree_cfg = xstrdup(buffer);
 	inside_work_tree = 1;
 
-	return rel;
+	return NULL;
 }
 
 /*
