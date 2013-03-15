From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 33/45] Convert add_files_to_cache to take struct pathspec
Date: Fri, 15 Mar 2013 13:06:48 +0700
Message-ID: <1363327620-29017-34-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:28:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO7m-0007QM-Q2
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab3COG1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:27:52 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46445 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab3COG1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:27:51 -0400
Received: by mail-ie0-f176.google.com with SMTP id k13so3914265iea.7
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=r5/SwSQW/wHJPXtmiVDeHdMkVTUVdCaWLOXkpdfjQ1U=;
        b=eoanrqdS2KfWI3q29y6daym+0nrdi6eu8UCMk+/tn6pTHCC0K80CgRDNaJkORxBXU2
         4URTiDvJjgZspVHgZRL3uAJTlaZmUIaBkYfkPtN9vAgSGQl/xklcyUj3LsvSpA+L8Ink
         r5O8gQm9iQYt37JtTKzIxZsnuHcsD9RtGyiF3vqkexq9DXxf1HY2jsgLclr1SX52juTj
         eHfJPn6q54MVlXqVeuqzVBN4+iA9ZGAuwpOLFXvqYBIUSKy9Y4P7ijsJqHww3WgkwljY
         46cGmm76CtkRlFRoDatyWkVq9LO/X2AUVRB5T6NkXtTRYciBxrT2Ezd6TZ+ByKY3a0Rj
         CUzg==
X-Received: by 10.43.65.195 with SMTP id xn3mr4023975icb.5.1363328871351;
        Thu, 14 Mar 2013 23:27:51 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ew5sm758606igc.2.2013.03.14.23.27.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:27:50 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:10:53 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218220>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c    | 8 +++++---
 builtin/commit.c | 2 +-
 cache.h          | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 7b9e50c..70bfc05 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -81,13 +81,15 @@ static void update_callback(struct diff_queue_struc=
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
@@ -446,7 +448,7 @@ int cmd_add(int argc, const char **argv, const char=
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
index 75ce807..b5a92fa 100644
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
index 26d0f98..6297783 100644
--- a/cache.h
+++ b/cache.h
@@ -1233,7 +1233,7 @@ void packet_trace_identity(const char *prog);
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
1.8.0.rc0.19.g7bbb31d
