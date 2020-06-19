Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA589C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AEB20776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rw0bZhNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404686AbgFSR5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404705AbgFSR4p (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A048760A76;
        Fri, 19 Jun 2020 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589396;
        bh=73juDmT7AedVAFtoq2gbukr8T2H8y8stjGC9wi2bUQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=rw0bZhNOvWv4YObOWax31THNIbgsO9d6vx/uyY75MVVHdJSakMwfAK2gPEUDrJQJN
         8xHH/42tv5oB0xfZ3ezcdzuhk3DPedcZ3LsYOdWQALPVc0O/fbogvTXqMsaaHAJ04G
         4zMrzc6zVdm3O4xphKbGA0hMX+mNFbYYUfLsbN4R1e8I0pu5R4G8AUMF1zrUAoVy85
         vTJmrBJcjv+nU+p3Av/KT6RCZthk3g1Y9AS/9DyM5pVzOn0QIjV16dHm4myQKgTW3o
         nPmHiHXqtlxtbnpaRYkjOVoiDJNb6RhEpNJt4Cc8Fa4+KwLpC8RUodPlgMKyxkHAmt
         QghYlNMVNdKVzzH8IOYh8LtTq6QdU3FNSM1dWTL1YCjRGpj1D0BI4353tm04QV3QDr
         FOYMpR6hlj8cfVDKHTPa+w9WcMNPsnyHxv72jQ3qY2n3QVORtt7DWRDqRgzgk4lEiB
         C6yDl3tEsDE06dd0KcKmLGcDkYqQWMZwgUcGQnxSc8XxIQfoOnc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 44/44] remote-testgit: adapt for object-format
Date:   Fri, 19 Jun 2020 17:56:01 +0000
Message-Id: <20200619175601.569856-45-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
