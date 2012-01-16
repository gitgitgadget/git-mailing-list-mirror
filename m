From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] diff: buffer dirstat output
Date: Mon, 16 Jan 2012 11:47:59 +0700
Message-ID: <1326689281-23788-4-git-send-email-pclouds@gmail.com>
References: <1326689281-23788-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 05:49:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmeVL-0002eA-Jc
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 05:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab2APEsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 23:48:42 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab2APEsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 23:48:41 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so1947623iag.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 20:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Z4Dg0oYrAOWoMPT5AB3Z5fmXkcQsW84/YGd8naSndVM=;
        b=NRAOm5s9eb8Oebo0pCESXkewdfiB/d+c7DNLFW+BNeW/+mF1Zb7FPLoK2DqUzxsyEI
         UuFsgA6QETEgY+HA7nb1LX7H7/i/Ei/pjindJSKePzZb8VXA3jo+Th03l14A7Xwh48oQ
         Bvf9BwTUbhfNIIigN2i1tjlm3+NreYe5Yfp60=
Received: by 10.43.125.193 with SMTP id gt1mr8928231icc.57.1326689320777;
        Sun, 15 Jan 2012 20:48:40 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pb6sm31123306igc.5.2012.01.15.20.48.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 20:48:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 11:48:31 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326689281-23788-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188613>

This allows us to decide whether to print it later on.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 203b054..8c448b5 100644
--- a/diff.c
+++ b/diff.c
@@ -1548,6 +1548,7 @@ struct dirstat_file {
 struct dirstat_dir {
 	struct dirstat_file *files;
 	int alloc, nr, permille, cumulative;
+	struct strbuf *sb;
 };
=20
 static long gather_dirstat(struct diff_options *opt, struct dirstat_di=
r *dir,
@@ -1597,8 +1598,8 @@ static long gather_dirstat(struct diff_options *o=
pt, struct dirstat_dir *dir,
 		if (this_dir) {
 			int permille =3D this_dir * 1000 / changed;
 			if (permille >=3D dir->permille) {
-				fprintf(opt->file, "%s%4d.%01d%% %.*s\n", line_prefix,
-					permille / 10, permille % 10, baselen, base);
+				strbuf_addf(dir->sb, "%s%4d.%01d%% %.*s\n", line_prefix,
+					    permille / 10, permille % 10, baselen, base);
 				if (!dir->cumulative)
 					return 0;
 			}
@@ -1614,18 +1615,20 @@ static int dirstat_compare(const void *_a, cons=
t void *_b)
 	return strcmp(a->name, b->name);
 }
=20
-static void show_dirstat(struct diff_options *options)
+static void show_dirstat(struct diff_options *options, struct strbuf *=
output)
 {
 	int i;
 	unsigned long changed;
 	struct dirstat_dir dir;
 	struct diff_queue_struct *q =3D &diff_queued_diff;
+	struct strbuf sb =3D STRBUF_INIT;
=20
 	dir.files =3D NULL;
 	dir.alloc =3D 0;
 	dir.nr =3D 0;
 	dir.permille =3D options->dirstat_permille;
 	dir.cumulative =3D DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE);
+	dir.sb =3D output ? output : &sb;
=20
 	changed =3D 0;
 	for (i =3D 0; i < q->nr; i++) {
@@ -1711,6 +1714,9 @@ found_damage:
 	/* Show all directories with more than x% of the changes */
 	qsort(dir.files, dir.nr, sizeof(dir.files[0]), dirstat_compare);
 	gather_dirstat(options, &dir, changed, "", 0);
+	if (!output)
+		fputs(sb.buf, options->file);
+	strbuf_release(&sb);
 }
=20
 static void show_dirstat_by_line(struct diffstat_t *data, struct diff_=
options *options)
@@ -1718,6 +1724,7 @@ static void show_dirstat_by_line(struct diffstat_=
t *data, struct diff_options *o
 	int i;
 	unsigned long changed;
 	struct dirstat_dir dir;
+	struct strbuf sb =3D STRBUF_INIT;
=20
 	if (data->nr =3D=3D 0)
 		return;
@@ -1727,6 +1734,7 @@ static void show_dirstat_by_line(struct diffstat_=
t *data, struct diff_options *o
 	dir.nr =3D 0;
 	dir.permille =3D options->dirstat_permille;
 	dir.cumulative =3D DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE);
+	dir.sb =3D &sb;
=20
 	changed =3D 0;
 	for (i =3D 0; i < data->nr; i++) {
@@ -1755,6 +1763,8 @@ static void show_dirstat_by_line(struct diffstat_=
t *data, struct diff_options *o
 	/* Show all directories with more than x% of the changes */
 	qsort(dir.files, dir.nr, sizeof(dir.files[0]), dirstat_compare);
 	gather_dirstat(options, &dir, changed, "", 0);
+	fputs(sb.buf, options->file);
+	strbuf_release(&sb);
 }
=20
 static void free_diffstat_info(struct diffstat_t *diffstat)
@@ -4239,7 +4249,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 	if ((output_format & DIFF_FORMAT_DIRSTAT) && !dirstat_by_line)
-		show_dirstat(options);
+		show_dirstat(options, NULL);
=20
 	if (output_format & DIFF_FORMAT_SUMMARY && !is_summary_empty(q)) {
 		for (i =3D 0; i < q->nr; i++) {
--=20
1.7.3.1.256.g2539c.dirty
