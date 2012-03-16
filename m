From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Thu, 15 Mar 2012 22:36:22 -0700
Message-ID: <7vlin1gl9l.fsf@alter.siamese.dyndns.org>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr> <7vty1rqek5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	peff@peff.net
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 06:36:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Pq8-0002pz-Lw
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 06:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031055Ab2CPFg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 01:36:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031039Ab2CPFg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 01:36:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E682472C3;
	Fri, 16 Mar 2012 01:36:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5aGNQLqnPdMhteF0e524vd7WVFY=; b=ZX0uDT93bri0nnbNMtGL
	9lv/Ak1CeIr9v5CPHWcn8APJqqISaM8HaUthIXCwIN6TAKBeRHPpH1RowaTBaC/T
	Rt00VBM5bdIPTZ2ahZjmT82kAblUvqJPAeqIquFPUbTIRHcmwJqBA2tIG90CkJUZ
	t/1GQSa62Nit5JnXQeqLL50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VVIUM7JpBTt63fUvc+3d7UjhgUesJubyYW5yhDfEMCwqZK
	ub/Ty4d6h+1f5GkM9qiUmL/yM+B4oZu+3RD8fGiicpWImD29+CgncgMLqL4KUkM2
	IQDsiYaI18oPTqsUOmM1t5X6SkzHqRu+EQp8asnYWlJbB6WZxF7+bCxK5oBv8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD3A572C2;
	Fri, 16 Mar 2012 01:36:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A94BC72C1; Fri, 16 Mar 2012
 01:36:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7A693CA-6F29-11E1-A266-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193243>

Here is what I'll queue on top of your patch in 'pu', based on the review
comments in the thread.

This message is primarily to make sure everybody is on the same page,
and ask eyeballs of people to make sure that I did not screw-up.

 Documentation/config.txt |   19 ++----------
 advice.c                 |    6 ----
 advice.h                 |    3 --
 builtin/push.c           |   76 +++++++++++++++++++++-------------------------
 builtin/send-pack.c      |    2 +-
 cache.h                  |    5 ++-
 transport.c              |   10 +++---
 7 files changed, 44 insertions(+), 77 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 50d9249..6e86681 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -138,8 +138,8 @@ advice.*::
 +
 --
 	pushNonFastForward::
-		Advice shown when linkgit:git-push[1] refuses
-		non-fast-forward refs.
+		Advice shown when linkgit:git-push[1] fails due to a
+		non-fast-forward update.
 	statusHints::
 		Directions on how to stage/unstage/add shown in the
 		output of linkgit:git-status[1] and the template shown
@@ -158,21 +158,6 @@ advice.*::
 		Advice shown when you used linkgit:git-checkout[1] to
 		move to the detach HEAD state, to instruct how to create
 		a local branch after the fact.
-	pullBeforePush::
-		Advice shown when you ran linkgit:git-push[1] and pushed
-		a non-fast-forward update to HEAD, instructing you to
-		linkgit:git-pull[1] before pushing again.
-	useUpstream::
-		Advice to set 'push.default' to 'upstream' when you ran
-		linkgit:git-push[1] and pushed 'matching refs' by default
-		(i.e. you did not have any explicit refspec on the command
-		line, and no 'push.default' configuration was set) and it
-		resulted in a non-fast-forward error.
-	checkoutPullPush::
-		Advice shown when you ran linkgit:git-push[1] and pushed
-		a non-fast-forward update to a non-HEAD branch, instructing
-		you to checkout the branch and run linkgit:git-pull[1]
-		before pushing again.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index 608e90d..01130e5 100644
--- a/advice.c
+++ b/advice.c
@@ -6,9 +6,6 @@ int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
-int advice_pull_before_push = 1;
-int advice_use_upstream = 1;
-int advice_checkout_pull_push = 1;
 
 static struct {
 	const char *name;
@@ -20,9 +17,6 @@ static struct {
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
-	{ "pullbeforepush", &advice_pull_before_push },
-	{ "useupstream", &advice_use_upstream },
-	{ "checkoutpullpush", &advice_checkout_pull_push }
 };
 
 void advise(const char *advice, ...)
diff --git a/advice.h b/advice.h
index ac07a44..7bda45b 100644
--- a/advice.h
+++ b/advice.h
@@ -9,9 +9,6 @@ extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
-extern int advice_use_upstream;
-extern int advice_pull_before_push;
-extern int advice_checkout_pull_push;
 
 int git_default_advice_config(const char *var, const char *value);
 void advise(const char *advice, ...);
diff --git a/builtin/push.c b/builtin/push.c
index 0fecf06..d7587d7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -118,57 +118,45 @@ static void setup_default_push_refspecs(struct remote *remote)
 	}
 }
 
