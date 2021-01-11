Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C4C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FC722AB0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbhAKAig (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 19:38:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50484 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbhAKAif (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 19:38:35 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8939A60783;
        Mon, 11 Jan 2021 00:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610325473;
        bh=thVbC8DVrD9sFIWv3f81FubaOEu8lfuLCi3OiTnIkrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=y3vWFKdTkyPK3rqH89qfOjygBCXXtOOIy9ReUcC8z8COblIywR4yFGafXrKpFzvIc
         3zRug+zgWs47MUm6TXF9pGhspkssqNAX5KLg4tvS3Nuckmr5tkPeSFYLnXBbjeBCSK
         AVQ2QyydxHQfP32CrNvw2Rjc4dPEphZsbSUrnDnLSpq1mcC/gZvgaq9kBHNyn5bZJy
         9HF/rNGHdlkxEiCuY9Z0OgLtssxNdnEVr9jgHNHBfIfxPMFhMPb2l/hMVNW8x9ZQMV
         NYTPASBQf79h63Vhr2hm6CDc47uLNk4BcjU4Y81hXQIhp4ffph7c5JRbgQTk7x3uqs
         07yqhLknnJH/hc6ehTSuA0svS5xfyEtu8y/tMU9fkrkKtfROSanXD2xu01wS/XrXE2
         Xn3uhRqFIWuzDshzyhMDvqHxJXHaJICpwsjzx9Ast8od8mkYf3OAA9ez3JRtrdDaMX
         X8kLcRxGDhacoYqyEIWbHi8hZk/iifk8P81v0cQiItTqTUBT/SN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/5] gpg-interface: improve interface for parsing tags
Date:   Mon, 11 Jan 2021 00:37:35 +0000
Message-Id: <20210111003740.1319996-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 builtin/receive-pack.c |  4 ++--
 builtin/tag.c          | 16 ++++++++++++----
 commit.c               |  9 ++++++---
 fmt-merge-msg.c        |  8 +++++---
 gpg-interface.c        | 13 ++++++++++++-
 gpg-interface.h        |  9 ++++++++-
 log-tree.c             | 13 +++++++------
 ref-filter.c           | 18 ++++++++++++++----
 tag.c                  | 15 ++++++++-------
 9 files changed, 74 insertions(+), 31 deletions(-)

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
index 93faaad764..794dc8b593 100644
--- a/commit.c
+++ b/commit.c
@@ -1134,8 +1134,10 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
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
@@ -1143,8 +1145,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	buf = read_object_file(&desc->obj->oid, &type, &size);
 	if (!buf || type != OBJ_TAG)
 		goto free_return;
-	len = parse_signature(buf, size);
-	if (size == len)
+	if (!parse_signature(buf, size, &payload, &signature))
 		goto free_return;
 	/*
 	 * We could verify this signature and either omit the tag when
@@ -1163,6 +1164,8 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 
 	**tail = mergetag;
 	*tail = &mergetag->next;
+	strbuf_release(&payload);
+	strbuf_release(&signature);
 	return;
 
 free_return:
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 9a664a4a58..b96e6e5926 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -512,15 +512,16 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		unsigned long size, len;
 		char *buf = read_object_file(oid, &type, &size);
 		struct signature_check sigc = { NULL };
-		struct strbuf sig = STRBUF_INIT;
+		struct strbuf payload = STRBUF_INIT, sig = STRBUF_INIT;
 
 		if (!buf || type != OBJ_TAG)
 			goto next;
-		len = parse_signature(buf, size);
+		len = parse_signature(buf, size, &payload, &sig);
 
 		if (size == len)
 			; /* merely annotated */
-		else if (check_signature(buf, len, buf + len, size - len, &sigc) &&
+		else if (check_signature(payload.buf, payload.len, sig.buf,
+					 sig.len, &sigc) &&
 			!sigc.gpg_output)
 			strbuf_addstr(&sig, "gpg verification failed.\n");
 		else
@@ -547,6 +548,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 					strlen(origins.items[i].string));
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 		}
+		strbuf_release(&payload);
 		strbuf_release(&sig);
 	next:
 		free(buf);
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
index aa260bfd09..8d8baec1b5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1215,7 +1215,13 @@ static void find_subpos(const char *buf,
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
 
