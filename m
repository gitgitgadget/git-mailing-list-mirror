From: Christopher Tiwald <christiwald@gmail.com>
Subject: [RFC/PATCH] Give better 'pull' advice when pushing non-ff updates to
 current branch
Date: Tue, 10 Apr 2012 22:08:16 -0400
Message-ID: <20120411020816.GU376@gmail.com>
References: <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 04:08:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHmyx-0007nB-23
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 04:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452Ab2DKCIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 22:08:21 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64358 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab2DKCIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 22:08:20 -0400
Received: by qcro28 with SMTP id o28so286675qcr.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 19:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tEdR+DNhTrZTojayjIsFQ4DGKJ3E/xuzV50R55ja1Ug=;
        b=D5+ydG1sTM8BJFHyZei4W4dmyVzhAsD78E3QzpvMPVJ7gf/+tAF5x4sJgKMQVwZkis
         uTxeaLdv318JvzF+Gc/8LAJGa96VX56mhbJMx7vGqNkTYIhywvyBZssm2ELqccRbiM+9
         FG52M9BNxsHZOCEo5AKcdw09WF71G4b19Yrtk2jtBBReuEwIcO5MfnxspEHl6xTDHDgt
         5s4aTOoYLoi7WniuSu4AEmhVSB7szFstjbw359Wb415YLYmyQ0hBb2HrTmtAA4WDo597
         CKF6p+Ig4G9YCoJlM3GHs2z8KNWrK20eJTGrzuyP5pHTxcaA+U97Fc3KFKCPIWv5OArC
         62zA==
Received: by 10.229.137.77 with SMTP id v13mr5635690qct.60.1334110099487;
        Tue, 10 Apr 2012 19:08:19 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id ew2sm3125315qab.11.2012.04.10.19.08.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 19:08:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120406071520.GD25301@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195142>

On Fri, Apr 06, 2012 at 03:15:20AM -0400, Jeff King wrote:
> So shouldn't the advice for a non-fast-forward push be:
> 
>    if $source_ref is currently checked out
>            advise "git checkout $source_ref, and then..."
>    fi
>    if $dest_remote == branch.$source_ref.remote &&
>       $dest_ref == branch.$source_ref.merge
>            advise "git pull"
>    else
>            advise "git pull $dest_remote $dest_ref"
>    fi
> 
> That handles only one ref, of course. If you get multiple non-ff
> failures, I'm not sure what we should advise.

Hmmm. Maybe something like this? Note to reviewers: This is necessarily
based on ct/advise-push-default.

Assuming this logic is sound and the patch is a reasonable change, I'm not
wedded to "pushNonFFCurrentUntracked" and "pushNonFFCurrentTracked". I'm
concerned both config options are a bit too long. Is there a better, more
concise way to specify those config options?

---- >8 ----
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
index 8a14e4b..0671d27 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -118,12 +118,18 @@ static void setup_default_push_refspecs(struct remote *remote)
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
@@ -136,11 +142,20 @@ static const char message_advice_checkout_pull_push[] =
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
@@ -161,6 +176,16 @@ static int push_with_options(struct transport *transport, int flags)
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
 
@@ -185,7 +210,18 @@ static int push_with_options(struct transport *transport, int flags)
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
@@ -195,6 +231,8 @@ static int push_with_options(struct transport *transport, int flags)
 		break;
 	}
 
+	strbuf_release(&buf);
+
 	return 1;
 }
 
-- 
1.7.10.4.g2c970.dirty
