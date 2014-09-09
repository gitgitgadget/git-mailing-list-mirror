From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] diff --no-index: allow pathspec after --
Date: Tue,  9 Sep 2014 16:56:24 +0700
Message-ID: <1410256584-19562-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 11:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRI9r-0006FJ-Hd
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 11:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbaIIJ4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Sep 2014 05:56:15 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:52155 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbaIIJ4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 05:56:14 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so3772177pde.12
        for <git@vger.kernel.org>; Tue, 09 Sep 2014 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=yCeCRwC1UFikr5uawz6fd9UqYovrkch+mN0lSwycXYc=;
        b=MlBjbRXDlI36Hwwrr7D6QTbG0/ZLYjQlUv+BKjRPoJlM9AE4N/Xh5sCsJRkNd5ENuh
         d5t/jq151mpqluzqvMs34AwVB2Z64MdLlskntPL9YmDADu4GsiA4TdpnXF32vPFJwX7Q
         Q2R6zATq7F3P3O0F54ctJRj1iaHW27xFxlJEGRIMEU9gTr+M+cPA8Oi7d/CLc5vktEgF
         i6XV7w2+IS4HOQc4bOPRYbsFXTolB/GYVMQH5xJtAm2+iQPcdVJZEnrsffWk0WFB7yh0
         oBuA9P54keRhb0A5L9ZUMGo5Emo0kYMXAIZ4oPSkDOQ3H8EhViPubigW/EBaYHWr9QhT
         mDQw==
X-Received: by 10.67.3.106 with SMTP id bv10mr1459680pad.13.1410256573710;
        Tue, 09 Sep 2014 02:56:13 -0700 (PDT)
Received: from lanh ([115.73.216.255])
        by mx.google.com with ESMTPSA id bv5sm11121690pbc.20.2014.09.09.02.56.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2014 02:56:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 09 Sep 2014 16:56:30 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256688>

Another patch to test the water before I put more effort into it.

Commit d516c2d (Teach git-diff-files the new option `--no-index` -
2007-02-22) brings the bells and whistles of git-diff to the world
outside a git repository. This patch continues that direction and adds
a new syntax

    git diff --no-index [--] <path> <path> -- <pathspec>

It's easy to guess that the two directories will be filtered by
pathspec, which could be useful for filtering out generated files
(negative pathspec to rescue!), or simply to limit diff output to a
selection of files.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/diff.c  | 26 ++++++++++++++------------
 diff-no-index.c | 49 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 0f247d2..4e37876 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -321,23 +321,25 @@ int cmd_diff(int argc, const char **argv, const c=
har *prefix)
=20
 	init_revisions(&rev, prefix);
=20
-	if (no_index && argc !=3D i + 2) {
-		if (no_index =3D=3D DIFF_NO_INDEX_IMPLICIT) {
-			/*
-			 * There was no --no-index and there were not two
-			 * paths. It is possible that the user intended
-			 * to do an inside-repository operation.
-			 */
-			fprintf(stderr, "Not a git repository\n");
-			fprintf(stderr,
-				"To compare two paths outside a working tree:\n");
-		}
+	if (no_index =3D=3D DIFF_NO_INDEX_IMPLICIT && argc !=3D i + 2) {
+		/*
+		 * There was no --no-index and there were not two
+		 * paths. It is possible that the user intended
+		 * to do an inside-repository operation.
+		 */
+		fprintf(stderr, "Not a git repository\n");
+		fprintf(stderr,
+			"To compare two paths outside a working tree:\n");
 		/* Give the usage message for non-repository usage and exit. */
 		usagef("git diff %s <path> <path>",
 		       no_index =3D=3D DIFF_NO_INDEX_EXPLICIT ?
 		       "--no-index" : "[--no-index]");
-
 	}
+	if (no_index =3D=3D DIFF_NO_INDEX_EXPLICIT && argc < i + 2)
+		/* Give the usage message for non-repository usage and exit. */
+		usagef("git diff %s <path> <path>",
+		       no_index =3D=3D DIFF_NO_INDEX_EXPLICIT ?
+		       "--no-index" : "[--no-index]");
 	if (no_index)
 		/* If this is a no-index diff, just run it and exit there. */
 		diff_no_index(&rev, argc, argv, prefix);
diff --git a/diff-no-index.c b/diff-no-index.c
index 265709b..7f5cd0f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -89,8 +89,20 @@ static struct diff_filespec *noindex_filespec(const =
char *name, int mode)
 	return s;
 }
