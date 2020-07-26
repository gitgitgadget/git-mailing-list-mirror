Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85FFC433EA
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA4620719
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cRBQlenk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgGZTys (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40666 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727862AbgGZTyr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E77A161013;
        Sun, 26 Jul 2020 19:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793286;
        bh=yISpjiYdNb20ay038vbmc40m1f3lZfeDdvoTNXqWBQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cRBQlenkxtz8ofhgwjeGamBFWO6uONX9H4CmMmLeoOIEW97vO6ScwL+7k92nF6LpB
         cIIHCk4Y3sXy9sJZ/l+8W/pyTqnrxfs3FsQG3hOIW3378Ymvrr6thk7V06rRVLva4n
         OfKeFAC3d1CtyBPt0fb8gY8EnsGyJKQRr0LJK/FuLOBnqGKEBau+iTN+Vrp/VLEHrY
         8ZgK98fsyzZvVqL5MrYQz4sJekcfxMEuMyeUKIqWsBfcqm7icQ9a0docSNmdpZDCCC
         NZFU7QuUwbRz/BpCp5xBKwwhJPhOQzT/dEXHtC4auQiri04fhh17oUd9z/jDBLxzw7
         pCU0YGx0zVFG5dbYvCZHP6ez3euDqSoWyr6LQfIBP8kC8ixit/rxfz7ghF8cwmffAP
         ISDW3VEW6ocNEqSgzXrOF2zqOhUuSVDzXR9as8Rn4UYlkcQsJb/8Wqs/3DXO4xN5Zq
         U8yvB+Y6SJJOcGOPFS5C/gRzeD+ouF/U8VYVpAkVninWGxjCPPx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 12/39] t7201: abstract away SHA-1-specific constants
Date:   Sun, 26 Jul 2020 19:53:57 +0000
Message-Id: <20200726195424.626969-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7201-co.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b696bae5f5..d4fd760915 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -230,9 +230,10 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
 
 	git config advice.detachedHead false &&
+	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
-	test_i18ngrep "HEAD is now at 7329388" messages &&
+	test_i18ngrep "HEAD is now at $rev" messages &&
 	test_line_count = 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -250,7 +251,7 @@ test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	git checkout -f renamer && git clean -f &&
 	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
-	grep "HEAD is now at 7329388" messages &&
+	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
