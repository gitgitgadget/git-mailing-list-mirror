From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/24] untracked cache: avoid racy timestamps
Date: Tue, 20 Jan 2015 20:03:23 +0700
Message-ID: <1421759013-8494-15-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:05:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYUd-0003my-3M
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbbATNFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:05:08 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40921 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbbATNFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:05:06 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so3327216pdj.7
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Eg4K89/K6uMSQN6l0jisHninLElkv84awPLAtyw58TE=;
        b=iod30AJPHPGWeoIpopLejg3WVU5jcRWcMDdE5yD2ZrtEz21jiAoKYGqiK80XB7Gv+G
         vXjJ9YIx8osIqCsQaPkxbq3ImJYWsgmSErteCC9PqpsGhVIP3KMTl44S8al8HowV3KV5
         82z0ZcfjdOZ7Nybtioccb6dpNw+MVkDhA+XgURXnzYp53+ETjjta2U0FY3V+e0YWO+Z+
         xeMPHoDQSTvq1jZH1XnCrYYv2JiNQi7Sz68ql8YQMuQdZoq/KiLA/N5DZ3IDI+1sa9Ih
         LTad5L5e/dDZk+w73R4EN4LtScP7zPTzCQTTiENymhHCJigyGpnR4DiAmXbREY9LG4ZD
         i0Ow==
X-Received: by 10.70.38.38 with SMTP id d6mr5377884pdk.71.1421759106213;
        Tue, 20 Jan 2015 05:05:06 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id j9sm12887pdl.72.2015.01.20.05.05.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:05:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:05:17 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262666>

When a directory is updated within the same second that its timestamp
is last saved, we cannot realize the directory has been updated by
checking timestamps. Assume the worst (something is update). See
29e4d36 (Racy GIT - 2005-12-20) for more information.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 30e23f8..439ff22 100644
--- a/dir.c
+++ b/dir.c
@@ -682,7 +682,7 @@ static int add_excludes(const char *fname, const ch=
ar *base, int baselen,
 		if (sha1_stat) {
 			int pos;
 			if (sha1_stat->valid &&
-			    !match_stat_data(&sha1_stat->stat, &st))
+			    !match_stat_data_racy(&the_index, &sha1_stat->stat, &st))
 				; /* no content change, ss->sha1 still good */
 			else if (check_index &&
 				 (pos =3D cache_name_pos(fname, strlen(fname))) >=3D 0 &&
@@ -1538,7 +1538,7 @@ static int valid_cached_dir(struct dir_struct *di=
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
index f12a185..0ecba05 100644
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
2.2.0.84.ge9c7a8a
