From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 07/11] dir: add new_untracked_cache()
Date: Wed, 23 Dec 2015 22:03:55 +0100
Message-ID: <1450904639-25592-8-git-send-email-chriscool@tuxfamily.org>
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
	id 1aBqaa-0000CF-7E
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965478AbbLWVEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:04:48 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33694 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965452AbbLWVEk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:40 -0500
Received: by mail-wm0-f43.google.com with SMTP id p187so158637001wmp.0
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4SXQWBpRuqKUoGOYviEtL7GAgeLabZNY6UqX9xbieuU=;
        b=DPq+nB1Kj5pzFwYDJfpu4Q0awd71jc8oDpQC8xTevUACb1W8+HETace65SUVq9gE/G
         0tJNRE6Zl0eRKhfTQ8Ddy9RmzQG4aqCsAGf2nwzhioBKHEtZwzpMFFoPwmHnpxGjs9YM
         ttVPdDwklPfp6LSGVDD51flGy+/Z1HqGidJdxQctMSyrZsGiW33zXvI4FZtouF0Aicji
         v6gJ/18bFiD26SFbEw1x18Hp8tqyMZMj6BUFM/dDmLbxXxp8SUTLjrC7eOpQXgwVfUCK
         BYSbm/k5lN0/F3I654PCn54+hcPS0HlYeZ7PBZ0jEmZDusehp6qq8YZRuoGyF6tBkKod
         sPgg==
X-Received: by 10.28.6.201 with SMTP id 192mr22191376wmg.0.1450904679193;
        Wed, 23 Dec 2015 13:04:39 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:37 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
In-Reply-To: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282961>

    Factor out code into new_untracked_cache(), which will be used
    multiple times in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 dir.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index 0f7e293..4227ba6 100644
--- a/dir.c
+++ b/dir.c
@@ -1938,16 +1938,20 @@ void add_untracked_ident(struct untracked_cache *uc)
 	strbuf_addch(&uc->ident, 0);
 }
 
+static void new_untracked_cache(void)
+{
+	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
+	strbuf_init(&uc->ident, 100);
+	uc->exclude_per_dir = ".gitignore";
+	/* should be the same flags used by git-status */
+	uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	the_index.untracked = uc;
+}
+
 void add_untracked_cache(void)
 {
-	if (!the_index.untracked) {
-		struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
-		strbuf_init(&uc->ident, 100);
-		uc->exclude_per_dir = ".gitignore";
-		/* should be the same flags used by git-status */
-		uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-		the_index.untracked = uc;
-	}
+	if (!the_index.untracked)
+		new_untracked_cache();
 	add_untracked_ident(the_index.untracked);
 	the_index.cache_changed |= UNTRACKED_CHANGED;
 }
-- 
2.7.0.rc2.11.g68ccdd4
