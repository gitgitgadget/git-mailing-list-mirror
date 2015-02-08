From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/24] untracked cache: avoid racy timestamps
Date: Sun,  8 Feb 2015 15:55:38 +0700
Message-ID: <1423385748-19825-15-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:57:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNg5-000382-56
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbbBHI5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:57:12 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43855 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452AbbBHI5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:57:11 -0500
Received: by pdev10 with SMTP id v10so1801977pde.10
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9n0FUsdByeezo0osghxLdo4wLVVzJU6eIUwN1X28s6M=;
        b=lXyl0wxyTibFQmD8eVorjlrrFip3eaca7A5Uv5KajmGYeCz8W03UP/H6w2InSr+LWF
         4Unk0LLepk5HtYpzQLMug7VPXI+jv+22xIoTvOgwWvc5cly02n7jM2fTgC/+5xM+u5yR
         Q2LNNEi7sxtmciqGKD0Ns0P8WiMIaDGKlsneaAajZi+uSMC8zW0C5fIoxqs3DU9bPQqI
         8UdC1pdrdDY1QRSZuQ0Kk0y38q1kD5GZ8EGqylTLVuO1utNuaiV4FA1y0O5j1bbTXERC
         7ueZrE1YCFfMHduAxzRDNI1Zp9D+Y9V7mWfKWttWt0dy0Dl/gL2bZnEZqZH98srN7yKa
         WrZw==
X-Received: by 10.68.109.227 with SMTP id hv3mr19544535pbb.84.1423385830681;
        Sun, 08 Feb 2015 00:57:10 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id sl5sm12914589pbc.45.2015.02.08.00.57.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:57:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:57:18 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263476>

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
2.3.0.rc1.137.g477eb31
