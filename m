Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87901FCEF
	for <e@80x24.org>; Fri, 12 Oct 2018 21:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbeJMEwF (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 00:52:05 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:52478 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbeJMEwF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 00:52:05 -0400
Received: from localhost.localdomain (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id C485F335CDA;
        Fri, 12 Oct 2018 21:17:41 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH v3] gpg-interface.c: detect and reject multiple signatures on commits
Date:   Fri, 12 Oct 2018 23:09:28 +0200
Message-Id: <20181012210928.18033-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GnuPG supports creating signatures consisting of multiple signature
packets.  If such a signature is verified, it outputs all the status
messages for each signature separately.  However, git currently does not
account for such scenario and gets terribly confused over getting
multiple *SIG statuses.

For example, if a malicious party alters a signed commit and appends
a new untrusted signature, git is going to ignore the original bad
signature and report untrusted commit instead.  However, %GK and %GS
format strings may still expand to the data corresponding
to the original signature, potentially tricking the scripts into
trusting the malicious commit.

Given that the use of multiple signatures is quite rare, git does not
support creating them without jumping through a few hoops, and finally
supporting them properly would require extensive API improvement, it
seems reasonable to just reject them at the moment.

Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 gpg-interface.c          | 94 +++++++++++++++++++++++++++-------------
 t/t7510-signed-commit.sh | 26 +++++++++++
 2 files changed, 91 insertions(+), 29 deletions(-)

Changes in v3: reworked the whole loop to iterate over lines rather
than scanning the whole buffer, as requested.  Now it also catches
duplicate instances of the same status.

diff --git a/gpg-interface.c b/gpg-interface.c
index db17d65f8..480aab4ee 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -75,48 +75,84 @@ void signature_check_clear(struct signature_check *sigc)
 	FREE_AND_NULL(sigc->key);
 }
 
+/* An exclusive status -- only one of them can appear in output */
+#define GPG_STATUS_EXCLUSIVE	(1<<0)
+
 static struct {
 	char result;
 	const char *check;
+	unsigned int flags;
 } sigcheck_gpg_status[] = {
-	{ 'G', "\n[GNUPG:] GOODSIG " },
-	{ 'B', "\n[GNUPG:] BADSIG " },
-	{ 'U', "\n[GNUPG:] TRUST_NEVER" },
-	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
-	{ 'E', "\n[GNUPG:] ERRSIG "},
-	{ 'X', "\n[GNUPG:] EXPSIG "},
-	{ 'Y', "\n[GNUPG:] EXPKEYSIG "},
-	{ 'R', "\n[GNUPG:] REVKEYSIG "},
+	{ 'G', "GOODSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'B', "BADSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'U', "TRUST_NEVER", 0 },
+	{ 'U', "TRUST_UNDEFINED", 0 },
+	{ 'E', "ERRSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'X', "EXPSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'Y', "EXPKEYSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'R', "REVKEYSIG ", GPG_STATUS_EXCLUSIVE },
 };
 
 static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
+	const char *line, *next;
 	int i;
-
-	/* Iterate over all search strings */
-	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
-		const char *found, *next;
-
-		if (!skip_prefix(buf, sigcheck_gpg_status[i].check + 1, &found)) {
-			found = strstr(buf, sigcheck_gpg_status[i].check);
-			if (!found)
-				continue;
-			found += strlen(sigcheck_gpg_status[i].check);
-		}
-		sigc->result = sigcheck_gpg_status[i].result;
-		/* The trust messages are not followed by key/signer information */
-		if (sigc->result != 'U') {
-			next = strchrnul(found, ' ');
-			sigc->key = xmemdupz(found, next - found);
-			/* The ERRSIG message is not followed by signer information */
-			if (*next && sigc-> result != 'E') {
-				found = next + 1;
-				next = strchrnul(found, '\n');
-				sigc->signer = xmemdupz(found, next - found);
+	int had_exclusive_status = 0;
+
+	/* Iterate over all lines */
+	for (line = buf; *line; line = strchrnul(line+1, '\n')) {
+		while (*line == '\n')
+			line++;
+		/* Skip lines that don't start with GNUPG status */
+		if (strncmp(line, "[GNUPG:] ", 9))
+			continue;
+		line += 9;
+
+		/* Iterate over all search strings */
+		for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
+			if (!strncmp(line, sigcheck_gpg_status[i].check,
+					strlen(sigcheck_gpg_status[i].check))) {
+				line += strlen(sigcheck_gpg_status[i].check);
+
+				if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE)
+					had_exclusive_status++;
+
+				sigc->result = sigcheck_gpg_status[i].result;
+				/* The trust messages are not followed by key/signer information */
+				if (sigc->result != 'U') {
+					next = strchrnul(line, ' ');
+					free(sigc->key);
+					sigc->key = xmemdupz(line, next - line);
+					/* The ERRSIG message is not followed by signer information */
+					if (*next && sigc->result != 'E') {
+						line = next + 1;
+						next = strchrnul(line, '\n');
+						free(sigc->signer);
+						sigc->signer = xmemdupz(line, next - line);
+					}
+				}
+
+				break;
 			}
 		}
 	}
+
+	/*
+	 * GOODSIG, BADSIG etc. can occur only once for each signature.
+	 * Therefore, if we had more than one then we're dealing with multiple
+	 * signatures.  We don't support them currently, and they're rather
+	 * hard to create, so something is likely fishy and we should reject
+	 * them altogether.
+	 */
+	if (had_exclusive_status > 1) {
+		sigc->result = 'E';
+		/* Clear partial data to avoid confusion */
+		if (sigc->signer)
+			FREE_AND_NULL(sigc->signer);
+		if (sigc->key)
+			FREE_AND_NULL(sigc->key);
+	}
 }
 
 int check_signature(const char *payload, size_t plen, const char *signature,
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 4e37ff8f1..180f0be91 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -234,4 +234,30 @@ test_expect_success GPG 'check config gpg.format values' '
 	test_must_fail git commit -S --amend -m "fail"
 '
 
+test_expect_success GPG 'detect fudged commit with double signature' '
+	sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
+	sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
+		sed -e "s/^gpgsig//;s/^ //" | gpg --dearmor >double-sig1.sig &&
+	gpg -o double-sig2.sig -u 29472784 --detach-sign double-base &&
+	cat double-sig1.sig double-sig2.sig | gpg --enarmor >double-combined.asc &&
+	sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/gpgsig /;2,\$s/^/ /" \
+		double-combined.asc > double-gpgsig &&
+	sed -e "/committer/r double-gpgsig" double-base >double-commit &&
+	git hash-object -w -t commit double-commit >double-commit.commit &&
+	test_must_fail git verify-commit $(cat double-commit.commit) &&
+	git show --pretty=short --show-signature $(cat double-commit.commit) >double-actual &&
+	grep "BAD signature from" double-actual &&
+	grep "Good signature from" double-actual
+'
+
+test_expect_success GPG 'show double signature with custom format' '
+	cat >expect <<-\EOF &&
+	E
+
+
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS" $(cat double-commit.commit) >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.19.1

