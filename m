Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC37C33CAF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415FB207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="i64hF71S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAMMsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37782 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbgAMMsC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:02 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 83927607F9
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919681;
        bh=6Dh6wdSKE7yP2t3z7OZWRVcFisna2BjaTUVFyEnqF9g=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=i64hF71S6Yzwq45Jo9f/z00XE4qVqCn3ziVuQgSpn5EnubBTfDv2xY8N0PZSnsae8
         4Aou8hfLzkEIPqEz9ZwFPvozk92juUT6+4NtuCI2+b9gr/COB1PWZeec3tg5uqunUu
         NptjuZUlWFuURJqUbEQHXGml7R2YIxabE3bdujgdPyhKF0PIvqYHk5DvlswdKwJEZH
         20XwMR/xuqIcclevV7yQQTYdE5TYPgxgBcj1pDRUblGOqFEcJBf+CVNX4skKQR5Sr4
         z5SjOYMMv+6XLpchWf0r6y4hI5Y9M2cpXYD/kp3mkvzQVdDcDbhtStfzUkrjoxMloy
         kb3x9gjopO1/h/+Gd8twVo0Aut4eYID1FcjKHeZPRgKAmnmYZZGT4UvKpQOUOKrKuU
         8cULjLvcC58yWsIGTgt+MjGalpiiSxW/q3a19WIkEOSsX3+dbFmMaYIef49xCTNtXt
         nSFPR9224vEcVLKo+qSFzXoCXrrmKhhJ1oHjgA+L9riWJeMNlra
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 10/22] setup: allow check_repository_format to read repository format
Date:   Mon, 13 Jan 2020 12:47:17 +0000
Message-Id: <20200113124729.3684846-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases, we will want to not only check the repository format, but
extract the information that we've gained.  To do so, allow
check_repository_format to take a pointer to struct repository_format.
Allow passing NULL for this argument if we're not interested in the
information, and pass NULL for all existing callers.  A future patch
will make use of this information.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/init-db.c | 2 +-
 cache.h           | 4 +++-
 path.c            | 2 +-
 setup.c           | 6 ++++--
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 944ec77fe1..b11f07064d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -378,7 +378,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format();
+	check_repository_format(NULL);
 
 	reinit = create_default_files(template_dir, original_git_dir);
 
diff --git a/cache.h b/cache.h
index 6c094c3210..75f95f6f10 100644
--- a/cache.h
+++ b/cache.h
@@ -1086,8 +1086,10 @@ int verify_repository_format(const struct repository_format *format,
  * and die if it is a version we don't understand. Generally one would
  * set_git_dir() before calling this, and use it only for "are we in a valid
  * repo?".
+ *
+ * If successful and fmt is not NULL, fill fmt with data.
  */
-void check_repository_format(void);
+void check_repository_format(struct repository_format *fmt);
 
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
diff --git a/path.c b/path.c
index a76eec8b96..18d96c8760 100644
--- a/path.c
+++ b/path.c
@@ -851,7 +851,7 @@ const char *enter_repo(const char *path, int strict)
 
 	if (is_git_directory(".")) {
 		set_git_dir(".");
-		check_repository_format();
+		check_repository_format(NULL);
 		return path;
 	}
 
diff --git a/setup.c b/setup.c
index e2a479a64f..57c3e98d7b 100644
--- a/setup.c
+++ b/setup.c
@@ -1235,10 +1235,12 @@ int git_config_perm(const char *var, const char *value)
 	return -(i & 0666);
 }
 
-void check_repository_format(void)
+void check_repository_format(struct repository_format *fmt)
 {
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	check_repository_format_gently(get_git_dir(), &repo_fmt, NULL);
+	if (!fmt)
+		fmt = &repo_fmt;
+	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
 	clear_repository_format(&repo_fmt);
 }
