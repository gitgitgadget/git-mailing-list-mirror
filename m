From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Sun, 23 Jun 2013 21:33:05 -0700
Message-ID: <1372048388-16742-4-git-send-email-gitster@pobox.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 06:34:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqyTk-0004hQ-LG
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 06:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab3FXEdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 00:33:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3FXEdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 00:33:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56008265B7
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JT5/
	bz4d2mOxZipgw0O0QJjvhUY=; b=J9falBYpfshZxpfvgql3z2xOmHPNKGkfiwXx
	6O9A2JHcoQHeYD77srV9joHS1EiRz88t826Kp07cXsPv/7dbJS+XJGtUlrChEQU4
	7vBIFiVhC1si4hrP7kZmK4rcjOzsmnlIRWx74gjDWGbIRNZwvRERLAdwfZHMFIEV
	7vMqe0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=yBYszY
	z98ytbIAWTMaABuKydZjcp3hSgcjSIZxGKQ4256C5Dbc86fvGWmhwtMqh4QD+c1e
	19QYnbZScMRup5Ts6c3EJrkedpZNsa9qNTYryHUvKf5GOfbeJOHpkL6D1DhYAeND
	6WCJAIQrqu1QdxuSCepiPvlqW2GKWYUeTrDAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D3FC265B4
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D89B265B0
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:15 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-721-g0a353d3
In-Reply-To: <1372048388-16742-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2FE13F44-DC87-11E2-9CC1-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228775>

From: Ramkumar Ramachandra <artagnon@gmail.com>

When remote.pushdefault or branch.<name>.pushremote is set (a triangular
workflow feature), master@{u} != origin, and push.default is set to
`upstream` or `simple`:

  $ git push
  fatal: You are pushing to remote 'origin', which is not the upstream of
  your current branch 'master', without telling me what to push
  to update which remote branch.

The very name of "upstream" indicates that it is only suitable for
use in central workflows; let us not even attempt to give it a new
meaning in triangular workflows, and error out as usual.

However, the `simple` does not have this problem: it is poised to be
the default for Git 2.0, and we would definitely like it to do
something sensible in triangular workflows.

Redefine "simple" as "safer upstream" for centralized workflow as
before, but work as "current" for triangular workflow.

An earlier round of this change by mistake broke the safety for
"simple" mode we have had since day 1 of that mode to make sure that
the branch in the repository we update is set to be the one we fetch
and integrate with, but it has been fixed.

Reported-by: Leandro Lucarella <leandro.lucarella@sociomantic.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 10 +++++++---
 builtin/push.c           | 43 +++++++++++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5d8ff1a..cae6870 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1848,9 +1848,13 @@ push.default::
   pushing to the same repository you would normally pull from
   (i.e. central workflow).
 
-* `simple` - like `upstream`, but refuses to push if the upstream
-  branch's name is different from the local one. This is the safest
-  option and is well-suited for beginners.
+* `simple` - in centralized workflow, work like `upstream` with an
+  added safety to refuse to push if the upstream branch's name is
+  different from the local one.
++
+When pushing to a remote that is different from the remote you normally
+pull from, work as `current`.  This is the safest option and is suited
+for beginners.
 +
 This mode will become the default in Git 2.0.
 
diff --git a/builtin/push.c b/builtin/push.c
index 2d84d10..f6c8047 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -120,10 +120,11 @@ static const char message_detached_head_die[] =
 	   "\n"
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
-static void setup_push_upstream(struct remote *remote, int simple)
+static void setup_push_upstream(struct remote *remote, struct branch *branch,
+				int triangular)
 {
 	struct strbuf refspec = STRBUF_INIT;
-	struct branch *branch = branch_get(NULL);
+
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
@@ -137,18 +138,29 @@ static void setup_push_upstream(struct remote *remote, int simple)
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
-	if (strcmp(branch->remote_name, remote->name))
+	if (triangular)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
-	if (simple && strcmp(branch->refname, branch->merge[0]->src))
-		die_push_simple(branch, remote);
+
+	if (push_default == PUSH_DEFAULT_SIMPLE) {
+		/* Additional safety */
+		if (strcmp(branch->refname, branch->merge[0]->src))
+			die_push_simple(branch, remote);
+	}
 
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
@@ -173,9 +185,16 @@ static void warn_unspecified_push_default_configuration(void)
 	warning("%s\n", _(warn_unspecified_push_default_msg));
 }
 
+static int is_workflow_triagular(struct remote *remote)
+{
+	struct remote *fetch_remote = remote_get(NULL);
+	return (fetch_remote && fetch_remote != remote);
+}
+
 static void setup_default_push_refspecs(struct remote *remote)
 {
-	struct branch *branch;
+	struct branch *branch = branch_get(NULL);
+	int triangular = is_workflow_triagular(remote);
 
 	switch (push_default) {
 	default:
@@ -188,18 +207,18 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_SIMPLE:
-		setup_push_upstream(remote, 1);
+		if (triangular)
+			setup_push_current(remote, branch);
+		else
+			setup_push_upstream(remote, branch, triangular);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, 0);
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
-- 
1.8.3.1-721-g0a353d3
