Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B535C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8852076A
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XbCvUdB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgFVSE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40074 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730193AbgFVSE6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6144E60A5C;
        Mon, 22 Jun 2020 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849067;
        bh=CQU1uFJvbhgXo5lAz9npfF/EORtng3o9n9vqKrMBAIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XbCvUdB+JdUIS3FJZGv4YOD7brxUokfvOT8fTKKbGmy+eO9OIQH9/MjUUrzIOMKu6
         DIkqEqtjsT/iOi3gl2QkhgHuON/40Y97F/H0DBuezdcxT8EpuX8BlqWvCzlQ5jQ8D+
         Cg0ePJ34Rv6/yBw3tr4TwUa31t4UAPZGmVkzRvJPD3dTKtHTDxwY40Zp6pFeE3s6Hb
         8soQyozqWDCozmgYFV2paDZoTs5P45aGb1t/RM3OrNKS+S3LEP5agF0cY1BoHaK5fd
         X0sucaXi77Pb0rdjyYTmhA8E3EBwmqxKtKk7yx2EgV88HO09/BSOAaY79DMmdi0f8m
         MjdaDavWdrQLc+1FByi/An82C+ipyg5/l80FWaw0us3D4D7tq4aLjf3cG2NbILrBns
         zIwXC1RP8Kqt9cGdV9hEQqXd7FZ0+JSprFUwliDbW3YZVKHL7KX3y2IXKJ/RxKNsD4
         SK9uwO1ODJ6D8MMYrh8f428M5687RzsPZZszFXhxd5Z/sF/hKgb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/14] t9101: make hash independent
Date:   Mon, 22 Jun 2020 18:04:10 +0000
Message-Id: <20200622180418.2418483-7-sandals@crustytoothpaste.net>
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

Instead of hard-coding the object ID for our test .gitignore file, let's
compute it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9101-git-svn-props.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index c26c4b0927..8b5681dd68 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -160,11 +160,13 @@ cat >create-ignore.expect <<\EOF
 /no-such-file*
 EOF
 
-cat >create-ignore-index.expect <<\EOF
-100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	.gitignore
-100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	deeply/.gitignore
-100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	deeply/nested/.gitignore
-100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	deeply/nested/directory/.gitignore
+expectoid=$(git hash-object create-ignore.expect)
+
+cat >create-ignore-index.expect <<EOF
+100644 $expectoid 0	.gitignore
+100644 $expectoid 0	deeply/.gitignore
+100644 $expectoid 0	deeply/nested/.gitignore
+100644 $expectoid 0	deeply/nested/directory/.gitignore
 EOF
 
 test_expect_success 'test create-ignore' "
