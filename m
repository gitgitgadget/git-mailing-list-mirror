From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 08/11] dir: add remove_untracked_cache()
Date: Wed, 23 Dec 2015 22:03:56 +0100
Message-ID: <1450904639-25592-9-git-send-email-chriscool@tuxfamily.org>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 22:05:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBqai-0000Re-JV
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbbLWVE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:04:56 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37105 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965435AbbLWVEo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:44 -0500
Received: by mail-wm0-f52.google.com with SMTP id p187so162734151wmp.0
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AhPstk0O36AA8sejvJzc0WCEiTNpvS+PyWDQtufK2MQ=;
        b=vjN1+Qii5Mnf/gQWVur+E3K9gpx6tumF5eIKVE4GXUvaJahQNDwoDKj/5CSZ/CLLO6
         rl99Xu+OZ2yaUwpLBqjXo4y8kAztTkES7+kRlFp18qqp0GKtG9oeRPw01/LS2TQcZSob
         GHJloBn2od1zY6hcPgFRGMIUieFdegMp94mjJR+qw+xJ2pI6FbBHve5NVkxQYL7H+lE9
         n+wyFPPCmrCbjbgQgREf9NTJbck7EzYYd3gnHuAQwM5xDIOv7pT02ukcqsA3zfvTD8GI
         icZ+801GYlbdcTC965Eq9N9Hb+J9UtsvuNNgvZRn3IeFDKWTr1AFd6Ne+UIeEHsjz92I
         guRA==
X-Received: by 10.28.72.2 with SMTP id v2mr37466441wma.84.1450904681565;
        Wed, 23 Dec 2015 13:04:41 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:40 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
In-Reply-To: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282963>

Factor out code into remove_untracked_cache(), which will be used
in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 6 +-----
 dir.c                  | 9 +++++++++
 dir.h                  | 1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 093725a..3e5b4a6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1127,11 +1127,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (verbose)
 			printf(_("Untracked cache enabled for '%s'\n"), get_git_work_tree());
 	} else if (untracked_cache == UC_DISABLE) {
-		if (the_index.untracked) {
-			free_untracked_cache(the_index.untracked);
-			the_index.untracked = NULL;
-			the_index.cache_changed |= UNTRACKED_CHANGED;
-		}
+		remove_untracked_cache();
 		if (verbose)
 			printf(_("Untracked cache disabled\n"));
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
2.7.0.rc2.11.g68ccdd4
