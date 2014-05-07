From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/20] untracked cache: avoid racy timestamps
Date: Wed,  7 May 2014 21:51:56 +0700
Message-ID: <1399474320-6840-17-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Dz-0006HP-70
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868AbaEGOxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:53:33 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:65533 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863AbaEGOx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:53:29 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so1301811pab.29
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ovvlJgSHUzPRCWihlF0RkEVeZSc1FgLgWWo7mcifoMA=;
        b=Lw/ZvN+efRmlrb9wdljZ58DO6RJaEoBFu2Fx2wItyCdWjlKrt1U6IDDVUyFBDTCaAY
         oDIfCLMlc+AkYDtVZnaS5dKUO0Jd2kSOwU8KxAswMkpjNwG2rR9Xi3Gp9p7lYdgDtvO7
         5HudkHw3jZkaZ4QkFWyIyr6JNx2+56hYTlhZlLs21+D7yyFeo7bLno80MU59kOCBiz47
         32HJ8M5yW3jmO85O23i7y2Yu6tLyGK/0nA0+GftFWvN4RNKSmnGCMpiFJ7Fj+AInRcZl
         yrMNBj0WENOnaxAfLijIn6iQxZYuAdCyaf6mweB65B1Lunmf44EEwYC478HIKmIHKt6U
         bH5w==
X-Received: by 10.66.141.109 with SMTP id rn13mr20011708pab.117.1399474409137;
        Wed, 07 May 2014 07:53:29 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id mt1sm3658350pbb.31.2014.05.07.07.53.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:53:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:53:29 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248322>

When a directory is updated within the same second that its timestamp
is last saved, we cannot realize the directory has been updated by
checking timestamps. Assume the worst (something is update). See
29e4d36 (Racy GIT - 2005-12-20) for more information.
---
 cache.h      | 2 ++
 dir.c        | 6 ++++--
 read-cache.c | 8 ++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 06fcb6b..98c22c4 100644
--- a/cache.h
+++ b/cache.h
@@ -525,6 +525,8 @@ extern void fill_stat_data(struct stat_data *sd, struct stat *st);
  * INODE_CHANGED, and DATA_CHANGED.
  */
 extern int match_stat_data(const struct stat_data *sd, struct stat *st);
+extern int match_stat_data_racy(const struct index_state *istate,
+				const struct stat_data *sd, struct stat *st);
 
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
diff --git a/dir.c b/dir.c
index 58303ca..24ccd22 100644
--- a/dir.c
+++ b/dir.c
@@ -677,7 +677,9 @@ static int add_excludes(const char *fname,
 			    !ce_stage(active_cache[pos]) &&
 			    ce_uptodate(active_cache[pos]))
 				hashcpy(sha1, active_cache[pos]->sha1);
-			else if (ref_stat && !match_stat_data(ref_stat, &st)) {
+			else if (ref_stat &&
+				 !match_stat_data_racy(&the_index,
+						       ref_stat, &st)) {
 				if (ref_sha1 != sha1) /* support ref_sha1 == sha1 */
 					hashcpy(sha1, ref_sha1);
 			} else
@@ -1543,7 +1545,7 @@ static int valid_cached_dir(struct dir_struct *dir,
 		return 0;
 	}
 	if (!untracked->valid ||
-	    match_stat_data(&untracked->stat_data, &st)) {
+	    match_stat_data_racy(&the_index, &untracked->stat_data, &st)) {
 		if (untracked->valid)
 			invalidate_directory(dir->untracked, untracked);
 		fill_stat_data(&untracked->stat_data, &st);
diff --git a/read-cache.c b/read-cache.c
index 72adcd6..823db9b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -280,6 +280,14 @@ static int is_racy_timestamp(const struct index_state *istate,
 		is_racy_stat(istate, &ce->ce_stat_data));
 }
 
+int match_stat_data_racy(const struct index_state *istate,
+			 const struct stat_data *sd, struct stat *st)
+{
+	if (is_racy_stat(istate, sd))
+		return MTIME_CHANGED;
+	return match_stat_data(sd, st);
+}
+
 int ie_match_stat(const struct index_state *istate,
 		  const struct cache_entry *ce, struct stat *st,
 		  unsigned int options)
-- 
1.9.1.346.ga2b5940
