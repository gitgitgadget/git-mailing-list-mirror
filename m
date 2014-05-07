From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/20] prep_exclude: remove the artificial PATH_MAX limit
Date: Wed,  7 May 2014 21:51:43 +0700
Message-ID: <1399474320-6840-4-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:52:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Ct-0005bD-2H
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbaEGOwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:52:19 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:57278 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaEGOwS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:18 -0400
Received: by mail-pd0-f173.google.com with SMTP id y10so1168349pdj.18
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sEqvBzlTMGsM2c2oglpzXURzDbk6h8vjId3aNBi5dok=;
        b=Znl0l87zqk3oRE9X24+VWk0zhlAUMxEDBjE0/n3nvRiWy++37XG7f5/Vz8qi0WBb0A
         NqDt1JFMoATlzQBOFZkHpMVBjf1JP8y1RSw4GXyAkv75w7CejNsR1kvqsyT2zUOqdx2Y
         bKph0vTMw1KUs7dIpmHjZwMN+ZZXYgg9JQHBlNHHXqe1D+TlRswq/vXlGA/xUNVU/XjS
         Jf2N/T6T3YfUlPrULvvZifLUAgCjCiPjaqRVcalpG+4t7VQ+Sl+aWd/JKd+CYM0jdNd5
         BR9bjGjpnDgs93DCBRe1haL0sOscuMyWrssLsTeGg1JtTKtOenCD5r8YyX2PGgBHiQu8
         Ediw==
X-Received: by 10.66.192.225 with SMTP id hj1mr19848408pac.142.1399474337467;
        Wed, 07 May 2014 07:52:17 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id kl1sm3630108pbd.73.2014.05.07.07.52.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:17 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248310>

This also fixes the problem of silently ignoring .gitignore if the
full path exceeds PATH_MAX. Now add_excludes_from_file() will report
if it gets ENAMETOOLONG.
---
 dir.c | 47 ++++++++++++++++++++++++++++-------------------
 dir.h |  2 +-
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/dir.c b/dir.c
index 7a83f70..c081754 100644
--- a/dir.c
+++ b/dir.c
@@ -795,12 +795,12 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	 */
 	while ((stk = dir->exclude_stack) != NULL) {
 		if (stk->baselen <= baselen &&
-		    !strncmp(dir->basebuf, base, stk->baselen))
+		    !strncmp(dir->basebuf.buf, base, stk->baselen))
 			break;
 		el = &group->el[dir->exclude_stack->exclude_ix];
 		dir->exclude_stack = stk->prev;
 		dir->exclude = NULL;
-		free((char *)el->src); /* see strdup() below */
+		free((char *)el->src); /* see strbuf_detach() below */
 		clear_exclude_list(el);
 		free(stk);
 		group->nr--;
@@ -810,8 +810,17 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	if (dir->exclude)
 		return;
 
+	/*
+	 * Lazy initialization. All call sites currently just
+	 * memset(dir, 0, sizeof(*dir)) before use. Changing all of
+	 * them seems lots of work for little benefit.
+	 */
+	if (!dir->basebuf.alloc)
+		strbuf_init(&dir->basebuf, PATH_MAX);
+
 	/* Read from the parent directories and push them down. */
 	current = stk ? stk->baselen : -1;
+	strbuf_setlen(&dir->basebuf, current < 0 ? 0 : current);
 	while (current < baselen) {
 		struct exclude_stack *stk = xcalloc(1, sizeof(*stk));
 		const char *cp;
@@ -829,48 +838,47 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		stk->baselen = cp - base;
 		stk->exclude_ix = group->nr;
 		el = add_exclude_list(dir, EXC_DIRS, NULL);
-		memcpy(dir->basebuf + current, base + current,
-		       stk->baselen - current);
+		strbuf_add(&dir->basebuf, base + current, stk->baselen - current);
+		assert(stk->baselen == dir->basebuf.len);
 
 		/* Abort if the directory is excluded */
 		if (stk->baselen) {
 			int dt = DT_DIR;
-			dir->basebuf[stk->baselen - 1] = 0;
+			dir->basebuf.buf[stk->baselen - 1] = 0;
 			dir->exclude = last_exclude_matching_from_lists(dir,
-				dir->basebuf, stk->baselen - 1,
-				dir->basebuf + current, &dt);
-			dir->basebuf[stk->baselen - 1] = '/';
+				dir->basebuf.buf, stk->baselen - 1,
+				dir->basebuf.buf + current, &dt);
+			dir->basebuf.buf[stk->baselen - 1] = '/';
 			if (dir->exclude &&
 			    dir->exclude->flags & EXC_FLAG_NEGATIVE)
 				dir->exclude = NULL;
 			if (dir->exclude) {
-				dir->basebuf[stk->baselen] = 0;
 				dir->exclude_stack = stk;
 				return;
 			}
 		}
 
-		/* Try to read per-directory file unless path is too long */
-		if (dir->exclude_per_dir &&
-		    stk->baselen + strlen(dir->exclude_per_dir) < PATH_MAX) {
-			strcpy(dir->basebuf + stk->baselen,
-					dir->exclude_per_dir);
+		/* Try to read per-directory file */
+		if (dir->exclude_per_dir) {
 			/*
 			 * dir->basebuf gets reused by the traversal, but we
 			 * need fname to remain unchanged to ensure the src
 			 * member of each struct exclude correctly
 			 * back-references its source file.  Other invocations
 			 * of add_exclude_list provide stable strings, so we
-			 * strdup() and free() here in the caller.
+			 * strbuf_detach() and free() here in the caller.
 			 */
-			el->src = strdup(dir->basebuf);
-			add_excludes_from_file_to_list(dir->basebuf,
-					dir->basebuf, stk->baselen, el, 1);
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addbuf(&sb, &dir->basebuf);
+			strbuf_addstr(&sb, dir->exclude_per_dir);
+			el->src = strbuf_detach(&sb, NULL);
+			add_excludes_from_file_to_list(el->src, el->src,
+						       stk->baselen, el, 1);
 		}
 		dir->exclude_stack = stk;
 		current = stk->baselen;
 	}
-	dir->basebuf[baselen] = '\0';
+	strbuf_setlen(&dir->basebuf, baselen);
 }
 
 /*
@@ -1668,4 +1676,5 @@ void clear_directory(struct dir_struct *dir)
 		free(stk);
 		stk = prev;
 	}
+	strbuf_release(&dir->basebuf);
 }
diff --git a/dir.h b/dir.h
index 02e3710..6c45e9d 100644
--- a/dir.h
+++ b/dir.h
@@ -119,7 +119,7 @@ struct dir_struct {
 	 */
 	struct exclude_stack *exclude_stack;
 	struct exclude *exclude;
-	char basebuf[PATH_MAX];
+	struct strbuf basebuf;
 };
 
 /*
-- 
1.9.1.346.ga2b5940
