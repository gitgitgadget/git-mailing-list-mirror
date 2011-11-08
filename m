From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/12] commit: copy merged signed tags to headers of merge
 commit
Date: Mon,  7 Nov 2011 19:00:44 -0800
Message-ID: <1320721245-13223-12-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:01:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbwG-0001XL-Ki
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 04:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab1KHDBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 22:01:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab1KHDBL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 22:01:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAC3A6529;
	Mon,  7 Nov 2011 22:01:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=prLl
	nKVQivxwTmTtiEP4uQO+gGs=; b=HJQZsRvPFTWdhbxtbaG45Aip5h3S9XC33Efx
	tqi26lcjhzuDh7DeYliEKgYXdcm5/yh1jFq8cSvDBJMCHMalpZQj/PkM1fLwJ3C0
	EdVHgx6XvbwjJIJr8NYCisYH0y2oFyt5pnT+zvC9vgmIGTpof0PjG+TMSrqFAFOA
	PCtIccM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Gv3X+f0O9lRpOWR/nrYEx/NM2ikQ22b+EfZ0JKSrns7EFm5hUfd4rsQ3fGZANgB/
	3aiCCeCaAIANNkANvQiV9Q2t0keQLWNb9+SoKg1QKTUkqS7vraXNWwW+2NImNIoq
	WGOKJmB/7zAESrnyUcbNDMhTjzYvfzfASPuksd6sHhg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D30A86528;
	Mon,  7 Nov 2011 22:01:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31A366527; Mon,  7 Nov 2011
 22:01:10 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.g90e080
In-Reply-To: <1320721245-13223-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E9169D66-09B5-11E1-A006-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185058>

Now MERGE_HEAD records the tag objects without peeling, we could record
the result of manual conflict resolution via "git commit" without losing
the tag information.

In hindsight, it would have been better to make "merge --continue" as the
way to continue from such an interrupted merge, not "commit", but this is
a backward compatibility baggage we would need to carry around for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c |   10 +++++-----
 commit.c         |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 6 deletions(-)

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
index 83ff503..7d471a3 100644
--- a/commit.c
+++ b/commit.c
@@ -840,6 +840,41 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+static void handle_signed_tag(struct strbuf *signed_tags, struct commit *parent)
+{
+	struct merge_remote_desc *desc;
+	struct strbuf sig = STRBUF_INIT;
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
+	 * We could verify this signature again and either omit writing
+	 * the contents of the tag when it does not validate, but the
+	 * integrator may not have the public key of the signer of the
+	 * tag he is merging, while a later auditor may acquire the public
+	 * key while auditing, so let's not run verify-signed-buffer here
+	 * for now...
+	 *
+	 * if (verify_signed_buffer(buf, len, buf + len, size - len, &sig))
+	 *	warn("warning: signed tag unverified.");
+	 */
+	strbuf_add_lines(signed_tags, "mergetag ", buf, size);
+
+free_return:
+	strbuf_release(&sig);
+	free(buf);
+}
+
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
@@ -852,6 +887,7 @@ int commit_tree(const char *msg, unsigned char *tree,
 	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
+	struct strbuf signed_tags = STRBUF_INIT;
 
 	assert_sha1_type(tree, OBJ_TREE);
 
@@ -868,8 +904,11 @@ int commit_tree(const char *msg, unsigned char *tree,
 	 */
 	while (parents) {
 		struct commit_list *next = parents->next;
+		struct commit *parent = parents->item;
+
 		strbuf_addf(&buffer, "parent %s\n",
-			sha1_to_hex(parents->item->object.sha1));
+			    sha1_to_hex(parent->object.sha1));
+		handle_signed_tag(&signed_tags, parent);
 		free(parents);
 		parents = next;
 	}
@@ -881,6 +920,11 @@ int commit_tree(const char *msg, unsigned char *tree,
 	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
+
+	if (signed_tags.len) {
+		strbuf_addbuf(&buffer, &signed_tags);
+		strbuf_release(&signed_tags);
+	}
 	strbuf_addch(&buffer, '\n');
 
 	/* And add the comment */
-- 
1.7.8.rc0.128.g31aa4
