From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 25/31] Convert add_files_to_cache to take struct pathspec
Date: Sun, 13 Jan 2013 19:35:33 +0700
Message-ID: <1358080539-17436-26-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:39:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMq2-0008D4-Pg
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166Ab3AMMii convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:38:38 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:61726 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3AMMih (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:38:37 -0500
Received: by mail-da0-f48.google.com with SMTP id k18so1431559dae.7
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=RV0Sp8d0zraoRVIlnHSusrS2d+dg/Coc6ojmCcY3cIk=;
        b=WqlqC/idpqCoqoiDHNTO9fQRvYhKrAV8BI4DMLxZi4yqVbVRSQOV8AI9a9uN3JdhuB
         NVwf+wLwRThSkVUofPkhDqSD45KW+sYBr5EZOAkqIZMgrxZPTJux5WkpCSlB+RSWFLIq
         F7YeXX4HKpBf7vDv7FLVSkjiZ9V1iE639yxezURTzzrq24NC8lc7MS3cKxuqsVDvxXgs
         TRud7id8bqtoLYqA4Va1GiTuKfY9f0P1+MnKL2ah0skMpJbm8sGRG7Xd1KPXm00gJEY0
         iyTx+PHoGuU9HQk37G2JkGuRv3f1J2S8+ro27/uVxQaBcYJx0069dPptc5GQjx8YnU0v
         MPug==
X-Received: by 10.68.243.105 with SMTP id wx9mr71203400pbc.74.1358080717523;
        Sun, 13 Jan 2013 04:38:37 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id x6sm2428373paw.0.2013.01.13.04.38.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:38:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:38:52 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213364>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c    | 8 +++++---
 builtin/commit.c | 2 +-
 cache.h          | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index dcea98f..89ae67d 100644
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
+		copy_pathspec(&rev.prune_data, pathspec);
 	rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D update_callback;
 	data.flags =3D flags;
@@ -438,7 +440,7 @@ int cmd_add(int argc, const char **argv, const char=
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
index 2fe6054..d79613d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -329,7 +329,7 @@ static char *prepare_index(int argc, const char **a=
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
index 803cfeb..f7afb19 100644
--- a/cache.h
+++ b/cache.h
@@ -1255,7 +1255,7 @@ void packet_trace_identity(const char *prog);
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
