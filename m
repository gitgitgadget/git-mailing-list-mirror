From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/17] commit: copy merged signed tags to headers of merge
 commit
Date: Tue,  8 Nov 2011 17:01:57 -0800
Message-ID: <1320800523-5407-12-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:02:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwZ1-0003z8-Hu
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657Ab1KIBCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab1KIBCb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEB7A5B94
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FafK
	ztf1LTr1hoCgSWTe71f90oM=; b=Pt4+O6HH8vnVa83Z7Yvucvaq1dCnAvT6UgFU
	IwGjrGQy+9oKOCCzWsSNcI/HdHHh85x9aHQ4mh44TSpzx9Z+wLl6MtCZVtO67yWU
	4Fxc8MF0hEoIR36yixelaYsaCI/02o6Y2ge2DBhJMO7lF23+omHX2aKct4/hJq/u
	+dVlzlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=mvwXin
	Epcbx5vzuLcWzr5Y8s2i+/Zl0TGWJSBXSokX+bevsroJfBW7mlqW12c7iTG4ktfh
	5oSyi6BqygV2CEZ8vjpOwqhbazJmfwiWhJ9NRIaCkwug2UnAjgBYZo1EDkdr+Vnt
	AO3B/6Q+ew9JxBINRQLxWDaodS1LUTZ/5T29s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E30C65B8A
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AC695B89 for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:30 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7FA23A98-0A6E-11E1-AAD6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185133>

Now MERGE_HEAD records the tag objects without peeling, we could record
the result of manual conflict resolution via "git commit" without losing
the tag information. Introduce a new "mergetag" multi-line header field to
the commit object, and use it to store the entire contents of each signed
tag merged.

A commit header that has a multi-line payload begins with the header tag
(e.g. "mergetag" in this case), SP, the first line of payload, LF, and all
the remaining lines have a SP inserted at the beginning.

