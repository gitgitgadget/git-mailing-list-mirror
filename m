From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 10/10] dir: do not use untracked cache ident anymore
Date: Tue, 15 Dec 2015 17:28:27 +0100
Message-ID: <1450196907-17805-11-git-send-email-chriscool@tuxfamily.org>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 17:29:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sU5-00054n-DW
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933371AbbLOQ32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:29:28 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34801 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349AbbLOQ3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:29:22 -0500
Received: by mail-wm0-f42.google.com with SMTP id l126so1749603wml.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ifHqWglPAR9VSbJdc/ab2CdK5E9fvxAUFGkAPcqh9Vc=;
        b=ldHmKDhOZHZzhKwNQI38lKm6o+pHkBGzlX3/Oog6LUS4XeH4FbX+m+Bji/J6xY5xCU
         gQi70H3ckVNKMIBvRt54tTsncY7w+OKV/OLWhYakyJ2BQv4QzXrLtMx8dWWPjU5q5lUn
         fKG8D9P1pLEkw5EScGSz+42TO5vIckU4KBTmS4eMDSQP6b3sV8rVuOmO9olj9FzuvUhC
         IJlYO1NSLAFU7uKkDdKxtHef/N30bg7tLZNjbCftEsunI3saGgd2wzXW22t4BCfxQv3P
         hNVaDQKNv+oytesT48piOS4/E9PAY+osNSHeovcbusSzPtw/qCHKAFCvMEBrEp+AQNgD
         nq8A==
X-Received: by 10.28.85.70 with SMTP id j67mr6095232wmb.80.1450196961836;
        Tue, 15 Dec 2015 08:29:21 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s11sm3513817wmb.14.2015.12.15.08.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 08:29:21 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.479.g8eb29d4
In-Reply-To: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282491>

A previous commit disabled the check to see if the untracked cache
ident field was matching the current environment. So this field is
now useless and we can remove some related code.

We don't remove the ident field from "struct untracked_cache" as
it would break compatibility with old indexes that already have an
untracked cache with this field.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 dir.c | 38 +++++---------------------------------
 dir.h |  2 +-
 2 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/dir.c b/dir.c
index 0b07ba7..94fba2a 100644
--- a/dir.c
+++ b/dir.c
@@ -1904,36 +1904,13 @@ static int treat_leading_path(struct dir_struct *dir,
 	return rc;
 }
 
-static const char *get_ident_string(void)
-{
-	static struct strbuf sb = STRBUF_INIT;
-	struct utsname uts;
-
-	if (sb.len)
-		return sb.buf;
-	if (uname(&uts) < 0)
-		die_errno(_("failed to get kernel name and information"));
-	strbuf_addf(&sb, "Location %s, system %s %s %s", get_git_work_tree(),
-		    uts.sysname, uts.release, uts.version);
-	return sb.buf;
-}
-
-static int ident_in_untracked(const struct untracked_cache *uc)
-{
-	const char *end = uc->ident.buf + uc->ident.len;
-	const char *p   = uc->ident.buf;
-
-	for (p = uc->ident.buf; p < end; p += strlen(p) + 1)
-		if (!strcmp(p, get_ident_string()))
-			return 1;
-	return 0;
-}
-
+/*
+ * We used to save the location of the work tree and the kernel version,
+ * but it was not a good idea, so we now just save an empty string.
+ */
 void add_untracked_ident(struct untracked_cache *uc)
 {
-	if (ident_in_untracked(uc))
-		return;
-	strbuf_addstr(&uc->ident, get_ident_string());
+	strbuf_addstr(&uc->ident, "");
 	/* this strbuf contains a list of strings, save NUL too */
 	strbuf_addch(&uc->ident, 0);
 }
@@ -2015,11 +1992,6 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	if (dir->exclude_list_group[EXC_CMDL].nr)
 		return NULL;
 
-	if (use_untracked_cache != 1 && !ident_in_untracked(dir->untracked)) {
-		warning(_("Untracked cache is disabled on this system."));
-		return NULL;
-	}
-
 	if (!dir->untracked->root) {
 		const int len = sizeof(*dir->untracked->root);
 		dir->untracked->root = xmalloc(len);
diff --git a/dir.h b/dir.h
index 3e5114d..1935b76 100644
--- a/dir.h
+++ b/dir.h
@@ -127,7 +127,7 @@ struct untracked_cache {
 	struct sha1_stat ss_info_exclude;
 	struct sha1_stat ss_excludes_file;
 	const char *exclude_per_dir;
-	struct strbuf ident;
+	struct strbuf ident; /* unused now */
 	/*
 	 * dir_struct#flags must match dir_flags or the untracked
 	 * cache is ignored.
-- 
2.6.3.479.g8eb29d4
