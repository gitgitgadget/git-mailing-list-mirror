From: Junio C Hamano <junkio@cox.net>
Subject: Moving initialization of log_all_ref_updates
Date: Sun, 07 Jan 2007 01:24:41 -0800
Message-ID: <7vbqlb2nqe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 10:24:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3UGn-0008Mk-W3
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 10:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbXAGJYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 04:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbXAGJYn
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 04:24:43 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57962 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455AbXAGJYm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 04:24:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070107092442.XWLJ20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sun, 7 Jan 2007 04:24:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 89Qx1W00P1kojtg0000000; Sun, 07 Jan 2007 04:24:57 -0500
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36141>

The patches to prevent Porcelainish that require working tree
from doing any damage in a bare repository make a lot of sense,
and I want to make the is_bare_git_dir() function more reliable.

In order to allow the repository owner override the heuristic
implemented in is_bare_git_dir() if/when it misidentifies a
particular repository, it would make sense to introduce a new
configuration variable "[core] bare = true/false", and make
is_bare_git_dir() notice it.

The scripts would do a 'repo-config --bool --get core.bare' and
iff the command fails (i.e. there is no such variable in the
configuration file), it would do the heuristic you implemented
in your RFC patch [*1*].

However, setup_git_env() which is called a lot earlier than we
even read from the repository configuration currently makes a
call to is_bare_git_dir(), in order to change the default
setting for log_all_ref_updates.  It somehow feels that this is
a hack, and I am considering the following patch.  What do you
think?

By the way, [*1*] is another thing I hate about the current
config mechanism.  "git-repo-config --get" does not know what
the possible configuration variables are, let alone what the
default values for them are.  It allows us not to maintain a
centralized configuration table, which makes it easy to
introduce ad-hoc variables and gives a warm fuzzy feeling of
being modular, but my feeling is that it is turning out to be a
rather high price to pay for scripts.

---

diff --git a/environment.c b/environment.c
index 09976c7..ee33bb1 100644
--- a/environment.c
+++ b/environment.c
@@ -15,7 +15,7 @@ int use_legacy_headers = 1;
 int trust_executable_bit = 1;
 int assume_unchanged;
 int prefer_symlink_refs;
-int log_all_ref_updates;
+int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 char *git_commit_encoding;
@@ -51,10 +51,9 @@ static void setup_git_env(void)
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file = xstrdup(git_path("info/grafts"));
-	log_all_ref_updates = !is_bare_git_dir(git_dir);
 }
 
-int is_bare_git_dir (const char *dir)
+int is_bare_git_dir(const char *dir)
 {
 	const char *s;
 	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
diff --git a/refs.c b/refs.c
index 5205745..b5eee11 100644
--- a/refs.c
+++ b/refs.c
@@ -923,6 +923,9 @@ static int log_ref_write(struct ref_lock *lock,
 	char *logrec;
 	const char *committer;
 
+	if (log_all_ref_updates < 0)
+		log_all_ref_updates = !is_bare_git_dir(get_git_dir());
+
 	if (log_all_ref_updates &&
 	    (!strncmp(lock->ref_name, "refs/heads/", 11) ||
 	     !strncmp(lock->ref_name, "refs/remotes/", 13))) {
