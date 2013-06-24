From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] push: honor branch.*.push
Date: Sun, 23 Jun 2013 21:33:08 -0700
Message-ID: <1372048388-16742-7-git-send-email-gitster@pobox.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 06:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqyTC-0004Eb-KU
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 06:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab3FXEdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 00:33:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab3FXEdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 00:33:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B5F265D3
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6nzC
	08Rd5sBPR4bcqTjsb4fP6U4=; b=jRBIJiuRK2HMnXOm58voAfRy1ckRX5123Tsp
	+2RwMLorejCJi9zwitTFpxSt6WqRWI48WHvsSYQGIOS7EpMVWU+DT/lIOqcb+RZK
	rzBI8sOeLHhm4+tgyTGu2W9N+swERegwKk4+NtdWU7SKvY3y1DylhRgm3hFTD02R
	KC8QWGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=PjImCE
	NgblxPqjeo1dLfbxqEeL/71Zz+pHgjDvSAb8DJQusg5cDR64XwOqxjBKX2R6eKiD
	tNZ+oS1E1kNTgCCGo0do2UdDQ9hZgXQCpsLbwnG1hZ88DkycmoSQC2odFSlaWt8n
	PerPCWZcUR49wp9gWjAnGLgb96hlHMzK7Lj6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9ECF265D2
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 597DB265CD
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:21 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-721-g0a353d3
In-Reply-To: <1372048388-16742-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 334A2CF4-DC87-11E2-A66A-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228772>

When branch.*.push configuration variable is defined for the current
branch, a lazy-typing "git push" (and "git push there") will push
the commit at the tip of the current branch to the destination and
update the branch named by that variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c | 18 +++++++++++++++++-
 remote.c       |  5 +++++
 remote.h       |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index f6c8047..a140b8e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -185,6 +185,15 @@ static void warn_unspecified_push_default_configuration(void)
 	warning("%s\n", _(warn_unspecified_push_default_msg));
 }
 
+static void setup_per_branch_push(struct branch *branch)
+{
+	struct strbuf refspec = STRBUF_INIT;
+
+	strbuf_addf(&refspec, "%s:%s",
+		    branch->name, branch->push_name);
+	add_refspec(refspec.buf);
+}
+
 static int is_workflow_triagular(struct remote *remote)
 {
 	struct remote *fetch_remote = remote_get(NULL);
@@ -194,7 +203,14 @@ static int is_workflow_triagular(struct remote *remote)
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch = branch_get(NULL);
-	int triangular = is_workflow_triagular(remote);
+	int triangular;
+
+	if (branch->push_name) {
+		setup_per_branch_push(branch);
+		return;
+	}
+
+	triangular = is_workflow_triagular(remote);
 
 	switch (push_default) {
 	default:
diff --git a/remote.c b/remote.c
index e71f66d..e033fef 100644
--- a/remote.c
+++ b/remote.c
@@ -372,6 +372,11 @@ static int handle_config(const char *key, const char *value, void *cb)
 			if (!value)
 				return config_error_nonbool(key);
 			add_merge(branch, xstrdup(value));
+		} else if (!strcmp(subkey, ".push")) {
+			if (!value)
+				return config_error_nonbool(key);
+			free(branch->push_name);
+			branch->push_name = xstrdup(value);
 		}
 		return 0;
 	}
diff --git a/remote.h b/remote.h
index cf56724..84e0f72 100644
--- a/remote.h
+++ b/remote.h
@@ -138,6 +138,8 @@ struct branch {
 	struct refspec **merge;
 	int merge_nr;
 	int merge_alloc;
+
+	char *push_name;
 };
 
 struct branch *branch_get(const char *name);
-- 
1.8.3.1-721-g0a353d3
