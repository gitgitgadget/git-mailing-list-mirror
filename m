From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff options: add --color
Date: Tue, 13 Jun 2006 18:45:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606131845120.29606@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 13 18:46:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqC1V-0005OE-Ky
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 18:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWFMQpr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 12:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWFMQpr
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 12:45:47 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:12754 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932145AbWFMQpq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 12:45:46 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id DD104B7C;
	Tue, 13 Jun 2006 18:45:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id D0C3BCFB;
	Tue, 13 Jun 2006 18:45:44 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B2555B7C;
	Tue, 13 Jun 2006 18:45:44 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21784>


This patch is a slightly adjusted version of Junio's patch:
http://www.gelato.unsw.edu.au/archives/git/0604/19354.html

However, instead of using a config variable, this patch makes it available
as a diff option.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 diff.c  |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 diff.h  |    3 ++
 pager.c |    2 +-
 3 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 9e9cfc8..bc32a4a 100644
--- a/diff.c
+++ b/diff.c
@@ -25,6 +25,20 @@ int git_diff_config(const char *var, con
 	return git_default_config(var, value);
 }
 
+enum color_diff {
+	DIFF_PLAIN = 0,
+	DIFF_METAINFO = 1,
+	DIFF_FILE_OLD = 2,
+	DIFF_FILE_NEW = 3,
+};
+
+static const char *diff_colors[] = {
+	"\033[0;0m",
+	"\033[1;35m",
+	"\033[1;31m",
+	"\033[1;34m",
+};
+
 static char *quote_one(const char *str)
 {
 	int needlen;
@@ -177,23 +191,54 @@ static int fill_mmfile(mmfile_t *mf, str
 }
 
 struct emit_callback {
+	struct xdiff_emit_state xm;
+	int nparents, color_diff;
 	const char **label_path;
 };
 
-static int fn_out(void *priv, mmbuffer_t *mb, int nbuf)
+static inline void color_diff(int diff_use_color, enum color_diff ix)
+{
+	if (diff_use_color)
+		fputs(diff_colors[ix], stdout);
+}
+
+static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	int i;
 	struct emit_callback *ecbdata = priv;
 
 	if (ecbdata->label_path[0]) {
+		color_diff(ecbdata->color_diff, DIFF_METAINFO);
 		printf("--- %s\n", ecbdata->label_path[0]);
+		color_diff(ecbdata->color_diff, DIFF_METAINFO);
 		printf("+++ %s\n", ecbdata->label_path[1]);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
-	for (i = 0; i < nbuf; i++)
-		if (!fwrite(mb[i].ptr, mb[i].size, 1, stdout))
-			return -1;
-	return 0;
+
+	/* This is not really necessary for now because
+	 * this codepath only deals with two-way diffs.
+	 */
+	for (i = 0; i < len && line[i] == '@'; i++)
+		;
+	if (2 <= i && i < len && line[i] == ' ') {
+		ecbdata->nparents = i - 1;
+		color_diff(ecbdata->color_diff, DIFF_METAINFO);
+	}
+	else if (len < ecbdata->nparents)
+		color_diff(ecbdata->color_diff, DIFF_PLAIN);
+	else {
+		int nparents = ecbdata->nparents;
+		int color = DIFF_PLAIN;
+		for (i = 0; i < nparents && len; i++) {
+			if (line[i] == '-')
+				color = DIFF_FILE_OLD;
+			else if (line[i] == '+')
+				color = DIFF_FILE_NEW;
+		}
+		color_diff(ecbdata->color_diff, color);
+	}
+	fwrite(line, len, 1, stdout);
+	color_diff(ecbdata->color_diff, DIFF_PLAIN);
 }
 
 static char *pprint_rename(const char *a, const char *b)
@@ -549,25 +594,35 @@ static void builtin_diff(const char *nam
 	b_two = quote_two("b/", name_b);
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
+	color_diff(o->color_diff, DIFF_METAINFO);
 	printf("diff --git %s %s\n", a_one, b_two);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
+		color_diff(o->color_diff, DIFF_METAINFO);
 		printf("new file mode %06o\n", two->mode);
-		if (xfrm_msg && xfrm_msg[0])
+		if (xfrm_msg && xfrm_msg[0]) {
+			color_diff(o->color_diff, DIFF_METAINFO);
 			puts(xfrm_msg);
+		}
 	}
 	else if (lbl[1][0] == '/') {
 		printf("deleted file mode %06o\n", one->mode);
-		if (xfrm_msg && xfrm_msg[0])
+		if (xfrm_msg && xfrm_msg[0]) {
+			color_diff(o->color_diff, DIFF_METAINFO);
 			puts(xfrm_msg);
+		}
 	}
 	else {
 		if (one->mode != two->mode) {
+			color_diff(o->color_diff, DIFF_METAINFO);
 			printf("old mode %06o\n", one->mode);
+			color_diff(o->color_diff, DIFF_METAINFO);
 			printf("new mode %06o\n", two->mode);
 		}
-		if (xfrm_msg && xfrm_msg[0])
+		if (xfrm_msg && xfrm_msg[0]) {
+			color_diff(o->color_diff, DIFF_METAINFO);
 			puts(xfrm_msg);
+		}
 		/*
 		 * we do not run diff between different kind
 		 * of objects.
@@ -575,6 +630,7 @@ static void builtin_diff(const char *nam
 		if ((one->mode ^ two->mode) & S_IFMT)
 			goto free_ab_and_return;
 		if (complete_rewrite) {
+			color_diff(o->color_diff, DIFF_PLAIN);
 			emit_rewrite_diff(name_a, name_b, one, two);
 			goto free_ab_and_return;
 		}
@@ -602,7 +658,9 @@ static void builtin_diff(const char *nam
 		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
 
+		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
+		ecbdata.color_diff = o->color_diff;
 		xpp.flags = XDF_NEED_MINIMAL;
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
@@ -612,8 +670,9 @@ static void builtin_diff(const char *nam
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
 		else if (!strncmp(diffopts, "-u", 2))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
-		ecb.outf = fn_out;
+		ecb.outf = xdiff_outf;
 		ecb.priv = &ecbdata;
+		ecbdata.xm.consume = fn_out_consume;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
 
@@ -1456,6 +1515,8 @@ int diff_opt_parse(struct diff_options *
 		else if (40 < options->abbrev)
 			options->abbrev = 40;
 	}
+	else if (!strcmp(arg, "--color"))
+		options->color_diff = 1;
 	else
 		return 0;
 	return 1;
diff --git a/diff.h b/diff.h
index 99838e6..2b821df 100644
--- a/diff.h
+++ b/diff.h
@@ -32,7 +32,8 @@ struct diff_options {
 		 full_index:1,
 		 silent_on_remove:1,
 		 find_copies_harder:1,
-		 summary:1;
+		 summary:1,
+		 color_diff:1;
 	int context;
 	int break_opt;
 	int detect_rename;
diff --git a/pager.c b/pager.c
index 9a30939..2d186e8 100644
--- a/pager.c
+++ b/pager.c
@@ -46,7 +46,7 @@ void setup_pager(void)
 	close(fd[0]);
 	close(fd[1]);
 
-	setenv("LESS", "-S", 0);
+	setenv("LESS", "-RS", 0);
 	run_pager(pager);
 	die("unable to execute pager '%s'", pager);
 	exit(255);
-- 
1.4.0.gcaba-dirty
