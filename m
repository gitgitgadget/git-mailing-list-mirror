From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 2/6] branch: install_branch_config and struct tracking refactoring
Date: Sun, 12 Jul 2009 14:17:29 +0200
Message-ID: <1247401053-20429-3-git-send-email-bonzini@gnu.org>
References: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 14:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPy08-0001H1-Vp
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 14:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbZGLMRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 08:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbZGLMRn
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 08:17:43 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60348 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbZGLMRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 08:17:41 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MPxzw-0003SL-JD
	for git@vger.kernel.org; Sun, 12 Jul 2009 08:17:40 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123143>

This patch combines two small refactoring.  The first is to store
a struct remote into struct tracking.  The second is to pass a
struct remote instead of just the name to install_branch_config.

Together, these will allow to easily implement the new configuration
keys remote.*.autosetupmerge and remote.*.autosetuprebase.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 branch.c        |   34 ++++++++++++++++++----------------
 branch.h        |    3 ++-
 builtin-clone.c |    4 ++--
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/branch.c b/branch.c
index 05ef3f5..d17c5ec 100644
--- a/branch.c
+++ b/branch.c
@@ -7,7 +7,7 @@
 struct tracking {
 	struct refspec spec;
 	char *src;
-	const char *remote;
+	struct remote *remote;
 	int matches;
 };
 
@@ -18,7 +18,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	if (!remote_find_tracking(remote, &tracking->spec)) {
 		if (++tracking->matches == 1) {
 			tracking->src = tracking->spec.src;
-			tracking->remote = remote->name;
+			tracking->remote = remote;
 		} else {
 			free(tracking->spec.src);
 			if (tracking->src) {
@@ -32,7 +32,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	return 0;
 }
 
-static int should_setup_rebase(const char *origin)
+static int should_setup_rebase(struct remote *origin)
 {
 	switch (autorebase) {
 	case AUTOREBASE_NEVER:
@@ -47,17 +47,18 @@ static int should_setup_rebase(const char *origin)
 	return 0;
 }
 
-void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
+void install_branch_config(int flag, const char *local, struct remote *remote,
+			   const char *merge)
 {
 	struct strbuf key = STRBUF_INIT;
-	int rebasing = should_setup_rebase(origin);
+	int rebasing = should_setup_rebase(remote);
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	git_config_set(key.buf, origin ? origin : ".");
+	git_config_set(key.buf, remote ? remote->name : ".");
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	git_config_set(key.buf, remote);
+	git_config_set(key.buf, merge);
 
 	if (rebasing) {
 		strbuf_reset(&key);
@@ -68,16 +69,15 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		strbuf_reset(&key);
 
-		strbuf_addstr(&key, origin ? "remote" : "local");
+		strbuf_addstr(&key, remote ? "remote" : "local");
 
 		/* Are we tracking a proper "branch"? */
-		if (!prefixcmp(remote, "refs/heads/")) {
-			strbuf_addf(&key, " branch %s", remote + 11);
-			if (origin)
-				strbuf_addf(&key, " from %s", origin);
-		}
+		if (!prefixcmp(merge, "refs/heads/"))
+			strbuf_addf(&key, " branch %s", merge + 11);
 		else
-			strbuf_addf(&key, " ref %s", remote);
+			strbuf_addf(&key, " ref %s", merge);
+		if (remote)
+			strbuf_addf(&key, " from %s", remote->name);
 		printf("Branch %s set up to track %s%s.\n",
 		       local, key.buf,
 		       rebasing ? " by rebasing" : "");
@@ -117,9 +117,11 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 		return error("Not tracking: ambiguous information for ref %s",
 				orig_ref);
 
-	install_branch_config(BRANCH_CONFIG_VERBOSE, new_ref, tracking.remote,
-			      tracking.src ? tracking.src : orig_ref);
+	if (!tracking.src)
+		tracking.src = xstrdup (orig_ref);
 
+	install_branch_config(BRANCH_CONFIG_VERBOSE, new_ref, tracking.remote,
+			      tracking.src);
 	free(tracking.src);
 	return 0;
 }
diff --git a/branch.h b/branch.h
index eed817a..f7c02c9 100644
--- a/branch.h
+++ b/branch.h
@@ -26,6 +26,7 @@ void remove_branch_state(void);
  * taken from origin "origin".
  */
 #define BRANCH_CONFIG_VERBOSE 01
-extern void install_branch_config(int flag, const char *local, const char *origin, const char *remote);
+struct remote;
+extern void install_branch_config(int flag, const char *local, struct remote *remote, const char *merge);
 
 #endif
diff --git a/builtin-clone.c b/builtin-clone.c
index 32dea74..552ddf6 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -527,7 +527,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare)
-			install_branch_config(0, "master", option_origin,
+			install_branch_config(0, "master", remote_get(option_origin),
 					      "refs/heads/master");
 	}
 
@@ -557,7 +557,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				      head_points_at->peer_ref->name,
 				      reflog_msg.buf);
 
-			install_branch_config(0, head, option_origin,
+			install_branch_config(0, head, remote_get(option_origin),
 					      head_points_at->name);
 		}
 	} else if (remote_head) {
-- 
1.6.2.5
