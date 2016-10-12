Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1223207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 13:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbcJLNE3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 09:04:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33544 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933100AbcJLNEX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Oct 2016 09:04:23 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6945E20920;
        Wed, 12 Oct 2016 09:04:17 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 12 Oct 2016 09:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-sasl-enc:x-sasl-enc; s=mesmtp; bh=mlva8OoK2tfPrWy0kqnkPnKXp18
        =; b=XxvvSsxs3APsVNuchS+Hu4Vf12yDfQxEVT/kyBC9vEzkVU3NtVomwdwMWc0
        nHg2YXzf7ke/ZoQB9BzxW3sLv6qs70ZPZIHjq37URwhMhx9C3UnSY14lSI9+eR9x
        gTdi+e4qFbsWBkaDP1UFydYWRAtTJYRIbhUtgUp5Qe7hnPxI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=mlva
        8OoK2tfPrWy0kqnkPnKXp18=; b=QjEH2fhWtKxjfLCWqTQRXokzQvxU+1uqtuKg
        GlsfaUtq1FgGqY5GTRwkYkO7fpR+LhklBLi1AoNpEsMMhwSXFXuh3P/Z3HtQ8HFi
        1Hx31jHHags3RrMGIsxB95WbmTJV0PcWQU+C0jyl+u6LRiuqSy8dAf42gv2h+iBo
        OpLaFT8=
X-Sasl-enc: UKr/kesa8hKS6oWnhbp9DFTJXczZGEqBUOVC15GWhYRX 1476277456
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3D4EF29D2;
        Wed, 12 Oct 2016 09:04:16 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Alex <agrambot@gmail.com>
Subject: [PATCH v3] gpg-interface: use more status letters
Date:   Wed, 12 Oct 2016 15:04:15 +0200
Message-Id: <a163120834c93482102cd616167bc2539d4e696d.1476271382.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.10.1.532.gfe29b57
In-Reply-To: <xmqqtwckf5mg.fsf@gitster.mtv.corp.google.com>
References: <xmqqtwckf5mg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to gpg2's doc/DETAILS:

    For each signature only one of the codes GOODSIG, BADSIG,
    EXPSIG, EXPKEYSIG, REVKEYSIG or ERRSIG will be emitted.

gpg1 ("classic") behaves the same (although doc/DETAILS differs).

Currently, we parse gpg's status output for GOODSIG, BADSIG and
trust information and translate that into status codes G, B, U, N
for the %G?  format specifier.

git-verify-* returns success in the GOODSIG case only. This is
somewhat in disagreement with gpg, which considers the first 5 of
the 6 above as VALIDSIG, but we err on the very safe side.

Introduce additional status codes E, X, Y, R for ERRSIG, EXPSIG,
EXPKEYSIG, and REVKEYSIG so that a user of %G? gets more information
about the absence of a 'G' on first glance.

Requested-by: Alex <agrambot@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
v3 incorporates Junios' changes to the commit message, as well as his
suggestion how to use an undefined gpghome the way test-lib does.
Also, all Y-related changes (including the if in pretty.c).

Testing X, Y, and R from our test scripts is somewhat problematic
(some gpg versions do not allow back-dating, and we cannot ship pre-made
signatures easily) but I have tested all of them locally.

 Documentation/pretty-formats.txt | 10 ++++++++--
 gpg-interface.c                  | 13 ++++++++++---
 pretty.c                         |  4 ++++
 t/t7510-signed-commit.sh         | 13 ++++++++++++-
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index a942d57f73..179c9389aa 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -143,8 +143,14 @@ ifndef::git-rev-list[]
 - '%N': commit notes
 endif::git-rev-list[]
 - '%GG': raw verification message from GPG for a signed commit
-- '%G?': show "G" for a good (valid) signature, "B" for a bad signature,
-  "U" for a good signature with unknown validity and "N" for no signature
+- '%G?': show "G" for a good (valid) signature,
+  "B" for a bad signature,
+  "U" for a good signature with unknown validity,
+  "X" for a good signature that has expired,
+  "Y" for a good signature made by an expired key,
+  "R" for a good signature made by a revoked key,
+  "E" if the signature cannot be checked (e.g. missing key)
+  and "N" for no signature
 - '%GS': show the name of the signer for a signed commit
 - '%GK': show the key used to sign a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}` or
diff --git a/gpg-interface.c b/gpg-interface.c
index 8672edaf48..e44cc27da1 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -33,6 +33,10 @@ static struct {
 	{ 'B', "\n[GNUPG:] BADSIG " },
 	{ 'U', "\n[GNUPG:] TRUST_NEVER" },
 	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
+	{ 'E', "\n[GNUPG:] ERRSIG "},
+	{ 'X', "\n[GNUPG:] EXPSIG "},
+	{ 'Y', "\n[GNUPG:] EXPKEYSIG "},
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
index 25efbcac92..d89ca30911 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1232,8 +1232,12 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			switch (c->signature_check.result) {
 			case 'G':
 			case 'B':
+			case 'E':
 			case 'U':
 			case 'N':
+			case 'X':
+			case 'Y':
+			case 'R':
 				strbuf_addch(sb, c->signature_check.result);
 			}
 			break;
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 6e839f5489..762135adea 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -2,6 +2,7 @@
 
 test_description='signed commit tests'
 . ./test-lib.sh
+GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success GPG 'create signed commits' '
@@ -190,7 +191,7 @@ test_expect_success GPG 'show bad signature with custom format' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'show unknown signature with custom format' '
+test_expect_success GPG 'show untrusted signature with custom format' '
 	cat >expect <<-\EOF &&
 	U
 	61092E85B7227189
@@ -200,6 +201,16 @@ test_expect_success GPG 'show unknown signature with custom format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'show unknown signature with custom format' '
+	cat >expect <<-\EOF &&
+	E
+	61092E85B7227189
+
+	EOF
+	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GK%n%GS" eighth-signed-alt >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'show lack of signature with custom format' '
 	cat >expect <<-\EOF &&
 	N
-- 
2.10.1.532.gfe29b57

