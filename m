From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Clarify and expand some hook documentation.
Date: Fri, 24 Mar 2006 21:21:07 -0600
Message-ID: <E1FMzKt-0006ur-Gj@jdl.com>
X-From: git-owner@vger.kernel.org Sat Mar 25 04:22:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMzMB-00069W-BI
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 04:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWCYDVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 22:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWCYDVl
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 22:21:41 -0500
Received: from mail.jdl.com ([66.118.10.122]:59824 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750706AbWCYDVk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 22:21:40 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FMzKt-0006ur-Gj
	for git@vger.kernel.org; Fri, 24 Mar 2006 21:21:08 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17948>


Clarify update and post-update hooks.
Made a few references to the hooks documentation.

Signed-off-by: Jon Loeliger <jdl@jdl.com>

---

 Documentation/git.txt               |    2 +
 Documentation/hooks.txt             |   49 ++++++++++++++++++++++++++---------
 Documentation/repository-layout.txt |    2 +
 3 files changed, 41 insertions(+), 12 deletions(-)

83472863b77cde6209ce01211500e2bd9b81ecc7
diff --git a/Documentation/git.txt b/Documentation/git.txt
index de3934d..0c424ff 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -531,6 +531,8 @@ File/Directory Structure
 
 Please see link:repository-layout.html[repository layout] document.
 
+Read link:hooks.html[hooks] for more details about each hook.
+
 Higher level SCMs may provide and manage additional information in the
 `$GIT_DIR`.
 
diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 4ad1920..3824a95 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -97,16 +97,31 @@ send out a commit notification e-mail.
 update
 ------
 
-This hook is invoked by `git-receive-pack`, which is invoked
-when a `git push` is done against the repository.  It takes
-three parameters, name of the ref being updated, old object name
-stored in the ref, and the new objectname to be stored in the
-ref.  Exiting with non-zero status from this hook prevents
-`git-receive-pack` from updating the ref.
+This hook is invoked by `git-receive-pack` on the remote repository,
+which is happens when a `git push` is done on a local repository.
+Just before updating the ref on the remote repository, the update hook
+is invoked.  It's exit status determins the success or failure of
+the ref update.
+
+The hook executes once for each ref to be updated, and takes
+three parameters:
+    - the name of the ref being updated,
+    - the old object name stored in the ref,
+    - and the new objectname to be stored in the ref.
+
+A zero exit from the update hook allows the ref to be updated.
+Exiting with a non-zero status prevents `git-receive-pack`
+from updating the ref.
 
-This can be used to prevent 'forced' update on certain refs by
+This hook can be used to prevent 'forced' update on certain refs by
 making sure that the object name is a commit object that is a
 descendant of the commit object named by the old object name.
+That is, to enforce a "fast forward only" policy.
+
+It could also be used to log the old..new status.  However, it
+does not know the entire set of branches, so it would end up
+firing one e-mail per ref when used naively, though.
+
 Another use suggested on the mailing list is to use this hook to
 implement access control which is finer grained than the one
 based on filesystem group.
@@ -115,20 +130,30 @@ The standard output of this hook is sent
 want to report something to the git-send-pack on the other end,
 you can redirect your output to your stderr.
 
+
 post-update
 -----------
 
-This hook is invoked by `git-receive-pack`, which is invoked
-when a `git push` is done against the repository.  It takes
-variable number of parameters; each of which is the name of ref
-that was actually updated.
+This hook is invoked by `git-receive-pack` on the remote repository,
+which is happens when a `git push` is done on a local repository.
+It executes on the remote repository once after all the refs have
+been updated.
+
+It takes a variable number of parameters, each of which is the
+name of ref that was actually updated.
 
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git-receive-pack`.
 
+The post-update hook can tell what are the heads that were pushed,
+but it does not know what their original and updated values are,
+so it is a poor place to do log old..new.
+
 The default post-update hook, when enabled, runs
 `git-update-server-info` to keep the information used by dumb
-transport up-to-date.
+transports (eg, http) up-to-date.  If you are publishing
+a git repository that is accessible via http, you should
+probably enable this hook.
 
 The standard output of this hook is sent to /dev/null; if you
 want to report something to the git-send-pack on the other end,
diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index 1f19bf8..98fbe7d 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -89,6 +89,8 @@ hooks::
 	commands.  A handful of sample hooks are installed when
 	`git init-db` is run, but all of them are disabled by
 	default.  To enable, they need to be made executable.
+	Read link:hooks.html[hooks] for more details about
+	each hook.
 
 index::
 	The current index file for the repository.  It is
-- 
1.2.4.gdd7be
