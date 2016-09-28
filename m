Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08F661F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 14:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbcI1OYS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 10:24:18 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45110 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932362AbcI1OYQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Sep 2016 10:24:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 63C1120647;
        Wed, 28 Sep 2016 10:24:15 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 28 Sep 2016 10:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-sasl-enc:x-sasl-enc; s=mesmtp; bh=APs5/qP2MfGcsUdDgnp8S8Fn/lE
        =; b=A+X7LAks1i07VN+ELJHPE5zHDflZJ48bIU1iGpx4pDKvTDg66Mb24UmPauz
        TYzJIC/CLrCEdVxxIgOXK25ZpApmB0VF8YNlNMuxeY8g6lPITckdsLj7LnWLQLqN
        9aXv4fVmKrkN4AyaUwlmrWeFQEXAuKSvxueuRXrzSs6UhLic=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=APs5
        /qP2MfGcsUdDgnp8S8Fn/lE=; b=OAN5RUwTjcfruD8TrCM9nz1ITnoOZqEUDlf+
        bys/Yb7Evlqy+5q1JNPo3bLI3ljVBb6Uj3Gjib7nhWFNTuM6kKrdwfInelgJTpiw
        RzsnR0WhGcdux9gBnIPAHDQodr6EwXj/qNhvmPOL8cogEcxZEUbnWULazbsLp/BO
        lVfuAKg=
X-Sasl-enc: apnGrnLN8rDXZo2LJxG22eR2JQqffKaRJOc0zM2HfkwD 1475072654
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id E95A6F29CF;
        Wed, 28 Sep 2016 10:24:14 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Cc:     Alex <agrambot@gmail.com>
Subject: [PATCH v2] gpg-interface: use more status letters
Date:   Wed, 28 Sep 2016 16:24:13 +0200
Message-Id: <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.10.0.527.gbcb6904
In-Reply-To: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to gpg2's doc/DETAILS:
"For each signature only one of the codes GOODSIG, BADSIG, EXPSIG,
EXPKEYSIG, REVKEYSIG or ERRSIG will be emitted."

gpg1 ("classic") behaves the same (although doc/DETAILS
differs).

Currently, we parse gpg's status output for GOODSIG, BADSIG and trust
information and translate that into status codes G, B, U, N for the %G?
format specifier.

git-verify-* returns success in the GOODSIG case only. This is somewhat in
disagreement with gpg, which considers the first 5 of the 6 above as VALIDSIG,
but we err on the very safe side.

Introduce additional status codes E, X, R for ERRSIG, EXP*SIG, REVKEYSIG
so that a user of %G? gets more information about the absence of a 'G'
on first glance.

Requested-by: Alex <agrambot@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Changes in v2:

- Use GNUPGHOME="$HOME/gnupg-home-not-used" just like in other tests (lib).
- Do not parse for signer UID in the ERRSIG case (and test that we do not).
- Retreat "rather" addition from the doc: good/valid are terms that we use
  differently from gpg anyways.

 Documentation/pretty-formats.txt |  9 +++++++--
 gpg-interface.c                  | 13 ++++++++++---
 pretty.c                         |  3 +++
 t/t7510-signed-commit.sh         | 12 +++++++++++-
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index a942d57..c28ff2b 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -143,8 +143,13 @@ ifndef::git-rev-list[]
 - '%N': commit notes
 endif::git-rev-list[]
 - '%GG': raw verification message from GPG for a signed commit
-- '%G?': show "G" for a good (valid) signature, "B" for a bad signature,
-  "U" for a good signature with unknown validity and "N" for no signature
+- '%G?': show "G" for a good (valid) signature,
+  "B" for a bad signature,
+  "U" for a good signature with unknown validity,
+  "X" for a good expired signature, or good signature made by an expired key,
+  "R" for a good signature made by a revoked key,
+  "E" if the signature cannot be checked (e.g. missing key)
+  and "N" for no signature
 - '%GS': show the name of the signer for a signed commit
 - '%GK': show the key used to sign a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}` or
diff --git a/gpg-interface.c b/gpg-interface.c
index 8672eda..6999e7b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -33,6 +33,10 @@ static struct {
 	{ 'B', "\n[GNUPG:] BADSIG " },
 	{ 'U', "\n[GNUPG:] TRUST_NEVER" },
 	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
+	{ 'E', "\n[GNUPG:] ERRSIG "},
+	{ 'X', "\n[GNUPG:] EXPSIG "},
+	{ 'X', "\n[GNUPG:] EXPKEYSIG "},
+	{ 'R', "\n[GNUPG:] REVKEYSIG "},
 };
 
 void parse_gpg_output(struct signature_check *sigc)
@@ -54,9 +58,12 @@ void parse_gpg_output(struct signature_check *sigc)
 		/* The trust messages are not followed by key/signer information */
 		if (sigc->result != 'U') {
 			sigc->key = xmemdupz(found, 16);
-			found += 17;
-			next = strchrnul(found, '\n');
-			sigc->signer = xmemdupz(found, next - found);
+			/* The ERRSIG message is not followed by signer information */
+			if (sigc-> result != 'E') {
+				found += 17;
+				next = strchrnul(found, '\n');
+				sigc->signer = xmemdupz(found, next - found);
+			}
 		}
 	}
 }
diff --git a/pretty.c b/pretty.c
index 493edb0..39a36cd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1232,8 +1232,11 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			switch (c->signature_check.result) {
 			case 'G':
 			case 'B':
+			case 'E':
 			case 'U':
 			case 'N':
+			case 'X':
+			case 'R':
 				strbuf_addch(sb, c->signature_check.result);
 			}
 			break;
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 6e839f5..9f487f9 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -190,7 +190,7 @@ test_expect_success GPG 'show bad signature with custom format' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'show unknown signature with custom format' '
+test_expect_success GPG 'show untrusted signature with custom format' '
 	cat >expect <<-\EOF &&
 	U
 	61092E85B7227189
@@ -200,6 +200,16 @@ test_expect_success GPG 'show unknown signature with custom format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'show unknown signature with custom format' '
+	cat >expect <<-\EOF &&
+	E
+	61092E85B7227189
+
+	EOF
+	GNUPGHOME="$HOME/gnupg-home-not-used" git log -1 --format="%G?%n%GK%n%GS" eighth-signed-alt >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'show lack of signature with custom format' '
 	cat >expect <<-\EOF &&
 	N
-- 
2.10.0.527.gbcb6904

