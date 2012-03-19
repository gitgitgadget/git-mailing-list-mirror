From: Christopher Tiwald <christiwald@gmail.com>
Subject: [PATCH v2] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 19 Mar 2012 03:49:44 -0400
Message-ID: <20120319074944.GA18489@democracyinaction.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: zbyszek@in.waw.pl, Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	drizzd@aon.at
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 08:50:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9XLs-0000ME-Tp
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 08:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab2CSHtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 03:49:52 -0400
Received: from email.democracyinaction.org ([69.174.82.44]:47198 "EHLO
	email.democracyinaction.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752938Ab2CSHtv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 03:49:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by email.democracyinaction.org (Postfix) with ESMTP id 205B723416C;
	Mon, 19 Mar 2012 03:49:50 -0400 (EDT)
X-Virus-Scanned: amavisd-new at email.democracyinaction.org
Received: from email.democracyinaction.org ([127.0.0.1])
	by localhost (email.democracyinaction.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2vWmpgxx4qOz; Mon, 19 Mar 2012 03:49:46 -0400 (EDT)
Received: from democracyinaction.org (cpe-74-66-248-47.nyc.res.rr.com [74.66.248.47])
	by email.democracyinaction.org (Postfix) with ESMTPSA id F0F7F23406D;
	Mon, 19 Mar 2012 03:49:45 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193417>

Pushing a non-fast-forward update to a remote repository will result in
an error, but the hint text doesn't provide the correct resolution in
every case. Give better resolution advice in three push scenarios:

1) If you push a non-fast-forward update to your current branch, you
should merge remote changes with 'git pull' before pushing again.

2) If you push to a shared repository others push to, and your local
tracking branches are not kept up to date, the 'matching refs' default
will generate non-fast-forward errors on outdated branches. If this is
your workflow, the 'matching refs' default is not for you. Consider
setting the 'push.default' configuration variable to 'current' or
'upstream' to ensure only your current branch is pushed.

3) If you explicitly specify a ref that is not your current branch or
push matching branches with ':', you will generate a non-fast-forward
error if any pushed branch tip is out of date. You should checkout the
offending branch and merge remote changes before pushing again.

Teach transport.c to recognize these scenarios and push.c to hint for
them. Do it with a switch statement so if 'git push's default behavior
changes or we discover more scenarios, modification is easy. Standardize
on the advice API and replace 'advice.pushNonFastForward' with two new
config variables, 'advice.pushNonFFCurrent' and 'advice.pushNonFFOther'.
Resolving a non-fast-forward error on your current branch requires
different operations than resolving one on a non-current branch. It
shouldn't be possible to disable both types of advice with one config
option.

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Christopher Tiwald <christiwald@gmail.com>
---
 Changes in v2:
	- Cleaned up language in both the commit and advice messages.
	- Uses advice.c::advise(), standardizing the API used and
	  providing support for i18n.
	- Uses a switch statement to select advice, rather than
	  if-statements, making this feature more extensible.
	- v1 used three non-ff advice variables and neglected to delete the
	  original. v2 replaces the original with two, which more
	  precisely matches the two types of errors we're trying to
	  advise:

	  non-ff errors on the current branch
	  non-ff errors on other branches, but not current

	- Shortened the nonfastforward enum name to make it more
	  readable.

 v2 should capture all the various comments about this patch, although
 I did make a few minor changes to the advice and settled on two config
 variables rather than one or three.
 
 There is one aspect about this patch about which I'm unsure: What to
 do with users who've set "advice.pushNonFastForward = false" already.
 I could leave the variable in advice.c and modify push.c to respect
 it easily, but at that point we're almost configuring advice.c to
 "turn off advice for this command".

 I don't know. Maybe that's the way we want to go with advice. I
 suppose it's largely a function of how much advice we have to give and
 whether or not it's useful to new users.

 Documentation/config.txt |   10 +++++---
 advice.c                 |    6 +++--
 advice.h                 |    3 ++-
 builtin/push.c           |   60 ++++++++++++++++++++++++++++++++++++++++++----
 cache.h                  |    8 +++++--
 environment.c            |    2 +-
 transport.c              |   13 ++++++++--
 7 files changed, 86 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c081657..a2329b5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -137,9 +137,13 @@ advice.*::
 	can tell Git that you do not need help by setting these to 'false':
 +
 --
-	pushNonFastForward::
-		Advice shown when linkgit:git-push[1] refuses
-		non-fast-forward refs.
+	pushNonFFCurrent::
+		Advice shown when linkgit:git-push[1] fails due to a
+		non-fast-forward update to the current branch.
+	pushNonFFOther::
+		Advice shown when linkgit:git-push[1] fails due to a
+		non-fast-forward update to a branch other than the
+		current one.
 	statusHints::
 		Directions on how to stage/unstage/add shown in the
 		output of linkgit:git-status[1] and the template shown
