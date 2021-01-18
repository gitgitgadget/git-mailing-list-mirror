Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9769EC433E6
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538D422E00
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbhARXvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 18:51:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55916 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387806AbhARXvW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Jan 2021 18:51:22 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DBC2360784;
        Mon, 18 Jan 2021 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611013810;
        bh=gZwjNjG0rrPzkbv2N7B6QULdmlWaROoNeaLgwPl2Bhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FJSex/SOR0TU+urd/U/bllGiGvNJ1YKEay+KbJSqEHkwxD1IaJA6mkNQe0TxbByUs
         +YnUY4Q7Hbf+QhEJAAeVB9Jc0/j2qPfTYNckOi5eV3shDYkfBVSMujGRG7sqllakaP
         ltEAA8hBjaEvRYT8ojBkjwJEKoVW55jHe5lCEB/qxdqnc4GaG/y1wFoFKdlZUBDR5A
         8UHiZVGcICPtcj1vSsTURLTL1hku7RVDPBrLBlV7HC5n71TVu1Hr3uJK2vXAZdsVvP
         Aboh+afWdiber2Q0uYoEQrW0rI1J/dRRl5MJGeScYgdG+MrzIQIFWwPq8QurAp9gaC
         B02R/Bjzsv6I+7Ei5iv/vmtgX6HYP8O2VYHVtj8qGLTlOwOxp2mTtoV4FSWCjHS52t
         WfL8BKz57CE9LAvtXDLe5iMxCF/TlbgTm0HTh1+TwN1BQoN/ir11r26tdiGQSJnJe6
         6sHbJI9BwysjY2dD+fBZwu0g2I80UjKNYVz22bR15T/p/dvTk0i
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 3/6] gpg-interface: improve interface for parsing tags
Date:   Mon, 18 Jan 2021 23:49:12 +0000
Message-Id: <20210118234915.2036197-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
References: <20210111035840.2437737-1-sandals@crustytoothpaste.net>
 <20210118234915.2036197-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a function which parses a buffer with a signature at the end,
parse_signature, and this function is used for signed tags.  However,
we'll need to store values for multiple algorithms, and we'll do this by
using a header for the non-default algorithm.

Adjust the parse_signature interface to store the parsed data in two
strbufs and turn the existing function into parse_signed_buffer.  The
latter is still used in places where we know we always have a signed
buffer, such as push certs.

Adjust all the callers to deal with this new interface.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c |  4 ++--
 builtin/tag.c          | 16 ++++++++++++----
 commit.c               |  9 ++++++---
 fmt-merge-msg.c        | 29 ++++++++++++++++++-----------
 gpg-interface.c        | 13 ++++++++++++-
 gpg-interface.h        |  9 ++++++++-
 log-tree.c             | 13 +++++++------
 ref-filter.c           | 18 ++++++++++++++----
 tag.c                  | 15 ++++++++-------
 9 files changed, 87 insertions(+), 39 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d49d050e6e..b89ce31bf2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -764,7 +764,7 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 
 		memset(&sigcheck, '\0', sizeof(sigcheck));
 
-		bogs = parse_signature(push_cert.buf, push_cert.len);
+		bogs = parse_signed_buffer(push_cert.buf, push_cert.len);
 		check_signature(push_cert.buf, bogs, push_cert.buf + bogs,
 				push_cert.len - bogs, &sigcheck);
 
