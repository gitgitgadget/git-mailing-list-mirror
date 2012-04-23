From: Christopher Tiwald <christiwald@gmail.com>
Subject: [PATCH] Give better 'pull' advice when pushing non-ff updates to current branch
Date: Mon, 23 Apr 2012 18:45:21 -0400
Message-ID: <1335221121-36664-1-git-send-email-christiwald@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, peff@peff.net,
	Christopher Tiwald <christiwald@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 00:46:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMS1i-0007Fb-I0
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 00:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab2DWWq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 18:46:29 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:42717 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab2DWWq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 18:46:28 -0400
Received: by qafi31 with SMTP id i31so2987036qaf.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=hnq17V7pUACm1TFYJpiuWy+6R8qqUYGVqJHSWNP1hsg=;
        b=uaiS2K72FicUTnW6rRJ6tEM2FPkEfXIUcfx5VTPBDFXwAtexA3oXWWunOp5DDfjOyS
         zIet9uQ6DKY82yyjYqMCeOICoU7WT1jWgb3wEJ2yHNs36ECoFpt3/8GB954zxUrx9nbg
         6ekD9PESxlAPO8QkS5ccirbVqV8XRaY4/bKxnDS2mX00CcuVOQn7xygEz1rUufyBR2cs
         BZygm4i9B4LeYZCfAjAXWTXXDVFsoaSKai4wFwLXputmjLPN9MKRLtMUC9zdpKbV5CWl
         /0XPTVCN6bEfZOu5hL2+lDXFKCzbemMLNdqySxmbUUjZxeaosCNy1u7DcfBop23Hb4hK
         U54w==
Received: by 10.224.95.205 with SMTP id e13mr551385qan.30.1335221187932;
        Mon, 23 Apr 2012 15:46:27 -0700 (PDT)
Received: from Christopher-Tiwalds-MacBook-Pro.local.net (cpe-74-66-248-47.nyc.res.rr.com. [74.66.248.47])
        by mx.google.com with ESMTPS id gw8sm23985978qab.7.2012.04.23.15.46.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 15:46:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.228.g42b8c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196169>

Suppose a user configured a local branch to track an upstream branch by
a different name or didn't set an upstream branch at all. In these
cases, issuing 'git pull' without specifying a remote repository or
refspec can be dangerous. In the first case, 'git pull --rebase' could
rewrite published history. In the second, 'git pull' without argument
will fail.

Modify 'git push's non-fast-forward advice to account for these cases.
Instruct users who push a non-fast-forward update to their current
branch to 'git pull <repository> <refspec>' when the branch is untracked
or tracks to a different repo or refspec then the one they specified.
Otherwise, instruct users to 'git pull'. Make both types of advice
configurable, so that users who disable one won't disable the other on
accident. Finally, offer users who configure a branch for octopus
merges, i.e. where 'branch->merge_nr > 1', the simple 'git pull' advice.

Signed-off-by: Christopher Tiwald <christiwald@gmail.com>
---
Sent this out a while back [1] but I think it went unnoticed in the
'push default' discussion. I wanted to wait until ct/advise-push-default
hit master before resending.

This patch clarifies the 'git pull' advice offered when a push to the
current branch fails for a non-fast-forward error. I think the patch is
reasonable up to the 'push default' change, possibly longer, but I'm not
totally happy with "pushNonFFCurrentUntracked" and "pushNonFFCurrentTracked".
I think they're both too long as variables and prohibit usability. I'm at
a loss for shorter names that convey as much information.

[1] http://thread.gmane.org/gmane.comp.version-control.git/194175/focus=195142
--
Christopher Tiwald



 Documentation/config.txt |    9 +++++++--
 advice.c                 |    6 ++++--
 advice.h                 |    3 ++-
 builtin/push.c           |   48 +++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb386ab..fd72120 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -141,9 +141,14 @@ advice.*::
 		Set this variable to 'false' if you want to disable
 		'pushNonFFCurrent', 'pushNonFFDefault', and
 		'pushNonFFMatching' simultaneously.
-	pushNonFFCurrent::
+	pushNonFFCurrentUntracked::
 		Advice shown when linkgit:git-push[1] fails due to a
-		non-fast-forward update to the current branch.
+		non-fast-forward update to the current branch and that
+		branch doesn't match the tracked remote and refspec.
+	pushNonFFCurrentTracked::
+		Advice shown when linkgit:git-push[1] fails due to a
+		non-fast-forward update to the current branch and that
+		branch matches the tracked remote and refspec.
 	pushNonFFDefault::
 		Advice to set 'push.default' to 'upstream' or 'current'
 		when you ran linkgit:git-push[1] and pushed 'matching
