From: Maciej Pasternacki <maciej@pasternacki.net>
Subject: [PATCH] -C/--chdir command line option
Date: Sat, 18 Oct 2008 17:02:27 -0700
Message-ID: <20081019000227.GA9423@charybdis.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 19 02:39:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrMKk-0003rx-Th
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 02:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbYJSAie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 20:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYJSAid
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 20:38:33 -0400
Received: from judo.dreamhost.com ([66.33.216.100]:56625 "EHLO
	judo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbYJSAic (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 20:38:32 -0400
X-Greylist: delayed 2073 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Oct 2008 20:38:32 EDT
Received: from smarty.dreamhost.com (smarty.dreamhost.com [208.113.175.8])
	by judo.dreamhost.com (Postfix) with ESMTP id A59C8175417
	for <git@vger.kernel.org>; Sat, 18 Oct 2008 17:03:58 -0700 (PDT)
Received: from charybdis.dreamhost.com (unknown [66.33.197.39])
	by smarty.dreamhost.com (Postfix) with ESMTP id 0FD01EE254;
	Sat, 18 Oct 2008 17:02:28 -0700 (PDT)
Received: by charybdis.dreamhost.com (Postfix, from userid 2307417)
	id 1036732088; Sat, 18 Oct 2008 17:02:28 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98584>

In my project cl-librarian, which is a layer built upon different
version control systems, I need to run git pull, but start it from
outside of work tree; however, pull needs to be in work tree (as in
getcwd()) in order to update said work tree.  --git-dir and
--work-tree options don't work; I discussed it on #git yesterday,
and it turned out that this issue is nontrivial:

231701 <doener> hm, require_work_tree checks if you are _in_ the work tree,
    and pull only switches to the work tree after the require_work_tree
    call...
231710 <doener> looks like a chicken-egg-problem
231715 <shd> japhy`: spawning commands requires forking anyway, so do chdir in
    forked process
231739 <doener> if you move the "cd_to_toplevel" call up in git-push, so that
    it happens before require_work_tree, then it works
231747 <japhy`> shd: yup, that would be a workaround, but I tried to avoid
    shell-quoting ;)
231749 <japhy`> doener: push?
231756 <doener> ehrm, pull
    channel #git
231820 <doener> but I guess doing the cd_to_toplevel first might break somehow
    if there is no working tree...
231843 <japhy`> Oh.
231922 <doener> I'd just ask on the list about that.

I don't like the idea of doing chdir() myself -- this would expose me to a
whole world of portability issues, and I don't feel like spending time to
figure out how to do a fork on windows ;) the best workaround that occured to
me was adding -C/--chdir option to main git binary, like one that Make accepts.
This fixed my problem, I paste the resulting patch below:

>From 4461cd1be99772c93a83bcdfe6e6a86e71abaa35 Mon Sep 17 00:00:00 2001
From: Maciej Pasternacki <maciej@pasternacki.net>
Date: Sun, 19 Oct 2008 01:33:49 +0200
Subject: [PATCH] Add command line option --chdir/-C to allow setting git process work directory.

Signed-off-by: Maciej Pasternacki <maciej@pasternacki.net>
---
 Documentation/git.txt |    6 +++++-
 git.c                 |    9 ++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index df420ae..6676d68 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]]
     [-p|--paginate|--no-pager]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
-    [--help] COMMAND [ARGS]
+    [-C DIRECTORY|--chdir=DIRECTORY] [--help] COMMAND [ARGS]
 
 DESCRIPTION
 -----------
@@ -185,6 +185,10 @@ help ...`.
 	environment is not set, it is set to the current working
 	directory.
 
+-C <directory>::
+--chdir=<directory>::
+	Change working directory before doing anything.
+
 
 FURTHER DOCUMENTATION
 ---------------------
diff --git a/git.c b/git.c
index 89feb0b..8c97671 100644
--- a/git.c
+++ b/git.c
@@ -115,7 +115,14 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged = 1;
-		} else {
+		} else if (!strcmp(cmd, "-C") || !strcmp(cmd, "--chdir")) {
+                        chdir((*argv)[1]);
+                        (*argv)++;
+                        (*argc)--;
+                        handled++;
+                } else if (!prefixcmp(cmd,"--chdir=")) {
+                        chdir(cmd+8);
+                } else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
 		}
-- 
1.6.0.1
