From: "Pat Notz" <pknotz@sandia.gov>
Subject: [PATCHv3] Make git-clone respect branch.autosetuprebase
Date: Tue, 3 Mar 2009 13:23:45 -0700
Message-ID: <1236111825-32159-1-git-send-email-pknotz@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Pat Notz" <pknotz@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 21:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LebBA-00045H-A9
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 21:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbZCCUX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 15:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbZCCUX7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 15:23:59 -0500
Received: from sentry-three.sandia.gov ([132.175.109.17]:52800 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbZCCUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 15:23:58 -0500
X-WSS-ID: 0KFY600-08-KG5-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Tumbleweed MailGate 3.6.1) with ESMTP id 210D98CBDC6
	for <git@vger.kernel.org>; Tue,  3 Mar 2009 13:24:00 -0700 (MST)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 03 Mar 2009 13:23:46 -0700
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.1/8.14.1) with ESMTP id n23KNkkW014965 for
 <git@vger.kernel.org>; Tue, 3 Mar 2009 13:23:46 -0700
Received: from localhost.localdomain (134.253.246.168) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.1.340.0; Tue, 3 Mar 2009 13:23:45 -0700
X-Mailer: git-send-email 1.6.1.2
X-TMWD-Spam-Summary: TS=20090303202346; ID=1; SEV=2.3.1;
 DFV=B2009030316; IFV=NA; AIF=B2009030316; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230312E34394144393144322E303138303A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAAAAAAAAAAAAAAAAAAAAAAAfQ==
X-MMS-Spam-Filter-ID: B2009030316_5.03.0010
X-WSS-ID: 65B34E583BW745702-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112164>

When git-clone creates an initial branch it was not
checking the branch.autosetuprebase configuration
option (which may exist in ~/.gitconfig).

Added function to branch.c to handle autorebase
configuration setup.

Signed-off-by: Pat Notz <pknotz@sandia.gov>
---

Sorry, the PATCHv2 email had a stray "From:..." line.

 branch.c         |   23 ++++++++++++++++-------
 branch.h         |    9 +++++++++
 builtin-clone.c  |    3 +++
 t/t5601-clone.sh |   14 ++++++++++++++
 4 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index 1f00e44..ee8b69d 100644
--- a/branch.c
+++ b/branch.c
@@ -32,21 +32,33 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	return 0;
 }
 
-static int should_setup_rebase(const struct tracking *tracking)
+static int should_setup_rebase(const char * remote)
 {
 	switch (autorebase) {
 	case AUTOREBASE_NEVER:
 		return 0;
 	case AUTOREBASE_LOCAL:
-		return tracking->remote == NULL;
+		return remote == NULL;
 	case AUTOREBASE_REMOTE:
-		return tracking->remote != NULL;
+		return remote != NULL;
 	case AUTOREBASE_ALWAYS:
 		return 1;
 	}
 	return 0;
 }
 
+int setup_autorebase(const char *local, const char *remote_tracked_branch)
+{
+	if (should_setup_rebase(remote_tracked_branch)) {
+		struct strbuf key = STRBUF_INIT;
+		strbuf_addf(&key, "branch.%s.rebase", local);
+		git_config_set(key.buf, "true");
+		strbuf_release(&key);
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -86,11 +98,8 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	git_config_set(key, tracking.src ? tracking.src : orig_ref);
 	printf("Branch %s set up to track %s branch %s.\n", new_ref,
 		tracking.remote ? "remote" : "local", orig_ref);
-	if (should_setup_rebase(&tracking)) {
-		sprintf(key, "branch.%s.rebase", new_ref);
-		git_config_set(key, "true");
+	if (setup_autorebase(new_ref, tracking.remote))
 		printf("This branch will rebase on pull.\n");
-	}
 	free(tracking.src);
 
 	return 0;
diff --git a/branch.h b/branch.h
index 9f0c2a2..b332c09 100644
--- a/branch.h
+++ b/branch.h
@@ -21,4 +21,13 @@ void create_branch(const char *head, const char *name, const char *start_name,
  */
 void remove_branch_state(void);
 
+/*
+ * Used when creating a new branch to properly setup the autorebase flag
+ * in the git-config file.  If the new branch ("local") is created from
+ * a remote branch then remote_tracked_branch should be non-NULL.  If
+ * the new branch is being created from another local branch then
+ * remote_tracked_branch should be NULL.
+ */
+int setup_autorebase(const char *local, const char *remote_tracked_branch);
+
 #endif
diff --git a/builtin-clone.c b/builtin-clone.c
index c338910..587c834 100644
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
@@ -360,6 +361,8 @@ static void install_branch_config(const char *local,
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
 	git_config_set(key.buf, remote);
+	if (setup_autorebase(local, remote))
+		printf("Default branch '%s' will rebase on pull.\n", local);
 	strbuf_release(&key);
 }
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 44793f2..0f8b43c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -159,4 +159,18 @@ test_expect_success 'clone a void' '
 	test_cmp target-6/.git/config target-7/.git/config
 '
 
+test_expect_success 'clone respects global branch.autosetuprebase' '
+	HOME="`pwd`" &&
+	export HOME &&
+	test_config="$HOME"/.gitconfig &&
+	unset GIT_CONFIG_NOGLOBAL &&
+	git config -f "$test_config" branch.autosetuprebase remote &&
+	rm -fr dst &&
+	git clone src dst &&
+	cd dst &&
+	expected="ztrue" &&
+	actual="z$(git config branch.master.rebase)" &&
+	test $expected = $actual
+'
+
 test_done
-- 
1.6.1.2
