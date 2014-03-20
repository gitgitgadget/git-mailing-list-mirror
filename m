From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/8] ls-files: add --column
Date: Thu, 20 Mar 2014 17:15:49 +0700
Message-ID: <1395310551-23201-7-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:16:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQa1N-0001LY-IC
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012AbaCTKQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 06:16:15 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:42072 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbaCTKQN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:16:13 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so729463pab.12
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zMOTZWjtNcj2N7LYfRc0aMrqrssDVluED8HDAproj+k=;
        b=h4M63MUOoews6wygZUymM/Ip0lx2rSAuD5PTWFr2N8wAbiJe4CWwFH4R/FlBNLWPDQ
         k2R24BTYNyPH+KYL0khTFQP7MMfh/FSwuwW8RoaJygurVDcGMTa87/48zRCATywa43BN
         x27pmYw7YB36v50fT2EXdfcqqXkvTx25f/47ljVm97WqFW4esUPIB/HZ4IMGTB+ZvaeI
         kpQYHL4DjSXBoE4+bMUusqI2IdIPE7CMLvnRRnH1014bocgBdNxQA+Kgv9mqDc2RRw52
         tHH01lzfln7UcLjgmzIXB681sZamvbYRT0e+Ly0KGIhWY7MRNwEpsyRBtHt1/DyTp5FI
         7LJw==
X-Received: by 10.69.17.230 with SMTP id gh6mr4765272pbd.0.1395310573369;
        Thu, 20 Mar 2014 03:16:13 -0700 (PDT)
Received: from lanh ([115.73.251.167])
        by mx.google.com with ESMTPSA id un5sm7880461pab.3.2014.03.20.03.16.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 03:16:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Mar 2014 17:17:00 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244536>

Default pathspec behavior is recursive which includes too many files
for effective column output. But if you can do

git ls-files --column ':(glob)*'

to limit to one level only. It's not exactly the same as GNU ls
(e.g. directories are never shown) but much closer.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 463280e..a43abdb 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -16,6 +16,7 @@
 #include "pathspec.h"
 #include "color.h"
 #include "ls_colors.h"
+#include "column.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -476,6 +477,7 @@ static int option_parse_exclude_standard(const stru=
ct option *opt,
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
 	int require_work_tree =3D 0, show_tag =3D 0, i;
+	unsigned int colopts =3D 0;
 	const char *max_prefix;
 	struct dir_struct dir;
 	struct exclude_list *el;
@@ -532,6 +534,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
 			N_("pretend that paths removed since <tree-ish> are still present")=
),
 		OPT__COLOR(&use_color, N_("show color")),
+		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_END()
@@ -576,6 +579,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 	if (dir.exclude_per_dir)
 		exc_given =3D 1;
=20
+	finalize_colopts(&colopts, -1);
+	if (!line_terminator && explicitly_enable_column(colopts))
+		die(_("--column and -z are incompatible"));
+
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
@@ -614,10 +621,19 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
 			die("ls-files --with-tree is incompatible with -s or -u");
 		overlay_tree_on_cache(with_tree, max_prefix);
 	}
+
+	if (column_active(colopts)) {
+		struct column_options copts;
+		memset(&copts, 0, sizeof(copts));
+		run_column_filter(colopts, &copts);
+	}
 	show_files(&dir);
 	if (show_resolve_undo)
 		show_ru_info();
=20
+	if (column_active(colopts))
+		stop_column_filter();
+
 	if (ps_matched) {
 		int bad;
 		bad =3D report_path_error(ps_matched, &pathspec, prefix);
--=20
1.9.0.40.gaa8c3ea
