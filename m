From: Jeff King <peff@peff.net>
Subject: Re: [BUG] bare repository detection does not work with aliases
Date: Fri, 8 Mar 2013 00:48:25 -0500
Message-ID: <20130308054824.GA24429@sigill.intra.peff.net>
References: <CAHREChhuX82ibNEDQnQUeS9TEeyMFGpuNhyXzt1Pn-Tt2BVOQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 06:48:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDqAr-000164-AV
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 06:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087Ab3CHFs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 00:48:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40650 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab3CHFs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 00:48:28 -0500
Received: (qmail 13744 invoked by uid 107); 8 Mar 2013 05:50:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 00:50:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 00:48:25 -0500
Content-Disposition: inline
In-Reply-To: <CAHREChhuX82ibNEDQnQUeS9TEeyMFGpuNhyXzt1Pn-Tt2BVOQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217638>

On Thu, Mar 07, 2013 at 05:47:45PM -0500, Mark Lodato wrote:

> It seems that the fallback bare repository detection in the absence of
> core.bare fails for aliases.

This triggered some deja vu for me, so I went digging. And indeed, this
has been a bug since at least 2008. This patch (which never got applied)
fixed it:

  http://thread.gmane.org/gmane.comp.version-control.git/72792

The issue is that we treat:

  GIT_DIR=/some/path git ...

as if the current directory is the work tree, unless core.bare is
explicitly set, or unless an explicit work tree is given (via
GIT_WORK_TREE, "git --work-tree", or in the config).  This is handy, and
backwards compatible.

Inside setup_git_directory, when we find the directory we put it in
$GIT_DIR for later reference by ourselves or sub-programs (since we are
typically moving to the top of the working tree next, we need to record
the original path, and can't rely on discovery finding the same path
again). But we don't set $GIT_WORK_TREE. So if you don't have core.bare
set, the above rule will kick in for sub-programs, or for aliases (which
will call setup_git_directory again).

The solution is that when we set $GIT_DIR like this, we need to also say
"no, there is no working tree; we are bare". And that's what that patch
does. It's 5 years old now, so not surprisingly, it does not apply
cleanly. The moral equivalent in today's code base would be something
like:

diff --git a/environment.c b/environment.c
index 89d6c70..8edaedd 100644
--- a/environment.c
+++ b/environment.c
@@ -200,7 +200,8 @@ void set_git_work_tree(const char *new_work_tree)
 		return;
 	}
 	git_work_tree_initialized = 1;
-	work_tree = xstrdup(real_path(new_work_tree));
+	if (*new_work_tree)
+		work_tree = xstrdup(real_path(new_work_tree));
 }
 
 const char *get_git_work_tree(void)
diff --git a/setup.c b/setup.c
index e1cfa48..f0e1251 100644
--- a/setup.c
+++ b/setup.c
@@ -544,7 +544,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	worktree = get_git_work_tree();
 
 	/* both get_git_work_tree() and cwd are already normalized */
-	if (!strcmp(cwd, worktree)) { /* cwd == worktree */
+	if (!worktree || !strcmp(cwd, worktree)) { /* cwd == worktree */
 		set_git_dir(gitdirenv);
 		free(gitfile);
 		return NULL;
@@ -636,6 +636,8 @@ static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongi
 	}
 	else
 		set_git_dir(".");
+
+	setenv(GIT_WORK_TREE_ENVIRONMENT, "", 1);
 	return NULL;
 }
 

which passes your test. Unfortunately, this patch runs afoul of the same
complaints that prevented the original from being acceptable (weirdness
on Windows with empty environment variables).

Having read the discussion again, I _think_ the more sane thing is to
actually just have a new variable, $GIT_BARE, which overrides any
core.bare config (just as $GIT_WORK_TREE override core.worktree). And
then we set that explicitly when we are in a bare $GIT_DIR, propagating
our auto-detection to sub-processes.

-Peff
