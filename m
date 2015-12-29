From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 06/10] dir: add {new,add}_untracked_cache()
Date: Tue, 29 Dec 2015 08:09:30 +0100
Message-ID: <1451372974-16266-7-git-send-email-chriscool@tuxfamily.org>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:12:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoSl-0008Us-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbbL2HMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:12:50 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33000 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbbL2HMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:12:15 -0500
Received: by mail-wm0-f47.google.com with SMTP id f206so29379430wmf.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 23:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cx1sj/YwU9CV8PbMCs7twSC6fDZf0GfNGLvMhiZQezI=;
        b=CnP3gIpoX/IdFHppjwsNGEbOXC74+FrhB5kwu0HZq+ghlVTM2NdPNzzwTN8CC7MRIu
         79CYbU9bLklyO6SHF1ujcI4mGBrAQXjl+8rZ4RzoPCuMOdmLGXrZLXMoJ94fFD3csQyX
         lYfarfoLwgztzGcCEojRjye205olrRiid+qP4SWaVKi5m7rpCRfiDokQTUbJHsSWUifH
         nYJCww2C0GCDGdPeKLajDzDpLP50ZPHGP0HdXzyn8ElDODxels6+pd1CvZ5btvHTZn0t
         e1lO0hzisXqMO56qpVLHmOji0YoYk0+xSlQz8FQNDzZA9FC0KwhUe/uS3TfaUC/u2WWg
         MpjA==
X-Received: by 10.194.88.73 with SMTP id be9mr61392955wjb.44.1451373134332;
        Mon, 28 Dec 2015 23:12:14 -0800 (PST)
Received: from localhost.localdomain (243.40.126.78.rev.sfr.net. [78.126.40.243])
        by smtp.gmail.com with ESMTPSA id uw6sm59795661wjc.42.2015.12.28.23.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 23:12:13 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.10.g544ad6b
In-Reply-To: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283083>

Factor out code into new_untracked_cache() and
add_untracked_cache(), which will be used
in later commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 11 +----------
 dir.c                  | 18 ++++++++++++++++++
 dir.h                  |  1 +
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index fe7aaa3..74a6f8d 100644
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
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 	} else if (untracked_cache == UC_DISABLE) {
 		if (the_index.untracked) {
diff --git a/dir.c b/dir.c
index d2a8f06..4227ba6 100644
--- a/dir.c
+++ b/dir.c
@@ -1938,6 +1938,24 @@ void add_untracked_ident(struct untracked_cache *uc)
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
+void add_untracked_cache(void)
+{
+	if (!the_index.untracked)
+		new_untracked_cache();
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
2.7.0.rc2.10.g544ad6b
