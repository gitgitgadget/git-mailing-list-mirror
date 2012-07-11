From: marcnarc@xiplink.com
Subject: [PATCH 2/6] Teach remote.c about the remote.default configuration setting.
Date: Wed, 11 Jul 2012 11:33:57 -0400
Message-ID: <1342020841-24368-3-git-send-email-marcnarc@xiplink.com>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com, Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 17:41:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soz2g-0007BM-QM
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 17:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894Ab2GKPlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 11:41:17 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:28500 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932837Ab2GKPlN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2012 11:41:13 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q6BFY4Ub029776;
	Wed, 11 Jul 2012 11:34:06 -0400
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201311>

From: Marc Branchaud <marcnarc@xiplink.com>

The code now has a default_remote_name and an effective_remote_name:

 - default_remote_name is set by remote.default in the config, or is "origin"
   if remote.default doesn't exist ("origin" was the fallback value before
   this change).

 - effective_remote_name is the name of the remote tracked by the current
   branch, or is default_remote_name if the current branch doesn't have a
   remote.

This has a minor side effect on the default behavior of "git push".  Consider
the following sequence of commands:

      git config remote.default foo                 # Set default remote
      git checkout somelocalbranch                  # Does not track a remote
      git remote add origin ssh://example.com/repo  # Add a new "origin"
      git push

Prior to this change, the above "git push" would attempt to push to the new
"origin" repository at ssh://example.com/repo.  Now instead that "git push"
will attempt to push to the repository named "foo".

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/config.txt           |  8 ++++++++
 Documentation/git-pull.txt         |  6 +++++-
 Documentation/git-push.txt         |  8 +++++++-
 Documentation/pull-fetch-param.txt |  6 ++++++
 remote.c                           | 14 +++++++++++---
 5 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..7869e1b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1856,6 +1856,14 @@ remote.<name>.vcs::
 	Setting this to a value <vcs> will cause git to interact with
 	the remote with the git-remote-<vcs> helper.
 
+remote.default::
+	This value is the <name> of a remote.  When Git needs to automatically
+	choose a remote to use, it first tries the 'branch.<branchname>.remote'
+	value of the currently checked-out branch.  If the currently checked-out
+	branch has no remote, Git uses the remote named by 'remote.default', or
+	the remote named "origin" if no value is set (even if there is no
+	actual remote named "origin").
+
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index defb544..2610253 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -33,7 +33,11 @@ but usually it is the name of a branch in the remote repository.
 
 Default values for <repository> and <branch> are read from the
 "remote" and "merge" configuration for the current branch
-as set by linkgit:git-branch[1] `--track`.
+as set by linkgit:git-branch[1] `--track`.  If the current branch
+has no remote configured, the default for <repository> is read
+from the "remote.default" configuration variable.  If that variable
+is not set, the default <repository> is "origin" even if there is no
+actual remote named "origin".
 
 Assume the following history exists and the current branch is
 "`master`":
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index cb97cc1..fc17d39 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -27,10 +27,16 @@ documentation for linkgit:git-receive-pack[1].
 OPTIONS[[OPTIONS]]
 ------------------
 <repository>::
-	The "remote" repository that is destination of a push
+	The "remote" repository that is the destination of the push
 	operation.  This parameter can be either a URL
 	(see the section <<URLS,GIT URLS>> below) or the name
 	of a remote (see the section <<REMOTES,REMOTES>> below).
+	If this parameter is omitted, git tries to use the remote
+	associated with the currently checked-out branch.  If there
+	is no remote associated with the current branch, git uses
+	the remote named by the "remote.default" configuration variable.
+	If "remote.default" is not set, git uses the name "origin" even
+	if there is no actual remote named "origin".
 
 <refspec>...::
 	The format of a <refspec> parameter is an optional plus
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 94a9d32..696f1fb 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -3,6 +3,12 @@
 	or pull operation.  This parameter can be either a URL
 	(see the section <<URLS,GIT URLS>> below) or the name
 	of a remote (see the section <<REMOTES,REMOTES>> below).
+	If this parameter is omitted, git tries to use the remote
+	associated with the currently checked-out branch.  If there
+	is no remote associated with the current branch, git uses
+	the remote named by the "remote.default" configuration variable.
+	If "remote.default" is not set, git uses the name "origin" even
+	if there is no actual remote named "origin".
 
 ifndef::git-pull[]
 <group>::
diff --git a/remote.c b/remote.c
index 6f371e0..2ebdbbd 100644
--- a/remote.c
+++ b/remote.c
@@ -47,6 +47,7 @@ static int branches_alloc;
 static int branches_nr;
 
 static struct branch *current_branch;
+static const char *default_remote_name;
 static const char *effective_remote_name;
 static int explicit_effective_remote_name;
 
@@ -397,8 +398,12 @@ static int handle_config(const char *key, const char *value, void *cb)
 		return 0;
 	}
 	subkey = strrchr(name, '.');
-	if (!subkey)
+	if (!subkey) {
+		/* Look for remote.default */
+		if (!strcmp(name, "default"))
+			default_remote_name = xstrdup(value);
 		return 0;
+	}
 	remote = make_remote(name, subkey - name);
 	remote->origin = REMOTE_CONFIG;
 	if (!strcmp(subkey, ".mirror"))
@@ -481,9 +486,8 @@ static void read_config(void)
 	unsigned char sha1[20];
 	const char *head_ref;
 	int flag;
-	if (effective_remote_name) /* did this already */
+	if (default_remote_name) /* did this already */
 		return;
-	effective_remote_name = xstrdup("origin");
 	current_branch = NULL;
 	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
@@ -492,6 +496,10 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config, NULL);
+	if (!default_remote_name)
+		default_remote_name = "origin";
+	if (!effective_remote_name)
+		effective_remote_name = default_remote_name;
 	alias_all_urls();
 }
 
-- 
1.7.11.1
