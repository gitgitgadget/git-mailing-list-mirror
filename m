Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6306F20986
	for <e@80x24.org>; Tue, 27 Sep 2016 14:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbcI0Obr (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 10:31:47 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56183 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753622AbcI0Obn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Sep 2016 10:31:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 89DD220776;
        Tue, 27 Sep 2016 10:31:42 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 27 Sep 2016 10:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-sasl-enc:x-sasl-enc; s=mesmtp; bh=Zxi7DRlXLYIlju6hvu6Kh7l+qxk
        =; b=S2YVGVq5mS2vwefK1cd/BQpnaqGFzcjqaOq5ZefG0n7O6Fi4SqROhnTTJyQ
        aJMQl3W/WjWYtS3OSJloWuUwkENkxwFh5o4/9pj61sf8xCnxfUNLTPohw79H3u+s
        haloGegc24qMjrGJjwBFLZ5LV2RobDHN89fwiRiSiHDK14e0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Zxi7
        DRlXLYIlju6hvu6Kh7l+qxk=; b=WmDyLxGuRVbw4v2gBWfxhkusCEnx8nex/fvX
        lHI5RivI/P5Aw9EvT7bcBCsqNUcrgyE2urlYHX+geFtYjrOAu3X6fLy/oNpObRgA
        zP9qV9mFZLwi7jflQRg3atn8K3Edg5ZkAS/0LGYstqbTiIVvUVfCUlBfVKXQTRar
        pVH0wgA=
X-Sasl-enc: wiXdZnixdAGqAPXVxC81h9qLcFGIhl4xQwfbrZ7NX99m 1474986702
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2063CCC085;
        Tue, 27 Sep 2016 10:31:42 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Cc:     Alex <agrambot@gmail.com>
Subject: [PATCH] gpg-interface: use more status letters
Date:   Tue, 27 Sep 2016 16:31:40 +0200
Message-Id: <06b5e0bfb898c7b3c6a866df5bda0ab4587284c6.1474986563.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.10.0.527.gbcb6904
In-Reply-To: <87y42ey3z4.fsf@gmail.com>
References: <87y42ey3z4.fsf@gmail.com>
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

Reported-by: Alex <agrambot@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I'd be happy to learn are more portable/safer/cooler way to make gpg forget
that key in the added test...

 Documentation/pretty-formats.txt |  9 +++++++--
 gpg-interface.c                  |  4 ++++
 pretty.c                         |  3 +++
 t/t7510-signed-commit.sh         | 11 ++++++++++-
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index a942d57..806b47f 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -143,8 +143,13 @@ ifndef::git-rev-list[]
 - '%N': commit notes
 endif::git-rev-list[]
 - '%GG': raw verification message from GPG for a signed commit
-- '%G?': show "G" for a good (valid) signature, "B" for a bad signature,
-  "U" for a good signature with unknown validity and "N" for no signature
+- '%G?': show "G" for a good (rather: valid) signature,
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
index 8672eda..8a3e245 100644
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
index 6e839f5..fd22742 100755
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
@@ -200,6 +200,15 @@ test_expect_success GPG 'show unknown signature with custom format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'show unknown signature with custom format' '
+	cat >expect <<-\EOF &&
+	E
+	61092E85B7227189
+	EOF
+	GNUPGHOME=/dev/null git log -1 --format="%G?%n%GK" eighth-signed-alt >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'show lack of signature with custom format' '
 	cat >expect <<-\EOF &&
 	N
-- 
2.10.0.527.gbcb6904