diff --git a/advice.c b/advice.c
index 01130e5..ee62e1b 100644
--- a/advice.c
+++ b/advice.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 
-int advice_push_nonfastforward = 1;
+int advice_push_non_ff_current = 1;
+int advice_push_non_ff_other = 1;
 int advice_status_hints = 1;
 int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
@@ -11,7 +12,8 @@ static struct {
 	const char *name;
 	int *preference;
 } advice_config[] = {
-	{ "pushnonfastforward", &advice_push_nonfastforward },
+	{ "pushnonffcurrent", &advice_push_non_ff_current },
+	{ "pushnonffother", &advice_push_non_ff_other },
 	{ "statushints", &advice_status_hints },
 	{ "commitbeforemerge", &advice_commit_before_merge },
 	{ "resolveconflict", &advice_resolve_conflict },
diff --git a/advice.h b/advice.h
index 7bda45b..98c675e 100644
--- a/advice.h
+++ b/advice.h
@@ -3,7 +3,8 @@
 
 #include "git-compat-util.h"
 
-extern int advice_push_nonfastforward;
+extern int advice_push_non_ff_current;
+extern int advice_push_non_ff_other;
 extern int advice_status_hints;
 extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
diff --git a/builtin/push.c b/builtin/push.c
index d315475..3de2737 100644
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
@@ -114,6 +118,45 @@ static void setup_default_push_refspecs(struct remote *remote)
 	}
 }
 
+static const char message_advice_pull_before_push[] =
+	N_("Updates were rejected because the tip of your current branch is behind\n"
+	   "its remote counterpart. Merge the remote changes (e.g. 'git pull')\n"
+	   "before pushing again.\n"
+	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
+
+static const char message_advice_use_upstream[] =
+	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
+	   "counterpart. If you did not intend to push that branch, you may want to\n"
+	   "specify branches to push or set the 'push.default' configuration\n"
+	   "variable to 'current' or 'upstream' to push only the current branch.");
+
+static const char message_advice_checkout_pull_push[] =
+	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
+	   "counterpart. Check out this branch and merge the remote changes\n"
+	   "(e.g. 'git pull') before pushing again.\n"
+	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
+
+static void advise_pull_before_push(void)
+{
+	if (!advice_push_non_ff_current)
+		return;
+	advise(_(message_advice_pull_before_push));
+}
+
+static void advise_use_upstream(void)
+{
+	if (!advice_push_non_ff_other)
+		return;
+	advise(_(message_advice_use_upstream));
+}
+
+static void advise_checkout_pull_push(void)
+{
+	if (!advice_push_non_ff_other)
+		return;
+	advise(_(message_advice_checkout_pull_push));
+}
+
 static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
@@ -135,14 +178,21 @@ static int push_with_options(struct transport *transport, int flags)
 		error(_("failed to push some refs to '%s'"), transport->url);
 
 	err |= transport_disconnect(transport);
-
 	if (!err)
 		return 0;
 
-	if (nonfastforward && advice_push_nonfastforward) {
-		fprintf(stderr, _("To prevent you from losing history, non-fast-forward updates were rejected\n"
-				"Merge the remote changes (e.g. 'git pull') before pushing again.  See the\n"
-				"'Note about fast-forwards' section of 'git push --help' for details.\n"));
+	switch (nonfastforward) {
+	default:
+		break;
+	case NON_FF_HEAD:
+		advise_pull_before_push();
+		break;
+	case NON_FF_OTHER:
+		if (default_matching_used)
+			advise_use_upstream();
+		else
+			advise_checkout_pull_push();
+		break;
 	}
 
 	return 1;
diff --git a/cache.h b/cache.h
index e5e1aa4..427b600 100644
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
@@ -1019,6 +1019,10 @@ struct ref {
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT
 	} status;
+	enum {
+		NON_FF_HEAD = 1,
+		NON_FF_OTHER
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
index 181f8f2..7864007 100644
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
@@ -738,8 +742,13 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
-		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
-			*nonfastforward = 1;
+		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD &&
+		    *nonfastforward != NON_FF_HEAD) {
+			if (!strcmp(head, ref->name))
+				*nonfastforward = NON_FF_HEAD;
+			else
+				*nonfastforward = NON_FF_OTHER;
+		}
 	}
 }
 
-- 
1.7.10.rc1.25.gff0ac.dirty
