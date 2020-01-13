Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA8AC33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065EE207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k8BUZxn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAMMsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37788 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728913AbgAMMsG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:06 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2C6C6607FB
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919684;
        bh=3UPvBqpRfPy6yAW4VG141VoXtm6OcseE4l8FW6I6lPY=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=k8BUZxn7JheTN1c5asSAcoAYiz7hIrUidajo4a43OawtNWU2b33d10v217rFSDxZX
         SK6knJTCLqYJQmBM2QezYlXx69Jg5UadV8PRDgRbBol0NI95rBDdbTagBKEFeWkpAJ
         v65r0UnuTYBytm1QJ/5hvH/Wsgzj6XJ4KJl7jnYp0H7+hPYgWr2J37nAGrCLxu7OVP
         Wo729GM5ynW5a44LQcgTglT9UnroVD+WbUEg+bvoRkC1lJcoBI0X7RfaeTG+robns4
         nhhLxSv1Mui1XyNSmjD3hFDxGUr2pv4IZJO1Ex4hwDeeOdO/8KrDUK8Ym/fhZonkWW
         3oXv5d8vQ18g/Ib8O+IeMh5lQGcXA8ej6w5gKPNRQ6yR1mzNV6qBOZE2CrKvD5eCcL
         c2LZDu6d77YOi6JOyqOnMREAcuvPlVaO/wQiVP4U9hygDZQ59BxM+RWJV1H+owFVen
         u39wSQE78urkAvRQWkVPXtcryuTnvOJFshx6QhivCzAmR0eFUM7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 17/22] tag: store SHA-256 signatures in a header
Date:   Mon, 13 Jan 2020 12:47:24 +0000
Message-Id: <20200113124729.3684846-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we'll want to allow a user to sign both the SHA-1 version
of a tag and the SHA-256 version at the same time.  Since for SHA-1 the
signature is appended to the tag message, we must use a different way to
allow multiple signature.

The transition plan envisions this using a gpgsig-sha256 header, much as
for commits.  Refactor the commit code that performs parsing of this
header and use it for tags that use SHA-256.  Check that we get tags in
the correct format depending on what algorithm we're using.

Note that currently we have no way to rewrite an object into another
hash algorithm, and therefore we don't have a way to verify the
signatures of the other hash algorithm.  Because of the way the
signatures are stored, we'll reject commits signed with both algorithms,
which is essential for security.  If we allowed both signatures despite
not being able to verify them and one signature were invalid, we'd end
up with a security problem.

There are, however, a few things to note.

In the ref-filter code, we hoist the signature parsing above the blank
line delimiting headers and body so we can find the signature when using
SHA-256.  For similar reasons, t6300 no longer emits the signature as
part of the body since it's no longer part of the body.

We mark a test for exporting signatures with remote helpers as SHA-1
only.  Since we no longer have signatures in the body (those are for
SHA-1 only), they cannot be exported this way.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/mktag.c           | 14 ++++++++++++++
 builtin/tag.c             |  4 +++-
 commit.c                  | 19 +++++++++++++++----
 commit.h                  |  8 ++++++++
 gpg-interface.c           | 16 ++++++++++------
 ref-filter.c              |  7 +++----
 t/t5801-remote-helpers.sh |  4 +++-
 t/t6300-for-each-ref.sh   | 34 +++++++++++++++++++++++++---------
 t/t7004-tag.sh            |  8 +++++++-
 t/t7030-verify-tag.sh     | 17 +++++++++++++++++
 10 files changed, 105 insertions(+), 26 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 6fb7dc8578..6c568b4d74 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -141,6 +141,20 @@ static int verify_tag(char *buffer, unsigned long size)
 			(uintmax_t) (tagger_line - buffer));
 	tagger_line += 6;
 
