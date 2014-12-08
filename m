From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 14/23] untracked cache: avoid racy timestamps
Date: Mon,  8 Dec 2014 21:04:58 +0700
Message-ID: <1418047507-22892-16-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:56:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxynD-0004qk-2C
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbaLHNz7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:55:59 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52595 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbaLHNz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:55:58 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so5282824pab.7
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iYweYH7UMNTSdN6xxx6SHV9hpTgIRkJSdCmcyZ+Gz6w=;
        b=HvR86ltqk9ImmzDissclG07SZS4huxeY0vJ8kNPM72JHpLn5CnLSZsl0IX+Zn4GIXZ
         1rqHMcwM7h2qohXHe3CHzhasjLrFQ4Z+g5V3Kiu/V59zuvXfdhBbO+ZUcWYUuduw/02p
         eNLDtfZgwgjlVwQ4KivzczqwKXY3aMrcRUSU6Telf9kC7YzjxvMdnz2LbTxHrg+96pfc
         heYNjHVpfbw7Qb3F9loYQCJ6gfUDmZls9hqj1pE+CKmbQGVYQmTGTKDH1V0jvdl1b5MO
         dHuFdi6+szDUAgp9FqT8Uiegj6izy8YQgikMrd7CnfYyK7ef224MIUkDfGD26say2crb
         jIOw==
X-Received: by 10.70.135.202 with SMTP id pu10mr21432146pdb.64.1418046957897;
        Mon, 08 Dec 2014 05:55:57 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id nh4sm25422553pdb.37.2014.12.08.05.55.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:55:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:06:33 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261032>

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
index a14b48f..7fa372e 100644
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
2.2.0.60.gb7b3c64
