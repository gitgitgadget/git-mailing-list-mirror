Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 6133 invoked by uid 107); 10 Mar 2009 03:27:17 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 09 Mar 2009 23:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbZCJD1H (ORCPT <rfc822;peff@peff.net>);
	Mon, 9 Mar 2009 23:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbZCJD1G
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 23:27:06 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:33530 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbZCJD1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 23:27:05 -0400
X-WSS-ID: 0KG9TLB-08-7KQ-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Tumbleweed MailGate 3.6.1) with ESMTP id 247B1901B55;
	Mon,  9 Mar 2009 21:27:10 -0600 (MDT)
Received: from [134.253.165.160] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Mon, 09 Mar 2009 21:26:55 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from localhost.localdomain (134.253.112.216) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.1.340.0; Mon, 9 Mar 2009 21:26:51 -0600
From:	"Pat Notz" <pknotz@sandia.gov>
To:	git@vger.kernel.org
cc:	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCHv5] Make git-clone respect branch.autosetuprebase
Date:	Mon, 9 Mar 2009 21:26:50 -0600
Message-ID: <1236655610-14236-1-git-send-email-pknotz@sandia.gov>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1cd1989b0903060621w60124401s9986507e356783b1@mail.gmail.com>
References: <1cd1989b0903060621w60124401s9986507e356783b1@mail.gmail.com>
MIME-Version: 1.0
X-TMWD-Spam-Summary: TS=20090310032655; ID=1; SEV=2.3.1;
 DFV=B2009031002; IFV=NA; AIF=B2009031002; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230392E34394235444446462E303042302C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAAAAAAAAAAAAAAAAAAAAAAAfQ==
X-MMS-Spam-Filter-ID: B2009031002_5.03.0010
X-WSS-ID: 65AB02753BW1190882-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

When git-clone creates an initial branch it was not checking the
branch.autosetuprebase configuration option (which may exist in
~/.gitconfig).  Refactor the code used by "git branch" to create
a new branch, and use it instead of the insufficiently duplicated code
in builtin-clone.

Minor modification of the patch from Junio Hamano.
---

This version fixes the verbose output to be more human friendly.  Before,
the branch being tracked was printed as 'refs/heads/frotz' regardless of
wether that was a local or remote branch.  Now, a local branch is just
printed as 'frotz' and a remote branch is printed as 'origin/frotz'

 branch.c         |   49 +++++++++++++++++++++++++++++++++----------------
 branch.h         |    7 +++++++
 builtin-clone.c  |   18 +++---------------
 t/t5601-clone.sh |   15 +++++++++++++++
 4 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/branch.c b/branch.c
index 1f00e44..d20fb04 100644
--- a/branch.c
+++ b/branch.c
@@ -32,21 +32,48 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	return 0;
 }
 
-static int should_setup_rebase(const struct tracking *tracking)
+static int should_setup_rebase(const char *origin)
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
 
+void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
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
+	if (flag & BRANCH_CONFIG_VERBOSE)
+		printf("Branch %s set up to track %s branch %s %s.\n",
+		       local,
+		       origin ? "remote" : "local",
+		       remote,
+		       rebasing ? "by rebasing" : "by merging");
+	strbuf_release(&key);
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -55,7 +82,6 @@ static int should_setup_rebase(const struct tracking *tracking)
 static int setup_tracking(const char *new_ref, const char *orig_ref,
                           enum branch_track track)
 {
-	char key[1024];
 	struct tracking tracking;
 
 	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
@@ -80,19 +106,10 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 		return error("Not tracking: ambiguous information for ref %s",
 				orig_ref);
 
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
-	free(tracking.src);
+	install_branch_config(BRANCH_CONFIG_VERBOSE, new_ref, tracking.remote,
+			      tracking.src ? tracking.src : orig_ref);
 
+	free(tracking.src);
 	return 0;
 }
 
diff --git a/branch.h b/branch.h
index 9f0c2a2..eed817a 100644
--- a/branch.h
+++ b/branch.h
@@ -21,4 +21,11 @@ void create_branch(const char *head, const char *name, const char *start_name,
  */
 void remove_branch_state(void);
 
+/*
+ * Configure local branch "local" to merge remote branch "remote"
+ * taken from origin "origin".
+ */
+#define BRANCH_CONFIG_VERBOSE 01
+extern void install_branch_config(int flag, const char *local, const char *origin, const char *remote);
+
 #endif
diff --git a/builtin-clone.c b/builtin-clone.c
index 92826cd..687df9a 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -20,6 +20,7 @@
 #include "dir.h"
 #include "pack-refs.h"
 #include "sigchain.h"
+#include "branch.h"
 
 /*
  * Overall FIXMEs:
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
 	int is_bundle = 0;
@@ -547,7 +535,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare)
-			install_branch_config("master", option_origin,
+			install_branch_config(0, "master", option_origin,
 					      "refs/heads/master");
 	}
 
@@ -577,7 +565,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				      head_points_at->peer_ref->name,
 				      reflog_msg.buf);
 
-			install_branch_config(head, option_origin,
+			install_branch_config(0, head, option_origin,
 					      head_points_at->name);
 		}
 	} else if (remote_head) {
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 44793f2..2335d8b 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -159,4 +159,19 @@ test_expect_success 'clone a void' '
 	test_cmp target-6/.git/config target-7/.git/config
 '
 
+test_expect_success 'clone respects global branch.autosetuprebase' '
+	(
+		HOME=$(pwd) &&
+		export HOME &&
+		test_config="$HOME/.gitconfig" &&
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
1.6.2


