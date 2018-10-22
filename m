Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BFCF1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 16:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeJWA5p (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 20:57:45 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58474 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJWA5p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 20:57:45 -0400
Received: from localhost.localdomain (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 28CE7335D0E;
        Mon, 22 Oct 2018 16:38:29 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH 2/3] gpg-interface.c: Support getting key fingerprint via %GF format
Date:   Mon, 22 Oct 2018 18:38:20 +0200
Message-Id: <20181022163821.23523-2-mgorny@gentoo.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022163821.23523-1-mgorny@gentoo.org>
References: <20181022163821.23523-1-mgorny@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support processing VALIDSIG status that provides additional information
for valid signatures.  Use this information to propagate signing key
fingerprint and expose it via %GF pretty format.  This format can be
used to build safer key verification systems that verify the key via
complete fingerprint rather than short/long identifier provided by %GK.

Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 Documentation/pretty-formats.txt |  1 +
 gpg-interface.c                  | 14 +++++++++++++-
 gpg-interface.h                  |  1 +
 pretty.c                         |  4 ++++
 t/t7510-signed-commit.sh         | 18 ++++++++++++------
 5 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 6109ef09a..8ab7d6dd1 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -153,6 +153,7 @@ endif::git-rev-list[]
   and "N" for no signature
 - '%GS': show the name of the signer for a signed commit
 - '%GK': show the key used to sign a signed commit
+- '%GF': show the fingerprint of the key used to sign a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}` or
   `refs/stash@{2 minutes ago`}; the format follows the rules described
   for the `-g` option. The portion before the `@` is the refname as
diff --git a/gpg-interface.c b/gpg-interface.c
index c7cd24ec0..a406484e4 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -73,6 +73,7 @@ void signature_check_clear(struct signature_check *sigc)
 	FREE_AND_NULL(sigc->gpg_status);
 	FREE_AND_NULL(sigc->signer);
 	FREE_AND_NULL(sigc->key);
+	FREE_AND_NULL(sigc->fingerprint);
 }
 
 /* An exclusive status -- only one of them can appear in output */
@@ -81,6 +82,8 @@ void signature_check_clear(struct signature_check *sigc)
 #define GPG_STATUS_KEYID	(1<<1)
 /* The status includes user identifier */
 #define GPG_STATUS_UID		(1<<2)
+/* The status includes key fingerprints */
+#define GPG_STATUS_FINGERPRINT	(1<<3)
 
 /* Short-hand for standard exclusive *SIG status with keyid & UID */
 #define GPG_STATUS_STDSIG	(GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID|GPG_STATUS_UID)
@@ -98,6 +101,7 @@ static struct {
 	{ 'X', "EXPSIG ", GPG_STATUS_STDSIG },
 	{ 'Y', "EXPKEYSIG ", GPG_STATUS_STDSIG },
 	{ 'R', "REVKEYSIG ", GPG_STATUS_STDSIG },
+	{ 0, "VALIDSIG ", GPG_STATUS_FINGERPRINT },
 };
 
 static void parse_gpg_output(struct signature_check *sigc)
@@ -123,7 +127,8 @@ static void parse_gpg_output(struct signature_check *sigc)
 						goto found_duplicate_status;
 				}
 
-				sigc->result = sigcheck_gpg_status[i].result;
+				if (sigcheck_gpg_status[i].result)
+					sigc->result = sigcheck_gpg_status[i].result;
 				/* Do we have key information? */
 				if (sigcheck_gpg_status[i].flags & GPG_STATUS_KEYID) {
 					next = strchrnul(line, ' ');
@@ -137,6 +142,12 @@ static void parse_gpg_output(struct signature_check *sigc)
 						sigc->signer = xmemdupz(line, next - line);
 					}
 				}
+				/* Do we have fingerprint? */
+				if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
+					next = strchrnul(line, ' ');
+					free(sigc->fingerprint);
+					sigc->fingerprint = xmemdupz(line, next - line);
+				}
 
 				break;
 			}
@@ -154,6 +165,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 	 */
 	sigc->result = 'E';
 	/* Clear partial data to avoid confusion */
+	FREE_AND_NULL(sigc->fingerprint);
 	FREE_AND_NULL(sigc->signer);
 	FREE_AND_NULL(sigc->key);
 }
diff --git a/gpg-interface.h b/gpg-interface.h
index acf50c461..8ce614fc9 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -23,6 +23,7 @@ struct signature_check {
 	char result;
 	char *signer;
 	char *key;
+	char *fingerprint;
 };
 
 void signature_check_clear(struct signature_check *sigc);
diff --git a/pretty.c b/pretty.c
index 8ca29e928..4567b5321 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1256,6 +1256,10 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			if (c->signature_check.key)
 				strbuf_addstr(sb, c->signature_check.key);
 			break;
+		case 'F':
+			if (c->signature_check.fingerprint)
+				strbuf_addstr(sb, c->signature_check.fingerprint);
+			break;
 		default:
 			return 0;
 		}
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 180f0be91..19ccae286 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -175,8 +175,9 @@ test_expect_success GPG 'show good signature with custom format' '
 	G
 	13B6F51ECDDE430D
 	C O Mitter <committer@example.com>
+	73D758744BE721698EC54E8713B6F51ECDDE430D
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS" sixth-signed >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF" sixth-signed >actual &&
 	test_cmp expect actual
 '
 
@@ -185,8 +186,9 @@ test_expect_success GPG 'show bad signature with custom format' '
 	B
 	13B6F51ECDDE430D
 	C O Mitter <committer@example.com>
+
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS" $(cat forged1.commit) >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF" $(cat forged1.commit) >actual &&
 	test_cmp expect actual
 '
 
@@ -195,8 +197,9 @@ test_expect_success GPG 'show untrusted signature with custom format' '
 	U
 	61092E85B7227189
 	Eris Discordia <discord@example.net>
+	D4BE22311AD3131E5EDA29A461092E85B7227189
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS" eighth-signed-alt >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF" eighth-signed-alt >actual &&
 	test_cmp expect actual
 '
 
@@ -205,8 +208,9 @@ test_expect_success GPG 'show unknown signature with custom format' '
 	E
 	61092E85B7227189
 
+
 	EOF
-	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GK%n%GS" eighth-signed-alt >actual &&
+	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GK%n%GS%n%GF" eighth-signed-alt >actual &&
 	test_cmp expect actual
 '
 
@@ -215,8 +219,9 @@ test_expect_success GPG 'show lack of signature with custom format' '
 	N
 
 
+
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS" seventh-unsigned >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF" seventh-unsigned >actual &&
 	test_cmp expect actual
 '
 
@@ -255,8 +260,9 @@ test_expect_success GPG 'show double signature with custom format' '
 	E
 
 
+
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS" $(cat double-commit.commit) >actual &&
+	git log -1 --format="%G?%n%GK%n%GS%n%GF" $(cat double-commit.commit) >actual &&
 	test_cmp expect actual
 '
 
-- 
2.19.1