=20
+static int path_ok(struct diff_options *o, const char *name, int prefi=
x)
+{
+	if (!name)
+		return 0;
+	name +=3D prefix;
+	if (*name =3D=3D '/')
+		name++;
+	return match_pathspec(&o->pathspec, name, strlen(name),
+			      0, NULL, 0);
+}
+
 static int queue_diff(struct diff_options *o,
-		      const char *name1, const char *name2)
+		      const char *name1, int prefix1,
+		      const char *name2, int prefix2)
 {
 	int mode1 =3D 0, mode2 =3D 0;
=20
@@ -157,7 +169,7 @@ static int queue_diff(struct diff_options *o,
 				n2 =3D buffer2.buf;
 			}
=20
-			ret =3D queue_diff(o, n1, n2);
+			ret =3D queue_diff(o, n1, prefix1, n2, prefix2);
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
@@ -165,7 +177,7 @@ static int queue_diff(struct diff_options *o,
 		strbuf_release(&buffer2);
=20
 		return ret;
-	} else {
+	} else if (path_ok(o, name1, prefix1) || path_ok(o, name2, prefix2)) =
{
 		struct diff_filespec *d1, *d2;
=20
 		if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
@@ -180,13 +192,14 @@ static int queue_diff(struct diff_options *o,
 		diff_queue(&diff_queued_diff, d1, d2);
 		return 0;
 	}
+	return 0;
 }
=20
 void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv,
 		   const char *prefix)
 {
-	int i, prefixlen;
+	int i, j, prefixlen;
 	const char *paths[2];
=20
 	diff_setup(&revs->diffopt);
@@ -194,19 +207,23 @@ void diff_no_index(struct rev_info *revs,
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
 			i++;
-		else if (!strcmp(argv[i], "--"))
+		else if (!strcmp(argv[i], "--")) {
 			i++;
-		else {
+			break;
+		} else {
 			j =3D diff_opt_parse(&revs->diffopt, argv + i, argc - i);
-			if (j <=3D 0)
+			if (j <=3D 0) {
+				if (argv[i][0] !=3D '-' || argv[i][1] =3D=3D '\0')
+					break;
 				die("invalid diff option/value: %s", argv[i]);
+			}
 			i +=3D j;
 		}
 	}
=20
 	prefixlen =3D prefix ? strlen(prefix) : 0;
-	for (i =3D 0; i < 2; i++) {
-		const char *p =3D argv[argc - 2 + i];
+	for (j =3D 0; j < 2 && i < argc; j++, i++) {
+		const char *p =3D argv[i];
 		if (!strcmp(p, "-"))
 			/*
 			 * stdin should be spelled as "-"; if you have
@@ -215,7 +232,15 @@ void diff_no_index(struct rev_info *revs,
 			p =3D file_from_standard_input;
 		else if (prefixlen)
 			p =3D xstrdup(prefix_filename(prefix, prefixlen, p));
-		paths[i] =3D p;
+		paths[j] =3D p;
+	}
+	if (j < 2)
+		die("two paths required");
+	if (i < argc) {
+		const char *p =3D argv[i];
+		if (strcmp(p, "--"))
+			die("two paths required");
+		parse_pathspec(&revs->diffopt.pathspec, 0, 0, "", argv + i + 1);
 	}
 	revs->diffopt.skip_stat_unmatch =3D 1;
 	if (!revs->diffopt.output_format)
@@ -229,7 +254,9 @@ void diff_no_index(struct rev_info *revs,
 	setup_diff_pager(&revs->diffopt);
 	DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
=20
-	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
+	if (queue_diff(&revs->diffopt,
+		       paths[0], strlen(paths[0]),
+		       paths[1], strlen(paths[1])))
 		exit(1);
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
--=20
2.1.0.rc0.78.gc0d8480
