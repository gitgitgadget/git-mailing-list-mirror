Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6705C001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 21:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjGaVou (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 17:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGaVot (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 17:44:49 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2695133
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 14:44:47 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0FA665B01B;
        Mon, 31 Jul 2023 21:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1690839887;
        bh=ZNMRyWbtgox7p0GojUSQL69AZfszAweIo2vznYRiz8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=M2+gzYuHbHa8f06vCQPIcn6mSiY0rOm8kBz/DpxlpgGJGXRuV+1BbtT/ku3CSXfP6
         xbhaaGwrwhIWpxs5RWAuEW66+6Hzrbr5VoZhhuqNxpsp5z0EYgtuh+K54ItNzHP9v2
         +C2MvsW6q0msAalicv01YoSU9Byk7wO6dl7DYEJ+XsQ0oiQ/Vo9CwTu1wZp8u491DZ
         rOpZGeoO2ivViUDNbo8pJzETSy6zoNB5FjpOQHtRnEVN5UfRYTcMyRGH0TskIal/Jw
         5sXkcU8QZyDeWSlsmMUCPXzDNpkwKPGS8Q96tz4XEdQefMJLO9PLqOr4Yr5KPMZLFR
         zpH0V3rhWbAsb1BGxPwGzXawBtNTImH5yk8BHWlHuPoRo2MXsWBhkZ/eGo4f3aUSos
         Na0mjuAegUM+Yfx6Q0PEOCYTolRAcWyyz13U3VAoceq+7cTo9jpX8vBb+PjrdVosYT
         lnvOEerJcoM6tQvJJ3ckBbgzNEi1W2xCT4e0Ez6h+w+1kAhzcRm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Thomas J. Faughnan Jr." <thomas@faughnan.net>,
        "Daniel P." <danpltile@gmail.com>
Subject: [PATCH] ident: don't consider trailing dot crud
Date:   Mon, 31 Jul 2023 21:44:35 +0000
Message-ID: <20230731214435.1462098-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <ZMghdgIaQB4L88WR@tapette.crustytoothpaste.net>
References: <ZMghdgIaQB4L88WR@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we process a user's name (as in user.name), we strip all trailing
crud from it.  Right now, we consider a dot trailing crud, and strip it
off.

However, this is unsuitable for many personal names because humans
frequently have abbreviated suffixes, such as "Jr." or "Sr." at the end
of their names, and this corrupts them.  Some other users may wish to
use an abbreviated name or initial, which will pose a problem especially
in cultures that write the family name first, followed by the personal
name.

Since the current approach causes lots of practical problems, let's
avoid it by no longer considering a dot to be crud.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ident.c                       |  1 -
 t/t4203-mailmap.sh            |  4 ++--
 t/t7518-ident-corner-cases.sh | 11 ++++++++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/ident.c b/ident.c
index 08be4d0747..cc7afdbf81 100644
--- a/ident.c
+++ b/ident.c
@@ -203,7 +203,6 @@ void reset_ident_date(void)
 static int crud(unsigned char c)
 {
 	return  c <= 32  ||
-		c == '.' ||
 		c == ',' ||
 		c == ':' ||
 		c == ';' ||
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index fa7f987284..2016132f51 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -466,7 +466,7 @@ test_expect_success 'gitmailmap(5) example output: example #1' '
 	Author Jane Doe <jane@laptop.(none)> maps to Jane Doe <jane@laptop.(none)>
 	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
 
-	Author Jane D <jane@desktop.(none)> maps to Jane Doe <jane@desktop.(none)>
+	Author Jane D. <jane@desktop.(none)> maps to Jane Doe <jane@desktop.(none)>
 	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
 	EOF
 	git -C doc log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
@@ -494,7 +494,7 @@ test_expect_success 'gitmailmap(5) example output: example #2' '
 	Author Jane Doe <jane@laptop.(none)> maps to Jane Doe <jane@example.com>
 	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
 
-	Author Jane D <jane@desktop.(none)> maps to Jane Doe <jane@example.com>
+	Author Jane D. <jane@desktop.(none)> maps to Jane Doe <jane@example.com>
 	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
 	EOF
 	git -C doc log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
index fffdb6ff2e..9ab2ae2f3b 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -20,10 +20,19 @@ test_expect_success 'empty name and missing email' '
 '
 
 test_expect_success 'commit rejects all-crud name' '
-	test_must_fail env GIT_AUTHOR_NAME=" .;<>" \
+	test_must_fail env GIT_AUTHOR_NAME=" ,;<>" \
 		git commit --allow-empty -m foo
 '
 
+test_expect_success 'commit does not strip trailing dot' '
+	author_name="Pat Doe Jr." &&
+	env GIT_AUTHOR_NAME="$author_name" \
+		git commit --allow-empty -m foo &&
+	git log -1 --format=%an >actual &&
+	echo "$author_name" >expected &&
+	test_cmp actual expected
+'
+
 # We must test the actual error message here, as an unwanted
 # auto-detection could fail for other reasons.
 test_expect_success 'empty configured name does not auto-detect' '
