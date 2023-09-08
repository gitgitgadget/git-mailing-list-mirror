Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4210DEEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345273AbjIHXaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243950AbjIHXad (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:30:33 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF3CE6B
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:30:28 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37218)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdn-00FHId-Gi; Fri, 08 Sep 2023 17:11:55 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdm-009u13-3z; Fri, 08 Sep 2023 17:11:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:31 -0500
Message-Id: <20230908231049.2035003-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdm-009u13-3z;;;mid=<20230908231049.2035003-14-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+TURJkKvTmTTd9AaHY8TxdfarsgiuBkYg=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 14/32] commit: write commits for both hashes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

When we write a commit, we include data that is specific to the hash
algorithm, such as parents and the root tree.  In order to write both a
SHA-1 commit and a SHA-256 version, we need to convert between them.

However, a straightforward conversion isn't necessarily what we want.
When we sign a commit, we sign its data, so if we create a commit for
SHA-256 and then write a SHA-1 version, we'll still have only signed the
SHA-256 data.  While this is valid, it would be better to sign both
forms of data so people using SHA-1 can verify the signatures as well.

Consequently, we don't want to use the standard mapping that occurs when
we write an object.  Instead, let's move most of the writing of the
commit into a separate function which is agnostic of the hash algorithm
and which simply writes into a buffer and specify both versions of the
object ourselves.

We can then call this function twice: once with the SHA-256 contents,
and if SHA-1 is enabled, once with the SHA-1 contents.  If we're signing
the commit, we then sign both versions and append both signatures to
both buffers.  To produce a consistent hash, we always append the
signatures in the order in which Git implemented them: first SHA-1, then
SHA-256.

In order to make this signing code work, we split the commit signing
code into two functions, one which signs the buffer, and one which
appends the signature.

*****

Updated to use write_object_file_flags and repo_oid_to_algop

-- EWB

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 commit.c | 176 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 131 insertions(+), 45 deletions(-)

diff --git a/commit.c b/commit.c
index b3223478bc2a..522ebb4b3002 100644
--- a/commit.c
+++ b/commit.c
@@ -28,6 +28,7 @@
 #include "shallow.h"
 #include "tree.h"
 #include "hook.h"
+#include "object-file-convert.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1100,12 +1101,11 @@ static const char *gpg_sig_headers[] = {
 	"gpgsig-sha256",
 };
 
-int sign_with_header(struct strbuf *buf, const char *keyid)
+static int add_commit_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo)
 {
-	struct strbuf sig = STRBUF_INIT;
 	int inspos, copypos;
 	const char *eoh;
-	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(the_hash_algo)];
+	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(algo)];
 	int gpg_sig_header_len = strlen(gpg_sig_header);
 
 	/* find the end of the header */
@@ -1115,15 +1115,8 @@ int sign_with_header(struct strbuf *buf, const char *keyid)
 	else
 		inspos = eoh - buf->buf + 1;
 
-	if (!keyid || !*keyid)
-		keyid = get_signing_key();
-	if (sign_buffer(buf, &sig, keyid)) {
-		strbuf_release(&sig);
-		return -1;
-	}
-
-	for (copypos = 0; sig.buf[copypos]; ) {
-		const char *bol = sig.buf + copypos;
+	for (copypos = 0; sig->buf[copypos]; ) {
+		const char *bol = sig->buf + copypos;
 		const char *eol = strchrnul(bol, '\n');
 		int len = (eol - bol) + !!*eol;
 
@@ -1136,11 +1129,17 @@ int sign_with_header(struct strbuf *buf, const char *keyid)
 		inspos += len;
 		copypos += len;
 	}
-	strbuf_release(&sig);
 	return 0;
 }
 
-
+static int sign_commit_to_strbuf(struct strbuf *sig, struct strbuf *buf, const char *keyid)
+{
+	if (!keyid || !*keyid)
+		keyid = get_signing_key();
+	if (sign_buffer(buf, sig, keyid))
+		return -1;
+	return 0;
+}
 
 int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature,
@@ -1599,70 +1598,157 @@ N_("Warning: commit message did not conform to UTF-8.\n"
    "You may want to amend it after fixing the message, or set the config\n"
    "variable i18n.commitEncoding to the encoding your project uses.\n");
 
-int commit_tree_extended(const char *msg, size_t msg_len,
-			 const struct object_id *tree,
-			 struct commit_list *parents, struct object_id *ret,
-			 const char *author, const char *committer,
-			 const char *sign_commit,
-			 struct commit_extra_header *extra)
+static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg_len,
+			      const struct object_id *tree,
+			      const struct object_id *parents, size_t parents_len,
+			      const char *author, const char *committer,
+			      struct commit_extra_header *extra)
 {
-	int result;
 	int encoding_is_utf8;
-	struct strbuf buffer;
-
-	assert_oid_type(tree, OBJ_TREE);
-
-	if (memchr(msg, '\0', msg_len))
-		return error("a NUL byte in commit log message not allowed.");
+	size_t i;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
-	strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers */
-	strbuf_addf(&buffer, "tree %s\n", oid_to_hex(tree));
+	strbuf_init(buffer, 8192); /* should avoid reallocs for the headers */
+	strbuf_addf(buffer, "tree %s\n", oid_to_hex(tree));
 
 	/*
 	 * NOTE! This ordering means that the same exact tree merged with a
 	 * different order of parents will be a _different_ changeset even
 	 * if everything else stays the same.
 	 */
-	while (parents) {
-		struct commit *parent = pop_commit(&parents);
-		strbuf_addf(&buffer, "parent %s\n",
-			    oid_to_hex(&parent->object.oid));
-	}
+	for (i = 0; i < parents_len; i++)
+		strbuf_addf(buffer, "parent %s\n", oid_to_hex(&parents[i]));
 
 	/* Person/date information */
 	if (!author)
 		author = git_author_info(IDENT_STRICT);
-	strbuf_addf(&buffer, "author %s\n", author);
+	strbuf_addf(buffer, "author %s\n", author);
 	if (!committer)
 		committer = git_committer_info(IDENT_STRICT);
-	strbuf_addf(&buffer, "committer %s\n", committer);
+	strbuf_addf(buffer, "committer %s\n", committer);
 	if (!encoding_is_utf8)
-		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
+		strbuf_addf(buffer, "encoding %s\n", git_commit_encoding);
 
 	while (extra) {
-		add_extra_header(&buffer, extra);
+		add_extra_header(buffer, extra);
 		extra = extra->next;
 	}
-	strbuf_addch(&buffer, '\n');
+	strbuf_addch(buffer, '\n');
 
 	/* And add the comment */
-	strbuf_add(&buffer, msg, msg_len);
+	strbuf_add(buffer, msg, msg_len);
+}
 
