From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] diff: add --dynstat
Date: Mon, 16 Jan 2012 11:48:00 +0700
Message-ID: <1326689281-23788-5-git-send-email-pclouds@gmail.com>
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
	id 1RmeVM-0002eA-8N
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 05:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab2APEsw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 23:48:52 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab2APEsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 23:48:50 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so1947623iag.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 20:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4oF14+k2OcYM31pFSlIidgVhtzYwVqdbeQSJboWJ0Ek=;
        b=LV1+uhkkb0LXpLr8/iT13yKwPy2yqooCfOKq+ufnBwdhoVo1LnzOnDv3pihJkoaOI+
         dLLrrljQhzxYBaec7et0bY+T07nMgiRKD+i9hRxtfnkYzMGwuEdB+BLRqj9/UeWjDKAk
         Aw4ZPTXeeYP2o1ZvNkmVpsWytFbwGmIDoX/Lg=
Received: by 10.50.194.202 with SMTP id hy10mr11263279igc.23.1326689329870;
        Sun, 15 Jan 2012 20:48:49 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id q30sm61424693ibc.1.2012.01.15.20.48.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 20:48:49 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 11:48:39 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326689281-23788-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188614>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++------
 diff.h |    1 +
 2 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 8c448b5..b945ad6 100644
--- a/diff.c
+++ b/diff.c
@@ -1226,6 +1226,7 @@ struct diffstat_t {
 		unsigned is_renamed:1;
 		uintmax_t added, deleted;
 	} **files;
+	struct strbuf dynstat;
 };
=20
 static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
@@ -1779,6 +1780,7 @@ static void free_diffstat_info(struct diffstat_t =
*diffstat)
 		free(f);
 	}
 	free(diffstat->files);
+	strbuf_release(&diffstat->dynstat);
 }
=20
 struct checkdiff_t {
@@ -3332,6 +3334,8 @@ int diff_opt_parse(struct diff_options *options, =
const char **av, int ac)
 		options->output_format |=3D DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |=3D DIFF_FORMAT_SHORTSTAT;
+	else if (!strcmp(arg, "--dynstat"))
+		options->output_format |=3D DIFF_FORMAT_DYNSTAT;
 	else if (!strcmp(arg, "-X") || !strcmp(arg, "--dirstat"))
 		return parse_dirstat_opt(options, "");
 	else if (!prefixcmp(arg, "-X"))
@@ -3922,6 +3926,76 @@ static int check_pair_status(struct diff_filepai=
r *p)
 	}
 }
