From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] Make git-clone respect branch.autosetuprebase
Date: Tue, 03 Mar 2009 22:29:55 -0800
Message-ID: <7vsklt94ws.fsf@gitster.siamese.dyndns.org>
References: <1236111825-32159-1-git-send-email-pknotz@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <pknotz@sandia.gov>
X-From: git-owner@vger.kernel.org Wed Mar 04 07:33:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lekf4-00075G-3y
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 07:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbZCDGaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 01:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbZCDGaO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 01:30:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZCDGaM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 01:30:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 16560323A;
	Wed,  4 Mar 2009 01:30:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 01BF53239; Wed, 
 4 Mar 2009 01:30:06 -0500 (EST)
In-Reply-To: <1236111825-32159-1-git-send-email-pknotz@sandia.gov> (Pat
 Notz's message of "Tue, 3 Mar 2009 13:23:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E9058514-0885-11DE-8807-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112183>

"Pat Notz" <pknotz@sandia.gov> writes:

> When git-clone creates an initial branch it was not
> checking the branch.autosetuprebase configuration
> option (which may exist in ~/.gitconfig).
>
> Added function to branch.c to handle autorebase
> configuration setup.
>
> Signed-off-by: Pat Notz <pknotz@sandia.gov>

Thanks.

Your patch still has two codepaths that set the branch.*.merge and other
information and they can diverge with later changes.  You can refactor
them even more to avoid that risk, like the attached patch.

The test is taken from your patch but runs inside a subshell, so that
later tests others may add to the script will be safer from the
environment variable settings and chdir this test does.

-- >8 --

When git-clone creates an initial branch it was not checking the
branch.autosetuprebase configuration option (which may exist in
~/.gitconfig).  Refactor the code used by "git branch" to create
a new branch, and use it instead of the insufficiently duplicated code
in builtin-clone.

---
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
index c338910..a5f000a 100644
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
 	int use_local_hardlinks = 1;
@@ -553,7 +541,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare)
-			install_branch_config("master", option_origin,
+			install_branch_config(0, "master", option_origin,
 					      "refs/heads/master");
 	}
 
@@ -583,7 +571,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
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
