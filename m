From: "Pat Notz" <pknotz@sandia.gov>
Subject: [PATCHv4] Make git-clone respect branch.autosetuprebase
Date: Thu, 5 Mar 2009 19:58:41 -0700
Message-ID: <1236308321-13557-1-git-send-email-pknotz@sandia.gov>
References: <7vsklt94ws.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Pat Notz" <pknotz@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 04:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfQIi-0002TR-W0
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 04:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZCFC7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 21:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbZCFC7M
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 21:59:12 -0500
Received: from sentry-three.sandia.gov ([132.175.109.17]:34049 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbZCFC7L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 21:59:11 -0500
X-WSS-ID: 0KG2DMS-08-UZB-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Tumbleweed MailGate 3.6.1) with ESMTP id 2573F8ECB91
	for <git@vger.kernel.org>; Thu,  5 Mar 2009 19:59:16 -0700 (MST)
Received: from [134.253.165.160] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 05 Mar 2009 19:58:43 -0700
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from localhost.localdomain (134.253.112.116) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.1.340.0; Thu, 5 Mar 2009 19:58:42 -0700
X-Mailer: git-send-email 1.6.1.2
In-Reply-To: <7vsklt94ws.fsf@gitster.siamese.dyndns.org>
X-TMWD-Spam-Summary: TS=20090306025845; ID=1; SEV=2.3.1;
 DFV=B2009030602; IFV=NA; AIF=B2009030602; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230382E34394230393136352E303133462C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAAAAAAAAAAAAAAAAAAAAAAAfQ==
X-MMS-Spam-Filter-ID: B2009030602_5.03.0010
X-WSS-ID: 65AE4EE93BW981171-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112371>

When git-clone creates an initial branch it was not
checking the branch.autosetuprebase configuration
option (which may exist in ~/.gitconfig).

Create a single function for installing a branch into
the config file.  Both 'clone' and 'branch' now use the
same function for installing branches.

Refactored as suggested by Junio C. Hamano.

Signed-off-by: Pat Notz <pknotz@sandia.gov>
---
 branch.c         |   54 ++++++++++++++++++++++++++++++++++++++----------------
 branch.h         |   11 +++++++++++
 builtin-clone.c  |   24 ++++++++----------------
 t/t5601-clone.sh |   15 +++++++++++++++
 4 files changed, 72 insertions(+), 32 deletions(-)

diff --git a/branch.c b/branch.c
index 1f00e44..332223b 100644
--- a/branch.c
+++ b/branch.c
@@ -32,21 +32,52 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	return 0;
 }
 
-static int should_setup_rebase(const struct tracking *tracking)
+static int should_setup_rebase(const char * origin)
 {
 	switch (autorebase) {
 	case AUTOREBASE_NEVER:
 		return 0;
 	case AUTOREBASE_LOCAL:
-		return tracking->remote == NULL;
+		return origin == NULL;
 	case AUTOREBASE_REMOTE:
-		return tracking->remote != NULL;
+		return origin != NULL;
 	case AUTOREBASE_ALWAYS:
 		return 1;
 	}
 	return 0;
 }
 
