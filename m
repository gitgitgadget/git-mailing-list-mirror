From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 4/6] remote: add per-remote autosetupmerge and autosetuprebase configuration
Date: Sun, 12 Jul 2009 14:17:31 +0200
Message-ID: <1247401053-20429-5-git-send-email-bonzini@gnu.org>
References: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 14:17:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPy0A-0001H1-HN
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 14:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbZGLMRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 08:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbZGLMRu
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 08:17:50 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60354 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbZGLMRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 08:17:46 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MPy01-0003Tp-9k
	for git@vger.kernel.org; Sun, 12 Jul 2009 08:17:45 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123145>

This is self-explanatory.  I chose to retain the full range of
possibilities for autosetuprebase, even though in practice only
never/false and always/true will make sense (local will be a
synonym of false, remote will be a synonym of true).

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/config.txt |   13 +++++++++++++
 branch.c                 |    9 ++++++++-
 builtin-branch.c         |    4 +---
 cache.h                  |    1 +
 remote.c                 |    3 +++
 remote.h                 |    1 +
 t/t3200-branch.sh        |   41 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1e37e33..524a222 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1363,6 +1363,19 @@ remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>
 
+remote.<name>.autosetupmerge::
+	Tells 'git-branch' and 'git-checkout' to setup new branches
+	so that linkgit:git-pull[1] will appropriately merge from the
+	starting point branch.  If present, this overrides the global
+	option branch.autosetupmerge, and can have the same settings.
+
+remote.<name>.autosetuprebase::
+	When a new branch is created with 'git-branch' or 'git-checkout'
+	that tracks another branch, this variable tells git to set
+	up pull to rebase instead of merge (see "branch.<name>.rebase").
+	If present, this overrides the global option
+	branch.autosetuprebase, and can have the same settings.
+
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/branch.c b/branch.c
index be683d9..e427721 100644
--- a/branch.c
+++ b/branch.c
@@ -34,7 +34,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 
 static int should_setup_rebase(struct remote *origin)
 {
-	switch (git_branch_track.rebase) {
+	switch (origin ? origin->track.rebase : git_branch_track.rebase) {
 	case AUTOREBASE_NEVER:
 		return 0;
 	case AUTOREBASE_LOCAL:
@@ -104,6 +104,13 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	if (for_each_remote(find_tracked_branch, &tracking))
 		return 1;
 
+	if (track == BRANCH_TRACK_UNSPECIFIED) {
+		track = (tracking.remote
+			 ? tracking.remote->track.merge : git_branch_track.merge);
+		if (!track)
+			return 0;
+	}
+
 	if (!tracking.matches)
 		switch (track) {
 		case BRANCH_TRACK_ALWAYS:
diff --git a/builtin-branch.c b/builtin-branch.c
index fdd6c05..f045e16 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -540,7 +540,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int delete = 0, rename = 0, force_create = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0;
-	enum branch_track track;
+	enum branch_track track = BRANCH_TRACK_UNSPECIFIED;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
 
@@ -595,8 +595,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (branch_use_color == -1)
 		branch_use_color = git_use_color_default;
 
-	track = git_branch_track.merge;
-
 	head = resolve_ref("HEAD", head_sha1, 0, NULL);
 	if (!head)
 		die("Failed to resolve HEAD as a valid ref.");
diff --git a/cache.h b/cache.h
index 2db4c3b..703dc45 100644
--- a/cache.h
+++ b/cache.h
@@ -881,6 +881,7 @@ extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigne
 extern int update_server_info(int);
 
 typedef int (*config_fn_t)(const char *, const char *, void *);
+extern int git_tracking_config(const char *, const char *, struct tracking_config *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config(config_fn_t fn, void *);
diff --git a/remote.c b/remote.c
index c3ada2d..5e21da3 100644
--- a/remote.c
+++ b/remote.c
@@ -131,6 +131,7 @@ static struct remote *make_remote(const char *name, int len)
 		ret->name = xstrndup(name, len);
 	else
 		ret->name = xstrdup(name);
+	ret->track = git_branch_track;
 	return ret;
 }
 
@@ -375,6 +376,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		return 0;
 	remote = make_remote(name, subkey - name);
 	remote->origin = REMOTE_CONFIG;
+	if (git_tracking_config(key, value, &remote->track))
+		return -1;
 	if (!strcmp(subkey, ".mirror"))
 		remote->mirror = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".skipdefaultupdate"))
diff --git a/remote.h b/remote.h
index 5db8420..86b18dc 100644
--- a/remote.h
+++ b/remote.h
@@ -38,6 +38,7 @@ struct remote {
 	int fetch_tags;
 	int skip_default_update;
 	int mirror;
+	struct tracking_config track;
 
 	const char *receivepack;
 	const char *uploadpack;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index b14a3a9..186ba56 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -476,5 +476,46 @@ test_expect_success 'boolean value (no value) for autosetuprebase' '
 	test "$(git config branch.myr22.merge)" = refs/heads/myr21 &&
 	test "z$(git config branch.myr22.rebase)" = ztrue
 '
+test_expect_success 'tracking remote with branch.autosetupmerge = false' '
+	git config remote.local.autosetupmerge true &&
+	git config branch.autosetupmerge false &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git branch myr23 local/master &&
+	test "$(git config branch.myr23.remote)" = local &&
+	test "$(git config branch.myr23.merge)" = refs/heads/master
+'
+
+test_expect_success 'non-tracking remote with branch.autosetupmerge = always' '
+	git config remote.local.autosetupmerge false &&
+	git config branch.autosetupmerge always &&
+	git branch myr24 local/master &&
+	test z"$(git config branch.myr24.remote)" = z &&
+	test z"$(git config branch.myr24.merge)" = z
+'
 
+test_expect_success 'tracking branch overriding remote configuration' '
+	git config remote.local.autosetupmerge false &&
+	git branch --track myr25 local/master &&
+	test "$(git config branch.myr25.remote)" = local &&
+	test "$(git config branch.myr25.merge)" = refs/heads/master
+'
+
+test_expect_success 'non-tracking branch overriding remote configuration' '
+	git config remote.local.autosetupmerge true &&
+	git branch --no-track myr26 local/master &&
+	test z"$(git config branch.myr26.remote)" = z &&
+	test z"$(git config branch.myr26.merge)" = z
+'
+
+test_expect_success '--no-track and multiple matches ' '
+	git config branch.autosetupmerge true &&
+	git config remote.local2.url . &&
+	git config remote.local2.fetch refs/heads/*:refs/remotes/local/* &&
+	git fetch local2 &&
+	git branch --no-track myr96 local/master
+	test z"$(git config branch.myr96.remote)" = z &&
+	test z"$(git config branch.myr96.merge)" = z
+'
 test_done
-- 
1.6.2.5
