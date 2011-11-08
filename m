From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/12] merge: make usage of commit->util more extensible
Date: Mon,  7 Nov 2011 19:00:42 -0800
Message-ID: <1320721245-13223-10-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:01:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbwI-0001XL-EN
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 04:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab1KHDBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 22:01:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862Ab1KHDBH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 22:01:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EA27651F;
	Mon,  7 Nov 2011 22:01:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=12N3
	nWeQc85Nj31DTZDKny/lsiU=; b=WFCuz5OdcR3Eqzix0OVMEStX8dl4288enlX1
	aTnVWwhv8UfbgtPeOu6yCSOSjiZCV251rrXing35VxyLFCDtXB4trBgbXoTN4U70
	P+/r8HmjwHutxKkcNhaYDzt/XdbN4Ubcc+Gm/7FjcF3bLN5MXs6/9Dl43IUytHH1
	AmTRFzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	T1JcQoTKoRBAi5uOBWQgU+pVVpO9q6fSHx7svH59ERvueW0ZUJyA1SbshPpdQi63
	sQVyc1dW/en/Kh54RKzq7a48F/IYDDB7asD0JbOgBNUHSTnmEetYIbyeS6hv6jsg
	vdaIIlYRcb/NCNxlmGz84yc5rtzT0yHzsIFVdiCh7lU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 165FD651E;
	Mon,  7 Nov 2011 22:01:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10044651C; Mon,  7 Nov 2011
 22:01:05 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.g90e080
In-Reply-To: <1320721245-13223-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E69F3520-09B5-11E1-B69B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185062>

The merge-recursive code uses the commit->util field directly to annotate
the commit objects given from the command line, i.e. the remote heads to
be merged, with a single string to be used to describe it in its trace
messages and conflict markers.

Correct this short-signtedness by redefining the field to be a pointer to
a structure "struct merge_remote_desc" that later enhancements can add
more information. Store the original objects we were told to merge in a
field "obj" in this struct, so that we can recover the tag we were told to
merge.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c   |   63 +++++++++++++++++++---------------------------------
 commit.c          |   19 ++++++++++++++++
 commit.h          |   13 +++++++++++
 merge-recursive.c |   13 +++++------
 4 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 48e7f00..8d4eb4e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -406,20 +406,10 @@ static void finish(struct commit *head_commit,
 	strbuf_release(&reflog_message);
 }
 
-static struct object *want_commit(const char *name)
-{
-	struct object *obj;
-	unsigned char sha1[20];
-	if (get_sha1(name, sha1))
-		return NULL;
-	obj = parse_object(sha1);
-	return peel_to_type(name, 0, obj, OBJ_COMMIT);
-}
-
 /* Get the name for the merge commit's message. */
 static void merge_name(const char *remote, struct strbuf *msg)
 {
-	struct object *remote_head;
+	struct commit *remote_head;
 	unsigned char branch_head[20], buf_sha[20];
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf bname = STRBUF_INIT;
@@ -431,7 +421,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	remote = bname.buf;
 
 	memset(branch_head, 0, sizeof(branch_head));
-	remote_head = want_commit(remote);
+	remote_head = get_merge_parent(remote);
 	if (!remote_head)
 		die(_("'%s' does not point to a commit"), remote);
 
@@ -487,7 +477,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		if (resolve_ref(truname.buf, buf_sha, 1, NULL)) {
 			strbuf_addf(msg,
 				    "%s\t\tbranch '%s'%s of .\n",
-				    sha1_to_hex(remote_head->sha1),
+				    sha1_to_hex(remote_head->object.sha1),
 				    truname.buf + 11,
 				    (early ? " (early part)" : ""));
 			strbuf_release(&truname);
@@ -515,7 +505,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		goto cleanup;
 	}
 	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
-		sha1_to_hex(remote_head->sha1), remote);
+		sha1_to_hex(remote_head->object.sha1), remote);
 cleanup:
 	strbuf_release(&buf);
 	strbuf_release(&bname);
@@ -719,7 +709,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				die(_("Unknown option for merge-recursive: -X%s"), xopts[x]);
 
 		o.branch1 = head_arg;
