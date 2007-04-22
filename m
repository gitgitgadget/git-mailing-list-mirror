From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Secure receive-pack to run setuid
Date: Sat, 21 Apr 2007 21:43:11 -0400
Message-ID: <20070422014311.GA3028@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 03:43:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfR71-0001LX-QJ
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 03:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbXDVBnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 21:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbXDVBnR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 21:43:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36776 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbXDVBnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 21:43:16 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HfR6V-0004Xg-0P; Sat, 21 Apr 2007 21:43:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4C1A620FBAE; Sat, 21 Apr 2007 21:43:12 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45206>

Some central repository type configurations are easier to setup and
configure if all writes to the repository are made by the repository
owner user.  In many corporate settings this can easily be a single
user account on the system, e.g. 'gitadmin'.

Since most writes to bare repositories are performed through
receive-pack, one way to make them all occur as the admin user is
to make the receive-pack executable owned by the admin account
('gitadmin') and mark it setuid.  However that opens a huge
security hole as any other user can create a repository with an
evil world-executable update hook and then push into it.  The hook
would run as the repository owner ('gitadmin') and be allowed full
access to its files.

If receive-pack is running setuid then we perform a strict set of
checks to verify we will only execute hooks that are deemed safe,
and we do so only from within a very restricted environment.  If
the hooks aren't safe then we drop the setuid privileges back to
the real user and continue running normally.

The security of this still assumes that the central repository
owner (e.g. 'gitadmin') won't run receive-pack themselves against
untrusted repositories, as doing so means you are running someone
else's hook as yourself.  This however is smart practice anyway, even
for non repository owners, as pushing to a repository you don't know
implicitly runs hooks (as you) that you may not have control over.

I'm currently using this patch along with the contributed paranoid
update hook (contrib/hooks/update-paranoid) to secure and control
write access to a number of Git repositories in a corporate
environment.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I'm not sure we should apply this.  I'm using this patch myself,
 and it doesn't break anything for non-setuid use, so maybe its OK
 to apply.  Certainly be nice if something like this was natively
 supported, but maybe my use case here is just too nuts to be in
 the main tree.

 Of course I would also appreciate any auditing that others can
 do on this code.  It looks correct to me, and has been beaten on
 pretty well, but it could benefit from more eyes.

 Documentation/git-receive-pack.txt |   29 ++++++++
 receive-pack.c                     |  128 ++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 6914aa5..713f5c7 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -146,6 +146,35 @@ if the repository is packed and is served via a dumb transport.
 	#!/bin/sh
 	exec git-update-server-info
 
+SETUID BEHAVIOR
+---------------
+If the git-receive-pack executable has the setuid bit enabled then
+additional access control checks will be performed before entering
+into the specified repository directory.
+
+If the program is running setuid root (uid 0): it will stat the
+repository directory to determine the owner and then switch the
+effective user ID to that owner ID.  The real user ID will be kept
+intact for use in hooks.  Additional checks will be made as described
+below.
+
+If the program's effective user ID is not the real user ID, but
+the effective user ID is the repository owner, then access is
+allowed only if the following are all true:
+
+* $GIT_DIR/hooks is owned by the repository owner, and is not
+  group or world writable.
+* All of the hooks described above that are present in
+  $GIT_DIR/hooks are owned by the repository owner, and none
+  of them are group or world writable.
+* At least one of $GIT_DIR/hooks/pre-receive or $GIT_DIR/hooks/update
+  exists and is executable by the repository owner.
+
+If the program's effective user ID is not the real user ID, and the
+effective user ID is not the repository owner, then the effective user
+ID is changed to the real user ID.  This drop in privileges prevents an
+evil local user from gaining control of the program's account by making
+a repository with an evil hook, and then running receive-pack.
 
 SEE ALSO
 --------
diff --git a/receive-pack.c b/receive-pack.c
index 26aa26b..b39f99e 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -9,6 +9,9 @@
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
+extern char **environ;
+static char **saved_environ;
+
 static int deny_non_fast_forwards = 0;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
@@ -458,11 +461,133 @@ static int delete_only(struct command *cmd)
 	return 1;
 }
 