In hindsight, it would have been better to make "merge --continue" as the
way to continue from such an interrupted merge, not "commit", but this is
a backward compatibility baggage we would need to carry around for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c |   10 +++---
 commit.c         |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 commit.h         |   21 +++++++++++-
 3 files changed, 115 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c46f2d1..4688a73 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1425,7 +1425,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			pptr = &commit_list_insert(c->item, pptr)->next;
 	} else if (whence == FROM_MERGE) {
 		struct strbuf m = STRBUF_INIT;
-		struct commit *commit;
 		FILE *fp;
 
 		if (!reflog_msg)
@@ -1436,11 +1435,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			die_errno(_("could not open '%s' for reading"),
 				  git_path("MERGE_HEAD"));
 		while (strbuf_getline(&m, fp, '\n') != EOF) {
-			unsigned char sha1[20];
-			if (get_sha1_hex(m.buf, sha1) < 0)
+			struct commit *parent;
+
+			parent = get_merge_parent(m.buf);
+			if (!parent)
 				die(_("Corrupt MERGE_HEAD file (%s)"), m.buf);
-			commit = lookup_commit_or_die(sha1, "MERGE_HEAD");
-			pptr = &commit_list_insert(commit, pptr)->next;
+			pptr = &commit_list_insert(parent, pptr)->next;
 		}
 		fclose(fp);
 		strbuf_release(&m);
diff --git a/commit.c b/commit.c
index 83ff503..ee12eff 100644
--- a/commit.c
+++ b/commit.c
@@ -840,14 +840,94 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+static void handle_signed_tag(struct commit *parent, struct commit_extra_header ***tail)
+{
+	struct merge_remote_desc *desc;
+	struct commit_extra_header *mergetag;
+	char *buf;
+	unsigned long size, len;
+	enum object_type type;
+
+	desc = merge_remote_util(parent);
+	if (!desc || !desc->obj)
+		return;
+	buf = read_sha1_file(desc->obj->sha1, &type, &size);
+	if (!buf || type != OBJ_TAG)
+		goto free_return;
+	len = parse_signature(buf, size);
+	if (size == len)
+		goto free_return;
+	/*
+	 * We could verify this signature and either omit the tag when
+	 * it does not validate, but the integrator may not have the
+	 * public key of the signer of the tag he is merging, while a
+	 * later auditor may have it while auditing, so let's not run
+	 * verify-signed-buffer here for now...
+	 *
+	 * if (verify_signed_buffer(buf, len, buf + len, size - len, ...))
+	 *	warn("warning: signed tag unverified.");
+	 */
+	mergetag = xcalloc(1, sizeof(*mergetag));
+	mergetag->key = "mergetag";
+	mergetag->value = buf;
+	mergetag->len = size;
+
+	**tail = mergetag;
+	*tail = &mergetag->next;
+	return;
+
+free_return:
+	free(buf);
+}
+
+void append_merge_tag_headers(struct commit_list *parents,
+			      struct commit_extra_header ***tail)
+{
+	while (parents) {
+		struct commit *parent = parents->item;
+		handle_signed_tag(parent, tail);
+		parents = parents->next;
+	}
+}
+
+static void add_extra_header(struct strbuf *buffer,
+			     struct commit_extra_header *extra)
+{
+	strbuf_addstr(buffer, extra->key);
+	strbuf_add_lines(buffer, " ", extra->value, extra->len);
+}
+
+void free_commit_extra_headers(struct commit_extra_header *extra)
+{
+	while (extra) {
+		struct commit_extra_header *next = extra->next;
+		free(extra->value);
+		free(extra);
+		extra = next;
+	}
+}
+
+int commit_tree(const char *msg, unsigned char *tree,
+		struct commit_list *parents, unsigned char *ret,
+		const char *author)
+{
+	struct commit_extra_header *extra = NULL, **tail = &extra;
+	int result;
+
+	append_merge_tag_headers(parents, &tail);
+	result = commit_tree_extended(msg, tree, parents, ret, author, extra);
+	free_commit_extra_headers(extra);
+	return result;
+}
+
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
 
-int commit_tree(const char *msg, unsigned char *tree,
-		struct commit_list *parents, unsigned char *ret,
-		const char *author)
+int commit_tree_extended(const char *msg, unsigned char *tree,
+			 struct commit_list *parents, unsigned char *ret,
+			 const char *author, struct commit_extra_header *extra)
 {
 	int result;
 	int encoding_is_utf8;
@@ -868,8 +948,10 @@ int commit_tree(const char *msg, unsigned char *tree,
 	 */
 	while (parents) {
 		struct commit_list *next = parents->next;
+		struct commit *parent = parents->item;
+
 		strbuf_addf(&buffer, "parent %s\n",
-			sha1_to_hex(parents->item->object.sha1));
+			    sha1_to_hex(parent->object.sha1));
 		free(parents);
 		parents = next;
 	}
@@ -881,6 +963,11 @@ int commit_tree(const char *msg, unsigned char *tree,
 	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
+
+	while (extra) {
+		add_extra_header(&buffer, extra);
+		extra = extra->next;
+	}
 	strbuf_addch(&buffer, '\n');
 
 	/* And add the comment */
diff --git a/commit.h b/commit.h
index 5b57eab..c1a723e 100644
--- a/commit.h
+++ b/commit.h
@@ -181,9 +181,26 @@ static inline int single_parent(struct commit *commit)
 
 struct commit_list *reduce_heads(struct commit_list *heads);
 
+struct commit_extra_header {
+	struct commit_extra_header *next;
+	char *key;
+	char *value;
+	size_t len;
+};
+
+extern void append_merge_tag_headers(struct commit_list *parents,
+				     struct commit_extra_header ***tail);
+
 extern int commit_tree(const char *msg, unsigned char *tree,
-		struct commit_list *parents, unsigned char *ret,
-		const char *author);
+		       struct commit_list *parents, unsigned char *ret,
+		       const char *author);
+
+extern int commit_tree_extended(const char *msg, unsigned char *tree,
+				struct commit_list *parents, unsigned char *ret,
+				const char *author,
+				struct commit_extra_header *);
+
+extern void free_commit_extra_headers(struct commit_extra_header *extra);
 
 struct merge_remote_desc {
 	struct object *obj; /* the named object, could be a tag */
-- 
1.7.8.rc1.82.g90e080
