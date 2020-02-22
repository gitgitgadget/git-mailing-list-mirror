Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186EBC35673
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD15208C3
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kGCyizla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgBVUST (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39086 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbgBVUSM (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:12 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 755FB6079A
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402690;
        bh=wmY3O8hcSosFsUom+jgrl41pnP5z1Yq9FNQuZ3ebhU8=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=kGCyizlaKe3C29oXqLFZWZNEoZVBEkpym2jTuV5vEzgxXg3BAjhucpX39LbI2tN1I
         yPOiwEiil7ZbCArSB/W1n5ucDsqtpmwlT1ekUPen+Cii2r8jrtwoKM2/uWXffhj8+T
         HAQdZYgGPMnd0D5DgO7kvQViUzfah0RNQgn/BoYwFJNMfpLBWerCq7wW2mtuNO9CAx
         NJLjKsMZr55SGmMx4doNxS2krPI/2tk5TctsSRqgSuFeId8i2zVb0qs1pigrExjHCu
         5HmJgKkAXV3uQeVVUhro4ImJ0p/7Y/CtY74Iqs9/xPS4Rd7ouwD95im/mCplDKILCE
         D8wvmKdUf8J8LKx70qBUMVY16sw2FFzhI0KlzpWcjDIi+zZIUKKY2VdnaGCUa11VaY
         LgZNcxEow3UfBAdWb8pCqEziqi7tZ1EbOhbHST5+X6ZhYP1pj2FfCC5Rs4/uSgeRtg
         8ocha90fN1PWHGNTzxMFIdJdi4vdLhO2kMwAUkfTQZhdZVV/T3k
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 18/24] gpg-interface: improve interface for parsing tags
Date:   Sat, 22 Feb 2020 20:17:43 +0000
Message-Id: <20200222201749.937983-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a function which parses a buffer with a signature at the end,
parse_signature, and this function is used for signed tags.  However,
the transition plan has SHA-256 tags using a header, which is a
materially different syntax.  The current interface is not suitable for
parsing such tags.

Adjust the parse_signature interface to store the parsed data in two
strbufs and turn the existing function into parse_signed_buffer.  The
latter is still used in places where we want to strip off the signature
in a SHA-1 tag or in places where we know we always have a signed
buffer, such as push certs.

Adjust all the callers to deal with this new interface.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fmt-merge-msg.c | 26 ++++++++++++++++++--------
 builtin/receive-pack.c  |  4 ++--
 builtin/tag.c           | 16 ++++++++++++----
 commit.c                |  9 ++++++---
 gpg-interface.c         | 13 ++++++++++++-
 gpg-interface.h         |  9 ++++++++-
 log-tree.c              | 14 ++++++++------
 ref-filter.c            | 18 ++++++++++++++----
 tag.c                   | 15 ++++++++-------
 9 files changed, 88 insertions(+), 36 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 05a92c59d8..29f647e2d9 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -472,6 +472,7 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 			      const char *buf,
 			      unsigned long len)
 {
+
 	const char *tag_body = strstr(buf, "\n\n");
 	if (tag_body) {
 		tag_body += 2;
@@ -492,24 +493,31 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 	for (i = 0; i < origins.nr; i++) {
 		struct object_id *oid = origins.items[i].util;
 		enum object_type type;
-		unsigned long size, len;
-		char *buf = read_object_file(oid, &type, &size);
+		unsigned long size;
+		char *buf = read_object_file(oid, &type, &size), *orig = buf;
 		struct signature_check sigc = { 0 };
+		struct strbuf payload = STRBUF_INIT;
+		struct strbuf signature = STRBUF_INIT;
 		struct strbuf sig = STRBUF_INIT;
+		size_t len = size;
 
 		if (!buf || type != OBJ_TAG)
 			goto next;
-		len = parse_signature(buf, size);
-
-		if (size == len)
-			; /* merely annotated */
-		else if (!check_signature(buf, len, buf + len, size - len,
+		if (!parse_signature(buf, size, &payload, &signature))
+			len = size; /* merely annotated */
+		else if (!check_signature(payload.buf, payload.len,
+					  signature.buf, signature.len,
 					  &sigc)) {
 			strbuf_addstr(&sig, sigc.gpg_output);
 			signature_check_clear(&sigc);
 		} else
 			strbuf_addstr(&sig, "gpg verification failed.\n");
 
+		if (payload.len) {
+			buf = payload.buf;
+			len = payload.len;
+		}
+
 		if (!tag_number++) {
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 			first_tag = i;
@@ -531,8 +539,10 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 		}
 		strbuf_release(&sig);
+		strbuf_release(&payload);
+		strbuf_release(&signature);
 	next:
-		free(buf);
+		free(orig);
 	}
 	if (tagbuf.len) {
 		strbuf_addch(out, '\n');
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 411e0b4d99..4c814c1963 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -636,7 +636,7 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 
 		memset(&sigcheck, '\0', sizeof(sigcheck));
 
-		bogs = parse_signature(push_cert.buf, push_cert.len);
+		bogs = parse_signed_buffer(push_cert.buf, push_cert.len);
 		check_signature(push_cert.buf, bogs, push_cert.buf + bogs,
 				push_cert.len - bogs, &sigcheck);
 
@@ -1568,7 +1568,7 @@ static void queue_commands_from_cert(struct command **tail,
 		die("malformed push certificate %.*s", 100, push_cert->buf);
 	else
 		boc += 2;
-	eoc = push_cert->buf + parse_signature(push_cert->buf, push_cert->len);
+	eoc = push_cert->buf + parse_signed_buffer(push_cert->buf, push_cert->len);
 
 	while (boc < eoc) {
 		const char *eol = memchr(boc, '\n', eoc - boc);
diff --git a/builtin/tag.c b/builtin/tag.c
index e0a4c25382..6b95c6a2ea 100644
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
index 534e14f22a..d39ce5076d 100644
--- a/commit.c
+++ b/commit.c
@@ -1097,8 +1097,10 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
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
@@ -1106,8 +1108,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	buf = read_object_file(&desc->obj->oid, &type, &size);
 	if (!buf || type != OBJ_TAG)
 		goto free_return;
-	len = parse_signature(buf, size);
-	if (size == len)
+	if (!parse_signature(buf, size, &payload, &signature))
 		goto free_return;
 	/*
 	 * We could verify this signature and either omit the tag when
@@ -1126,6 +1127,8 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 
 	**tail = mergetag;
 	*tail = &mergetag->next;
+	strbuf_release(&payload);
+	strbuf_release(&signature);
 	return;
 
 free_return:
diff --git a/gpg-interface.c b/gpg-interface.c
index 2d538bcd6e..b25f5c21d8 100644
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
index cae38dcc66..75bd61a531 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -499,7 +499,9 @@ static int show_one_mergetag(struct commit *commit,
 	struct strbuf verify_message;
 	struct signature_check sigc = { 0 };
 	int status, nth;
-	size_t payload_size, gpg_message_offset;
+	size_t gpg_message_offset;
+	struct strbuf payload = STRBUF_INIT;
+	struct strbuf signature = STRBUF_INIT;
 
 	hash_object_file(the_hash_algo, extra->value, extra->len,
 			 type_name(OBJ_TAG), &oid);
@@ -523,13 +525,11 @@ static int show_one_mergetag(struct commit *commit,
 			    "parent #%d, tagged '%s'\n", nth + 1, tag->tag);
 	gpg_message_offset = verify_message.len;
 
-	payload_size = parse_signature(extra->value, extra->len);
 	status = -1;
-	if (extra->len > payload_size) {
+	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
 		/* could have a good signature */
-		if (!check_signature(extra->value, payload_size,
-				     extra->value + payload_size,
-				     extra->len - payload_size, &sigc)) {
+		if (!check_signature(payload.buf, payload.len,
+				     signature.buf, signature.len, &sigc)) {
 			strbuf_addstr(&verify_message, sigc.gpg_output);
 			signature_check_clear(&sigc);
 			status = 0; /* good */
@@ -540,6 +540,8 @@ static int show_one_mergetag(struct commit *commit,
 
 	show_sig_lines(opt, status, verify_message.buf);
 	strbuf_release(&verify_message);
+	strbuf_release(&payload);
+	strbuf_release(&signature);
 	return 0;
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 6867e33648..212f1165bb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1161,7 +1161,13 @@ static void find_subpos(const char *buf,
 			unsigned long *nonsiglen,
 			const char **sig, unsigned long *siglen)
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
@@ -1174,13 +1180,14 @@ static void find_subpos(const char *buf,
 		buf++;
 
 	/* parse signature first; we might not even have a subject line */
-	*sig = buf + parse_signature(buf, strlen(buf));
-	*siglen = strlen(*sig);
+	parse_signature(buf, end - buf, &payload, &signature);
+	*sig = strbuf_detach(&signature, siglen);
+	sigstart = buf + parse_signed_buffer(buf, strlen(buf));
 
 	/* subject is first non-empty line */
 	*sub = buf;
 	/* subject goes to first empty line */
-	while (buf < *sig && *buf && *buf != '\n') {
+	while (buf < sigstart && *buf && *buf != '\n') {
 		eol = strchrnul(buf, '\n');
 		if (*eol)
 			eol++;
@@ -1196,7 +1203,7 @@ static void find_subpos(const char *buf,
 		buf++;
 	*body = buf;
 	*bodylen = strlen(buf);
-	*nonsiglen = *sig - buf;
+	*nonsiglen = sigstart - buf;
 }
 
 /*
@@ -1234,6 +1241,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 		struct used_atom *atom = &used_atom[i];
 		const char *name = atom->name;
 		struct atom_value *v = &val[i];
+
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
@@ -1273,6 +1281,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_BARE)
 			v->s = xstrdup(subpos);
+
+		free((void *)sigpos);
 	}
 }
 
diff --git a/tag.c b/tag.c
index 71b544467e..5d04506d10 100644
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
 