-		o.branch2 = remoteheads->item->util;
+		o.branch2 = merge_remote_util(remoteheads->item)->name;
 
 		for (j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
@@ -1190,7 +1180,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		argv += 2;
 		argc -= 2;
 	} else if (!head_commit) {
-		struct object *remote_head;
+		struct commit *remote_head;
 		/*
 		 * If the merged head is a valid one there is no reason
 		 * to forbid "git merge" into a branch yet to be born.
@@ -1204,12 +1194,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (!allow_fast_forward)
 			die(_("Non-fast-forward commit does not make sense into "
 			    "an empty head"));
-		remote_head = want_commit(argv[0]);
+		remote_head = get_merge_parent(argv[0]);
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
-		read_empty(remote_head->sha1, 0);
-		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
-				DIE_ON_ERR);
+		read_empty(remote_head->object.sha1, 0);
+		update_ref("initial pull", "HEAD", remote_head->object.sha1,
+			   NULL, 0, DIE_ON_ERR);
 		return 0;
 	} else {
 		struct strbuf merge_names = STRBUF_INIT;
@@ -1218,12 +1208,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		head_arg = "HEAD";
 
 		/*
-		 * All the rest are the commits being merged;
-		 * prepare the standard merge summary message to
-		 * be appended to the given message.  If remote
-		 * is invalid we will die later in the common
-		 * codepath so we discard the error in this
-		 * loop.
+		 * All the rest are the commits being merged; prepare
+		 * the standard merge summary message to be appended
+		 * to the given message.
 		 */
 		for (i = 0; i < argc; i++)
 			merge_name(argv[i], &merge_names);
@@ -1251,17 +1238,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	strbuf_reset(&buf);
 
 	for (i = 0; i < argc; i++) {
-		struct object *o;
-		struct commit *commit;
-
-		o = want_commit(argv[i]);
-		if (!o)
+		struct commit *commit = get_merge_parent(argv[i]);
+		if (!commit)
 			die(_("%s - not something we can merge"), argv[i]);
-		commit = lookup_commit(o->sha1);
-		commit->util = (void *)argv[i];
 		remotes = &commit_list_insert(commit, remotes)->next;
-
-		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
+		strbuf_addf(&buf, "GITHEAD_%s",
+			    sha1_to_hex(commit->object.sha1));
 		setenv(buf.buf, argv[i], 1);
 		strbuf_reset(&buf);
 	}
@@ -1307,7 +1289,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			!hashcmp(common->item->object.sha1, head_commit->object.sha1)) {
 		/* Again the most common case of merging one remote. */
 		struct strbuf msg = STRBUF_INIT;
-		struct object *o;
+		struct commit *commit;
 		char hex[41];
 
 		strcpy(hex, find_unique_abbrev(head_commit->object.sha1, DEFAULT_ABBREV));
@@ -1321,14 +1303,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (have_message)
 			strbuf_addstr(&msg,
 				" (no commit created; -m option ignored)");
-		o = want_commit(sha1_to_hex(remoteheads->item->object.sha1));
-		if (!o)
+		commit = remoteheads->item;
+		if (!commit)
 			return 1;
 
-		if (checkout_fast_forward(head_commit->object.sha1, remoteheads->item->object.sha1))
+		if (checkout_fast_forward(head_commit->object.sha1,
+					  commit->object.sha1))
 			return 1;
 
-		finish(head_commit, o->sha1, msg.buf);
+		finish(head_commit, commit->object.sha1, msg.buf);
 		drop_save();
 		return 0;
 	} else if (!remoteheads->next && common->next)
diff --git a/commit.c b/commit.c
index 73b7e00..83ff503 100644
--- a/commit.c
+++ b/commit.c
@@ -894,3 +894,22 @@ int commit_tree(const char *msg, unsigned char *tree,
 	strbuf_release(&buffer);
 	return result;
 }
+
+struct commit *get_merge_parent(const char *name)
+{
+	struct object *obj;
+	struct commit *commit;
+	unsigned char sha1[20];
+	if (get_sha1(name, sha1))
+		return NULL;
+	obj = parse_object(sha1);
+	commit = (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
+	if (commit && !commit->util) {
+		struct merge_remote_desc *desc;
+		desc = xmalloc(sizeof(*desc));
+		desc->obj = obj;
+		desc->name = strdup(name);
+		commit->util = desc;
+	}
+	return commit;
+}
diff --git a/commit.h b/commit.h
index 009b113..5b57eab 100644
--- a/commit.h
+++ b/commit.h
@@ -185,4 +185,17 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
 
+struct merge_remote_desc {
+	struct object *obj; /* the named object, could be a tag */
+	const char *name;
+};
+#define merge_remote_util(commit) ((struct merge_remote_desc *)((commit)->util))
+
+/*
+ * Given "name" from the command line to merge, find the commit object
+ * and return it, while storing merge_remote_desc in its ->util field,
+ * to allow callers to tell if we are told to merge a tag.
+ */
+struct commit *get_merge_parent(const char *name);
+
 #endif /* COMMIT_H */
diff --git a/merge-recursive.c b/merge-recursive.c
index cc664c3..5a2db29 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -38,16 +38,15 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 	return lookup_tree(shifted);
 }
 
-/*
- * A virtual commit has (const char *)commit->util set to the name.
- */
-
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
 	struct commit *commit = xcalloc(1, sizeof(struct commit));
+	struct merge_remote_desc *desc = xmalloc(sizeof(*desc));
+
+	desc->name = comment;
+	desc->obj = (struct object *)commit;
 	commit->tree = tree;
-	commit->util = (void*)comment;
-	/* avoid warnings */
+	commit->util = desc;
 	commit->object.parsed = 1;
 	return commit;
 }
@@ -184,7 +183,7 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 	for (i = o->call_depth; i--;)
 		fputs("  ", stdout);
 	if (commit->util)
-		printf("virtual %s\n", (char *)commit->util);
+		printf("virtual %s\n", merge_remote_util(commit)->name);
 	else {
 		printf("%s ", find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 		if (parse_commit(commit) != 0)
-- 
1.7.8.rc0.128.g31aa4
