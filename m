From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 06/11] dir: add add_untracked_cache()
Date: Wed, 23 Dec 2015 22:03:54 +0100
Message-ID: <1450904639-25592-7-git-send-email-chriscool@tuxfamily.org>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 22:04:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBqaZ-0000CF-JI
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965477AbbLWVEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:04:46 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35834 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965405AbbLWVEh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:37 -0500
Received: by mail-wm0-f54.google.com with SMTP id l126so161974660wml.0
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y0oO5p/YeD9fpeE5BZh5iXGxYqnqU6VyJy1sx9A9iQA=;
        b=Slfxfb0gvLjQI2QqKOo9ywJ0C/Ks7YmWlMpuvI/lDgJZa8ozjcXsWBgkD4o6Djhxha
         eKwxAzfDVwMYJxo0zeCdeyPQyN2IUYCpGSfpOBowJw5yFlEh0B8JUaCtALEuGrTuO9cF
         0JeQQcT96A9VnNRAav6bC4/1q4peKNicNUN6Kcl1rThYkpwwyXJjzM8W1NKIph7zM0tt
         I1u30pgD7kX5EwJplnRqspJUyCMHRhg/rxu040skAi8l6AIX4UJWdHxrnKZVeOpNQm35
         8eKbILdQsv6JKny+bCFIDzITKJMLGA2RzXsT7BOkNX6NCcNjOLkacn/hOM1SkXSfH4CP
         fLow==
X-Received: by 10.194.88.130 with SMTP id bg2mr35451820wjb.162.1450904676509;
        Wed, 23 Dec 2015 13:04:36 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:35 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
In-Reply-To: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282962>

Factor out code into add_untracked_cache(), which will be used
in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 11 +----------
 dir.c                  | 14 ++++++++++++++
 dir.h                  |  1 +
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index f667125..093725a 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1123,16 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			if (untracked_cache == UC_TEST)
 				return 0;
 		}
-		if (!the_index.untracked) {
-			struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
-			strbuf_init(&uc->ident, 100);
-			uc->exclude_per_dir = ".gitignore";
-			/* should be the same flags used by git-status */
-			uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-			the_index.untracked = uc;
-		}
-		add_untracked_ident(the_index.untracked);
-		the_index.cache_changed |= UNTRACKED_CHANGED;
+		add_untracked_cache();
 		if (verbose)
 			printf(_("Untracked cache enabled for '%s'\n"), get_git_work_tree());
 	} else if (untracked_cache == UC_DISABLE) {
diff --git a/dir.c b/dir.c
index d2a8f06..0f7e293 100644
--- a/dir.c
+++ b/dir.c
@@ -1938,6 +1938,20 @@ void add_untracked_ident(struct untracked_cache *uc)
 	strbuf_addch(&uc->ident, 0);
 }
 
+void add_untracked_cache(void)
+{
+	if (!the_index.untracked) {
+		struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
+		strbuf_init(&uc->ident, 100);
+		uc->exclude_per_dir = ".gitignore";
+		/* should be the same flags used by git-status */
+		uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+		the_index.untracked = uc;
+	}
+	add_untracked_ident(the_index.untracked);
+	the_index.cache_changed |= UNTRACKED_CHANGED;
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
diff --git a/dir.h b/dir.h
index 7b5855d..ee94c76 100644
--- a/dir.h
+++ b/dir.h
@@ -308,4 +308,5 @@ void free_untracked_cache(struct untracked_cache *);
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_ident(struct untracked_cache *);
+void add_untracked_cache(void);
 #endif
-- 
2.7.0.rc2.11.g68ccdd4
