From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] push -s: signed push
Date: Fri,  9 Sep 2011 13:41:44 -0700
Message-ID: <1315600904-17032-5-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 22:42:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R27tv-00036K-Qb
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 22:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933680Ab1IIUmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 16:42:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933350Ab1IIUlz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 16:41:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 929B25E61
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9bfs
	FjSUxdPWazu8TsE5d8C5uQ8=; b=X9clMt1DhIIQg9RbdffvUEhbkv1WBghn3DH3
	veeALQ6oz0z3c8Venc3HsnOKdqsb59C7CCrttij4NefJhVddoaIxvoZlSCfs9Zpi
	99CP+YPPW2QG1Bq4YNsNamS+niR/O5+M25tUwLor0h0dusRTjWOV4cDiycD8IUvr
	l7KRsTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=tU85DW
	IO260+tIEb7HDjK00e9I0jmTv8NMbLdrH92wn4GP+kK74RoMqP9TirxEnlYCkfAm
	uSii8okk1OKO09lMpos6mx2+dI8mOcLfq2WaBFkU52hKZtnX25R2A/Ps+tVzHZ23
	Gm+pdrEILYr54w6L27Mp+dDrs2qvGxsl/3lYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8746B5E60
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B15625E5F for
 <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315600904-17032-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 26CC6B1A-DB24-11E0-A51B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181122>

If a tag is GPG-signed, and if you trust the cryptographic robustness of
the SHA-1 hash and GPG, you can sleep well knowing that all the history
leading to the signed commit cannot be tampered with. However, it would be
both cumbersome and cluttering to sign each and every commit. Especially
if you strive to keep your history clean by tweaking, rewriting and
polishing your commits before pushing the resulting history out, many
commits you will create locally end up not mattering at all, and it is a
waste of time to sign them all.

A better alternative could be to sign a "push certificate" (for the lack
of better name) every time you push, asserting that what commits you are
pushing to update which refs.

The basic workflow based on this idea would go like this:

 1. You push out your work with "git push -s";

 2. "git push", as usual, learns where the remote refs are and which refs
    are to be updated with this push. It prepares a text file in core,
    that looks like the following:

	Push-Certificate-Version: 0
	Pusher: Junio C Hamano <gitster@pobox.com> 1315427886 -0700
	Update: 3793ac56b4c4f9bf0bddc306a0cec21118683728 refs/heads/master
	Update: 12850bec0c24b529c9a9df6a95ad4bdeea39373e refs/heads/next

    Each "Update" line shows the new object name at the tip of the ref
    this push tries to update.

    The user then is asked to sign this push certificate using GPG.

 3. The signed push certificate is added as notes in the "signed-push"
    notes tree to the objects listed in the certificate. The push refspec
    is altered to push this notes tree to the other side.

Compared to the alternative design posted earlier on the list, this does
not require changes in the receiving end, as the signed push certificate
is added to the notes tree on the sending side. A possible downside is
that it may become more likely that a push is refused due to a conflict
while updating the notes tree if the receiving repository is pushed into
frequently and by multiple people.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c |    1 +
 notes.c        |   16 +++++++
 notes.h        |    2 +
 transport.c    |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 transport.h    |    5 ++
 5 files changed, 148 insertions(+), 0 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 35cce53..2238f4e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -261,6 +261,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('u', "set-upstream", &flags, "set upstream for git pull/status",
 			TRANSPORT_PUSH_SET_UPSTREAM),
 		OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
+		OPT_BIT('s', "signed", &flags, "GPG sign the push", TRANSPORT_PUSH_SIGNED),
 		OPT_END()
 	};
 
diff --git a/notes.c b/notes.c
index 93e9868..d081e7c 100644
--- a/notes.c
+++ b/notes.c
@@ -1296,3 +1296,19 @@ void expand_notes_ref(struct strbuf *sb)
 	else
 		strbuf_insert(sb, 0, "refs/notes/", 11);
 }
+
+void get_note_text(struct strbuf *buf, struct notes_tree *t,
+		   const unsigned char *object)
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
diff --git a/notes.h b/notes.h
index c716694..5141e13 100644
--- a/notes.h
+++ b/notes.h
@@ -312,4 +312,6 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 /* Expand inplace a note ref like "foo" or "notes/foo" into "refs/notes/foo" */
 void expand_notes_ref(struct strbuf *sb);
 
+void get_note_text(struct strbuf *, struct notes_tree *, const unsigned char *);
+
 #endif
diff --git a/transport.c b/transport.c
index 740a739..de61669 100644
--- a/transport.c
+++ b/transport.c
@@ -11,6 +11,12 @@
 #include "branch.h"
 #include "url.h"
 #include "submodule.h"
+#include "gpg-interface.h"
+#include "commit.h"
+#include "notes.h"
+#include "notes-merge.h"
+#include "blob.h"
+#include "tag.h"
 
 /* rsync support */
 
@@ -476,6 +482,9 @@ static int set_git_option(struct git_transport_options *opts,
 		else
 			opts->depth = atoi(value);
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_SIGNED_PUSH)) {
+		opts->signed_push = !!value;
+		return 0;
 	}
 	return 1;
 }
@@ -1004,6 +1013,112 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 	transport->progress = force_progress || (verbosity >= 0 && isatty(2));
 }
 