+void install_branch_config(int verbose_flag,
+			   const char *local,
+			   const char *origin,
+			   const char *remote)
+{
+	struct strbuf key = STRBUF_INIT;
+	int rebasing = should_setup_rebase(origin);
+
+	strbuf_addf(&key, "branch.%s.remote", local);
+	git_config_set(key.buf, origin ? origin : ".");
+
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.merge", local);
+	git_config_set(key.buf, remote);
+
+	if (rebasing) {
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.rebase", local);
+		git_config_set(key.buf, "true");
+	}
+
+	if (verbose_flag & BRANCH_CONFIG_VERBOSE)
+		printf("Branch %s set up to track %s branch %s %s.\n",
+			local,
+			origin ? "remote" : "local",
+			remote,
+			rebasing ? "by rebasing" : "by merging");
+	strbuf_release(&key);
+}
+
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -55,7 +86,6 @@ static int should_setup_rebase(const struct tracking *tracking)
 static int setup_tracking(const char *new_ref, const char *orig_ref,
                           enum branch_track track)
 {
-	char key[1024];
 	struct tracking tracking;
 
 	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
@@ -79,18 +109,10 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	if (tracking.matches > 1)
 		return error("Not tracking: ambiguous information for ref %s",
 				orig_ref);
-
-	sprintf(key, "branch.%s.remote", new_ref);
-	git_config_set(key, tracking.remote ?  tracking.remote : ".");
-	sprintf(key, "branch.%s.merge", new_ref);
-	git_config_set(key, tracking.src ? tracking.src : orig_ref);
-	printf("Branch %s set up to track %s branch %s.\n", new_ref,
-		tracking.remote ? "remote" : "local", orig_ref);
-	if (should_setup_rebase(&tracking)) {
-		sprintf(key, "branch.%s.rebase", new_ref);
-		git_config_set(key, "true");
-		printf("This branch will rebase on pull.\n");
-	}
+	install_branch_config(BRANCH_CONFIG_VERBOSE,
+			      new_ref,
+			      tracking.remote,
+			      tracking.src ? tracking.src : orig_ref);
 	free(tracking.src);
 
 	return 0;
diff --git a/branch.h b/branch.h
index 9f0c2a2..9f7fdb0 100644
--- a/branch.h
+++ b/branch.h
@@ -21,4 +21,15 @@ void create_branch(const char *head, const char *name, const char *start_name,
  */
 void remove_branch_state(void);
 
+/*
+ * Configure local branch "local" to merge remote branch "remote"
+ * taken from origin "origin".
+ */
+#define BRANCH_CONFIG_QUIET   00
+#define BRANCH_CONFIG_VERBOSE 01
+void install_branch_config(int verbose_flag,
+			   const char *local,
+			   const char *origin,
+			   const char *remote);
+
 #endif
diff --git a/builtin-clone.c b/builtin-clone.c
index c338910..e1abf83 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -17,6 +17,7 @@
 #include "unpack-trees.h"
 #include "transport.h"
 #include "strbuf.h"
+#include "branch.h"
 #include "dir.h"
 #include "pack-refs.h"
 #include "sigchain.h"
@@ -350,19 +351,6 @@ static struct ref *write_remote_refs(const struct ref *refs,
 	return local_refs;
 }
 
-static void install_branch_config(const char *local,
-				  const char *origin,
-				  const char *remote)
-{
-	struct strbuf key = STRBUF_INIT;
-	strbuf_addf(&key, "branch.%s.remote", local);
-	git_config_set(key.buf, origin);
-	strbuf_reset(&key);
-	strbuf_addf(&key, "branch.%s.merge", local);
-	git_config_set(key.buf, remote);
-	strbuf_release(&key);
-}
-
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int use_local_hardlinks = 1;
@@ -553,8 +541,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare)
-			install_branch_config("master", option_origin,
-					      "refs/heads/master");
+			install_branch_config(BRANCH_CONFIG_QUIET,
+					     "master",
+					     option_origin,
+					     "refs/heads/master");
 	}
 
 	if (head_points_at) {
@@ -583,7 +573,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				      head_points_at->peer_ref->name,
 				      reflog_msg.buf);
 
-			install_branch_config(head, option_origin,
+			install_branch_config(BRANCH_CONFIG_QUIET,
+					      head,
+					      option_origin,
 					      head_points_at->name);
 		}
 	} else if (remote_head) {
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 44793f2..fa10573 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -159,4 +159,19 @@ test_expect_success 'clone a void' '
 	test_cmp target-6/.git/config target-7/.git/config
 '
 
+test_expect_success 'clone respects global branch.autosetuprebase' '
+	(
+		HOME="`pwd`" &&
+		export HOME &&
+		test_config="$HOME"/.gitconfig &&
+		unset GIT_CONFIG_NOGLOBAL &&
+		git config -f "$test_config" branch.autosetuprebase remote &&
+		rm -fr dst &&
+		git clone src dst &&
+		cd dst &&
+		actual="z$(git config branch.master.rebase)" &&
+		test ztrue = $actual
+	)
+'
+
 test_done
-- 
1.6.1.2
