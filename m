From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/2] push -s: receiving end
Date: Wed, 07 Sep 2011 22:38:31 -0700
Message-ID: <7v7h5jzj8o.fsf_-_@alter.siamese.dyndns.org>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <7vehzrzm0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 07:38:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1XJx-0001XU-Vz
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 07:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421Ab1IHFif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 01:38:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37241 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab1IHFie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 01:38:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C33AE346D;
	Thu,  8 Sep 2011 01:38:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s7Csgwlc0XL5b+Dr2sp9Y5h5dcw=; b=IsKKCL
	COAslOSKh4l5OHPygyJI9E8pDEEXrkDY6U32GLzAt1EJzNCpfO30JSDCNvYJh5TX
	9MbsFoCUoVcFNGb+bmfHzp86aDl9XmS/pEndjXWac+TYnrmy/gn0ryLtqo82PZiN
	8gHWeyNOF32xEvRKZ56wLz3HDss1/0/1Dd7tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EvEKZgXhYNLJmcqeJ+8eA6MU+w91bmR+
	HY3pAs45k1k/lv2uZi1dQ81pcgJTsds0Gr37A2bFFXBuyCOWsmOqv6DpW4n36Enr
	iyUMFSvjwhPZXfgMUzjlFaBlSE/ecQ9Tivvq4Y8/C9aQaOWN5+MrUOk50vTKfmKj
	aZIPg3siW0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA2D1346B;
	Thu,  8 Sep 2011 01:38:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 082E9346A; Thu,  8 Sep 2011
 01:38:32 -0400 (EDT)
In-Reply-To: <7vehzrzm0e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 07 Sep 2011 21:38:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA41A100-D9DC-11E0-9A2D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180940>

This stores the GPG signed push certificate in the receiving repository
using the notes mechanism. The certificate is appended to a note in the
refs/notes/signed-push tree for each object that appears on the right
hand side of the push certificate, i.e. the object that was pushed to
update the tip of a ref.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is largely untested, so take it with a large grain of salt.
   This concludes tonight's hacking session for me.

 builtin/receive-pack.c |   74 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 307fc3b..257f2a5 100644
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
 
@@ -156,6 +161,7 @@ struct command {
 };
 
 static const char pre_receive_hook[] = "hooks/pre-receive";
+static const char pre_receive_signature_hook[] = "hooks/pre-receive-signature";
 static const char post_receive_hook[] = "hooks/post-receive";
 
 static void rp_error(const char *err, ...) __attribute__((format (printf, 1, 2)));
@@ -581,6 +587,22 @@ static void check_aliased_updates(struct command *commands)
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
@@ -591,19 +613,57 @@ static int record_signed_push(char *cert)
 	 *
 	 * You could also feed the signed push certificate to GPG,
 	 * verify the signer identity, and all the other fun stuff,
-	 * including feeding it to "pre-push-verify-signature" hook.
-	 *
-	 * Here we just throw it to stderr to demonstrate that the
-	 * codepath is being exercised.
+	 * including feeding it to "pre-receive-signature" hook.
 	 */
+	size_t total, payload;
 	char *cp, *ep;
-	for (cp = cert; *cp; cp = ep) {
+	int ret = 0;
+	struct notes_tree *t;
+	struct strbuf nbuf = STRBUF_INIT;
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
+		cp += 41;
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
+
+	return ret;
 }
 
 static void execute_commands(struct command *commands, const char *unpacker_error)
-- 
1.7.7.rc0.188.g3793ac
