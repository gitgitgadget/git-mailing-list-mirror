From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] builtin/merge.c: collect other parents early
Date: Tue, 17 Apr 2012 13:34:45 -0700
Message-ID: <1334694886-27756-4-git-send-email-gitster@pobox.com>
References: <1334694886-27756-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 22:35:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKF7K-0006rx-FH
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab2DQUe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 16:34:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120Ab2DQUez (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 16:34:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E915162AE
	for <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0y2s
	GuxzDy2SmCjDhfYt1ZVv2AY=; b=jR+i612WHzNn0I/1hFdElQc3JF6GxDHlvuLg
	zpWYJqXHGlE+e80xMQMFR2F63xb0iYUybQkXq3/NvGJe/NzPU8yiHkdeJrarq5kv
	a/dml4f8It+xnFrpmt6hyzM3tFrtTMcrfKFpVloDwa+TjV6Rm6EW+ft50Sg5lQ80
	i6oCKUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ln3zOO
	x8p/Hstaij/ZDmcb4l438BcmPEwL9tHB1msuPy1g49bFcWl6tAH+ccqUj2lPQ5fH
	UheNCUbmvrelDA9kokt0+7o9C2zBzfsxH0IfJFD5rIaTKeiDCHnVN0+yMl71Itdo
	s5JNmWtqe2XUBMAZdGfXWYzco0zs/5wGU9KB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1DC762AC
	for <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFDE962AB for
 <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.332.g1863c
In-Reply-To: <1334694886-27756-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C9E78A36-88CC-11E1-B1BF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195802>

Move the code around to populate remoteheads list early in the process
before any decision regarding twohead vs octopus and fast-forwardness is
made.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c |   40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index c5ca70b..2cef2f6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1137,6 +1137,21 @@ static int default_edit_option(void)
 		st_stdin.st_mode == st_stdout.st_mode);
 }
 
+static struct commit_list *collect_parents(int argc, const char **argv)
+{
+	int i;
+	struct commit_list *remoteheads = NULL;
+	struct commit_list **remotes = &remoteheads;
+
+	for (i = 0; i < argc; i++) {
+		struct commit *commit = get_merge_parent(argv[i]);
+		if (!commit)
+			die(_("%s - not something we can merge"), argv[i]);
+		remotes = &commit_list_insert(commit, remotes)->next;
+	}
+	*remotes = NULL;
+	return remoteheads;
+}
 
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
@@ -1150,8 +1165,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
-	struct commit_list *remoteheads = NULL;
-	struct commit_list **remotes = &remoteheads;
+	struct commit_list *remoteheads, *p;
 	void *branch_to_free;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -1256,6 +1270,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		head_arg = argv[1];
 		argv += 2;
 		argc -= 2;
+		remoteheads = collect_parents(argc, argv);
 	} else if (!head_commit) {
 		struct commit *remote_head;
 		/*
@@ -1271,7 +1286,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (!allow_fast_forward)
 			die(_("Non-fast-forward commit does not make sense into "
 			    "an empty head"));
-		remote_head = get_merge_parent(argv[0]);
+		remoteheads = collect_parents(argc, argv);
+		remote_head = remoteheads->item;
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
 		read_empty(remote_head->object.sha1, 0);
@@ -1289,8 +1305,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * the standard merge summary message to be appended
 		 * to the given message.
 		 */
-		for (i = 0; i < argc; i++)
-			merge_name(argv[i], &merge_names);
+		remoteheads = collect_parents(argc, argv);
+		for (p = remoteheads; p; p = p->next)
+			merge_name(merge_remote_util(p->item)->name, &merge_names);
 
 		if (!have_message || shortlog_len) {
 			struct fmt_merge_msg_opts opts;
@@ -1309,19 +1326,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			builtin_merge_options);
 
 	strbuf_addstr(&buf, "merge");
-	for (i = 0; i < argc; i++)
-		strbuf_addf(&buf, " %s", argv[i]);
+	for (p = remoteheads; p; p = p->next)
+		strbuf_addf(&buf, " %s", merge_remote_util(p->item)->name);
 	setenv("GIT_REFLOG_ACTION", buf.buf, 0);
 	strbuf_reset(&buf);
 
-	for (i = 0; i < argc; i++) {
-		struct commit *commit = get_merge_parent(argv[i]);
-		if (!commit)
-			die(_("%s - not something we can merge"), argv[i]);
-		remotes = &commit_list_insert(commit, remotes)->next;
+	for (p = remoteheads; p; p = p->next) {
+		struct commit *commit = p->item;
 		strbuf_addf(&buf, "GITHEAD_%s",
 			    sha1_to_hex(commit->object.sha1));
-		setenv(buf.buf, argv[i], 1);
+		setenv(buf.buf, merge_remote_util(commit)->name, 1);
 		strbuf_reset(&buf);
 		if (!fast_forward_only &&
 		    merge_remote_util(commit) &&
-- 
1.7.10.332.g1863c
