Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DE2C2D0FC
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23DE020753
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Uc1YZH98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgEMAyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38104 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgEMAyk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:40 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4CD62609D3;
        Wed, 13 May 2020 00:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331279;
        bh=OLURWUEYz9+b3/c+Xf6DUH98Mfh15gzkrC5937mfdYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Uc1YZH98UMifDUuPvWZTTKkO1LIaywXF0u4Qam/n+cpvcs4AajqtoatqtuaWXtNlH
         TvCPWsz8JVzJzd3QyyYulpn6AiQ7MoWgZ+Hu0VfkSwoYh0Jm5ly2Rc1w+lcnIBStZY
         KQlr4ooycjgzJuiYl2phc7NLnoeklSXihVC8cg2di1VXcQy1qBnEkJ18vszs4Ownqy
         YBDlGuNjgV29ibOQhA4twrfLjotpUmicqsjq7sj5ZL+8w15H9ur2pIUEDpifUeQyFD
         q8Gc2zHZOi2YXOT+o82nGfoNsVqcF4aqit1wSjCtHNduBKsx/kpyZdi3b+Qs/khQ7S
         px6ESfxkIdDREWQNzx7Uu1L/EJEziZ9q1f5XQTKEHQbtHHKu0OOesULXMIikbulnPk
         7Hpv91dyFG/dyY603Awq0Y3BHePUedbocEqehnO10kdnWmQv5hAiRD9k/eJlpkuixy
         U3tEW8hZzJJR5sVLkt8yfm6wGDTUd8XebuXVWeE/Qb2DiiKMljh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 04/44] wrapper: add function to compare strings with different NUL termination
Date:   Wed, 13 May 2020 00:53:44 +0000
Message-Id: <20200513005424.81369-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
 git-compat-util.h |  2 ++
 wrapper.c         | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8ba576e81e..6503deb171 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -868,6 +868,8 @@ char *xgetcwd(void);
 FILE *fopen_for_writing(const char *path);
 FILE *fopen_or_warn(const char *path, const char *mode);
 
+int xstrncmpz(const char *s, const char *t, size_t len);
+
 /*
  * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
  * that ptr is used twice, so don't pass e.g. ptr++.
diff --git a/wrapper.c b/wrapper.c
index 3a1c0e0526..15a09740e7 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -430,6 +430,18 @@ int xmkstemp(char *filename_template)
 	return fd;
 }
 
+/*
+ * Like strncmp, but only return zero if s is NUL-terminated and exactly len
+ * characters long.  If it is not, consider it greater than t.
+ */
+int xstrncmpz(const char *s, const char *t, size_t len)
+{
+	int res = strncmp(s, t, len);
+	if (res)
+		return res;
+	return s[len] == '\0' ? 0 : 1;
+}
+
 /* Adapted from libiberty's mkstemp.c. */
 
 #undef TMP_MAX
