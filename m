Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F05CC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7064464EBC
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBKCJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:09:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45908 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhBKCJe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Feb 2021 21:09:34 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 42B3A60B19;
        Thu, 11 Feb 2021 02:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613009300;
        bh=FmtUhyouguXRjT/AjMAE1ABWDIUzU8+uEqqGVOBwuZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CJKW0P/ZrKH8VMzbcZqPJ53Q6t+v9uR6nKc0mMgpMzHFVjmXQxfgliKiO7r90dnrc
         hgNXR4ki03pMrR7vy3JZec6hczPp5x03bxD/walvy5wiJixHckNJILuRv2T4p+rNQJ
         Gnh6g3mn30Jcr2UOJsoVsIxI6DKGrOKdP/OeSq6ijCv8kj63laHILJ1j/Ui+eZafs+
         ZvRSC87cRwwD0/LJ635OWVYFmmSc0HMYoz1S+4JgpqY/LnucPaaoBLsTuz8q1dkN5T
         Af8f8l7BTgZzsT2IdfKPUXS+OdPSQFWODxlOc8IC/c3oLTkK55URwrQqIITIwyaIVq
         6hXR0UZDnQ92nbPeaTNEh1MVbvWLCcanlINrf8kXV2ErBk+tTLABhLPS9UOqXG+Piy
         eScL5Ud7ywxaVZByN7evzdA0c2/+MgAwjF2j2uM3pYSaovG+SSa1Ta4al5l4SkN11y
         3tsV8FCH/G5dny4Rm8VAT1xpjz15SGKQWj3NfBLzDGgG9dYtWID
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/6] commit: ignore additional signatures when parsing signed commits
Date:   Thu, 11 Feb 2021 02:08:02 +0000
Message-Id: <20210211020806.288523-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210211020806.288523-1-sandals@crustytoothpaste.net>
References: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
 <20210211020806.288523-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we create a commit with multiple signatures, neither of these
signatures includes the other.  Consequently, when we produce the
payload which has been signed so we can verify the commit, we must strip
off any other signatures, or the payload will differ from what was
signed.  Do so, and in preparation for verifying with multiple
algorithms, pass the algorithm we want to verify into
parse_signed_commit.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c                 | 54 +++++++++++++++++++++++++---------------
 commit.h                 |  3 ++-
 log-tree.c               |  2 +-
 t/t7510-signed-commit.sh | 43 +++++++++++++++++++++++++++++++-
 4 files changed, 79 insertions(+), 23 deletions(-)

diff --git a/commit.c b/commit.c
index bab8d5ab07..1006c85ca8 100644
--- a/commit.c
+++ b/commit.c
@@ -1036,20 +1036,18 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
 }
 
 int parse_signed_commit(const struct commit *commit,
-			struct strbuf *payload, struct strbuf *signature)
+			struct strbuf *payload, struct strbuf *signature,
+			const struct git_hash_algo *algop)
 {
 
 	unsigned long size;
 	const char *buffer = get_commit_buffer(commit, &size);
-	int in_signature, saw_signature = -1;
-	const char *line, *tail;
-	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(the_hash_algo)];
-	int gpg_sig_header_len = strlen(gpg_sig_header);
+	int in_signature = 0, saw_signature = 0, other_signature = 0;
+	const char *line, *tail, *p;
+	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(algop)];
 
 	line = buffer;
 	tail = buffer + size;
