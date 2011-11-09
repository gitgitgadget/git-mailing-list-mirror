From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/17] commit: teach --amend to carry forward extra
 headers
Date: Tue,  8 Nov 2011 17:01:59 -0800
Message-ID: <1320800523-5407-14-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:02:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwZ2-0003z8-5r
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab1KIBCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828Ab1KIBCf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B33405BA1
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zO3y
	zkKGmlNP+gxuXbjHnwvNSMI=; b=EZgUX9pTQ9A4kAVMcUCQxvpl1fimPcl+hOWh
	9TstpKZZ/X+4ely1dtHt6S/IKOLYNTY+YiAa9Hpj74lB9dGTSbFhWSVqFma0FAy5
	nQJhPnSaWZE6ux/glbAtjCYls7zpA1y6NfVLoG+WX16rZgbQ18/WVSqT7oOETvMB
	5203Fhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gZHF6Q
	ppbECrG+eic0qfLqB6vwnFlNSLBArg8eUSR8h2i6SGe4iap1BfKF4VZQUG9iCa4R
	PMVzybgtD5k5Y+YZwU/Kq+/RmVQ3g16j9snmBEuqY0IgM21aiK6wiR1HF9CuEk8i
	IDuTQqK986VKR+kMb0vYFEVrblckpDGepA5W4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB4E25BA0
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F8195B9C for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:33 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 81F398DC-0A6E-11E1-BF64-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185136>

After running "git pull $there for-linus" to merge a signed tag, the
integrator may need to amend the resulting merge commit to fix typoes
in it. Teach --amend option to read the existing extra headers, and
carry them forward.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c |    9 ++++++-
 commit.c         |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.h         |    3 ++
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4688a73..fca7ea0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1382,6 +1382,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	int allow_fast_forward = 1;
 	struct wt_status s;
 	struct commit *current_head = NULL;
+	struct commit_extra_header *extra = NULL;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1483,12 +1484,16 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
-	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, sha1,
-			author_ident.buf)) {
+	if (amend)
+		extra = read_commit_extra_headers(current_head);
+
+	if (commit_tree_extended(sb.buf, active_cache_tree->sha1, parents, sha1,
+				 author_ident.buf, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
 	strbuf_release(&author_ident);
+	free_commit_extra_headers(extra);
 
 	ref_lock = lock_any_ref_for_update("HEAD",
 					   !current_head
diff --git a/commit.c b/commit.c
index ee12eff..1c05879 100644
--- a/commit.c
+++ b/commit.c
@@ -897,6 +897,66 @@ static void add_extra_header(struct strbuf *buffer,
 	strbuf_add_lines(buffer, " ", extra->value, extra->len);
 }
 
+struct commit_extra_header *read_commit_extra_headers(struct commit *commit)
+{
+	struct commit_extra_header *extra = NULL;
+	size_t size;
+	enum object_type type;
+	char *buffer = read_sha1_file(commit->object.sha1, &type, &size);
+	if (buffer && type == OBJ_COMMIT)
+		extra = read_commit_extra_header_lines(buffer, size);
+	free(buffer);
+	return extra;
+}
+
+static inline int standard_header_field(const char *field, size_t len)
+{
+	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
+		(len == 6 && !memcmp(field, "parent ", 7)) ||
+		(len == 6 && !memcmp(field, "author ", 7)) ||
+		(len == 9 && !memcmp(field, "committer ", 10)) ||
+		(len == 8 && !memcmp(field, "encoding ", 9)));
+}
+
+struct commit_extra_header *read_commit_extra_header_lines(const char *buffer, size_t size)
+{
+	struct commit_extra_header *extra = NULL, **tail = &extra, *it = NULL;
+	const char *line, *next, *eof, *eob;
+	struct strbuf buf = STRBUF_INIT;
+
+	for (line = buffer, eob = line + size;
+	     line < eob && *line != '\n';
+	     line = next) {
+		next = memchr(line, '\n', eob - line);
+		next = next ? next + 1 : eob;
+		if (*line == ' ') {
+			/* continuation */
+			strbuf_add(&buf, line + 1, next - (line + 1));
+			continue;
+		}
+		if (it)
+			it->value = strbuf_detach(&buf, &it->len);
+		strbuf_reset(&buf);
+		it = NULL;
+
+		eof = strchr(line, ' ');
+		if (next <= eof)
+			continue; /* malformed */
+
+		if (standard_header_field(line, eof - line))
+			continue;
+
+		it = xcalloc(1, sizeof(*it));
+		it->key = xmemdupz(line, eof-line);
+		*tail = it;
+		tail = &it->next;
+		strbuf_add(&buf, eof + 1, next - (eof + 1));
+	}
+	if (it)
+		it->value = strbuf_detach(&buf, &it->len);
+	return extra;
+}
+
 void free_commit_extra_headers(struct commit_extra_header *extra)
 {
 	while (extra) {
diff --git a/commit.h b/commit.h
index c1a723e..3745f12 100644
--- a/commit.h
+++ b/commit.h
@@ -200,6 +200,9 @@ extern int commit_tree_extended(const char *msg, unsigned char *tree,
 				const char *author,
 				struct commit_extra_header *);
 
+extern struct commit_extra_header *read_commit_extra_headers(struct commit *);
+extern struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len);
+
 extern void free_commit_extra_headers(struct commit_extra_header *extra);
 
 struct merge_remote_desc {
-- 
1.7.8.rc1.82.g90e080
