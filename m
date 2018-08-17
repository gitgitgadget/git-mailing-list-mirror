Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09CFE1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 07:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeHQKhL (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 06:37:11 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:60214 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbeHQKhL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 06:37:11 -0400
Received: from localhost.localdomain (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id B90B3335D6E;
        Fri, 17 Aug 2018 07:34:50 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com,
        =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH v2] gpg-interface.c: detect and reject multiple signatures on commits
Date:   Fri, 17 Aug 2018 09:34:41 +0200
Message-Id: <20180817073441.5247-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.18.0
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
 gpg-interface.c          | 41 ++++++++++++++++++++++++++++++++--------
 t/t7510-signed-commit.sh | 26 +++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 8 deletions(-)

Changes in v2:
* used generic 'flags' instead of boolean field,
* added test case for git-verify-commit & git-show.

diff --git a/gpg-interface.c b/gpg-interface.c
index 09ddfbc26..35c25106a 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -21,24 +21,29 @@ void signature_check_clear(struct signature_check *sigc)
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
+	{ 'G', "\n[GNUPG:] GOODSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'B', "\n[GNUPG:] BADSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'U', "\n[GNUPG:] TRUST_NEVER", 0 },
+	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED", 0 },
+	{ 'E', "\n[GNUPG:] ERRSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'X', "\n[GNUPG:] EXPSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'Y', "\n[GNUPG:] EXPKEYSIG ", GPG_STATUS_EXCLUSIVE },
+	{ 'R', "\n[GNUPG:] REVKEYSIG ", GPG_STATUS_EXCLUSIVE },
 };
 
 static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
 	int i;
+	int had_exclusive_status = 0;
 
 	/* Iterate over all search strings */
 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
@@ -50,6 +55,10 @@ static void parse_gpg_output(struct signature_check *sigc)
 				continue;
 			found += strlen(sigcheck_gpg_status[i].check);
 		}
+
+		if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE)
+			had_exclusive_status++;
+
 		sigc->result = sigcheck_gpg_status[i].result;
 		/* The trust messages are not followed by key/signer information */
 		if (sigc->result != 'U') {
@@ -62,6 +71,22 @@ static void parse_gpg_output(struct signature_check *sigc)
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
index 6e2015ed9..51fb92a72 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -227,4 +227,30 @@ test_expect_success GPG 'log.showsignature behaves like --show-signature' '
 	grep "gpg: Good signature" actual
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
2.18.0

