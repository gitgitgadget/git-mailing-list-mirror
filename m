From: Christopher Tiwald <christiwald@gmail.com>
Subject: [PATCH] push: Provide situational hints for non-fast-forward errors
Date: Tue, 13 Mar 2012 19:22:57 -0400
Message-ID: <20120313232256.GA49626@democracyinaction.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 00:32:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7bCh-0006W7-EE
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 00:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab2CMXc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 19:32:27 -0400
Received: from email.democracyinaction.org ([69.174.82.44]:46691 "EHLO
	email.democracyinaction.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754740Ab2CMXcY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 19:32:24 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Mar 2012 19:32:24 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by email.democracyinaction.org (Postfix) with ESMTP id 0FE1B2344AF;
	Tue, 13 Mar 2012 19:23:02 -0400 (EDT)
X-Virus-Scanned: amavisd-new at email.democracyinaction.org
Received: from email.democracyinaction.org ([127.0.0.1])
	by localhost (email.democracyinaction.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6vPOo9gieJhl; Tue, 13 Mar 2012 19:23:00 -0400 (EDT)
Received: from democracyinaction.org (unknown [216.55.38.246])
	by email.democracyinaction.org (Postfix) with ESMTPSA id 366762344B9;
	Tue, 13 Mar 2012 19:22:59 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193079>

Pushing a non-fast-forward update to a remote repository will result in
an error, but the hint text doesn't provide the correct resolution in
every case. Three scenarios may arise depending on your workflow, each
with a different resolution:

1) If you push a non-fast-forward update to HEAD, you should merge
remote changes with 'git pull' before pushing again.

2) If you push to a shared repository others push to, and your local
tracking branches are not kept up to date, the 'matching refs' default
will generate non-fast-forward errors on outdated branches. If this is
your workflow, the 'matching refs' default is not for you. Consider
setting the 'push.default' configuration variable to 'upstream' to
ensure only your checked-out branch is pushed.

3) If you push with explicit ref matching (e.g. 'git push ... topic:topic')
while checked out on another branch (e.g. 'master'), the correct
resolution is checking out the local branch, issuing git pull, and
merging remote changes before pushing again.

Make nonfastforward an enum and teach transport.c to detect the
scenarios described above. Give situation-specific resolution advice
when pushes are rejected due to non-fast-forward updates. Finally,
update other instances of nonfastforward to use the proper enum option.

Signed-off-by: Christopher Tiwald <christiwald@gmail.com>
Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
---
This is a reroll of jc/advise-push-default (2011-12-18). Apologies if
it is out of band. I saw some chatter recently about 1.7.10.rc*. I
wasn't sure if that meant "Don't submit patches at this point in the
cycle" or "Feel free to submit patches, but they might not be
acknowledged for a while." Mostly, I wanted to move this topic out of
stalled in the "What's Cooking" emails. I'm happy to resubmit at a
better time.

The patch is based on jc/advise-push-default and attempts to
implement Peff's logic in [1]. It would also require a change if the
push default behavior changes [2], but I think the core logic is
sound. `git push` should be smart enough to distinguish different
types of non-fast-forward updates and advise accordingly regardless of
its default.

[1] http://thread.gmane.org/gmane.comp.version-control.git/187079/focus=187447
[2] http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694

 Documentation/config.txt |   15 ++++++++++
 advice.c                 |    6 ++++
 advice.h                 |    3 ++
 builtin/push.c           |   72 ++++++++++++++++++++++++++++++++++++++++++----
 builtin/send-pack.c      |    2 +-
 cache.h                  |    9 ++++--
 environment.c            |    2 +-
 transport.c              |   17 ++++++++---
 8 files changed, 112 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c081657..50d9249 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -158,6 +158,21 @@ advice.*::
 		Advice shown when you used linkgit:git-checkout[1] to
 		move to the detach HEAD state, to instruct how to create
 		a local branch after the fact.