-	/* And check the encoding */
-	if (encoding_is_utf8 && !verify_utf8(&buffer))
-		fprintf(stderr, _(commit_utf8_warn));
+int commit_tree_extended(const char *msg, size_t msg_len,
+			 const struct object_id *tree,
+			 struct commit_list *parents, struct object_id *ret,
+			 const char *author, const char *committer,
+			 const char *sign_commit,
+			 struct commit_extra_header *extra)
+{
+	struct repository *r = the_repository;
+	int result = 0;
+	int encoding_is_utf8;
+	struct strbuf buffer, compat_buffer;
+	struct strbuf sig = STRBUF_INIT, compat_sig = STRBUF_INIT;
+	struct object_id *parent_buf = NULL;
+	struct object_id compat_oid = {};
+	size_t i, nparents;
+
+	/* Not having i18n.commitencoding is the same as having utf-8 */
+	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+
+	assert_oid_type(tree, OBJ_TREE);
+
+	if (memchr(msg, '\0', msg_len))
+		return error("a NUL byte in commit log message not allowed.");
+
+	nparents = commit_list_count(parents);
+	parent_buf = xcalloc(nparents, sizeof(*parent_buf));
+	for (i = 0; i < nparents; i++) {
+		struct commit *parent = pop_commit(&parents);
+		oidcpy(&parent_buf[i], &parent->object.oid);
+	}
 
-	if (sign_commit && sign_with_header(&buffer, sign_commit)) {
+	/* should avoid reallocs for the headers */
+	strbuf_init(&buffer, 8192);
+	strbuf_init(&compat_buffer, 8192);
+
+	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
+	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
 		result = -1;
 		goto out;
 	}
+	if (r->compat_hash_algo) {
+		struct object_id mapped_tree;
+		struct object_id *mapped_parents = xcalloc(nparents, sizeof(*mapped_parents));
+		if (repo_oid_to_algop(r, tree, r->compat_hash_algo, &mapped_tree)) {
+			result = -1;
+			free(mapped_parents);
+			goto out;
+		}
+		for (i = 0; i < nparents; i++)
+			if (repo_oid_to_algop(r, &parent_buf[i], r->compat_hash_algo, &mapped_parents[i])) {
+				result = -1;
+				free(mapped_parents);
+				goto out;
+			}
+		write_commit_tree(&compat_buffer, msg, msg_len, &mapped_tree,
+				  mapped_parents, nparents, author, committer, extra);
+
+		hash_object_file(r->compat_hash_algo, compat_buffer.buf, compat_buffer.len,
+				 OBJ_COMMIT, &compat_oid);
 
-	result = write_object_file(buffer.buf, buffer.len, OBJ_COMMIT, ret);
+		if (sign_commit && sign_commit_to_strbuf(&compat_sig, &compat_buffer, sign_commit)) {
+			result = -1;
+			goto out;
+		}
+	}
+
+	if (sign_commit) {
+		struct sig_pairs {
+			struct strbuf *sig;
+			const struct git_hash_algo *algo;
+		} bufs [2] = {
+			{ &compat_sig, r->compat_hash_algo },
+			{ &sig, r->hash_algo },
+		};
+		int i;
+
+		/*
+		 * We write algorithms in the order they were implemented in
+		 * Git to produce a stable hash when multiple algorithms are
+		 * used.
+		 */
+		if (r->compat_hash_algo && hash_algo_by_ptr(bufs[0].algo) > hash_algo_by_ptr(bufs[1].algo))
+			SWAP(bufs[0], bufs[1]);
+
+		/*
+		 * We traverse each algorithm in order, and apply the signature
+		 * to each buffer.
+		 */
+		for (i = 0; i < ARRAY_SIZE(bufs); i++) {
+			if (!bufs[i].algo)
+				continue;
+			add_commit_signature(&buffer, bufs[i].sig, bufs[i].algo);
+			if (r->compat_hash_algo)
+				add_commit_signature(&compat_buffer, bufs[i].sig, bufs[i].algo);
+		}
+	}
+
+	/* And check the encoding. */
+	if (encoding_is_utf8 && (!verify_utf8(&buffer) || !verify_utf8(&compat_buffer)))
+		fprintf(stderr, _(commit_utf8_warn));
+
+	result = write_object_file_flags(buffer.buf, buffer.len, OBJ_COMMIT,
+					 ret, &compat_oid, 0);
 out:
 	strbuf_release(&buffer);
+	strbuf_release(&compat_buffer);
+	strbuf_release(&sig);
+	strbuf_release(&compat_sig);
 	return result;
 }
 
-- 
2.41.0

