From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 05/10] dir: add add_untracked_cache()
Date: Tue, 15 Dec 2015 17:28:22 +0100
Message-ID: <1450196907-17805-6-git-send-email-chriscool@tuxfamily.org>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 17:29:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sTT-00041v-Ki
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbbLOQ3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:29:11 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34414 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbbLOQ3I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:29:08 -0500
Received: by mail-wm0-f41.google.com with SMTP id l126so1737770wml.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tevm32ir33rlebtaJ4FIzfUElTixfaUZmjz+L3kxGNQ=;
        b=oB5hadtZIklEcJVAesyXuWPUO6l9vkvrww3bFIns5Rx0XTi0KEmYsO6VRhM4qNk6v5
         bCOFDMG+Jdf3FRkIzujFzImnZt9LCG0TIo/ZUpKW8f9LvpvWzJdro3FZNAL3LD1yMryN
         5b0QWP80aqO8PZDOYqz8/s/VtLgq/oceniu/D0AZn1rMHKk4R22dPG1ZpwJZntf7jz4c
         vMHTKlfOgW+eJMIiwI3EnIAyrJ/3krmgyOxWh1/R7GDu4IoMeKGPW6MXFAo6TC5hfJKL
         faa84Iu48GQQ5mIPPgEBKlNo01pE5pQ3tVdkrYU6ymTRHpCmxWEz8nXkY6crp7uW4cSB
         aGEw==
X-Received: by 10.28.85.70 with SMTP id j67mr6093788wmb.80.1450196947518;
        Tue, 15 Dec 2015 08:29:07 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s11sm3513817wmb.14.2015.12.15.08.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 08:29:06 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.479.g8eb29d4
In-Reply-To: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282485>

Factor out code into add_untracked_cache(), which will be used
in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 11 +----------
 dir.c                  | 14 ++++++++++++++
 dir.h                  |  1 +
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index fffad79..5f009cf 100644
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
 			printf(_("Untracked cache enabled\n"));
 	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
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
2.6.3.479.g8eb29d4
