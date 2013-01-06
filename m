From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/21] Convert add_files_to_cache to take struct pathspec
Date: Sun,  6 Jan 2013 13:21:07 +0700
Message-ID: <1357453268-12543-21-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:23:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjdl-0000oU-Co
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab3AFGXG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:23:06 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:56879 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab3AFGXE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:23:04 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so10053124pad.3
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=1N3Cljl+1oqLkmb5rbeozd7HyOhdNe0MqNPvjRUAY+g=;
        b=IeaJ5wY5E5MYcUGKjK3pTFSMrO8/3VkQnTQPvaJnMklV+tij2nhqWDD8CoreCxzVyX
         Bx/wdOG3Z5e4kTZyZBpqMDV4xNKFMJf+gdt8zVdhVXwVR21y6SC0TVmBxDa+NnfmUmfv
         aFRZ9RMP70fQxrz5gKphgXWnS3MNZQTOr/jPR8ULzovwkmJ62hi9aQ7LewIv5Rpj77UG
         Fc4G+BnbT5uc1DDwOxjKWc602UeEpa/I2NKg5mK/Zj3wBgvjD9InvZUtX0Poh2CbeKqx
         5Ds5A4ukrhPXazyO7EWdZrnpM80biCDfnumyRenDJjSM8xWcPlADNE9z/fsJZy98w3t6
         tB6A==
X-Received: by 10.66.83.136 with SMTP id q8mr167626341pay.83.1357453383218;
        Sat, 05 Jan 2013 22:23:03 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id vc10sm1900878pbc.51.2013.01.05.22.23.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:23:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:23:12 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212773>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c    | 8 +++++---
 builtin/commit.c | 2 +-
 cache.h          | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f5ceb5c..641037f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -80,13 +80,15 @@ static void update_callback(struct diff_queue_struc=
t *q,
 	}
 }
=20
-int add_files_to_cache(const char *prefix, const char **pathspec, int =
flags)
+int add_files_to_cache(const char *prefix,
+		       const struct pathspec *pathspec, int flags)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-	init_pathspec(&rev.prune_data, pathspec);
+	if (pathspec)
+		rev.prune_data =3D *pathspec;
 	rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D update_callback;
 	data.flags =3D flags;
@@ -464,7 +466,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
=20
 	plug_bulk_checkin();
=20
-	exit_status |=3D add_files_to_cache(prefix, pathspec.raw, flags);
+	exit_status |=3D add_files_to_cache(prefix, &pathspec, flags);
=20
 	if (add_new_files)
 		exit_status |=3D add_files(&dir, flags);
diff --git a/builtin/commit.c b/builtin/commit.c
index 193a37e..a3a22b8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -330,7 +330,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 	 */
 	if (all || (also && pathspec.nr)) {
 		fd =3D hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, pathspec.raw, 0);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
diff --git a/cache.h b/cache.h
index 41e1421..10cba21 100644
--- a/cache.h
+++ b/cache.h
@@ -1224,7 +1224,7 @@ void packet_trace_identity(const char *prog);
  * return 0 if success, 1 - if addition of a file failed and
  * ADD_FILES_IGNORE_ERRORS was specified in flags
  */
-int add_files_to_cache(const char *prefix, const char **pathspec, int =
flags);
+int add_files_to_cache(const char *prefix, const struct pathspec *path=
spec, int flags);
=20
 /* diff.c */
 extern int diff_auto_refresh_index;
--=20
1.8.0.rc2.23.g1fb49df
