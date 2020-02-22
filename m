Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E03C35673
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD93206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AMP+vXyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgBVUSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:09 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39082 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgBVUSJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4B3F26079B
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402688;
        bh=kllEanv5O3VvTHJIW4hRVKZyv8UnIINCYFUGsRnnx/0=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=AMP+vXyFEc05WNszR26CfDX/71xPFVeoZCTyT2IxWk2Ux2lYhUrAgfQZQ7m6/K5L4
         SJ87fJE3SXKTLVAKyu5AA586FLtDt9EwzXr4Iw1d0wnWw33WQdSLTROhWhKiYzcKwd
         WJHZmXFACN+zwH9/+7PqRzPGdOgm76ynFJt78YIlDJXzLLNJRgmnbvbfs8W6Ia6C9i
         cm0dktQTZSxim366jGHKwV/Pc2th+IdaiMlvIBsvxSClqiHW0TDDFJnNoO/YRuU/dL
         33rKHIOvMYjclylAkAyU3hRVgW2ONdrDWA8UqRldAnlR7N+ZXNDWNjkLjBgLJFr6qf
         ZFU1JFGY37VW01RLMJFrMmw2BLQuBVEvIex5OjfDhtx2sEw9twTn0t44vekgkhlZ2d
         BzFk9hyN0M3WYn42b2UeMYvvKe7y0dQHN9PczsMxbRde6MewR+bFAmyLmc2sYR+o7a
         1uSqOdOW0XHPi0LdAF7sj3G1KaEiz4ROw/Vfdl9hRevImf1H5Xd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 12/24] setup: allow check_repository_format to read repository format
Date:   Sat, 22 Feb 2020 20:17:37 +0000
Message-Id: <20200222201749.937983-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
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
index 158d7ccfd8..29ee02a8d4 100644
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
index 88cf593007..a10b62c0c4 100644
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
index 4ea7a0b081..af20c3d7c0 100644
--- a/setup.c
+++ b/setup.c
@@ -1253,10 +1253,12 @@ int git_config_perm(const char *var, const char *value)
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