-	in_signature = 0;
-	saw_signature = 0;
 	while (line < tail) {
 		const char *sig = NULL;
 		const char *next = memchr(line, '\n', tail - line);
@@ -1057,9 +1055,15 @@ int parse_signed_commit(const struct commit *commit,
 		next = next ? next + 1 : tail;
 		if (in_signature && line[0] == ' ')
 			sig = line + 1;
-		else if (starts_with(line, gpg_sig_header) &&
-			 line[gpg_sig_header_len] == ' ')
-			sig = line + gpg_sig_header_len + 1;
+		else if (skip_prefix(line, gpg_sig_header, &p) &&
+			 *p == ' ') {
+			sig = line + strlen(gpg_sig_header) + 1;
+			other_signature = 0;
+		}
+		else if (starts_with(line, "gpgsig"))
+			other_signature = 1;
+		else if (other_signature && line[0] != ' ')
+			other_signature = 0;
 		if (sig) {
 			strbuf_add(signature, sig, next - sig);
 			saw_signature = 1;
@@ -1068,7 +1072,8 @@ int parse_signed_commit(const struct commit *commit,
 			if (*line == '\n')
 				/* dump the whole remainder of the buffer */
 				next = tail;
-			strbuf_add(payload, line, next - line);
+			if (!other_signature)
+				strbuf_add(payload, line, next - line);
 			in_signature = 0;
 		}
 		line = next;
@@ -1082,23 +1087,29 @@ int remove_signature(struct strbuf *buf)
 	const char *line = buf->buf;
 	const char *tail = buf->buf + buf->len;
 	int in_signature = 0;
-	const char *sig_start = NULL;
-	const char *sig_end = NULL;
+	struct sigbuf {
+		const char *start;
+		const char *end;
+	} sigs[2], *sigp = &sigs[0];
+	int i;
+	const char *orig_buf = buf->buf;
+
+	memset(sigs, 0, sizeof(sigs));
 
 	while (line < tail) {
 		const char *next = memchr(line, '\n', tail - line);
 		next = next ? next + 1 : tail;
 
 		if (in_signature && line[0] == ' ')
-			sig_end = next;
+			sigp->end = next;
 		else if (starts_with(line, "gpgsig")) {
 			int i;
 			for (i = 1; i < GIT_HASH_NALGOS; i++) {
 				const char *p;
 				if (skip_prefix(line, gpg_sig_headers[i], &p) &&
 				    *p == ' ') {
-					sig_start = line;
-					sig_end = next;
+					sigp->start = line;
+					sigp->end = next;
 					in_signature = 1;
 				}
 			}
@@ -1106,15 +1117,18 @@ int remove_signature(struct strbuf *buf)
 			if (*line == '\n')
 				/* dump the whole remainder of the buffer */
 				next = tail;
+			if (in_signature && sigp - sigs != ARRAY_SIZE(sigs))
+				sigp++;
 			in_signature = 0;
 		}
 		line = next;
 	}
 
-	if (sig_start)
-		strbuf_remove(buf, sig_start - buf->buf, sig_end - sig_start);
+	for (i = ARRAY_SIZE(sigs) - 1; i >= 0; i--)
+		if (sigs[i].start)
+			strbuf_remove(buf, sigs[i].start - orig_buf, sigs[i].end - sigs[i].start);
 
-	return sig_start != NULL;
+	return sigs[0].start != NULL;
 }
 
 static void handle_signed_tag(struct commit *parent, struct commit_extra_header ***tail)
@@ -1165,7 +1179,7 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 
 	sigc->result = 'N';
 
-	if (parse_signed_commit(commit, &payload, &signature) <= 0)
+	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 	ret = check_signature(payload.buf, payload.len, signature.buf,
 		signature.len, sigc);
diff --git a/commit.h b/commit.h
index f4e7b0158e..030aa65ab8 100644
--- a/commit.h
+++ b/commit.h
@@ -317,7 +317,8 @@ void set_merge_remote_desc(struct commit *commit,
 struct commit *get_merge_parent(const char *name);
 
 int parse_signed_commit(const struct commit *commit,
-			struct strbuf *message, struct strbuf *signature);
+			struct strbuf *message, struct strbuf *signature,
+			const struct git_hash_algo *algop);
 int remove_signature(struct strbuf *buf);
 
 /*
diff --git a/log-tree.c b/log-tree.c
index e048467650..0f9ef836d4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -502,7 +502,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	struct signature_check sigc = { 0 };
 	int status;
 
-	if (parse_signed_commit(commit, &payload, &signature) <= 0)
+	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 
 	status = check_signature(payload.buf, payload.len, signature.buf,
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index f4bf925bdd..8df5a74f1d 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -175,7 +175,7 @@ test_expect_success GPG 'show signed commit with signature' '
 	git cat-file commit initial >cat &&
 	grep -v -e "gpg: " -e "Warning: " show >show.commit &&
 	grep -e "gpg: " -e "Warning: " show >show.gpg &&
-	grep -v "^ " cat | grep -v "^$(test_oid header) " >cat.commit &&
+	grep -v "^ " cat | grep -v "^gpgsig.* " >cat.commit &&
 	test_cmp show.commit commit &&
 	test_cmp show.gpg verify.2 &&
 	test_cmp cat.commit verify.1
@@ -337,4 +337,45 @@ test_expect_success GPG 'show double signature with custom format' '
 	test_cmp expect actual
 '
 
+
+test_expect_success GPG 'verify-commit verifies multiply signed commits' '
+	git init multiply-signed &&
+	cd multiply-signed &&
+	test_commit first &&
+	echo 1 >second &&
+	git add second &&
+	tree=$(git write-tree) &&
+	parent=$(git rev-parse HEAD^{commit}) &&
+	git commit --gpg-sign -m second &&
+	git cat-file commit HEAD &&
+	# Avoid trailing whitespace.
+	sed -e "s/^Q//" -e "s/^Z/ /" >commit <<-EOF &&
+	Qtree $tree
+	Qparent $parent
+	Qauthor A U Thor <author@example.com> 1112912653 -0700
+	Qcommitter C O Mitter <committer@example.com> 1112912653 -0700
+	Qgpgsig -----BEGIN PGP SIGNATURE-----
+	QZ
+	Q iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCX/uBDRYcY29tbWl0dGVy
+	Q QGV4YW1wbGUuY29tAAoJEBO29R7N3kMNd+8AoK1I8mhLHviPH+q2I5fIVgPsEtYC
+	Q AKCTqBh+VabJceXcGIZuF0Ry+udbBQ==
+	Q =tQ0N
+	Q -----END PGP SIGNATURE-----
+	Qgpgsig-sha256 -----BEGIN PGP SIGNATURE-----
+	QZ
+	Q iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCX/uBIBYcY29tbWl0dGVy
+	Q QGV4YW1wbGUuY29tAAoJEBO29R7N3kMN/NEAn0XO9RYSBj2dFyozi0JKSbssYMtO
+	Q AJwKCQ1BQOtuwz//IjU8TiS+6S4iUw==
+	Q =pIwP
+	Q -----END PGP SIGNATURE-----
+	Q
+	Qsecond
+	EOF
+	head=$(git hash-object -t commit -w commit) &&
+	git reset --hard $head &&
+	git verify-commit $head 2>actual &&
+	grep "Good signature from" actual &&
+	! grep "BAD signature from" actual
+'
+
 test_done
