Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A1CC35674
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A489020702
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pJjpRSAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgBVUSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:18 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39080 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbgBVUSL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:11 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1B13160CF2
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402690;
        bh=djvK4ApocES9qSOPoQa2oWaCdk4P5tmyZq1wPjNeHMc=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=pJjpRSABV6FEuXDCDC+BESsmLxVZWLQTzW7fLrRjYEQSYNHPIfirP6MDkrA9jRSgl
         LyoPBZ1hdtZbWA141JdjsqDy5FltpTuvR47mWi6Ta6TM7yVX/lxAXAe5M3txSus1hf
         KAcL0elKImOtpugxrK2RZMl2L6LNKg+s7rSCYOG/wtujf5PRY2Z1Dmp8RWWZ7XOD/F
         mOFs1HrHp8LttqOgp2ipIzSRXzQY1x9Niki+9eIGCU5Mt7VypjTL/SoJApiaQIaCKw
         G3LicbkpaqVtO7pkCR/P4X8k3u27UCWeQdWS2SpK6fTZnEwY3pBe+ME17E8fOxoCUO
         ow28vZiDi49YyXltn65vQYDyoDYA0q8+raMSvvHCML3/bBHjmz/A4WYdlc/5N0d19o
         01VX8BQXQv6/szM3oYqqow03w4lEDQ1mYOQD/Jxydqe4wJwSb0sMDsMSv2zmCrxnoz
         kpz+ae5WkSc3L+HSDMjNnH6Vn1bMfvh4nqnVD7W2P/zjyEw7qC9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 17/24] commit: use expected signature header for SHA-256
Date:   Sat, 22 Feb 2020 20:17:42 +0000
Message-Id: <20200222201749.937983-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The transition plan anticipates that we will allow signatures using
multiple algorithms in a single commit. In order to do so, we need to
use a different header per algorithm so that it will be obvious over
which data to compute the signature.

The transition plan specifies that we should use "gpgsig-sha256", so
wire up the commit code such that it can write and parse the current
algorithm, and it can remove the headers for any algorithm when creating
a new commit. Add tests to ensure that we write using the right header
and that git fsck doesn't reject these commits.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/commit.c         |  2 +-
 commit.c                 | 30 +++++++++++++++++++++++-------
 sequencer.c              |  2 +-
 t/t1450-fsck.sh          | 24 ++++++++++++++++++++++++
 t/t7510-signed-commit.sh | 16 +++++++++++++---
 5 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7ba33a3bec..798d362a2e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1659,7 +1659,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	if (amend) {
-		const char *exclude_gpgsig[2] = { "gpgsig", NULL };
+		const char *exclude_gpgsig[3] = { "gpgsig", "gpgsig-sha256", NULL };
 		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
 	} else {
 		struct commit_extra_header **tail = &extra;
diff --git a/commit.c b/commit.c
index a6cfa41a4e..534e14f22a 100644
--- a/commit.c
+++ b/commit.c
@@ -961,14 +961,22 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	return ret;
 }
 
-static const char gpg_sig_header[] = "gpgsig";
-static const int gpg_sig_header_len = sizeof(gpg_sig_header) - 1;
+/*
+ * Indexed by hash algorithm identifier.
+ */
+static const char *gpg_sig_headers[] = {
+	NULL,
+	"gpgsig",
+	"gpgsig-sha256",
+};
 
 static int do_sign_commit(struct strbuf *buf, const char *keyid)
 {
 	struct strbuf sig = STRBUF_INIT;
 	int inspos, copypos;
 	const char *eoh;
+	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(the_hash_algo)];
+	int gpg_sig_header_len = strlen(gpg_sig_header);
 
 	/* find the end of the header */
 	eoh = strstr(buf->buf, "\n\n");
@@ -1010,6 +1018,8 @@ int parse_signed_commit(const struct commit *commit,
 	const char *buffer = get_commit_buffer(commit, &size);
 	int in_signature, saw_signature = -1;
 	const char *line, *tail;
+	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(the_hash_algo)];
+	int gpg_sig_header_len = strlen(gpg_sig_header);
 
 	line = buffer;
 	tail = buffer + size;
@@ -1056,11 +1066,17 @@ int remove_signature(struct strbuf *buf)
 
 		if (in_signature && line[0] == ' ')
 			sig_end = next;