=20
+static int diff_flush_dynstat(struct diff_options *o, struct diffstat_=
t *diffstat)
+{
+	struct diff_queue_struct *q =3D &diff_queued_diff;
+	int i, adds =3D 0, dels =3D 0, summary_lines =3D 0, printed_lines =3D=
 0, total_files;
+
+	memset(diffstat, 0, sizeof(struct diffstat_t));
+	for (i =3D 0; i < q->nr; i++) {
+		struct diff_filepair *p =3D q->queue[i];
+		if (check_pair_status(p))
+			diff_flush_stat(p, o, diffstat);
+	}
+
+	total_files =3D diffstat->nr;
+	if (!total_files)
+		return o->output_format;
+
+	/* how many lines for --stat ? */
+	for (i =3D 0; i < diffstat->nr; i++) {
+		struct diffstat_file *f =3D diffstat->files[i];
+		if (!f->is_binary && !f->is_unmerged) {
+			if (!f->is_renamed && (f->added + f->deleted =3D=3D 0))
+				total_files--;
+			else {
+				adds +=3D f->added;
+				dels +=3D f->deleted;
+			}
+		}
+	}
+
+	/* how many lines for --summary ? */
+	for (i =3D 0; i < q->nr; i++) {
+		struct diff_filepair *p =3D q->queue[i];
+		if ((p->status & (DIFF_STATUS_DELETED | DIFF_STATUS_ADDED |
+				 DIFF_STATUS_COPIED | DIFF_STATUS_RENAMED)) ||
+		    p->score)
+			summary_lines++;
+	}
+
+	if (printed_lines + total_files < 50) {
+		o->output_format |=3D DIFF_FORMAT_DIFFSTAT;
+		printed_lines +=3D total_files;
+		if (printed_lines + summary_lines < 50) {
+			printed_lines +=3D summary_lines;
+			o->output_format |=3D DIFF_FORMAT_SUMMARY;
+		}
+	} else {
+		const char *s;
+		int nr =3D 0;
+		show_dirstat(o, &diffstat->dynstat);
+		s =3D diffstat->dynstat.buf;
+
+		/* how many lines for --dirstat ? */
+		while (s && (s =3D strchr(s, '\n'))) {
+			nr++;
+			s++;
+		}
+		if (nr < 50)
+			printed_lines +=3D nr;
+		else
+			strbuf_release(&diffstat->dynstat);
+	}
+
+	/* how many lines for --patch ? */
+	if (adds + dels < 10 && printed_lines < 10)
+		o->output_format |=3D DIFF_FORMAT_PATCH;
+
+	o->output_format |=3D DIFF_FORMAT_SHORTSTAT;
+	return o->output_format;
+}
+
 static void flush_one_pair(struct diff_filepair *p, struct diff_option=
s *opt)
 {
 	int fmt =3D opt->output_format;
@@ -4201,6 +4275,7 @@ void diff_flush(struct diff_options *options)
 	int i, output_format =3D options->output_format;
 	int separator =3D 0;
 	int dirstat_by_line =3D 0;
+	struct diffstat_t diffstat;
=20
 	/*
 	 * Order: raw, stat, summary, patch
@@ -4221,6 +4296,19 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
=20
+	memset(&diffstat, 0, sizeof(struct diffstat_t));
+	strbuf_init(&diffstat.dynstat, 0);
+	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_=
=46ORMAT_NUMSTAT|DIFF_FORMAT_DYNSTAT)) {
+		for (i =3D 0; i < q->nr; i++) {
+			struct diff_filepair *p =3D q->queue[i];
+			if (check_pair_status(p))
+				diff_flush_stat(p, options, &diffstat);
+		}
+	}
+
+	if (output_format & DIFF_FORMAT_DYNSTAT)
+		output_format =3D diff_flush_dynstat(options, &diffstat);
+
 	if (output_format & DIFF_FORMAT_DIRSTAT && DIFF_OPT_TST(options, DIRS=
TAT_BY_LINE))
 		dirstat_by_line =3D 1;
=20
@@ -4229,25 +4317,19 @@ void diff_flush(struct diff_options *options)
=20
 	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_=
=46ORMAT_NUMSTAT) ||
 	    dirstat_by_line) {
-		struct diffstat_t diffstat;
-
-		memset(&diffstat, 0, sizeof(struct diffstat_t));
-		for (i =3D 0; i < q->nr; i++) {
-			struct diff_filepair *p =3D q->queue[i];
-			if (check_pair_status(p))
-				diff_flush_stat(p, options, &diffstat);
-		}
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
 			show_stats(&diffstat, options);
+		if ((output_format & DIFF_FORMAT_DYNSTAT) && diffstat.dynstat.len)
+			fputs(diffstat.dynstat.buf, options->file);
 		if (output_format & DIFF_FORMAT_SHORTSTAT)
 			show_shortstats(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIRSTAT)
 			show_dirstat_by_line(&diffstat, options);
-		free_diffstat_info(&diffstat);
 		separator++;
 	}
+	free_diffstat_info(&diffstat);
 	if ((output_format & DIFF_FORMAT_DIRSTAT) && !dirstat_by_line)
 		show_dirstat(options, NULL);
=20
diff --git a/diff.h b/diff.h
index ae71f4c..6bebad8 100644
--- a/diff.h
+++ b/diff.h
@@ -39,6 +39,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct dif=
f_options *opt, void *data)
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
 #define DIFF_FORMAT_DIRSTAT	0x0040
+#define DIFF_FORMAT_DYNSTAT	0x0080
=20
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
--=20
1.7.3.1.256.g2539c.dirty
