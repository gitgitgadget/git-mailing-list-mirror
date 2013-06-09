From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 33/45] Convert add_files_to_cache to take struct pathspec
Date: Sun,  9 Jun 2013 13:26:06 +0700
Message-ID: <1370759178-1709-34-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:28:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ74-0001Rm-5L
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab3FIG2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:28:22 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:58411 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab3FIG2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:28:21 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so6351799pdj.28
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OMxKiOqH/jP15nsR8j9vc+XH8FSIEJXynXGBJvH7QgQ=;
        b=gVawBg+AewCjSnxwhQF2OuLxwsiXCIRzR/S+fFAViXPbrx9Q9wPXoO0EzjHYuymAiE
         4CCgXySdGlAnsiHxH7JjpOfhXZRMbSIimclLBQOIn1NnowD4Va0i3T6rovp/2RURWS/L
         +FEKbbHlhBx3DSRrLgfvrdwuJ4WH7O0Lk0MyNQN/iiekX8woJSe79KqZgHtYiGJX8DoD
         nMd6ck4ZjSIDwV7xyUgZFAXWe5s27foFwOStUB1eyIRxSvIkhyVREhnUoWtX47bXACw8
         30jgLI26s2Xf5OzE5OkB7S+rr/Zv6Xht28IvvKm9I0cF0ul3m+Zrm/wt9yAR5R2ageF/
         l9tg==
X-Received: by 10.68.108.163 with SMTP id hl3mr5001060pbb.160.1370759300998;
        Sat, 08 Jun 2013 23:28:20 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id rn7sm5546293pbc.12.2013.06.08.23.28.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:28:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:29:52 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226925>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c    | 11 +++++++----
 builtin/commit.c |  2 +-
 cache.h          |  2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 34c9358..a47aeb4 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -166,14 +166,16 @@ static void update_callback(struct diff_queue_str=
uct *q,
 	}
 }
=20
-static void update_files_in_cache(const char *prefix, const char **pat=
hspec,
+static void update_files_in_cache(const char *prefix,
+				  const struct pathspec *pathspec,
 				  struct update_callback_data *data)
 {
 	struct rev_info rev;
=20
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-	init_pathspec(&rev.prune_data, pathspec);
+	if (pathspec)
+		copy_pathspec(&rev.prune_data, pathspec);
 	rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D update_callback;
 	rev.diffopt.format_callback_data =3D data;
@@ -181,7 +183,8 @@ static void update_files_in_cache(const char *prefi=
x, const char **pathspec,
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 }
=20
-int add_files_to_cache(const char *prefix, const char **pathspec, int =
flags)
+int add_files_to_cache(const char *prefix,
+		       const struct pathspec *pathspec, int flags)
 {
 	struct update_callback_data data;
=20
@@ -571,7 +574,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		memset(&pathspec, 0, sizeof(pathspec));
 	}
 	update_data.flags =3D flags & ~ADD_CACHE_IMPLICIT_DOT;
-	update_files_in_cache(prefix, pathspec.raw, &update_data);
+	update_files_in_cache(prefix, &pathspec, &update_data);
=20
 	exit_status |=3D !!update_data.add_errors;
 	if (add_new_files)
diff --git a/builtin/commit.c b/builtin/commit.c
index 56bc7be..2ddff4e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -331,7 +331,7 @@ static char *prepare_index(int argc, const char **a=
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
index 25410b9..b3d8b29 100644
--- a/cache.h
+++ b/cache.h
@@ -1260,7 +1260,7 @@ void packet_trace_identity(const char *prog);
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
1.8.2.83.gc99314b
