From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/19] untracked cache: avoid racy timestamps
Date: Mon, 27 Oct 2014 19:10:40 +0700
Message-ID: <1414411846-4450-14-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij9Q-00035v-QN
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbaJ0MLw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:11:52 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:49183 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbaJ0MLw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:11:52 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so5508604pde.22
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VDqsQF8MOzP6+G5OXOiDd04Con9hyU0h6hEWtDsuRjA=;
        b=J5Ud/i9ydzqUSk9UeROWURkCNZT3h0SCbRQX6JgfeoixC9wnC1hGcxAXUOBwWezZ4i
         yrEY7/GUozRprMKcmBwIlMtlQFhgnVg6CsuI7UYgvb/YQn0REpxg95uCPgq1xHp2eDVV
         bP95iWXS/r2y+NHHpeFeYERz8efxDj+SzKyXygYrwLnehMkNyBSCzDUNj29tZKeCIUTn
         opa2oT0zVHUrp9GXHNCpa9Yyf/N4GUciBGKj7fEX6QErOGMrQCwWpLNtla4U73Z99X6C
         +tvROuV8MmwBhQ70KXQpVVXwqZx2MxbNB0LCGwwhmO3pHaJvkjzlhGRWGYZNeD8PDRZ8
         qNtw==
X-Received: by 10.70.42.145 with SMTP id o17mr16054686pdl.34.1414411911498;
        Mon, 27 Oct 2014 05:11:51 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id oq6sm10792017pdb.45.2014.10.27.05.11.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:11:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:11:54 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
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
 dir.c        | 5 +++--
 read-cache.c | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 4f903fa..2b93217 100644
--- a/cache.h
+++ b/cache.h
@@ -562,6 +562,8 @@ extern void fill_stat_data(struct stat_data *sd, st=
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
index ddc549c..3eb1a12 100644
--- a/dir.c
+++ b/dir.c
@@ -678,7 +678,8 @@ static int add_excludes(const char *fname, const ch=
ar *base, int baselen,
 		close(fd);
 		if (ss) {
 			int pos;
-			if (ss_valid && !match_stat_data(&ss->stat, &st))
+			if (ss_valid &&
+			    !match_stat_data_racy(&the_index, &ss->stat, &st))
 				; /* no content change, ss->sha1 still good */
 			else if (check_index &&
 				 (pos =3D cache_name_pos(fname, strlen(fname))) >=3D 0 &&
@@ -1533,7 +1534,7 @@ static int valid_cached_dir(struct dir_struct *di=
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
index a14646b..177cbae 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -293,6 +293,14 @@ static int is_racy_timestamp(const struct index_st=
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
