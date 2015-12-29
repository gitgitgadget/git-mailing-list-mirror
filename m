From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 07/10] dir: add remove_untracked_cache()
Date: Tue, 29 Dec 2015 08:09:31 +0100
Message-ID: <1451372974-16266-8-git-send-email-chriscool@tuxfamily.org>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:13:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoSm-0008Us-F3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbbL2HMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:12:51 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36562 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbbL2HMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:12:18 -0500
Received: by mail-wm0-f50.google.com with SMTP id l65so24574244wmf.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 23:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6jKWAFNP6whlkIK/IWQy4dY312u31zhg9GX9Rhx6puo=;
        b=oZERf6ybCRB8OHTcrUk7Ty6MXVO1NELirmtXJCJLkm9LFpaGj2NASGm8nqfNENLiAL
         sh8RGWDFAwHsmud9L2KBytnLo+WSn0GC5p6b98n0GcgmJ4Iuzg2/AiNV5AxvOQt1hB4M
         vtdHeIpUj9D1GDEEIzwZW6xIXLv0/DoXTPsNTGDf0/Ipwkv+ejrQRaedXirOwUW8UqJp
         aIGvJgZ8m3A2jL8tki8PxIYotgGKpBh6RPyW4HQz0m63T+HsAoOP6ex2M4z9v7mLf1JT
         7OA1zGM7jDEOLODwlzWBPVPuHqJr0W+UrTHffu/w/YuqulztDdc/irNoi+bUI4+S1/By
         kaXw==
X-Received: by 10.28.146.145 with SMTP id u139mr1311991wmd.81.1451373136957;
        Mon, 28 Dec 2015 23:12:16 -0800 (PST)
Received: from localhost.localdomain (243.40.126.78.rev.sfr.net. [78.126.40.243])
        by smtp.gmail.com with ESMTPSA id uw6sm59795661wjc.42.2015.12.28.23.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 23:12:15 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.10.g544ad6b
In-Reply-To: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283088>

Factor out code into remove_untracked_cache(), which will be used
in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 6 +-----
 dir.c                  | 9 +++++++++
 dir.h                  | 1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 74a6f8d..7844991 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1126,11 +1126,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_cache();
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 	} else if (untracked_cache == UC_DISABLE) {
-		if (the_index.untracked) {
-			free_untracked_cache(the_index.untracked);
-			the_index.untracked = NULL;
-			the_index.cache_changed |= UNTRACKED_CHANGED;
-		}
+		remove_untracked_cache();
 		report(_("Untracked cache disabled"));
 	}
 
diff --git a/dir.c b/dir.c
index 4227ba6..dba1ad0 100644
--- a/dir.c
+++ b/dir.c
@@ -1956,6 +1956,15 @@ void add_untracked_cache(void)
 	the_index.cache_changed |= UNTRACKED_CHANGED;
 }
 
+void remove_untracked_cache(void)
+{
+	if (the_index.untracked) {
+		free_untracked_cache(the_index.untracked);
+		the_index.untracked = NULL;
+		the_index.cache_changed |= UNTRACKED_CHANGED;
+	}
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
diff --git a/dir.h b/dir.h
index ee94c76..3e5114d 100644
--- a/dir.h
+++ b/dir.h
@@ -309,4 +309,5 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_ident(struct untracked_cache *);
 void add_untracked_cache(void);
+void remove_untracked_cache(void);
 #endif
-- 
2.7.0.rc2.10.g544ad6b