+	if (hash_algo_by_ptr(the_hash_algo) == GIT_HASH_SHA256 &&
+		!memcmp(tagger_line, "gpgsig-sha256 ", 14)) {
+		char *p = strpbrk(tagger_line + 1, "\n");
+		if (!p)
+			return error("char%"PRIuMAX": could not find end of line",
+				(uintmax_t) (tagger_line - buffer));
+		tagger_line = p + 1;
+		while (*tagger_line == ' ' && (p = strpbrk(tagger_line, "\n")))
+			tagger_line = p + 1;
+		if (!p)
+			return error("char%"PRIuMAX": could not find end of line",
+				(uintmax_t) (tagger_line - buffer));
+	}
+
 	/* Verify the blank line separating the header from the body */
 	if (*tagger_line != '\n')
 		return error("char%"PRIuMAX": trailing garbage in tag header",
diff --git a/builtin/tag.c b/builtin/tag.c
index 6b95c6a2ea..ab6b5044e6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -128,7 +128,9 @@ static int verify_tag(const char *name, const char *ref,
 
 static int do_sign(struct strbuf *buffer)
 {
-	return sign_buffer(buffer, buffer, get_signing_key());
+	if (hash_algo_by_ptr(the_hash_algo) == GIT_HASH_SHA1)
+		return sign_buffer(buffer, buffer, get_signing_key());
+	return sign_with_header(buffer, get_signing_key());
 }
 
 static const char tag_template[] =
diff --git a/commit.c b/commit.c
index d44f0c1c26..ded396b69d 100644
--- a/commit.c
+++ b/commit.c
@@ -970,7 +970,7 @@ static const char *gpg_sig_headers[] = {
 	"gpgsig-sha256",
 };
 
-static int do_sign_commit(struct strbuf *buf, const char *keyid)
+int sign_with_header(struct strbuf *buf, const char *keyid)
 {
 	struct strbuf sig = STRBUF_INIT;
 	int inspos, copypos;
@@ -1010,12 +1010,24 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
 	return 0;
 }
 
+
+
 int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature)
 {
-
 	unsigned long size;
 	const char *buffer = get_commit_buffer(commit, &size);
+	int ret = parse_buffer_signed_by_header(buffer, size, payload, signature);
+
+	unuse_commit_buffer(commit, buffer);
+	return ret;
+}
+
+int parse_buffer_signed_by_header(const char *buffer,
+				  unsigned long size,
+				  struct strbuf *payload,
+				  struct strbuf *signature)
+{
 	int in_signature, saw_signature = -1;
 	const char *line, *tail;
 	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(the_hash_algo)];
@@ -1048,7 +1060,6 @@ int parse_signed_commit(const struct commit *commit,
 		}
 		line = next;
 	}
-	unuse_commit_buffer(commit, buffer);
 	return saw_signature;
 }
 
@@ -1488,7 +1499,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	if (encoding_is_utf8 && !verify_utf8(&buffer))
 		fprintf(stderr, _(commit_utf8_warn));
 