-		else if (starts_with(line, gpg_sig_header) &&
-			 line[gpg_sig_header_len] == ' ') {
-			sig_start = line;
-			sig_end = next;
-			in_signature = 1;
+		else if (starts_with(line, "gpgsig")) {
+			int i;
+			for (i = 1; i < GIT_HASH_NALGOS; i++) {
+				const char *p;
+				if (skip_prefix(line, gpg_sig_headers[i], &p) &&
+				    *p == ' ') {
+					sig_start = line;
+					sig_end = next;
+					in_signature = 1;
+				}
+			}
 		} else {
 			if (*line == '\n')
 				/* dump the whole remainder of the buffer */
diff --git a/sequencer.c b/sequencer.c
index ba90a513b9..cbd920afb2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1321,7 +1321,7 @@ static int try_to_commit(struct repository *r,
 		return -1;
 
 	if (flags & AMEND_MSG) {
-		const char *exclude_gpgsig[] = { "gpgsig", NULL };
+		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
 		const char *out_enc = get_commit_output_encoding();
 		const char *message = logmsg_reencode(current_head, NULL,
 						      out_enc);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 02478bc4ec..70a8307154 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -133,6 +133,30 @@ test_expect_success 'other worktree HEAD link pointing at a funny place' '
 	test_i18ngrep "worktrees/other/HEAD points to something strange" out
 '
 
+test_expect_success 'commit with multiple signatures is okay' '
+	git cat-file commit HEAD >basis &&
+	cat >sigs <<-EOF &&
+	gpgsig -----BEGIN PGP SIGNATURE-----
+	  VGhpcyBpcyBub3QgcmVhbGx5IGEgc2lnbmF0dXJlLg==
+	  -----END PGP SIGNATURE-----
+	gpgsig-sha256 -----BEGIN PGP SIGNATURE-----
+	  VGhpcyBpcyBub3QgcmVhbGx5IGEgc2lnbmF0dXJlLg==
+	  -----END PGP SIGNATURE-----
+	EOF
+	sed -e "/^committer/q" basis >okay &&
+	cat sigs >>okay &&
+	echo >>okay &&
+	sed -e "1,/^$/d" basis >>okay &&
+	cat okay &&
+	new=$(git hash-object -t commit -w --stdin <okay) &&
+	test_when_finished "remove_object $new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+	git fsck 2>out &&
+	cat out &&
+	! grep "commit $new" out
+'
+
 test_expect_success 'email without @ is okay' '
 	git cat-file commit HEAD >basis &&
 	sed "s/@/AT/" basis >okay &&
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 0c06d22a00..6baaa1ad91 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -6,6 +6,11 @@ GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success GPG 'create signed commits' '
+	test_oid_cache <<-\EOF &&
+	header sha1:gpgsig
+	header sha256:gpgsig-sha256
+	EOF
+
 	test_when_finished "test_unconfig commit.gpgsign" &&
 
 	echo 1 >file && git add file &&
@@ -155,6 +160,11 @@ test_expect_success GPG 'verify signatures with --raw' '
 	)
 '
 
+test_expect_success GPG 'proper header is used for hash algorithm' '
+	git cat-file commit fourth-signed >output &&
+	grep "^$(test_oid header) -----BEGIN PGP SIGNATURE-----" output
+'
+
 test_expect_success GPG 'show signed commit with signature' '
 	git show -s initial >commit &&
 	git show -s --show-signature initial >show &&
@@ -162,7 +172,7 @@ test_expect_success GPG 'show signed commit with signature' '
 	git cat-file commit initial >cat &&
 	grep -v -e "gpg: " -e "Warning: " show >show.commit &&
 	grep -e "gpg: " -e "Warning: " show >show.gpg &&
-	grep -v "^ " cat | grep -v "^gpgsig " >cat.commit &&
+	grep -v "^ " cat | grep -v "^$(test_oid header) " >cat.commit &&
 	test_cmp show.commit commit &&
 	test_cmp show.gpg verify.2 &&
 	test_cmp cat.commit verify.1
@@ -299,10 +309,10 @@ test_expect_success GPG 'check config gpg.format values' '
 test_expect_success GPG 'detect fudged commit with double signature' '
 	sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
 	sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
-		sed -e "s/^gpgsig//;s/^ //" | gpg --dearmor >double-sig1.sig &&
+		sed -e "s/^$(test_oid header)//;s/^ //" | gpg --dearmor >double-sig1.sig &&
 	gpg -o double-sig2.sig -u 29472784 --detach-sign double-base &&
 	cat double-sig1.sig double-sig2.sig | gpg --enarmor >double-combined.asc &&
-	sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/gpgsig /;2,\$s/^/ /" \
+	sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/$(test_oid header) /;2,\$s/^/ /" \
 		double-combined.asc > double-gpgsig &&
 	sed -e "/committer/r double-gpgsig" double-base >double-commit &&
 	git hash-object -w -t commit double-commit >double-commit.commit &&
