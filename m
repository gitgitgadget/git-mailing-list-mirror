Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0206C433E1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8873D20767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wyu8+FG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgFVSEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40002 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730252AbgFVSE2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CACA860A60;
        Mon, 22 Jun 2020 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849067;
        bh=mIcA5gOf7x6V4CtJBabDCzptsnGtuqXE3ouDLrU4xOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wyu8+FG3IHKtOvBjCFfuMQSsDJwxbOlOhbROK8vqnvjNkF2TInuXH8WEFRo3aN5It
         SpNuZ3DwDyY242fMAcm7Xy6XDmIWc9rqsQz2qoaPSNIg7BjFqPRoS7nF+gLZKV1OKG
         zBVS5nhveRIz1s8L/5qgRpbLsYqcHd3batHwIanW6HPpkC4HOBqYD2f0sFwZiTUTMe
         KyKdjZnhIRdmJD1XY38uqBrJX3680hkZTPCS7W5nK3m3cUo4k57winDzkJNOlIuOsN
         2W9t9QXKZRM18gw/EqBlJ6xu1F8VAy8lRA6g2m5BIsofu7mYRNiS45pvaT0xdvKVwm
         T8ayp7Vd8OI+qogvvqFOYvC73atHms+qny/OpEhqzmuHwu1JfC6luAHM4zem4RAE5K
         ThdHBcwJ/5xDYEUwyEFgmL8psO+dGCl3QaS8JY9kq8V2GyfcZ2qR9Z4NwgFS0nhEz+
         PAhJFA9ZlB5ZVDQzJ+Af0ERVMKlOGrDDE5mgWX9k5Bqf9yVCG/y
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/14] t9104: make hash size independent
Date:   Mon, 22 Jun 2020 18:04:09 +0000
Message-Id: <20200622180418.2418483-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200622180418.2418483-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The size of a record in the database used by git svn is four bytes plus
the length of the binary hash.  Instead of hard-coding 24, compute this
value based on the size of the hash in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9104-git-svn-follow-parent.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 5e0ad19177..67eed2fefc 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -161,6 +161,7 @@ test_expect_success "track initial change if it was only made to parent" '
 	'
 
 test_expect_success "follow-parent is atomic" '
+	record_size=$(($(test_oid rawsz) + 4)) &&
 	(
 		cd wc &&
 		svn_cmd up &&
@@ -186,7 +187,7 @@ test_expect_success "follow-parent is atomic" '
 	mkdir -p "$GIT_DIR"/svn/refs/remotes/flunk@18 &&
 	rev_map=$(cd "$GIT_DIR"/svn/refs/remotes/stunk && ls .rev_map*) &&
 	dd if="$GIT_DIR"/svn/refs/remotes/stunk/$rev_map \
-	   of="$GIT_DIR"/svn/refs/remotes/flunk@18/$rev_map bs=24 count=1 &&
+	   of="$GIT_DIR"/svn/refs/remotes/flunk@18/$rev_map bs=$record_size count=1 &&
 	rm -rf "$GIT_DIR"/svn/refs/remotes/stunk &&
 	git svn init --minimize-url -i flunk "$svnrepo"/flunk &&
 	git svn fetch -i flunk &&