@@ -2050,7 +2050,7 @@ static void queue_commands_from_cert(struct command **tail,
 		die("malformed push certificate %.*s", 100, push_cert->buf);
 	else
 		boc += 2;
-	eoc = push_cert->buf + parse_signature(push_cert->buf, push_cert->len);
+	eoc = push_cert->buf + parse_signed_buffer(push_cert->buf, push_cert->len);
 
 	while (boc < eoc) {
 		const char *eol = memchr(boc, '\n', eoc - boc);
diff --git a/builtin/tag.c b/builtin/tag.c
index ecf011776d..7162f4ccc5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -174,11 +174,17 @@ static void write_tag_body(int fd, const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf, *sp;
+	char *buf, *sp, *orig;
+	struct strbuf payload = STRBUF_INIT;
+	struct strbuf signature = STRBUF_INIT;
 
-	buf = read_object_file(oid, &type, &size);
+	orig = buf = read_object_file(oid, &type, &size);
 	if (!buf)
 		return;
+	if (parse_signature(buf, size, &payload, &signature)) {
+		buf = payload.buf;
+		size = payload.len;
+	}
 	/* skip header */
 	sp = strstr(buf, "\n\n");
 
@@ -187,9 +193,11 @@ static void write_tag_body(int fd, const struct object_id *oid)
 		return;
 	}
 	sp += 2; /* skip the 2 LFs */
-	write_or_die(fd, sp, parse_signature(sp, buf + size - sp));
+	write_or_die(fd, sp, buf + size - sp);
 
-	free(buf);
+	free(orig);
+	strbuf_release(&payload);
+	strbuf_release(&signature);
 }
 
 static int build_tag_object(struct strbuf *buf, int sign, struct object_id *result)
diff --git a/commit.c b/commit.c
index 1006c85ca8..ccb912b9b5 100644
--- a/commit.c
+++ b/commit.c
@@ -1136,8 +1136,10 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	struct merge_remote_desc *desc;
 	struct commit_extra_header *mergetag;
 	char *buf;
-	unsigned long size, len;
+	unsigned long size;
 	enum object_type type;
+	struct strbuf payload = STRBUF_INIT;
+	struct strbuf signature = STRBUF_INIT;
 
 	desc = merge_remote_util(parent);
 	if (!desc || !desc->obj)
@@ -1145,8 +1147,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	buf = read_object_file(&desc->obj->oid, &type, &size);
 	if (!buf || type != OBJ_TAG)
 		goto free_return;
-	len = parse_signature(buf, size);
-	if (size == len)
+	if (!parse_signature(buf, size, &payload, &signature))
 		goto free_return;
 	/*
 	 * We could verify this signature and either omit the tag when
@@ -1165,6 +1166,8 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 
 	**tail = mergetag;
 	*tail = &mergetag->next;
+	strbuf_release(&payload);
+	strbuf_release(&signature);
 	return;
 
 free_return:
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 9a664a4a58..7fd99f0ac1 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -509,22 +509,28 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 	for (i = 0; i < origins.nr; i++) {
 		struct object_id *oid = origins.items[i].util;
 		enum object_type type;
-		unsigned long size, len;
+		unsigned long size;
 		char *buf = read_object_file(oid, &type, &size);
+		char *origbuf = buf;
+		unsigned long len = size;
 		struct signature_check sigc = { NULL };
-		struct strbuf sig = STRBUF_INIT;
+		struct strbuf payload = STRBUF_INIT, sig = STRBUF_INIT;
 
 		if (!buf || type != OBJ_TAG)
 			goto next;
-		len = parse_signature(buf, size);
 
-		if (size == len)
-			; /* merely annotated */
-		else if (check_signature(buf, len, buf + len, size - len, &sigc) &&
-			!sigc.gpg_output)
-			strbuf_addstr(&sig, "gpg verification failed.\n");
-		else
-			strbuf_addstr(&sig, sigc.gpg_output);
+		if (!parse_signature(buf, size, &payload, &sig))
+			;/* merely annotated */
+		else {
+			buf = payload.buf;
+			len = payload.len;
+			if (check_signature(payload.buf, payload.len, sig.buf,
+					 sig.len, &sigc) &&
+				!sigc.gpg_output)
+				strbuf_addstr(&sig, "gpg verification failed.\n");
+			else
+				strbuf_addstr(&sig, sigc.gpg_output);
+		}
 		signature_check_clear(&sigc);
 
 		if (!tag_number++) {
@@ -547,9 +553,10 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 					strlen(origins.items[i].string));
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 		}
+		strbuf_release(&payload);
 		strbuf_release(&sig);
 	next:
-		free(buf);
+		free(origbuf);
 	}
 	if (tagbuf.len) {
 		strbuf_addch(out, '\n');
diff --git a/gpg-interface.c b/gpg-interface.c
index b499270836..c6274c14af 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -345,7 +345,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }
 
-size_t parse_signature(const char *buf, size_t size)
+size_t parse_signed_buffer(const char *buf, size_t size)
 {
 	size_t len = 0;
 	size_t match = size;
@@ -361,6 +361,17 @@ size_t parse_signature(const char *buf, size_t size)
 	return match;
 }
 
