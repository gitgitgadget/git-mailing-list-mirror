Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F91C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB56D20776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ou+MNh76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436519AbgFSR5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39624 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404749AbgFSR4q (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B6F4160A5E;
        Fri, 19 Jun 2020 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589375;
        bh=VRoONdvcbARP5+3wr28J+/lkAxkxEY4gUpFmTPvhqlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ou+MNh767hw6VmhymtyGEFb+BR67zJBGeu+mU4sAe367aFxImUuxQgm4Hwrnyemnb
         PpmbcwS53G2c9jE4CoC5qSutoaJtLJh8HMVtqdP7bN0gpbhc0n14Xt3zSBapUsB+aK
         vGNnEx1zLWTDyIDZTe3o3sERqktXGFeiedt8SqMc/GwIXWJgK3uJV6yWFkvZ8z3PF6
         zv27MM6Q9e1EczuXamTdTqRqpXGr6mBg/FFKH9X6vytRzPHXzOpPjnhG08+fCMbn+H
         nbIHYnx2kszV/yKeP2yBOZTxDiSyK4ChOyxWCa5qrgKWJ5Y/EOCYA2cRE+zr49pSoG
         caivI5+PHuaibEsxZS51JneVgsfK1kd95uGNL9bOCr/CFzMI4mLH+CpGNrV0KPigVi
         SnrcccuAOIwHqiaPuftqsDp/yT5zBHccg5g9NpYnL2DV4V/pGXUVz+6jbDlZWRlcSD
         ytG49RIDcjsdNKZSSHYUbUcVJPpKYu4UlsKxJbDhvegYzES6Q/p
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 04/44] wrapper: add function to compare strings with different NUL termination
Date:   Fri, 19 Jun 2020 17:55:21 +0000
Message-Id: <20200619175601.569856-5-sandals@crustytoothpaste.net>
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

When parsing capabilities for the pack protocol, there are times we'll
want to compare the value of a capability to a NUL-terminated string.
Since the data we're reading will be space-terminated, not
NUL-terminated, we need a function that compares the two strings, but
also checks that they're the same length.  Otherwise, if we used strncmp
to compare these strings, we might accidentally accept a parameter that
was a prefix of the expected value.

Add a function, xstrncmpz, that takes a NUL-terminated string and a
non-NUL-terminated string, plus a length, and compares them, ensuring
that they are the same length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-compat-util.h | 6 ++++++
 wrapper.c         | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index a73632e8e4..5637114b8d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -868,6 +868,12 @@ char *xgetcwd(void);
 FILE *fopen_for_writing(const char *path);
 FILE *fopen_or_warn(const char *path, const char *mode);
 
+/*
+ * Like strncmp, but only return zero if s is NUL-terminated and exactly len
+ * characters long.  If it is not, consider it greater than t.
+ */
+int xstrncmpz(const char *s, const char *t, size_t len);
+
 /*
  * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
  * that ptr is used twice, so don't pass e.g. ptr++.
diff --git a/wrapper.c b/wrapper.c
index 3a1c0e0526..4ff4a9c3db 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -105,6 +105,14 @@ char *xstrndup(const char *str, size_t len)
 	return xmemdupz(str, p ? p - str : len);
 }
 
+int xstrncmpz(const char *s, const char *t, size_t len)
+{
+	int res = strncmp(s, t, len);
+	if (res)
+		return res;
+	return s[len] == '\0' ? 0 : 1;
+}
+
 void *xrealloc(void *ptr, size_t size)
 {
 	void *ret;
