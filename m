From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Wed, 19 Jun 2013 19:57:41 -0700
Message-ID: <7vk3lpwkt6.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-4-git-send-email-artagnon@gmail.com>
	<7v38sdzx8o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 04:57:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpV4I-0006in-58
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 04:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935569Ab3FTC5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 22:57:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935534Ab3FTC5p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 22:57:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 561E21C739;
	Thu, 20 Jun 2013 02:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WTLM4XwCN6yIHcxnbZil6roSpfs=; b=RtC1u8
	T6yrIUcPWmNzPaYsxt0OCjClu+/JEzqhrpFA0bWhnsnrVOYtfm6htXlTze1bQ933
	Ywa4qDXR4/3jLP5SDBNY20+eegTz4B3lTHXlpu1q61yRpsZ2ZmXcKjWx5Ygs3KwX
	twL0WMjGl/8VSa4/HuaX0Y0PXhv7WugQIk0ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BE/zz53Tv1rcnW0U8+coRgi+oi8Hh5Ny
	pgunrYDT2ttmplMsGuJnKcOFmC86M7M2rGq456LBiShWQ/oRxAEKwcaQWJ622MZj
	qEHDaXCU/lG/nMxHfLryXRWdoUIT+5zvFOteiNuiQQUOmEwnRklRwrrU9z+AnJI5
	LbOAW6T9Tns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D80C1C738;
	Thu, 20 Jun 2013 02:57:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8329A1C736;
	Thu, 20 Jun 2013 02:57:43 +0000 (UTC)
In-Reply-To: <7v38sdzx8o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 19 Jun 2013 13:00:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DA034C2-D955-11E2-9BB1-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228436>

Junio C Hamano <gitster@pobox.com> writes:

> Without any configuration the current branch is pushed out, which
> loosens the safety we implemented in the current 'safer upstream'.
>
> I am not convinced this is a good change.  I am not convinced this is
> a bad change, either, yet, but this loosening smells bad.

Provided that we would want to keep the "Push the current one to the
same name but you have to have it set up as your integration source"
safety for central workflow (which I am starting to think we
should), we would want something like this on top of your entire
series, I think.  The behaviour change can be seen in the revert of
one test you made to the test that expects "simple" to fail due to
the safety.

This patch is somewhat minimal in that it does not address other
issues I raised in the review of the series; it only addresses the
"simple must be safe" issue.

 builtin/push.c          | 60 +++++++++++++++++++++++++------------------------
 t/t5528-push-default.sh |  2 +-
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 783bacf..84c4a90 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -120,29 +120,11 @@ static const char message_detached_head_die[] =
 	   "\n"
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
-static void setup_push_simple(struct remote *remote)
-{
-	struct branch *branch = branch_get(NULL);
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
-	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
-		/* No upstream configured */
-		goto end;
-	if (branch->merge_nr != 1)
-		die(_("The current branch %s has multiple upstream branches, "
-		    "refusing to push."), branch->name);
-	if (!strcmp(branch->remote_name, remote->name) &&
-		strcmp(branch->refname, branch->merge[0]->src))
-		/* Central workflow safety feature */
-		die_push_simple(branch, remote);
-end:
-	add_refspec(branch->name);
-}
-
-static void setup_push_upstream(struct remote *remote)
+static void setup_push_upstream(struct remote *remote, struct branch *branch,
+				int triangular)
 {
 	struct strbuf refspec = STRBUF_INIT;
-	struct branch *branch = branch_get(NULL);
+
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
@@ -156,16 +138,29 @@ static void setup_push_upstream(struct remote *remote)
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
-	if (strcmp(branch->remote_name, remote->name))
+	if (triangular)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
 
+	if (push_default == PUSH_DEFAULT_SIMPLE) {
+		/* Additional safety */
+		if (strcmp(branch->refname, branch->merge[0]->src))
+			die_push_simple(branch, remote);
+	}
+
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);
 }
 
+static void setup_push_current(struct remote *remote, struct branch *branch)
+{
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
+	add_refspec(branch->name);
+}
+
 static char warn_unspecified_push_default_msg[] =
 N_("push.default is unset; its implicit value is changing in\n"
    "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
@@ -190,9 +185,16 @@ static void warn_unspecified_push_default_configuration(void)
 	warning("%s\n", _(warn_unspecified_push_default_msg));
 }
 
+static int is_workflow_triagular(struct remote *remote)
+{
+	struct remote *fetch_remote = remote_get(NULL);
+	return (fetch_remote != remote);
+}
+
 static void setup_default_push_refspecs(struct remote *remote)
 {
-	struct branch *branch;
+	struct branch *branch = branch_get(NULL);
+	int triangular = is_workflow_triagular(remote);
 
 	switch (push_default) {
 	default:
@@ -205,18 +207,18 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_SIMPLE:
-		setup_push_simple(remote);
+		if (triangular)
+			setup_push_current(remote, branch);
+		else
+			setup_push_upstream(remote, branch, triangular);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote);
+		setup_push_upstream(remote, branch, triangular);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		branch = branch_get(NULL);
-		if (!branch)
-			die(_(message_detached_head_die), remote->name);
-		add_refspec(branch->name);
+		setup_push_current(remote, branch);
 		break;
 
 	case PUSH_DEFAULT_NOTHING:
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index eabc09d..36f5a63 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -107,7 +107,7 @@ test_expect_success 'push from/to new branch with current creates remote branch'
 test_expect_success 'push to existing branch, with no upstream configured' '
 	test_config branch.master.remote repo1 &&
 	git checkout master &&
-	test_push_success simple master &&
+	test_push_failure simple &&
 	test_push_failure upstream
 '
 