+int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct strbuf *signature)
+{
+	size_t match = parse_signed_buffer(buf, size);
+	if (match != size) {
+		strbuf_add(payload, buf, match);
+		strbuf_add(signature, buf + match, size - match);
+		return 1;
+	}
+	return 0;
+}
+
 void set_signing_key(const char *key)
 {
 	free(configured_signing_key);
diff --git a/gpg-interface.h b/gpg-interface.h
index f4e9b4f371..80567e4894 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -37,13 +37,20 @@ struct signature_check {
 
 void signature_check_clear(struct signature_check *sigc);
 
+/*
+ * Look at a GPG signed tag object.  If such a signature exists, store it in
+ * signature and the signed content in payload.  Return 1 if a signature was
+ * found, and 0 otherwise.
+ */
+int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct strbuf *signature);
+
 /*
  * Look at GPG signed content (e.g. a signed tag object), whose
  * payload is followed by a detached signature on it.  Return the
  * offset where the embedded detached signature begins, or the end of
  * the data when there is no such signature.
  */
-size_t parse_signature(const char *buf, size_t size);
+size_t parse_signed_buffer(const char *buf, size_t size);
 
 /*
  * Create a detached signature for the contents of "buffer" and append
diff --git a/log-tree.c b/log-tree.c
index 7e0335e548..b025c8da93 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -548,7 +548,8 @@ static int show_one_mergetag(struct commit *commit,
 	struct strbuf verify_message;
 	struct signature_check sigc = { 0 };
 	int status, nth;
-	size_t payload_size;
+	struct strbuf payload = STRBUF_INIT;
+	struct strbuf signature = STRBUF_INIT;
 
 	hash_object_file(the_hash_algo, extra->value, extra->len,
 			 type_name(OBJ_TAG), &oid);
@@ -571,13 +572,11 @@ static int show_one_mergetag(struct commit *commit,
 		strbuf_addf(&verify_message,
 			    "parent #%d, tagged '%s'\n", nth + 1, tag->tag);
 
-	payload_size = parse_signature(extra->value, extra->len);
 	status = -1;
-	if (extra->len > payload_size) {
+	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
 		/* could have a good signature */
-		status = check_signature(extra->value, payload_size,
-					 extra->value + payload_size,
-					 extra->len - payload_size, &sigc);
+		status = check_signature(payload.buf, payload.len,
+					 signature.buf, signature.len, &sigc);
 		if (sigc.gpg_output)
 			strbuf_addstr(&verify_message, sigc.gpg_output);
 		else
@@ -588,6 +587,8 @@ static int show_one_mergetag(struct commit *commit,
 
 	show_sig_lines(opt, status, verify_message.buf);
 	strbuf_release(&verify_message);
+	strbuf_release(&payload);
+	strbuf_release(&signature);
 	return 0;
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 606f638ab1..bba4877745 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1215,7 +1215,13 @@ static void find_subpos(const char *buf,
 			size_t *nonsiglen,
 			const char **sig, size_t *siglen)
 {
+	struct strbuf payload = STRBUF_INIT;
+	struct strbuf signature = STRBUF_INIT;
 	const char *eol;
+	const char *end = buf + strlen(buf);
+	const char *sigstart;
+
+
 	/* skip past header until we hit empty line */
 	while (*buf && *buf != '\n') {
 		eol = strchrnul(buf, '\n');
@@ -1228,14 +1234,15 @@ static void find_subpos(const char *buf,
 		buf++;
 
 	/* parse signature first; we might not even have a subject line */
-	*sig = buf + parse_signature(buf, strlen(buf));
-	*siglen = strlen(*sig);
+	parse_signature(buf, end - buf, &payload, &signature);
+	*sig = strbuf_detach(&signature, siglen);
+	sigstart = buf + parse_signed_buffer(buf, strlen(buf));
 
 	/* subject is first non-empty line */
 	*sub = buf;
 	/* subject goes to first empty line before signature begins */
 	if ((eol = strstr(*sub, "\n\n"))) {
-		eol = eol < *sig ? eol : *sig;
+		eol = eol < sigstart ? eol : sigstart;
 	/* check if message uses CRLF */
 	} else if (! (eol = strstr(*sub, "\r\n\r\n"))) {
 		/* treat whole message as subject */
@@ -1253,7 +1260,7 @@ static void find_subpos(const char *buf,
 		buf++;
 	*body = buf;
 	*bodylen = strlen(buf);
-	*nonsiglen = *sig - buf;
+	*nonsiglen = sigstart - buf;
 }
 
 /*
@@ -1291,6 +1298,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 		struct used_atom *atom = &used_atom[i];
 		const char *name = atom->name;
 		struct atom_value *v = &val[i];
+
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
@@ -1336,6 +1344,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_BARE)
 			v->s = xstrdup(subpos);
+
+		free((void *)sigpos);
 	}
 }
 
diff --git a/tag.c b/tag.c
index 1ed2684e45..3e18a41841 100644
--- a/tag.c
+++ b/tag.c
@@ -13,26 +13,27 @@ const char *tag_type = "tag";
 static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 {
 	struct signature_check sigc;
-	size_t payload_size;
+	struct strbuf payload = STRBUF_INIT;
+	struct strbuf signature = STRBUF_INIT;
 	int ret;
 
 	memset(&sigc, 0, sizeof(sigc));
 
-	payload_size = parse_signature(buf, size);
-
-	if (size == payload_size) {
+	if (!parse_signature(buf, size, &payload, &signature)) {
 		if (flags & GPG_VERIFY_VERBOSE)
-			write_in_full(1, buf, payload_size);
+			write_in_full(1, buf, size);
 		return error("no signature found");
 	}
 
-	ret = check_signature(buf, payload_size, buf + payload_size,
-				size - payload_size, &sigc);
+	ret = check_signature(payload.buf, payload.len, signature.buf,
+				signature.len, &sigc);
 
 	if (!(flags & GPG_VERIFY_OMIT_STATUS))
 		print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
+	strbuf_release(&payload);
+	strbuf_release(&signature);
 	return ret;
 }
 
