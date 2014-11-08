From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/22] untracked cache: avoid racy timestamps
Date: Sat,  8 Nov 2014 16:39:46 +0700
Message-ID: <1415439595-469-14-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:41:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2WK-0001ba-2g
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbaKHJlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:41:07 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:49454 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbaKHJlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:41:06 -0500
Received: by mail-pd0-f175.google.com with SMTP id y13so4810926pdi.20
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eMd8HprM7ugNudwEfx4Y2pg0de5J9ybz8k5IMiGgbzk=;
        b=n+gy5EhIcIGibrjtIqu/gkHFw3nvije1LlS5t53biM4jLTwqT8q8tish6CBkjU/OaA
         yYNlJyI9R+NO3sN4N8yOSsUbenC0naYLsJrAQJZBsVhHRPt0TuQNFeO7OLmeR4jQqWAZ
         uCkssC2oJ6nr5PweEjvnwEooBk8kUv0fg7oWxAYEsdi/bJv/oy5ItJce7MxWJ2m/LPtf
         i6HmsWhDlukeCi5TWkeKGt8KrhNX05hUE4I/Kmp+dNAEWdnKJhsPM2+lpyFOyYgmZPfA
         j4E6Kxf5yiKna4+FMjsFrFRjRzBY/IDeZrLlyQHeg1+Ln1yseWZfrf2zx7fAtCkXkG3W
         zhFQ==
X-Received: by 10.68.90.34 with SMTP id bt2mr18117820pbb.29.1415439656005;
        Sat, 08 Nov 2014 01:40:56 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id ev8sm11041820pdb.28.2014.11.08.01.40.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:40:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:41:10 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a directory is updated within the same second that its timestamp
is last saved, we cannot realize the directory has been updated by
checking timestamps. Assume the worst (something is update). See
29e4d36 (Racy GIT - 2005-12-20) for more information.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      | 2 ++
 dir.c        | 4 ++--
 read-cache.c | 8 ++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index b14d6e2..f8b3dc5 100644
--- a/cache.h
+++ b/cache.h
@@ -561,6 +561,8 @@ extern void fill_stat_data(struct stat_data *sd, st=
ruct stat *st);
  * INODE_CHANGED, and DATA_CHANGED.
  */
 extern int match_stat_data(const struct stat_data *sd, struct stat *st=
);
+extern int match_stat_data_racy(const struct index_state *istate,
+				const struct stat_data *sd, struct stat *st);
=20
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *=
st);
=20
diff --git a/dir.c b/dir.c
index b3ba278..52daaf7 100644
--- a/dir.c
+++ b/dir.c
@@ -680,7 +680,7 @@ static int add_excludes(const char *fname, const ch=
ar *base, int baselen,
 		if (sha1_stat) {
 			int pos;
 			if (sha1_stat->valid &&
-			    !match_stat_data(&sha1_stat->stat, &st))
+			    !match_stat_data_racy(&the_index, &sha1_stat->stat, &st))
 				; /* no content change, ss->sha1 still good */
 			else if (check_index &&
 				 (pos =3D cache_name_pos(fname, strlen(fname))) >=3D 0 &&
@@ -1536,7 +1536,7 @@ static int valid_cached_dir(struct dir_struct *di=
r,
 		return 0;
 	}
 	if (!untracked->valid ||
-	    match_stat_data(&untracked->stat_data, &st)) {
+	    match_stat_data_racy(&the_index, &untracked->stat_data, &st)) {
 		if (untracked->valid)
 			invalidate_directory(dir->untracked, untracked);
 		fill_stat_data(&untracked->stat_data, &st);
diff --git a/read-cache.c b/read-cache.c
index 794176f..103c294 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -292,6 +292,14 @@ static int is_racy_timestamp(const struct index_st=
ate *istate,
 		is_racy_stat(istate, &ce->ce_stat_data));
 }
=20
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
--=20
2.1.0.rc0.78.gc0d8480