-	if (sign_commit && do_sign_commit(&buffer, sign_commit)) {
+	if (sign_commit && sign_with_header(&buffer, sign_commit)) {
 		result = -1;
 		goto out;
 	}
diff --git a/commit.h b/commit.h
index 221cdaa34b..257acc857b 100644
--- a/commit.h
+++ b/commit.h
@@ -392,4 +392,12 @@ int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void
 LAST_ARG_MUST_BE_NULL
 int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
 
+/* Sign a commit or tag buffer, storing the result in a header. */
+int sign_with_header(struct strbuf *buf, const char *keyid);
+/* Parse the signature out of a header. */
+int parse_buffer_signed_by_header(const char *buffer,
+				  unsigned long size,
+				  struct strbuf *payload,
+				  struct strbuf *signature);
+
 #endif /* COMMIT_H */
diff --git a/gpg-interface.c b/gpg-interface.c
index 727a657a5b..961bdb7224 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "commit.h"
 #include "config.h"
 #include "run-command.h"
 #include "strbuf.h"
@@ -312,13 +313,16 @@ size_t parse_signed_buffer(const char *buf, size_t size)
 
 int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct strbuf *signature)
 {
-	size_t match = parse_signed_buffer(buf, size);
-	if (match != size) {
-		strbuf_add(payload, buf, match);
-		strbuf_add(signature, buf + match, size - match);
-		return 1;
+	if (hash_algo_by_ptr(the_hash_algo) == GIT_HASH_SHA1) {
+		size_t match = parse_signed_buffer(buf, size);
+		if (match != size) {
+			strbuf_add(payload, buf, match);
+			strbuf_add(signature, buf + match, size - match);
+			return 1;
+		}
+		return 0;
 	}
-	return 0;
+	return parse_buffer_signed_by_header(buf, size, payload, signature);
 }
 
 void set_signing_key(const char *key)
diff --git a/ref-filter.c b/ref-filter.c
index 212f1165bb..933530a14c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1167,6 +1167,8 @@ static void find_subpos(const char *buf,
 	const char *end = buf + strlen(buf);
 	const char *sigstart;
 
+	/* parse signature first; we might not even have a subject line */
+	parse_signature(buf, end - buf, &payload, &signature);
 
 	/* skip past header until we hit empty line */
 	while (*buf && *buf != '\n') {
@@ -1178,9 +1180,6 @@ static void find_subpos(const char *buf,
 	/* skip any empty lines */
 	while (*buf == '\n')
 		buf++;
-
-	/* parse signature first; we might not even have a subject line */
-	parse_signature(buf, end - buf, &payload, &signature);
 	*sig = strbuf_detach(&signature, siglen);
 	sigstart = buf + parse_signed_buffer(buf, strlen(buf));
 
@@ -1267,7 +1266,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			v->s = xmemdupz(sigpos, siglen);
 		else if (atom->u.contents.option == C_LINES) {
 			struct strbuf s = STRBUF_INIT;
-			const char *contents_end = bodylen + bodypos - siglen;
+			const char *contents_end = bodypos + nonsiglen;
 
 			/*  Size is the length of the message after removing the signature */
 			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 121e5c6edb..801802be9d 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -192,7 +192,9 @@ test_expect_success GPG 'push signed tag' '
 	test_must_fail compare_refs local signed-tag server signed-tag
 '
 
-test_expect_success GPG 'push signed tag with signed-tags capability' '
+# SHA-256 signatures are stored in the header and can't be round-tripped through
+# fast-export.
+test_expect_success GPG,SHA1 'push signed tag with signed-tags capability' '
 	(cd local &&
 	git checkout master &&
 	git tag -s -m signed-tag signed-tag-2 &&
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b3c1092338..caeabfb293 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -54,6 +54,17 @@ test_atom() {
 	"
 }
 
+test_atom_hash () {
+	local val
+	if [ "$(test_oid algo)" = sha1 ]
+	then
+		val="$3"
+	else
+		val="$4"
+	fi
+	test_atom "$1" "$2" "$val"
+}
+
 hexlen=$(test_oid hexsz)
 disklen=$(test_oid disklen)
 
@@ -625,30 +636,35 @@ sig='-----BEGIN PGP SIGNATURE-----
 PREREQ=GPG
 test_atom refs/tags/signed-empty subject ''
 test_atom refs/tags/signed-empty contents:subject ''
-test_atom refs/tags/signed-empty body "$sig"
+test_atom_hash refs/tags/signed-empty body "$sig" ''
 test_atom refs/tags/signed-empty contents:body ''
 test_atom refs/tags/signed-empty contents:signature "$sig"
-test_atom refs/tags/signed-empty contents "$sig"
+test_atom_hash refs/tags/signed-empty contents "$sig" ''
 
 test_atom refs/tags/signed-short subject 'subject line'
 test_atom refs/tags/signed-short contents:subject 'subject line'
-test_atom refs/tags/signed-short body "$sig"
+test_atom_hash refs/tags/signed-short body "$sig" ''
 test_atom refs/tags/signed-short contents:body ''
 test_atom refs/tags/signed-short contents:signature "$sig"
-test_atom refs/tags/signed-short contents "subject line
-$sig"
+test_atom_hash refs/tags/signed-short contents "subject line
+$sig" 'subject line
+'
 
 test_atom refs/tags/signed-long subject 'subject line'
 test_atom refs/tags/signed-long contents:subject 'subject line'
-test_atom refs/tags/signed-long body "body contents
-$sig"
+test_atom_hash refs/tags/signed-long body "body contents
+$sig" 'body contents
+'
 test_atom refs/tags/signed-long contents:body 'body contents
 '
 test_atom refs/tags/signed-long contents:signature "$sig"
-test_atom refs/tags/signed-long contents "subject line
+test_atom_hash refs/tags/signed-long contents "subject line
 
 body contents
-$sig"
+$sig" 'subject line
+
+body contents
+'
 
 sort >expected <<EOF
 $(git rev-parse refs/tags/bogo) <committer@example.com> refs/tags/bogo
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 6db92bd3ba..bd74b2d7e0 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -425,7 +425,13 @@ test_expect_success \
 # creating annotated tags:
 
 get_tag_msg () {
-	git cat-file tag "$1" | sed -e "/BEGIN PGP/q"
+	if [ "$(test_oid algo)" = sha1 ]
+	then
+		git cat-file tag "$1" | sed -e "/BEGIN PGP/q"
+	else
+
+		git cat-file tag "$1" | sed -e '/^gpgsig-sha256/{s/^gpgsig-sha256 //;h;d};/^ /d;${p;x;/^$/d}'
+	fi
 }
 
 # run test_tick before committing always gives the time in that timezone
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 8f077bea60..d339512da2 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -79,6 +79,23 @@ test_expect_success GPG 'verify and show signatures' '
 	)
 '
 
+test_expect_success GPG 'signature has expected format' '
+	for tag in initial second merge fourth-signed sixth-signed seventh-signed
+	do
+		if [ "$(test_oid algo)"	= sha1 ]
+		then
+			git cat-file tag seventh-signed >output &&
+			! grep gpgsig output &&
+			grep "^-----BEGIN PGP SIGNATURE-----" output
+		else
+			git cat-file tag seventh-signed >output &&
+			grep gpgsig-sha256 output &&
+			! grep "^-----BEGIN PGP SIGNATURE-----" output
+		fi &&
+		echo $tag OK || exit 1
+	done
+'
+
 test_expect_success GPGSM 'verify and show signatures x509' '
 	git verify-tag ninth-signed-x509 2>actual &&
 	grep "Good signature from" actual &&
