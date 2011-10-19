From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/3] log: --show-signature
Date: Tue, 18 Oct 2011 17:20:45 -0700
Message-ID: <1318983645-18897-4-git-send-email-gitster@pobox.com>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <1318983645-18897-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 02:21:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGJu4-0007Gr-Pg
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 02:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab1JSAU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 20:20:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592Ab1JSAUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 20:20:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB92744E4
	for <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1pgB
	1MMbz/5iPuQxAZe93QdvKyk=; b=Br1zu96VU4EBbqjHFOEogW0ovnqB1PHzvIvh
	OrFV11jfElFEv9wT9Hp49VzOUfmcFY5YT1aEG0A6QgojKOi6XxpLDvNalPyCHZ7V
	CYtR7P6aiRcpJNrtN+TNV7PUxypmLsildX6hXoIABiCB7UMCOzEq3Fcf0fn/fv08
	1SPLY4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Cs0Wi0
	+NGLA3pIH8db+Bi8y139BDrS6wRd1DEeDGqk46RCggNbK67XMTvB8RXQmOU8u6qe
	NjNDyeaeBpjtfaGA8CXj6kqiE2X/lDgsS/6wa45fCqYalAnBJLKB3U2pDzFEJiCH
	JzQ7CfqeEMK4hkSDw9JcGZvEVapjzg/cDC+fc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E34D744E3
	for <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3480044E2 for
 <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.388.g3a4b7
In-Reply-To: <1318983645-18897-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 34A7B6E4-F9E8-11E0-A2CC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183910>

This teaches the "log" family of commands to pass the GPG signature in the
commit objects to "gpg --verify" via the verify_signed_buffer() interface
used to verify signed tag objects. E.g.

    $ git show --show-signature -s HEAD

would show GPG output in the header part of the output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * We may want to capture good/bad/untrusted signature information from
   GPG and teach userformat to show that, but this code is not there yet.

 commit.c   |   34 ++++++++++++++++++++++++++++++++++
 commit.h   |    3 +++
 log-tree.c |   17 +++++++++++++++++
 revision.c |    2 ++
 revision.h |    1 +
 5 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 4bff3cd..93045a2 100644
--- a/commit.c
+++ b/commit.c
@@ -848,6 +848,40 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
 	return 0;
 }
 
+int parse_signed_commit(const unsigned char *sha1,
+			struct strbuf *payload, struct strbuf *signature)
+{
+	unsigned long size;
+	enum object_type type;
+	char *buffer = read_sha1_file(sha1, &type, &size);
+	int in_header, saw_signature = -1;
+	char *line;
+
+	if (!buffer || type != OBJ_COMMIT)
+		goto cleanup;
+
+	line = buffer;
+	in_header = 1;
+	saw_signature = 0;
+	while (*line) {
+		char *next = strchrnul(line, '\n');
+		if (*next)
+			next++;
+		if (in_header && !prefixcmp(line, gpg_sig_header)) {
+			const char *sig = line + gpg_sig_header_len;
+			strbuf_add(signature, sig, next - sig);
+			saw_signature = 1;
+		} else {
+			strbuf_add(payload, line, next - line);
+		}
+		if (*line == '\n')
+			in_header = 0;
+		line = next;
+	}
+ cleanup:
+	free(buffer);
+	return saw_signature;
+}
 
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
diff --git a/commit.h b/commit.h
index 8c2419b..1885471 100644
--- a/commit.h
+++ b/commit.h
@@ -177,4 +177,7 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		       const char *author, const char *sign_commit);
 
+extern int parse_signed_commit(const unsigned char *sha1,
+			       struct strbuf *message, struct strbuf *signature);
+
 #endif /* COMMIT_H */
diff --git a/log-tree.c b/log-tree.c
index 24c295e..749bb65 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -8,6 +8,7 @@
 #include "refs.h"
 #include "string-list.h"
 #include "color.h"
+#include "gpg-interface.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -395,6 +396,19 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 	*extra_headers_p = extra_headers;
 }
 
+static void show_signature(struct rev_info *opt, struct commit *commit)
+{
+	struct strbuf payload = STRBUF_INIT;
+	struct strbuf signature = STRBUF_INIT;
+
+	if (parse_signed_commit(commit->object.sha1, &payload, &signature) >= 0) {
+		verify_signed_buffer(payload.buf, payload.len,
+				     signature.buf, signature.len, 0);
+	}
+	strbuf_release(&payload);
+	strbuf_release(&signature);
+}
+
 void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
@@ -502,6 +516,9 @@ void show_log(struct rev_info *opt)
 		}
 	}
 
+	if (opt->show_signature)
+		show_signature(opt, commit);
+
 	if (!commit->buffer)
 		return;
 
diff --git a/revision.c b/revision.c
index c46cfaa..860a312 100644
--- a/revision.c
+++ b/revision.c
@@ -1381,6 +1381,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
 		revs->notes_opt.use_default_notes = 1;
+	} else if (!strcmp(arg, "--show-signature")) {
+		revs->show_signature = 1;
 	} else if (!prefixcmp(arg, "--show-notes=") ||
 		   !prefixcmp(arg, "--notes=")) {
 		struct strbuf buf = STRBUF_INIT;
diff --git a/revision.h b/revision.h
index 3d64ada..198bb95 100644
--- a/revision.h
+++ b/revision.h
@@ -89,6 +89,7 @@ struct rev_info {
 			show_merge:1,
 			show_notes:1,
 			show_notes_given:1,
+			show_signature:1,
 			pretty_given:1,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
-- 
1.7.7.388.g3a4b7
