From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/20] untracked cache: don't open non-existent .gitignore
Date: Wed,  7 May 2014 21:51:50 +0700
Message-ID: <1399474320-6840-11-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3DS-0005yG-0s
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbaEGOw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:52:58 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:49494 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbaEGOw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:57 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so1149961pdj.38
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dp8ijSmahf46/Q4anWj00QFnDTp3tK1R+mf7dO5qtxI=;
        b=rDAyKVSx67BkhJJUDwdsU/mdoYEVzkfqCml7+UaTA+zHarVObliA7GeSp2aoWxW9Tl
         gxpgXJlw/ZZ4q9he+EMwab7d/J1cuRPo9UkCfLXpLs/Tur0DEUAgL/9jGRafBPZK92gj
         bFQNGQn1Zp8ePTQn/ZG7FChEcifvRvbA2xtCbsJU+9jdo+MNJqtJX9NA7oWF6dUEOWR6
         O2xpwF9xWkvmS9McNgr7pHMstcb/1KZvF3Yz29BpDSeN2jXirjZAd6q5xQHXxKAooihs
         6DQ7Cj96et55p/hcp5DaUMYU2dSabRRuSGxGZzugYfyDxJA3q3vuSPkSHwmdw/tRWBG1
         jASA==
X-Received: by 10.66.140.6 with SMTP id rc6mr19623510pab.87.1399474376920;
        Wed, 07 May 2014 07:52:56 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id io6sm8506040pac.44.2014.05.07.07.52.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:57 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248316>

This cuts down a signficant number of open(.gitignore) because most
directories usually don't have .gitignore files.
---
 dir.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 63fa960..b5bfda8 100644
--- a/dir.c
+++ b/dir.c
@@ -1021,7 +1021,21 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 
 		/* Try to read per-directory file */
 		hashclr(sha1);
-		if (dir->exclude_per_dir) {
+		if (dir->exclude_per_dir &&
+		    /*
+		     * If we know that no files have been added in
+		     * this directory (i.e. valid_cached_dir() has
+		     * been executed and set untracked->valid) ..
+		     */
+		    (!untracked || !untracked->valid ||
+		     /*
+		      * .. and .gitignore does not exist before
+		      * (i.e. null exclude_sha1 and skip_worktree is
+		      * not set). Then we can skip loading .gitignore,
+		      * which would result in ENOENT anyway.
+		      * skip_worktree is taken care in read_directory()
+		      */
+		     !is_null_sha1(untracked->exclude_sha1))) {
 			/*
 			 * dir->basebuf gets reused by the traversal, but we
 			 * need fname to remain unchanged to ensure the src
@@ -1788,6 +1802,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 						      const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *root;
+	int i;
 
 	if (!dir->untracked)
 		return NULL;
@@ -1839,6 +1854,15 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	if (dir->exclude_list_group[EXC_CMDL].nr)
 		return NULL;
 
+	/*
+	 * An optimization in prep_exclude() does not play well with
+	 * CE_SKIP_WORKTREE. It's a rare case anyway, if a single
+	 * entry has that bit set, disable the whole untracked cache.
+	 */
+	for (i = 0; i < active_nr; i++)
+		if (ce_skip_worktree(active_cache[i]))
+			return NULL;
+
 	if (!dir->untracked->root) {
 		const int len = sizeof(*dir->untracked->root);
 		dir->untracked->root = xmalloc(len);
-- 
1.9.1.346.ga2b5940