+static int is_ref_pushed(const struct ref *ref)
+{
+	if (!ref->peer_ref || ref->deletion)
+		return 0;
+
+	/* Filter out unchanged ones */
+	switch (ref->status) {
+	case REF_STATUS_REJECT_NONFASTFORWARD:
+	case REF_STATUS_UPTODATE:
+		return 0;
+	default:
+		; /* ok */
+	}
+
+	return 1;
+}
+
+static const char push_signature_note[] = "refs/notes/signed-push";
+
+static int add_push_signature_note(struct ref *signature_note,
+				   struct ref *ref,
+				   struct strbuf *cert)
+{
+	struct notes_tree *notes_tree;
+	struct strbuf nbuf = STRBUF_INIT;
+	int ret = 0;
+	unsigned char parent[20], commit[20];
+	struct ref_lock *lock;
+
+	init_notes(NULL, push_signature_note, NULL, 0);
+	notes_tree = &default_notes_tree;
+
+	resolve_ref(notes_tree->ref, parent, 0, NULL);
+	lock = lock_any_ref_for_update(notes_tree->ref, parent, 0);
+
+	for ( ; ref; ref = ref->next) {
+		unsigned char nsha1[20];
+
+		if ((ref == signature_note) || !is_ref_pushed(ref))
+			continue;
+		get_note_text(&nbuf, notes_tree, ref->new_sha1);
+		if (nbuf.len)
+			strbuf_addch(&nbuf, '\n');
+		strbuf_add(&nbuf, cert->buf, cert->len);
+		if (write_sha1_file(nbuf.buf, nbuf.len, blob_type, nsha1) ||
+		    add_note(notes_tree, ref->new_sha1, nsha1, NULL))
+			ret = error(_("unable to write note object"));
+		strbuf_reset(&nbuf);
+	}
+
+	if (!ret) {
+		create_notes_commit(notes_tree, NULL, "push", commit);
+		ret = write_ref_sha1(lock, commit, "signed push");
+	}
+	free_notes(notes_tree);
+
+	if (!ret) {
+		hashcpy(signature_note->new_sha1, commit);
+		if (!signature_note->peer_ref)
+			signature_note->peer_ref = alloc_ref(push_signature_note);
+	}
+	return ret;
+}
+
+static int sign_push_certificate(struct strbuf *cert)
+{
+	return sign_buffer(cert, git_committer_info(IDENT_NO_DATE));
+}
+
+static int sign_push(struct transport *transport,
+		     struct ref *remote_refs,
+		     int flags)
+{
+	struct ref *ref, *tail = NULL, *signature_note = NULL;
+	struct strbuf push_cert = STRBUF_INIT;
+	int updates = 0, ret = 0;
+
+	if (flags & TRANSPORT_PUSH_DRY_RUN)
+		return 0;
+
+	strbuf_addstr(&push_cert, "Push-Certificate-Version: 0\n");
+	strbuf_addf(&push_cert, "Pusher: %s\n", git_committer_info(0));
+
+	for (ref = remote_refs; ref; ref = ref->next) {
+		tail = ref;
+		if (!strcmp(ref->name, push_signature_note))
+			signature_note = ref;
+		if (!is_ref_pushed(ref))
+			continue;
+		updates++;
+		strbuf_addf(&push_cert, "Update: %s %s\n",
+			    sha1_to_hex(ref->new_sha1), ref->name);
+	}
+
+	if (updates && !sign_push_certificate(&push_cert)) {
+		if (!signature_note) {
+			signature_note = alloc_ref(push_signature_note);
+			tail->next = signature_note;
+		}
+		ret = add_push_signature_note(signature_note,
+					      remote_refs, &push_cert);
+	}
+	strbuf_release(&push_cert);
+	return ret;
+}
+
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
 		   int *nonfastforward)
@@ -1015,6 +1130,9 @@ int transport_push(struct transport *transport,
 		/* Maybe FIXME. But no important transport uses this case. */
 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
 			die("This transport does not support using --set-upstream");
+		/* Likewise */
+		if (flags & TRANSPORT_PUSH_SIGNED)
+			die("This transport does not support using --signed");
 
 		return transport->push(transport, refspec_nr, refspec, flags);
 	} else if (transport->push_refs) {
@@ -1050,7 +1168,13 @@ int transport_push(struct transport *transport,
 					die("There are unpushed submodules, aborting.");
 		}
 
+		if (flags & TRANSPORT_PUSH_SIGNED) {
+			if (sign_push(transport, remote_refs, flags))
+				return -1;
+		}
+
 		push_ret = transport->push_refs(transport, remote_refs, flags);
+
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
 
diff --git a/transport.h b/transport.h
index 059b330..034ff5a 100644
--- a/transport.h
+++ b/transport.h
@@ -8,6 +8,7 @@ struct git_transport_options {
 	unsigned thin : 1;
 	unsigned keep : 1;
 	unsigned followtags : 1;
+	unsigned signed_push : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
@@ -102,6 +103,7 @@ struct transport {
 #define TRANSPORT_PUSH_PORCELAIN 16
 #define TRANSPORT_PUSH_SET_UPSTREAM 32
 #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
+#define TRANSPORT_PUSH_SIGNED 128
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
@@ -128,6 +130,9 @@ struct transport *transport_get(struct remote *, const char *);
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
 
+/* Signed push */
+#define TRANS_OPT_SIGNED_PUSH "signedpush"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
1.7.7.rc0.188.g3793ac
