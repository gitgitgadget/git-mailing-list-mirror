From: Christopher Tiwald <christiwald@gmail.com>
Subject: [PATCH v3] push: Provide situational hints for non-fast-forward
 errors
Date: Tue, 20 Mar 2012 00:31:33 -0400
Message-ID: <20120320043133.GA2755@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, zbyszek@in.waw.pl, Matthieu.Moy@grenoble-inp.fr,
	drizzd@aon.at
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 05:32:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9qk9-0007I5-6u
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 05:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923Ab2CTEbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 00:31:43 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35080 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab2CTEbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 00:31:42 -0400
Received: by qcqw6 with SMTP id w6so1601660qcq.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 21:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=7i6qIsqbFuFTw38H675ohPIilof1WZjSUNmUVAJGnYM=;
        b=VI6ozTuMOKtZONDsPHGZZdkYwEPrDmMlHzkzrwETPTsEoG9BhOgS8Vn0IL3DMQWKnX
         EtQLeoazw+NcrCeEreXKKj/x20WZR1DFYkkDFnWEsVLV/9J81iE1kgl0VN6G3IWoFkO8
         BaADKSbLxTYGgy4nNzIvh0Q0pVwAf5Lmwual2ibE88+wFo2goo/noF13Qyr7dmU09O1G
         eswt7/GkeGMc7/3F5PsPyAKX79QEnJOYIYV+owOz+XcDH2C7HlQt0lrTrScNqD+lou4T
         6TVvFTT8yXNiOZPM4/lWjfXp37/yR7CXQtXFagdkkxQXPYo1X9a8QSNXEag8LG0vOTfK
         rSMQ==
Received: by 10.224.31.203 with SMTP id z11mr18344951qac.72.1332217899085;
        Mon, 19 Mar 2012 21:31:39 -0700 (PDT)
Received: from gmail.com (cpe-74-66-248-47.nyc.res.rr.com. [74.66.248.47])
        by mx.google.com with ESMTPS id ec5sm777981qab.21.2012.03.19.21.31.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 21:31:37 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193483>

Pushing a non-fast-forward update to a remote repository will result in
an error, but the hint text doesn't provide the correct resolution in
every case. Give better resolution advice in three push scenarios:

1) If you push your current branch and it triggers a non-fast-forward
error, you should merge remote changes with 'git pull' before pushing
again.

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

Teach transport.c to recognize these scenarios and configure push.c
to hint for them. If 'git push's default behavior changes or we
discover more scenarios, extension is easy. Standardize on the
advice API and add three new advice variables, 'pushNonFFCurrent',
'pushNonFFDefault', and 'pushNonFFMatching'. Setting any of these
to 'false' will disable their affiliated advice. Setting
'pushNonFastForward' to false will disable all three, thus preserving the
config option for users who already set it, but guaranteeing new
users won't disable push advice accidentally.

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Christopher Tiwald <christiwald@gmail.com>
---
 Changes since v2:
	- Cleaned up commit message language, specifically in scenario
	  one.
	- Created one config variable per piece of non-ff push advice.
	  Additionally, preserved 'pushNonFastForward' as a means of
	  disabling all non-ff push advice. Users who set this
	  config option should see no change to 'git push'.

 Documentation/config.txt |   19 +++++++++++++--
 advice.c                 |    6 +++++
 advice.h                 |    3 +++
 builtin/push.c           |   60 ++++++++++++++++++++++++++++++++++++++++++----
 cache.h                  |    8 +++++--
 environment.c            |    2 +-
 transport.c              |   13 ++++++++--
 7 files changed, 99 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c081657..fb386ab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -138,8 +138,23 @@ advice.*::
 +
 --
 	pushNonFastForward::
-		Advice shown when linkgit:git-push[1] refuses
-		non-fast-forward refs.
+		Set this variable to 'false' if you want to disable
+		'pushNonFFCurrent', 'pushNonFFDefault', and
+		'pushNonFFMatching' simultaneously.
+	pushNonFFCurrent::
+		Advice shown when linkgit:git-push[1] fails due to a
+		non-fast-forward update to the current branch.
+	pushNonFFDefault::
+		Advice to set 'push.default' to 'upstream' or 'current'
+		when you ran linkgit:git-push[1] and pushed 'matching
+		refs' by default (i.e. you did not provide an explicit
+		refspec, and no 'push.default' configuration was set)
+		and it resulted in a non-fast-forward error.
+	pushNonFFMatching::
+		Advice shown when you ran linkgit:git-push[1] and pushed
+		'matching refs' explicitly (i.e. you used ':', or
+		specified a refspec that isn't your current branch) and
+		it resulted in a non-fast-forward error.
 	statusHints::
 		Directions on how to stage/unstage/add shown in the
 		output of linkgit:git-status[1] and the template shown
diff --git a/advice.c b/advice.c
index 01130e5..a492eea 100644
--- a/advice.c
+++ b/advice.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 
 int advice_push_nonfastforward = 1;
+int advice_push_non_ff_current = 1;
+int advice_push_non_ff_default = 1;
+int advice_push_non_ff_matching = 1;
 int advice_status_hints = 1;
 int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
@@ -12,6 +15,9 @@ static struct {
 	int *preference;
 } advice_config[] = {
 	{ "pushnonfastforward", &advice_push_nonfastforward },
+	{ "pushnonffcurrent", &advice_push_non_ff_current },
+	{ "pushnonffdefault", &advice_push_non_ff_default },
+	{ "pushnonffmatching", &advice_push_non_ff_matching },
 	{ "statushints", &advice_status_hints },
 	{ "commitbeforemerge", &advice_commit_before_merge },
 	{ "resolveconflict", &advice_resolve_conflict },
diff --git a/advice.h b/advice.h
index 7bda45b..f3cdbbf 100644
--- a/advice.h
+++ b/advice.h
@@ -4,6 +4,9 @@
 #include "git-compat-util.h"
 
 extern int advice_push_nonfastforward;
+extern int advice_push_non_ff_current;
+extern int advice_push_non_ff_default;
+extern int advice_push_non_ff_matching;
 extern int advice_status_hints;
 extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
diff --git a/builtin/push.c b/builtin/push.c
index d315475..8a14e4b 100644
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
+	if (!advice_push_non_ff_current || !advice_push_nonfastforward)
+		return;
+	advise(_(message_advice_pull_before_push));
+}
+
+static void advise_use_upstream(void)
+{
+	if (!advice_push_non_ff_default || !advice_push_nonfastforward)
+		return;
+	advise(_(message_advice_use_upstream));
+}
+
+static void advise_checkout_pull_push(void)
+{
+	if (!advice_push_non_ff_matching || !advice_push_nonfastforward)
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
1.7.10.rc1.23.g2a051.dirty
