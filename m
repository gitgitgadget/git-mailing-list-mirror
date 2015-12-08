From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 6/8] dir: add remove_untracked_cache()
Date: Tue,  8 Dec 2015 18:15:14 +0100
Message-ID: <1449594916-21167-7-git-send-email-chriscool@tuxfamily.org>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 18:16:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6LsM-0007P0-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbbLHRPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 12:15:51 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35519 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbLHRPu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:15:50 -0500
Received: by wmuu63 with SMTP id u63so189555679wmu.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 09:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eZthddMaZm5mz/I4H67BSNTSBzJPkhsonyT0eKjb6nI=;
        b=Kcp2K5IELw29bb6+Bpuxc8T9+xCFSKvkYsMg6SeXIxcoS7ZaFojOIv98nEej7bquLa
         OX9nK4DNUC/F9fvmGhg06dZjNgSHmbWaLszvf+kSp+pzRG8bD1rbBow6FyfJUcjD1Ddw
         zNVY4yCw1ohJHJJpECCNDy+iL8xLraAC/ld7r4krOYhOn4oDJ6ocU3qruH7+rniNdByx
         MfvIaTuEq9BZwIdXl76H3U1P8XCGDtSDmsB+SmgSBCDQRpkMWImQI7Jy5flgYProZFpJ
         tPDJo7bSNE7SHK2kM2smBm+zZ6yqeRvVmT/3Z8GU6PLceUQimCyJgUb9mU1gb2ut7aWp
         //5w==
X-Received: by 10.28.174.130 with SMTP id x124mr6108349wme.2.1449594949098;
        Tue, 08 Dec 2015 09:15:49 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 200sm4332517wmn.11.2015.12.08.09.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 09:15:48 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.478.g9f95483.dirty
In-Reply-To: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282165>

This new function will be used in a later patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 3 +--
 dir.c                  | 6 ++++++
 dir.h                  | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 40530b0..e427657 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1126,8 +1126,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_cache();
 		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
 	} else if (untracked_cache == NO_UC && the_index.untracked) {
-		the_index.untracked = NULL;
-		the_index.cache_changed |= UNTRACKED_CHANGED;
+		remove_untracked_cache();
 		fprintf(stderr, _("Untracked cache disabled\n"));
 	}
 
diff --git a/dir.c b/dir.c
index 0f7e293..ffc0286 100644
--- a/dir.c
+++ b/dir.c
@@ -1952,6 +1952,12 @@ void add_untracked_cache(void)
 	the_index.cache_changed |= UNTRACKED_CHANGED;
 }
 
+void remove_untracked_cache(void)
+{
+	the_index.untracked = NULL;
+	the_index.cache_changed |= UNTRACKED_CHANGED;
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
2.6.3.478.g9f95483.dirty
