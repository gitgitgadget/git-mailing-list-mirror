From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] Give the hunk comment its own color
Date: Wed, 18 Nov 2009 12:30:36 +0100
Message-ID: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 12:31:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAilD-0005nd-7P
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 12:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbZKRLah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 06:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbZKRLah
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 06:30:37 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:20715 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZKRLag (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 06:30:36 -0500
Received: by ey-out-2122.google.com with SMTP id 25so162189eya.19
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qtBOdvin8wTMpTxGPnFJJt1DFaaDMaXuIr4eMyNbeXU=;
        b=p74G82cPQ58VyMH39MLYweaqGLh0zUc3RJTKcZ2AiArhn22dNCiQPgWEXWGE/f1tlg
         8clxcG/FLEqJVSU3rcuSZSwWNlD9h22FGBAnm/8AupFbYOwG9tAKO3/AXTK4h92BU/6j
         v2JEk9HrOBOjkr8ANyvG4MeHvYrPEQao0H944=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FUVsNyFs0hiCGKhNjPHqNTq7pPxegeEIftz3Zgay0xejyJ1rngtPtORXx9Pj1rqEQh
         JUns52Rzoj13z31uDIWcj1DPB/2VORenn21OT/7hUwOzcJhR+BCm3G4P0ROU1M91YSlK
         wL+JWnJl788KX6qei2pgNcQR7j8W6S5bxIxnk=
Received: by 10.213.96.83 with SMTP id g19mr349266ebn.20.1258543840943;
        Wed, 18 Nov 2009 03:30:40 -0800 (PST)
Received: from localhost ([141.76.90.217])
        by mx.google.com with ESMTPS id 23sm1273867eya.28.2009.11.18.03.30.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Nov 2009 03:30:40 -0800 (PST)
X-Mailer: git-send-email 1.6.5.rc3.61.g9c905
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133159>

Insired by the coloring of quilt.

Introduce a separate color for the hunk comment part, i.e. the current function.
Whitespace between hunk header and hunk comment is now printed as plain.

The current default is magenta. But I'm not settled on this. My favorite would
be bold yellow.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 Documentation/config.txt |    8 +++---
 combine-diff.c           |    5 +++-
 diff.c                   |   62 +++++++++++++++++++++++++++++++++++++++++++--
 diff.h                   |    1 +
 4 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cb73d75..421cd50 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -598,10 +598,10 @@ color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
 	of `plain` (context text), `meta` (metainformation), `frag`
-	(hunk header), `old` (removed lines), `new` (added lines),
-	`commit` (commit headers), or `whitespace` (highlighting
-	whitespace errors). The values of these variables may be specified as
-	in color.branch.<slot>.
+	(hunk header), 'func' (function in hunk header), `old` (removed lines),
+	`new` (added lines), `commit` (commit headers), or `whitespace`
+	(highlighting whitespace errors). The values of these variables may be
+	specified as in color.branch.<slot>.
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
diff --git a/combine-diff.c b/combine-diff.c
index 5b63af1..6162691 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -524,6 +524,7 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 	int i;
 	unsigned long lno = 0;
 	const char *c_frag = diff_get_color(use_color, DIFF_FRAGINFO);
+	const char *c_func = diff_get_color(use_color, DIFF_FUNCINFO);
 	const char *c_new = diff_get_color(use_color, DIFF_FILE_NEW);
 	const char *c_old = diff_get_color(use_color, DIFF_FILE_OLD);
 	const char *c_plain = diff_get_color(use_color, DIFF_PLAIN);
@@ -588,7 +589,9 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 				    comment_end = i;
 			}
 			if (comment_end)
-				putchar(' ');
+				printf("%s%s %s%s", c_reset,
+						    c_plain, c_reset,
+						    c_func);
 			for (i = 0; i < comment_end; i++)
 				putchar(hunk_comment[i]);
 		}
diff --git a/diff.c b/diff.c
index 0d7f5ea..8a5ed1b 100644
--- a/diff.c
+++ b/diff.c
@@ -39,6 +39,7 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_GREEN,	/* NEW */
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
+	GIT_COLOR_MAGENTA,	/* FUNCINFO */
 };
 
 static void diff_filespec_load_driver(struct diff_filespec *one);
@@ -60,6 +61,8 @@ static int parse_diff_color_slot(const char *var, int ofs)
 		return DIFF_COMMIT;
 	if (!strcasecmp(var+ofs, "whitespace"))
 		return DIFF_WHITESPACE;
+	if (!strcasecmp(var+ofs, "func"))
+		return DIFF_FUNCINFO;
 	die("bad config variable '%s'", var);
 }
 
@@ -344,6 +347,61 @@ static void emit_add_line(const char *reset,
 	}
 }
 
+static void emit_hunk_line(struct emit_callback *ecbdata,
+			   const char *line, int len)
+{
+	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
+	const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
+	const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
+	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
+	const char *part_end = NULL;
+	int part_len = 0;
+
+	/* determine length of @ */
+	while (part_len < len && line[part_len] == '@')
+		part_len++;
+
+	/* find end of frag, (Ie. find second @@) */
+	part_end = memmem(line + part_len, len - part_len,
+			  line, part_len);
+	if (!part_end)
+		return emit_line(ecbdata->file, frag, reset, line, len);
+	/* go to end of @@ */
+	part_end += part_len;
+	/* calculate total length of frag */
+	part_len = part_end - line;
+	/* emit frag */
+	emit_line(ecbdata->file, frag, reset, line, part_len);
+
+	/* consume hunk header */
+	len -= part_len;
+	line += part_len;
+
+	/* return early */
+	if (!len)
+		return;
+
+	/* determine length of sep space */
+	part_len = 0;
+	while (part_len < len && isspace(line[part_len]))
+		part_len++;
+
+	/* no whitespace sep => print reminder as FRAGINFO */
+	if (!part_len)
+		return emit_line(ecbdata->file, frag, reset, line, len);
+
+	/* print whitespace sep as PLAIN */
+	emit_line(ecbdata->file, plain, reset, part_end, part_len);
+
+	/* consume whitespace sep */
+	len -= part_len;
+	line += part_len;
+
+	/* print reminder as FUNCINFO */
+	if (len)
+		emit_line(ecbdata->file, func, reset, line, len);
+}
+
 static struct diff_tempfile *claim_diff_tempfile(void) {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
@@ -781,9 +839,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			diff_words_flush(ecbdata);
 		len = sane_truncate_line(ecbdata, line, len);
 		find_lno(line, ecbdata);
-		emit_line(ecbdata->file,
-			  diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
-			  reset, line, len);
+		emit_hunk_line(ecbdata, line, len);
 		if (line[len-1] != '\n')
 			putc('\n', ecbdata->file);
 		return;
diff --git a/diff.h b/diff.h
index 2740421..15fcecd 100644
--- a/diff.h
+++ b/diff.h
@@ -130,6 +130,7 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
+	DIFF_FUNCINFO = 8,
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
-- 
tg: (785c58e..) bw/func-color (depends on: master)
