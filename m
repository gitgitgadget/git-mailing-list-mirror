From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: show chain length histogram as graph for better visual
Date: Sat, 22 Feb 2014 08:28:24 +0700
Message-ID: <1393032504-11854-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 02:28:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH1OT-00084K-9u
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 02:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbaBVB2O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Feb 2014 20:28:14 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:62272 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbaBVB2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 20:28:14 -0500
Received: by mail-pb0-f41.google.com with SMTP id up15so4211975pbc.0
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 17:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=qxU7RhjlNWxsU5/GUDwhTIpZd8O/LYCvFs3TXYjQ4OY=;
        b=XfyycwWcb1HGyv7/8OCGUm2mgOeXYmVfdJJ1k7LMsNJolq7Ulz1VPRRicxy5y0DeRL
         jJGWt8g2QRT5W0ITyDIIKTdKKMtGcWm1JPbQBuN0V76qVtK2UpscbAZt4oZyjATYFjCz
         f7FAYc2TyB3d80k31R30r3MfTcW9Wdy/M5fxWA+PEO1NeAukkPkbjFrCUA6wNxsZMFB1
         GXVjTlo/c8FlQXbcd9HVasoSBBIxk3sS8InH+4TT51YdJcHbr32J7CoorDpShLm3Z9mD
         ZU/obMpg4MrQHp/MwMfsquCO7/vxDP5z/74fhZ9VhOtDwL6dr7EDBhIo1rCRbryGb3F5
         jTmw==
X-Received: by 10.66.253.33 with SMTP id zx1mr12505995pac.28.1393032493551;
        Fri, 21 Feb 2014 17:28:13 -0800 (PST)
Received: from lanh ([115.73.213.219])
        by mx.google.com with ESMTPSA id yg4sm60453809pab.19.2014.02.21.17.28.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 17:28:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Feb 2014 08:28:30 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242498>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 definitely better than raw numbers but not really important

 builtin/index-pack.c | 11 ++---------
 diff.c               | 35 +++++++++++++++++++++++++++++++++--
 diff.h               |  2 ++
 3 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2f37a38..a875894 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,6 +11,7 @@
 #include "exec_cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "diff.h"
=20
 static const char index_pack_usage[] =3D
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=3D<msg>] [--ve=
rify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -1476,15 +1477,7 @@ static void show_pack_info(int stat_only)
 			     "non delta: %d objects",
 			     baseobjects),
 			  baseobjects);
-	for (i =3D 0; i < deepest_delta; i++) {
-		if (!chain_histogram[i])
-			continue;
-		printf_ln(Q_("chain length =3D %d: %lu object",
-			     "chain length =3D %d: %lu objects",
-			     chain_histogram[i]),
-			  i + 1,
-			  chain_histogram[i]);
-	}
+	show_histogram_graph("chain length =3D ", chain_histogram, deepest_de=
lta);
 }
=20
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
diff --git a/diff.c b/diff.c
index 8e4a6a9..ca2b92a 100644
--- a/diff.c
+++ b/diff.c
@@ -1489,7 +1489,8 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
 	return ret;
 }
=20
-static void show_stats(struct diffstat_t *data, struct diff_options *o=
ptions)
+static void show_stats(struct diffstat_t *data, struct diff_options *o=
ptions,
+		       int summary)
 {
 	int i, len, add, del, adds =3D 0, dels =3D 0;
 	uintmax_t max_change =3D 0, max_len =3D 0;
@@ -1729,10 +1730,40 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
 			fprintf(options->file, "%s ...\n", line_prefix);
 		extra_shown =3D 1;
 	}
+	if (!summary)
+		return;
 	fprintf(options->file, "%s", line_prefix);
 	print_stat_summary(options->file, total_files, adds, dels);
 }
=20
+void show_histogram_graph(const char *label, unsigned long *data, int =
nr)
+{
+	struct diffstat_t diffstat;
+	struct diff_options options;
+	struct diffstat_file *files;
+	char buf[64];
+	int i;
+
+	memset(&options, 0, sizeof(options));
+	options.file =3D stdout;
+	options.use_color =3D diff_use_color_default;
+	options.stat_width =3D -1;
+	diffstat.nr =3D nr;
+	diffstat.files =3D xmalloc(nr * sizeof(*diffstat.files));
+	files =3D xcalloc(nr, sizeof(*files));
+	for (i =3D 0; i < nr; i++) {
+		diffstat.files[i] =3D files + i;
+		sprintf(buf, "%s %d", label, i);
+		files[i].name =3D xstrdup(buf);
+		files[i].added =3D data[i];
+	}
+	show_stats(&diffstat, &options, 0);
+	for (i =3D 0; i < nr; i++)
+		free(files[i].name);
+	free(files);
+	free(diffstat.files);
+}
+
 static void show_shortstats(struct diffstat_t *data, struct diff_optio=
ns *options)
 {
 	int i, adds =3D 0, dels =3D 0, total_files =3D data->nr;
@@ -4548,7 +4579,7 @@ void diff_flush(struct diff_options *options)
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
-			show_stats(&diffstat, options);
+			show_stats(&diffstat, options, 1);
 		if (output_format & DIFF_FORMAT_SHORTSTAT)
 			show_shortstats(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIRSTAT)
diff --git a/diff.h b/diff.h
index ce123fa..d09b937 100644
--- a/diff.h
+++ b/diff.h
@@ -352,4 +352,6 @@ extern int print_stat_summary(FILE *fp, int files,
 			      int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
=20
+extern void show_histogram_graph(const char *label, unsigned long *dat=
a, int nr);
+
 #endif /* DIFF_H */
--=20
1.9.0.40.gaa8c3ea