-static const char *message_advice_pull_before_push[] = {
-	"To prevent you from losing history, non-fast-forward updates to HEAD",
-	"were rejected. Merge the remote changes (e.g. 'git pull') before",
-	"pushing again. See the 'Note about fast-forwards' section of",
-	"'git push --help' for details."
-};
-
-static const char *message_advice_use_upstream[] = {
-	"By default, git pushes all branches that have a matching counterpart",
-	"on the remote. In this case, some of your local branches were stale",
-	"with respect to their remote counterparts. If you did not intend to",
-	"push these branches, you may want to set the 'push.default'",
-	"configuration variable to 'upstream' to push only the current branch."
-};
-
-static const char *message_advice_checkout_pull_push[] = {
-	"To prevent you from losing history, your non-fast-forward branch",
-	"updates were rejected. Checkout the branch and merge the remote",
-	"changes (e.g. 'git pull') before pushing again. See the",
-	"'Note about fast-forwards' section of 'git push --help' for",
-	"details."
-};
+static const char message_advice_pull_before_push[] =
+	N_("Update was rejected because the tip of your current branch is behind\n"
+	   "the remote. Merge the remote changes (e.g. 'git pull') before\n"
+	   "pushing again. See the 'Note about fast-forwards' section of\n"
+	   "'git push --help' for details.");
+
+
+static const char message_advice_use_upstream[] =
+	N_("Some of your local branches were stale with respect to their\n"
+	   "remote counterparts. If you did not intend to push these branches,\n"
+	   "you may want to set the 'push.default' configuration variable to\n"
+	   "'current' or 'upstream' to push only the current branch.");
+
+static const char message_advice_checkout_pull_push[] =
+	N_("Updates were rejected because the tip of some of your branches are\n"
+	   "behind the remote. Check out the branch and merge the remote\n"
+	   "changes (e.g. 'git pull') before pushing again. See the\n"
+	   "'Note about fast-forwards' section of 'git push --help'\n"
+	   "for details.");
 
 static void advise_pull_before_push(void)
 {
-	int i;
-
-	if (!advice_pull_before_push)
+	if (!advice_push_nonfastforward)
 		return;
-	for (i = 0; i < ARRAY_SIZE(message_advice_pull_before_push); i++)
-		advise(message_advice_pull_before_push[i]);
+	advise(_(message_advice_pull_before_push));
 }
 
 static void advise_use_upstream(void)
 {
-	int i;
-
-	if (!advice_use_upstream)
+	if (!advice_push_nonfastforward)
 		return;
-	for (i = 0; i < ARRAY_SIZE(message_advice_use_upstream); i++)
-		advise(message_advice_use_upstream[i]);
+	advise(_(message_advice_use_upstream));
 }
 
 static void advise_checkout_pull_push(void)
 {
-	int i;
-
-	if (!advice_checkout_pull_push)
+	if (!advice_push_nonfastforward)
 		return;
-	for (i = 0; i < ARRAY_SIZE(message_advice_checkout_pull_push); i++)
-		advise(message_advice_checkout_pull_push[i]);
+	advise(_(message_advice_checkout_pull_push));
 }
 
 static int push_with_options(struct transport *transport, int flags)
@@ -192,19 +180,23 @@ static int push_with_options(struct transport *transport, int flags)
 		error(_("failed to push some refs to '%s'"), transport->url);
 
 	err |= transport_disconnect(transport);
+	if (!err)
+		return 0;
 
-	if (nonfastforward == NONFASTFORWARD_HEAD) {
+	switch (nonfastforward) {
+	default:
+		break;
+	case NON_FF_HEAD:
 		advise_pull_before_push();
-	} else if (nonfastforward == NONFASTFORWARD_OTHER) {
+		break;
+	case NON_FF_OTHER:
 		if (default_matching_used)
 			advise_use_upstream();
 		else
 			advise_checkout_pull_push();
+		break;
 	}
 
-	if (!err)
-		return 0;
-
 	return 1;
 }
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 09895b9..9df341c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -409,7 +409,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int send_all = 0;
 	const char *receivepack = "git-receive-pack";
 	int flags;
-	int nonfastforward = NONFASTFORWARD_NONE;
+	int nonfastforward = 0;
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
diff --git a/cache.h b/cache.h
index 14bc305..427b600 100644
--- a/cache.h
+++ b/cache.h
@@ -1020,9 +1020,8 @@ struct ref {
 		REF_STATUS_EXPECTING_REPORT
 	} status;
 	enum {
-		NONFASTFORWARD_NONE = 0,
-		NONFASTFORWARD_HEAD,
-		NONFASTFORWARD_OTHER
+		NON_FF_HEAD = 1,
+		NON_FF_OTHER
 	} nonfastforward;
 	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
diff --git a/transport.c b/transport.c
index 23210d5..7864007 100644
--- a/transport.c
+++ b/transport.c
@@ -736,18 +736,18 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		if (ref->status == REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 
-	*nonfastforward = NONFASTFORWARD_NONE;
+	*nonfastforward = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD &&
-		    *nonfastforward != NONFASTFORWARD_HEAD) {
+		    *nonfastforward != NON_FF_HEAD) {
 			if (!strcmp(head, ref->name))
-				*nonfastforward = NONFASTFORWARD_HEAD;
+				*nonfastforward = NON_FF_HEAD;
 			else
-				*nonfastforward = NONFASTFORWARD_OTHER;
+				*nonfastforward = NON_FF_OTHER;
 		}
 	}
 }
@@ -1017,7 +1017,7 @@ int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
 		   int *nonfastforward)
 {
-	*nonfastforward = NONFASTFORWARD_NONE;
+	*nonfastforward = 0;
 	transport_verify_remote_names(refspec_nr, refspec);
 
 	if (transport->push) {
-- 
1.7.10.rc1.22.g07e85