+static void use_paranoid_environ(void)
+{
+	static const char *syspath = "PATH=/bin:/usr/bin";
+	char *no_env = NULL;
+	char **old_env, **paranoid_env;
+	const char *gitbin;
+	char *path;
+	unsigned oldcnt;
+
+	/* We cannot trust the environment to run *anything*, and
+	 * that includes the entire malloc family, as well as a
+	 * large number of internal git functions.  We are very afraid
+	 * of malloc related values, e.g. if MALLOC_DEBUG_FILE is set
+	 * to /etc/passwd on some platforms we could have a problem.
+	 */
+	old_env = environ;
+	environ = &no_env;
+
+	/* At least on Solaris 9's libc if we mess around with environ
+	 * and then later want to get back to what we had before we
+	 * must make a copy of it now.  Otherwise we get a SIGBUS, and
+	 * and I don't know why.  Of course it doesn't reproduce in the
+	 * debugger.
+	 */
+	for (oldcnt = 0; old_env[oldcnt];)
+		oldcnt++;
+	saved_environ = xmalloc((oldcnt + 1) * sizeof(char*));
+	for (oldcnt = 0; old_env[oldcnt]; oldcnt++)
+		saved_environ[oldcnt] = xstrdup(old_env[oldcnt]);
+	saved_environ[oldcnt] = NULL;
+
+	gitbin = git_exec_path();
+	path = xmalloc(strlen(syspath) + strlen(gitbin) + 2);
+	sprintf(path, "%s:%s", syspath, gitbin);
+
+	paranoid_env = xmalloc(2 * sizeof(char*));
+	paranoid_env[0] = path;
+	paranoid_env[1] = NULL;
+	environ = paranoid_env;
+}
+
+static void use_saved_environ(void)
+{
+	environ = saved_environ;
+	setenv("GIT_DIR", ".", 1); /* see enter_repo() */
+}
+
+static int path_insecure(uid_t owner_uid, const char *path)
+{
+	struct stat sb;
+	if (stat(path, &sb))
+		return errno != ENOENT;
+	return sb.st_uid != owner_uid || (sb.st_mode & (S_IWGRP|S_IWOTH));
+}
+
+static int setuid_insecure(void)
+{
+	uid_t ruid = getuid(), euid = geteuid(), owner_uid;
+	gid_t rgid = getgid(), egid = getegid(), owner_gid;
+	struct stat sb;
+
+	/* Our decisions center around the repository owner's identity. */
+	if (stat(".", &sb))
+		return 1;
+	owner_uid = sb.st_uid;
+	owner_gid = sb.st_gid;
+
+	/* Running as root?  Drop to the owner or abort. */
+	if (!euid) {
+		if (   setegid(owner_gid)
+		    || seteuid(owner_uid)
+			|| !enter_repo(".", 1))
+			return 1;
+		euid = owner_uid;
+		egid = owner_gid;
+	}
+
+	/* If we aren't running setuid then normal rules apply. */
+	if (euid == ruid && egid == rgid) {
+		use_saved_environ();
+		return 0;
+	}
+
+	/* We aren't the owner but we are running setuid; that's risky.
+	 * Drop back to the real uid and verify we can still access the
+	 * repository, or abort.
+	 */
+	if (euid != owner_uid) {
+		if (setgid(rgid) || setuid(ruid) || !enter_repo(".", 1))
+			return 1;
+		use_saved_environ();
+		return 0;
+	}
+
+	/* We are thinking about continuing to run setuid.  If any
+	 * hooks that we might run exist, they better be secured.
+	 */
+	if (   path_insecure(owner_uid, "hooks")
+	    || path_insecure(owner_uid, pre_receive_hook)
+	    || path_insecure(owner_uid, "hooks/update")
+	    || path_insecure(owner_uid, post_receive_hook)
+	    || path_insecure(owner_uid, update_post_hook))
+		return 1;
+
+	/* We should have a hook that can perform access control
+	 * logic.  If we don't, we are in an insecure repository,
+	 * as system level access controls aren't being used here.
+	 */
+	if (   access(pre_receive_hook, X_OK)
+	    && access("hooks/update", X_OK))
+		return 1;
+
+	/* We are staying setuid, and have decided its OK to do
+	 * so.  We really want to keep our paranoid environment
+	 * however, as the hooks and other GIT executables we
+	 * will run need to trust their environment.
+	 */
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int i;
 	char *dir = NULL;
 
+	use_paranoid_environ();
+
 	argv++;
 	for (i = 1; i < argc; i++) {
 		char *arg = *argv++;
@@ -481,6 +606,9 @@ int main(int argc, char **argv)
 	if (!enter_repo(dir, 0))
 		die("'%s': unable to chdir or not a git archive", dir);
 
+	if (setuid_insecure())
+		die("security controls forbid accessing '%s'", dir);
+
 	if (is_repository_shallow())
 		die("attempt to push into a shallow repository");
 
-- 
1.5.1.1.135.gf948