diff --git a/advice.c b/advice.c
index a492eea..828a41b 100644
--- a/advice.c
+++ b/advice.c
@@ -1,7 +1,8 @@
 #include "cache.h"
 
 int advice_push_nonfastforward = 1;
-int advice_push_non_ff_current = 1;
+int advice_push_non_ff_current_untracked = 1;
+int advice_push_non_ff_current_tracked = 1;
 int advice_push_non_ff_default = 1;
 int advice_push_non_ff_matching = 1;
 int advice_status_hints = 1;
@@ -15,7 +16,8 @@ static struct {
 	int *preference;
 } advice_config[] = {
 	{ "pushnonfastforward", &advice_push_nonfastforward },
-	{ "pushnonffcurrent", &advice_push_non_ff_current },
+	{ "pushnonffcurrentuntracked", &advice_push_non_ff_current_untracked },
+	{ "pushnonffcurrenttracked", &advice_push_non_ff_current_tracked },
 	{ "pushnonffdefault", &advice_push_non_ff_default },
 	{ "pushnonffmatching", &advice_push_non_ff_matching },
 	{ "statushints", &advice_status_hints },
diff --git a/advice.h b/advice.h
index f3cdbbf..c18809f 100644
--- a/advice.h
+++ b/advice.h
@@ -4,7 +4,8 @@
 #include "git-compat-util.h"
 
 extern int advice_push_nonfastforward;
-extern int advice_push_non_ff_current;
+extern int advice_push_non_ff_current_untracked;
+extern int advice_push_non_ff_current_tracked;
 extern int advice_push_non_ff_default;
 extern int advice_push_non_ff_matching;
 extern int advice_status_hints;
diff --git a/builtin/push.c b/builtin/push.c
index 6936713..e6614e9 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -134,12 +134,18 @@ static void setup_default_push_refspecs(struct remote *remote)
 	}
 }
 
-static const char message_advice_pull_before_push[] =
+static const char message_advice_tracked_pull_before_push[] =
 	N_("Updates were rejected because the tip of your current branch is behind\n"
 	   "its remote counterpart. Merge the remote changes (e.g. 'git pull')\n"
 	   "before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
+static const char message_advice_untracked_pull_before_push[] =
+	N_("Updates were rejected because the tip of your current branch is behind\n"
+	   "its remote counterpart. Merge the remote changes to your local branch\n"
+	   "(e.g. 'git pull <repository> <refspec>') before pushing again.\n"
+	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
+
 static const char message_advice_use_upstream[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
 	   "counterpart. If you did not intend to push that branch, you may want to\n"
@@ -152,11 +158,20 @@ static const char message_advice_checkout_pull_push[] =
 	   "(e.g. 'git pull') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
-static void advise_pull_before_push(void)
+static void advise_tracked_pull_before_push(void)
+{
+	if (!advice_push_non_ff_current_tracked ||
+	    !advice_push_nonfastforward)
+		return;
+	advise(_(message_advice_tracked_pull_before_push));
+}
+
+static void advise_untracked_pull_before_push(void)
 {
-	if (!advice_push_non_ff_current || !advice_push_nonfastforward)
+	if (!advice_push_non_ff_current_untracked ||
+	    !advice_push_nonfastforward)
 		return;
-	advise(_(message_advice_pull_before_push));
+	advise(_(message_advice_untracked_pull_before_push));
 }
 
 static void advise_use_upstream(void)
@@ -177,6 +192,16 @@ static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
 	int nonfastforward;
+	struct branch *branch;
+	struct strbuf buf = STRBUF_INIT;
+
+	branch = branch_get(NULL);
+
+	if (branch) {
+		strbuf_addstr(&buf, transport->remote->name);
+		strbuf_addstr(&buf, "/");
+		strbuf_addstr(&buf, branch->name);
+	}
 
 	transport_set_verbosity(transport, verbosity, progress);
 
@@ -201,7 +226,18 @@ static int push_with_options(struct transport *transport, int flags)
 	default:
 		break;
 	case NON_FF_HEAD:
-		advise_pull_before_push();
+		/* Branches configured for octopus merges should advise
+		 * just 'git pull' */
+		if (branch->remote_name &&
+		    branch->merge &&
+		    branch->merge_nr == 1 &&
+		    !strcmp(transport->remote->name, branch->remote_name) &&
+		    !strcmp(strbuf_detach(&buf, NULL),
+			    prettify_refname(branch->merge[0]->dst))) {
+			advise_tracked_pull_before_push();
+		}
+		else
+			advise_untracked_pull_before_push();
 		break;
 	case NON_FF_OTHER:
 		if (default_matching_used)
@@ -211,6 +247,8 @@ static int push_with_options(struct transport *transport, int flags)
 		break;
 	}
 
+	strbuf_release(&buf);
+
 	return 1;
 }
 
-- 
1.7.10.228.g7061d