+	pullBeforePush::
+		Advice shown when you ran linkgit:git-push[1] and pushed
+		a non-fast-forward update to HEAD, instructing you to
+		linkgit:git-pull[1] before pushing again.
+	useUpstream::
+		Advice to set 'push.default' to 'upstream' when you ran
+		linkgit:git-push[1] and pushed 'matching refs' by default
+		(i.e. you did not have any explicit refspec on the command
+		line, and no 'push.default' configuration was set) and it
+		resulted in a non-fast-forward error.
+	checkoutPullPush::
+		Advice shown when you ran linkgit:git-push[1] and pushed
+		a non-fast-forward update to a non-HEAD branch, instructing
+		you to checkout the branch and run linkgit:git-pull[1]
+		before pushing again.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index 01130e5..608e90d 100644
--- a/advice.c
+++ b/advice.c
@@ -6,6 +6,9 @@ int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
+int advice_pull_before_push = 1;
+int advice_use_upstream = 1;
+int advice_checkout_pull_push = 1;
 
 static struct {
 	const char *name;
@@ -17,6 +20,9 @@ static struct {
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
+	{ "pullbeforepush", &advice_pull_before_push },
+	{ "useupstream", &advice_use_upstream },
+	{ "checkoutpullpush", &advice_checkout_pull_push }
 };
 
 void advise(const char *advice, ...)
diff --git a/advice.h b/advice.h
index 7bda45b..ac07a44 100644
--- a/advice.h
+++ b/advice.h
@@ -9,6 +9,9 @@ extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
+extern int advice_use_upstream;
+extern int advice_pull_before_push;
+extern int advice_checkout_pull_push;
 
 int git_default_advice_config(const char *var, const char *value);
 void advise(const char *advice, ...);
diff --git a/builtin/push.c b/builtin/push.c
index d315475..0fecf06 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -24,6 +24,7 @@ static int progress = -1;
 static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
+static int default_matching_used;
 
 static void add_refspec(const char *ref)
 {
@@ -95,6 +96,9 @@ static void setup_default_push_refspecs(struct remote *remote)
 {
 	switch (push_default) {
 	default:
+	case PUSH_DEFAULT_UNSPECIFIED:
+		default_matching_used = 1;
+		/* fallthru */
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
 		break;
@@ -114,6 +118,59 @@ static void setup_default_push_refspecs(struct remote *remote)
 	}
 }
 
+static const char *message_advice_pull_before_push[] = {
+	"To prevent you from losing history, non-fast-forward updates to HEAD",
+	"were rejected. Merge the remote changes (e.g. 'git pull') before",
+	"pushing again. See the 'Note about fast-forwards' section of",
+	"'git push --help' for details."
+};
+
+static const char *message_advice_use_upstream[] = {
+	"By default, git pushes all branches that have a matching counterpart",
+	"on the remote. In this case, some of your local branches were stale",
+	"with respect to their remote counterparts. If you did not intend to",
+	"push these branches, you may want to set the 'push.default'",
+	"configuration variable to 'upstream' to push only the current branch."
+};
+
+static const char *message_advice_checkout_pull_push[] = {
+	"To prevent you from losing history, your non-fast-forward branch",
+	"updates were rejected. Checkout the branch and merge the remote",
+	"changes (e.g. 'git pull') before pushing again. See the",
+	"'Note about fast-forwards' section of 'git push --help' for",
+	"details."
+};
+
+static void advise_pull_before_push(void)
+{
+	int i;
+
+	if (!advice_pull_before_push)
+		return;
+	for (i = 0; i < ARRAY_SIZE(message_advice_pull_before_push); i++)
+		advise(message_advice_pull_before_push[i]);
+}
+
+static void advise_use_upstream(void)
+{
+	int i;
+
+	if (!advice_use_upstream)
+		return;
+	for (i = 0; i < ARRAY_SIZE(message_advice_use_upstream); i++)
+		advise(message_advice_use_upstream[i]);
+}
+
+static void advise_checkout_pull_push(void)
+{
+	int i;
+
+	if (!advice_checkout_pull_push)
+		return;
+	for (i = 0; i < ARRAY_SIZE(message_advice_checkout_pull_push); i++)
+		advise(message_advice_checkout_pull_push[i]);
+}
+
 static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
@@ -136,15 +193,18 @@ static int push_with_options(struct transport *transport, int flags)
 
 	err |= transport_disconnect(transport);
 
+	if (nonfastforward == NONFASTFORWARD_HEAD) {
+		advise_pull_before_push();
+	} else if (nonfastforward == NONFASTFORWARD_OTHER) {
+		if (default_matching_used)
+			advise_use_upstream();
+		else
+			advise_checkout_pull_push();
+	}
+
 	if (!err)
 		return 0;
 
-	if (nonfastforward && advice_push_nonfastforward) {
-		fprintf(stderr, _("To prevent you from losing history, non-fast-forward updates were rejected\n"
-				"Merge the remote changes (e.g. 'git pull') before pushing again.  See the\n"
-				"'Note about fast-forwards' section of 'git push --help' for details.\n"));
-	}
-
 	return 1;
 }
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 9df341c..09895b9 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -409,7 +409,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int send_all = 0;
 	const char *receivepack = "git-receive-pack";
 	int flags;
-	int nonfastforward = 0;
+	int nonfastforward = NONFASTFORWARD_NONE;
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
diff --git a/cache.h b/cache.h
index e5e1aa4..14bc305 100644
--- a/cache.h
+++ b/cache.h
@@ -625,7 +625,8 @@ enum push_default_type {
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_UPSTREAM,
-	PUSH_DEFAULT_CURRENT
+	PUSH_DEFAULT_CURRENT,
+	PUSH_DEFAULT_UNSPECIFIED
 };
 
 extern enum branch_track git_branch_track;
@@ -1008,7 +1009,6 @@ struct ref {
 	char *symref;
 	unsigned int force:1,
 		merge:1,
-		nonfastforward:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
@@ -1019,6 +1019,11 @@ struct ref {
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT
 	} status;
+	enum {
+		NONFASTFORWARD_NONE = 0,
+		NONFASTFORWARD_HEAD,
+		NONFASTFORWARD_OTHER
+	} nonfastforward;
 	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
diff --git a/environment.c b/environment.c
index c93b8f4..d7e6c65 100644
--- a/environment.c
+++ b/environment.c
@@ -52,7 +52,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
-enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
+enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
diff --git a/transport.c b/transport.c
index 181f8f2..23210d5 100644
--- a/transport.c
+++ b/transport.c
@@ -721,6 +721,10 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 {
 	struct ref *ref;
 	int n = 0;
+	unsigned char head_sha1[20];
+	char *head;
+
+	head = resolve_refdup("HEAD", head_sha1, 1, NULL);
 
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
@@ -732,14 +736,19 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		if (ref->status == REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 
-	*nonfastforward = 0;
+	*nonfastforward = NONFASTFORWARD_NONE;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
-		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
-			*nonfastforward = 1;
+		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD &&
+		    *nonfastforward != NONFASTFORWARD_HEAD) {
+			if (!strcmp(head, ref->name))
+				*nonfastforward = NONFASTFORWARD_HEAD;
+			else
+				*nonfastforward = NONFASTFORWARD_OTHER;
+		}
 	}
 }
 
@@ -1008,7 +1017,7 @@ int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
 		   int *nonfastforward)
 {
-	*nonfastforward = 0;
+	*nonfastforward = NONFASTFORWARD_NONE;
 	transport_verify_remote_names(refspec_nr, refspec);
 
 	if (transport->push) {
-- 
1.7.10.rc0.42.gefc97.dirty
