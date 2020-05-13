Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EEBC2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5377820675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kqF4LMWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgEMAzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38140 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731946AbgEMAy6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A5DAC60D1A;
        Wed, 13 May 2020 00:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331296;
        bh=73juDmT7AedVAFtoq2gbukr8T2H8y8stjGC9wi2bUQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kqF4LMWPH8twVcsAIivho/qlwBS1GDqrxz8yiclkyA5CdCbfd9378gmudFvtRui2F
         a1IZjnGKgMiNL/zHr6UJ4kh9l31FRtzILNTsGQhSUp3tJfNjL2s2zwquhgNMfKVH8A
         VV6IsuWLgOlMfdu84ia+u6AxQvoCEvBbP2fAEuuQyqqYmwCpi+377YgCoeGW73LzKj
         UPzxaQeOUoj8ckXzTOG2P6YLkjFR6F0N8fVgg5N9SVxljCGPm2yOOt4d2HFmy7TbJV
         WezbbeCO9vzzRMuxyUPNZbkfHFfnVk2xn/F4jKkCtXtS4YliSXznPj6U4Ot54JWpSW
         /Z7yhAZa+WgHkuWkq7vWLV7K89CfK6KNwh/fpbTw2pGufoXWDEACjIddhbBWttTDz/
         BOeyNTT8Zs6aJqBs3HiDq0YcQQLskD/ha9o0nbjhlOTfSUfPYVciQvJUPCqvN+E+NM
         55aeWdcWQOAZdVEu5mrifwwNFZw18mzQPrIEsjJJVkruSQuwg8O
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 44/44] remote-testgit: adapt for object-format
Date:   Wed, 13 May 2020 00:54:24 +0000
Message-Id: <20200513005424.81369-45-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using an algorithm other than SHA-1, we need the remote helper to
advertise support for the object-format extension and provide
information back to us so that we can properly parse refs and return
data. Ensure that the test remote helper understands these extensions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5801/git-remote-testgit | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
index 6b9f0b5dc7..1544d6dc6b 100755
--- a/t/t5801/git-remote-testgit
+++ b/t/t5801/git-remote-testgit
@@ -52,9 +52,11 @@ do
 		test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
 		test -n "$GIT_REMOTE_TESTGIT_NO_PRIVATE_UPDATE" && echo "no-private-update"
 		echo 'option'
+		echo 'object-format'
 		echo
 		;;
 	list)
+		echo ":object-format $(git rev-parse --show-object-format=storage)"
 		git for-each-ref --format='? %(refname)' 'refs/heads/' 'refs/tags/'
 		head=$(git symbolic-ref HEAD)
 		echo "@$head HEAD"
@@ -139,6 +141,10 @@ do
 			test $val = "true" && force="true" || force=
 			echo "ok"
 			;;
+		object-format)
+			test $val = "true" && object_format="true" || object_format=
+			echo "ok"
+			;;
 		*)
 			echo "unsupported"
 			;;
