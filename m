From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 19/21] Convert add_files_to_cache to take struct pathspec
Date: Fri, 11 Jan 2013 18:21:13 +0700
Message-ID: <1357903275-16804-20-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:23:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttchj-00086N-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab3AKLW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:22:59 -0500
Received: from mail-da0-f53.google.com ([209.85.210.53]:55428 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab3AKLW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:22:59 -0500
Received: by mail-da0-f53.google.com with SMTP id x6so733215dac.12
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=agUNtxdtwUusj3UaHZFN5r5Pa6AUdhQTFw7WZcBNzbQ=;
        b=LlPGZsYl5A0M+AcXWTMHOioRPRVCCqFiyP6qQKY+tHHuV5A7KtnDZf4g0eacR5yr10
         hFxnbtF5d6YjTKZLRbBTvR83bu/zPNEuN2wSyL+QNKofO1TqVPc8cr4nWztM0T6uw677
         1HR5DBg3SlsE4ZJBzoif+kSwAk+lOoJ3kzCCi63c7znkbe5w8A8XhUmG3MnEoNAfkeNI
         1tDbGjxn6AI+dawI19o9VcRQ2NVKYMZgkD3+j24MXs+RgMQFgNoJRtuIv2hFvuJdCNPt
         X/csPyH6tM/zm1tIS4WufwCAG9wH8MzfwpDEt2mlOt3rQFRvU3w7hwsf7HK6tRskjB0p
         2tzA==
X-Received: by 10.68.237.167 with SMTP id vd7mr228610858pbc.161.1357903378708;
        Fri, 11 Jan 2013 03:22:58 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id o5sm2952636pay.5.2013.01.11.03.22.55
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:22:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:23:13 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213212>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c    | 8 +++++---
 builtin/commit.c | 2 +-
 cache.h          | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0295cef..5d262eb 100644
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
@@ -437,7 +439,7 @@ int cmd_add(int argc, const char **argv, const char=
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
index 32298ba..3e09a61 100644
--- a/cache.h
+++ b/cache.h
@@ -1228,7 +1228,7 @@ void packet_trace_identity(const char *prog);
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
