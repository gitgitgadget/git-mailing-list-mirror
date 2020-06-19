Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E03AC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5078F223BE
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xUGcCoK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgFSWvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:51:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39744 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbgFSWvf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 18:51:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 45B4A60A60;
        Fri, 19 Jun 2020 22:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592607093;
        bh=mIcA5gOf7x6V4CtJBabDCzptsnGtuqXE3ouDLrU4xOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xUGcCoK9qDUZ0fsclDngr611zFvWpqC2Dm1CpgX1spDl2ffsfFfXrJxx+KF/JIko3
         3pxD7GdeDt23NkXNYU9rUP3JaxbR8YWS5ibZNAsLY2GDdI7bvB3Ode+X/t6mn/B7hQ
         0qkUW/1DL9sYUqqqy85QZ+qHGtjWmHl1huZ2+gToQnVkiTAFGz7NCuh34CrZbM4tvK
         Bx6IQZ4kujJ0Jv5acWqtTO4SzeIQgQmbbf0I6M/jLDrIrzFBtfDciYg81VjnCwDdzz
         JgKpH+TDZuetZ3aH79YzDQgU2IRTIG2M/noPNRBjvroqAUS8+4V8vuXt7QH4m6aPXP
         Ao/4KllFRQhSiVIucvGyAHKN7+TdT8/nm0mN+M3J8euE+wxGHC/npz2idO45q18ZN/
         2cB7whnlohsKfYEKBJxZXCClAXz+ClyxbCPbeLRxQX6MwJS/Wi2Zemw92600KNdYMN
         b0vax8t4ShJ5EFBTiU9wmxv4s5AeebhDymr5YEfp+7Xp/s1XnLa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 05/14] t9104: make hash size independent
Date:   Fri, 19 Jun 2020 22:39:38 +0000
Message-Id: <20200619223947.947067-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
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
