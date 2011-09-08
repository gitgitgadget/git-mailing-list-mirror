From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/7] push -s: receiving end
Date: Thu,  8 Sep 2011 13:01:40 -0700
Message-ID: <1315512102-19022-6-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 00:56:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nWe-0004sj-5B
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553Ab1IHW4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:56:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38550 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333Ab1IHW4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:56:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 841A1464D
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UU2y
	YCk/gAQNTZ3qR6bN3dWQ/oY=; b=RXsQNlTeuzxBbFHyFxQOoqSBiEK0Y/lOFEwk
	mLdVOiD+ZlL31EtzAAN2ghA/6kdyGD7S6MkriEuMtg5NJnL1g9D1YAO73ikLZwYk
	baLH5xpziRO+i4py7VVjJ7R5WDCLM6W0PQqGVPXWgfw2acFqIpcdfsSxWF5p66z+
	TDsVBiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=t2k+Mw
	iV2F4ZlL+M2T245qze6ySsKnU/am3Os7ZJEGglN1makOeiJsyGUmrF8qFK7jYolH
	yIOdT7J4vSVkwzTp90+KF15emTPFdrOeAejmqtjTLuaRO/qlx5QN3+GaA9ozDOzb
	sB9gJ3kArqh36jKz6VFQZIYf/W84emvoEw83c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A7C3464C
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B95AB464B for
 <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315512102-19022-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 65E4DD34-DA55-11E0-BCF9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180982>

This stores the GPG signed push certificate in the receiving repository
using the notes mechanism. The certificate is appended to a note in the
refs/notes/signed-push tree for each object that appears on the right
hand side of the push certificate, i.e. the object that was pushed to
update the tip of a ref.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c |   72 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 20b6799..344660e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -11,6 +11,11 @@
 #include "transport.h"
 #include "string-list.h"
 #include "sha1-array.h"
+#include "gpg-interface.h"
+#include "notes.h"
+#include "notes-merge.h"
+#include "blob.h"
+#include "tag.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -581,6 +586,22 @@ static void check_aliased_updates(struct command *commands)
 	string_list_clear(&ref_list, 0);
 }
 
+static void get_note_text(struct strbuf *buf, struct notes_tree *t,
+			  const unsigned char *object)
+{
+	const unsigned char *sha1 = get_note(t, object);
+	char *text;
+	unsigned long len;
+	enum object_type type;
+
+	if (!sha1)
+		return;
+	text = read_sha1_file(sha1, &type, &len);
+	if (text && len && type == OBJ_BLOB)
+		strbuf_add(buf, text, len);
+	free(text);
+}
+
 static int record_signed_push(char *cert)
 {
 	/*
@@ -592,18 +613,55 @@ static int record_signed_push(char *cert)
 	 * You could also feed the signed push certificate to GPG,
 	 * verify the signer identity, and all the other fun stuff,
 	 * including feeding it to "pre-receive-signature" hook.
-	 *
-	 * Here we just throw it to stderr to demonstrate that the
-	 * codepath is being exercised.
 	 */
+	size_t total, payload;
 	char *cp, *ep;
-	for (cp = cert; *cp; cp = ep) {
+	int ret = 0;
+	struct notes_tree *t;
+	struct strbuf nbuf = STRBUF_INIT;
+
+	if (!cert)
+		return 0;
+
+	init_notes(NULL, "refs/notes/signed-push", NULL, 0);
+	t = &default_notes_tree;
+
+	total = strlen(cert);
+	payload = parse_signature(cert, total);
+	for (cp = cert; cp < cert + payload; cp = ep) {
+		unsigned char sha1[20], nsha1[20];
+
 		ep = strchrnul(cp, '\n');
 		if (*ep == '\n')
 			ep++;
-		fprintf(stderr, "RSP: %.*s", (int)(ep - cp), cp);
+		if (prefixcmp(cp, "Update: "))
+			continue;
+		cp += strlen("Update: ");
+		if (get_sha1_hex(cp, sha1) || cp[40] != ' ')
+			continue;
+
+		get_note_text(&nbuf, t, sha1);
+		if (nbuf.len)
+			strbuf_addch(&nbuf, '\n');
+		strbuf_add(&nbuf, cert, total);
+		if (write_sha1_file(nbuf.buf, nbuf.len, blob_type, nsha1) ||
+		    add_note(t, sha1, nsha1, NULL))
+			ret = error(_("unable to write note object"));
+		strbuf_reset(&nbuf);
 	}
-	return 0;
+
+	if (!ret) {
+		unsigned char commit[20];
+		unsigned char parent[20];
+		struct ref_lock *lock;
+
+		resolve_ref(t->ref, parent, 0, NULL);
+		lock = lock_any_ref_for_update(t->ref, parent, 0);
+		create_notes_commit(t, NULL, "push", commit);
+		ret = write_ref_sha1(lock, commit, "push");
+	}
+	free_notes(t);
+	return ret;
 }
 
 static void execute_commands(struct command *commands, const char *unpacker_error)
@@ -623,7 +681,7 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 		return;
 	}
 
-	if (push_certificate && record_signed_push(push_certificate)) {
+	if (record_signed_push(push_certificate)) {
 		for (cmd = commands; cmd; cmd = cmd->next)
 			cmd->error_string = "n/a (push signature error)";
 		return;
-- 
1.7.7.rc0.188.g3793ac
