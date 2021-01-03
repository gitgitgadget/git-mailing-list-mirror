Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5609C433E0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13B3207FB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbhACVUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:20:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45776 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727453AbhACVUS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jan 2021 16:20:18 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 031BD60813;
        Sun,  3 Jan 2021 21:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1609708747;
        bh=bvaKPPUf9jCHS07WB0sIrmL/eG253OE3KgZpLiWKS3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=05bVC5m8O1GQoGICwTB9qyiCFhoqbnFzwtcznflgTLu4zc8mmZKxjHiWBASvkODmM
         70pSsc2//oPZVQQRphx9d0OEM7wLrJpKMqWl66imHiPIHKI/7YHC+Rdc+4jll+EjSQ
         5FVVu99Eg7Z5690VgL4g+nNA0vkyv6/p0x1A3bNmmEK3YdK0yc9cVYo2gYkt1G0LeZ
         JEHGf2Yk/oJIgIDaKHJ9DxQg1vOAeicy7ZTbSgZNx+6Wr3ctD3uX/EHMDmHIDqevb4
         dkoTPWPWJX3pDJKKkWiJmTrddasZe/zNd+YzIXh4+icopxUWFWCTDiPO4O7HWV7xv4
         9D5dIY/ZZs8GtIDBeHlEAtEkz0ccIvoMFAk1xFZ6sx460L2b6LmhA1GLWWdBk2518z
         L06TOYPmdu97tfemE0dvCLtd1gx1H9RO5rSSMsZrxZh6EoYnlnIWjGnxsEoZpnKnJ3
         mLq3+FmpFgOvAYnHtbDvMbBkS0rieXvk4/wyCi0t7zahy9vQqq8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/5] t4203: add failing test for case-sensitive local-parts and names
Date:   Sun,  3 Jan 2021 21:18:47 +0000
Message-Id: <20210103211849.2691287-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git always looks up entries in the mailmap in a
case-insensitive way, both for names and addresses, which is, as
explained below, suboptimal.

First, for email addresses, RFC 5321 is clear that only domains are case
insensitive; local-parts (the portion before the at sign) are not.  It
states this:

  The local-part of a mailbox MUST BE treated as case sensitive.
  Therefore, SMTP implementations MUST take care to preserve the case of
  mailbox local-parts.

There exist systems today where local-parts remain case sensitive (and
this author has one), and as such, it's incorrect for us to case fold
them in any way.  Let's add a failing test that indicates this is a
problem, while still keeping the test for case-insensitive domains.

Note that it's also incorrect for us to case-fold names because we don't
guarantee that we're using the locale of the author, and it's impossible
to case-fold names in a locale-insensitive way.  Turkish and Azeri
contain both a dotted and dotless I, and the uppercase ASCII I folds not
to the lowercase ASCII I, but to a dotless version, and vice versa with
the lowercase I.  There are many words in Turkish which differ only in
the dottedness of the I, so it is likely that there are also personal
names which differ in the same way.

That would be a problem even if our implementation were perfect, which
it is not.  We currently fold only ASCII characters, so this feature has
never worked correctly for the vast majority of the users on the planet,
regardless of the locale.  For example, on Linux, even in a Spanish
locale, we don't handle "Simón" properly.  Even if we did handle that,
we'd probably also want to implement Unicode normalization, which we
don't.

In general, case-folding text is extremely language- and locale-specific
and requires intimacy with the spelling and grammar of the language in
question and careful attention to the Unicode details in order to
produce a result that is meaningful to humans and conforms with
linguistic and societal norms.

Because we do not have any of the required context with a plain personal
name, we cannot hope to possibly case-fold personal names correctly.  We
should stop trying to do so and just treat them as a series of bytes, so
let's add a test that we don't case-fold personal names as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4203-mailmap.sh | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 586c3a86b1..32e849504c 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -170,10 +170,35 @@ Repo Guy (1):
 
 EOF
 
-test_expect_success 'name entry after email entry, case-insensitive' '
+test_expect_success 'name entry after email entry, case-insensitive domain' '
 	mkdir -p internal_mailmap &&
 	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
-	echo "Internal Guy <BUGS@Company.xx>" >>internal_mailmap/.mailmap &&
+	echo "Internal Guy <bugs@Company.xx>" >>internal_mailmap/.mailmap &&
+	git shortlog HEAD >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<\EOF
+Repo Guy (1):
+      initial
+
+nick1 (1):
+      second
+
+EOF
+
+test_expect_failure 'name entry after email entry, case-sensitive local-part' '
+	mkdir -p internal_mailmap &&
+	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
+	echo "Internal Guy <BUGS@company.xx>" >>internal_mailmap/.mailmap &&
+	git shortlog HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'name entry after email entry, case-sensitive personal name' '
+	mkdir -p internal_mailmap &&
+	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
+	echo "Nick1 <bugs@company.xx> NICK1 <bugs@company.xx>" >internal_mailmap/.mailmap &&
 	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
