Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3271F744
	for <e@80x24.org>; Tue, 21 Jun 2016 10:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbcFUKlC (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:41:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:51897 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbcFUKgC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 06:36:02 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LdYSM-1bgQe32cTK-00ihm8; Tue, 21 Jun 2016 12:35:05
 +0200
Date:	Tue, 21 Jun 2016 12:35:03 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 4/9] line-log: respect diffopt's configured output file
 stream
In-Reply-To: <cover.1466505222.git.johannes.schindelin@gmx.de>
Message-ID: <228f28864245f89a0a641202472bf78fdcd8a3aa.1466505222.git.johannes.schindelin@gmx.de>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cGL5VYwkpVo2i06CusgxHTmM64ZSc83FBFVOwIGMaZ+Nfr3Hzmh
 A0SBl8LSRQ0mQ5viy8Alb4eNznLDQARdIsQUI7/beBhy1wHf06hRNeocKyGo7KnQ+JDFg+9
 rnC76bElbkx8fmwBuyLGVVqbacMCcT47CRuKoE4H1lpua/nNB20HAo/L1FlI+d37W9uiQ+w
 Rb1Rv5IWSO7beUlDo0i8Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:b9Z7TytAT+g=:cd/JMDqUoxolVaJuKA0OLy
 hbbR7YtDrvcHfmOPvAn98DY/KCxOQ37fwpyYzgkvDIDmp/iLQdlAbJmVPfHkoOwO4hrEAjA5y
 wuFdY97pARUtl2D2zkt0858KzBhyWPgGqgAINF1Pk75MO8p2iT8TQeOCcVVrcz8RJ9mvvgwjx
 D0sFjs/DeJw+mM8yRmWB0PCxXjDnkjI9reAyiN1kt6Hl46FQ1Kz8/n8NE+l9pnIj6yTo8ckcB
 fW3FHTeiCvDI1NRXvw+vs08O+ErodZY+K/9KjuMrI+LpSCr4lsDCNuPsTjhCgCgadpR5ZWgTc
 /YEdv+WFA+q9bBjWcy4FZ+ZaKDIhtuQRgM3Fk5XmfSCpdLDjvuUadGfFOM1MwL2SjPXEIjY+V
 XWynm7ZSqzXW6moaDsVHPB4VxK39okcoDSBrb5Lj9aoF3xrxhYGSDcqrDPgULaqS7iohsIPLY
 mOIPm/2ItThwlavTFzxjr38vVBlkg/WFT7zd3OsJ9TBh/VqtjSYN4wxCStkBW4Rj4M3PbtII2
 z8wIlRPaATjmJyZ3QtXwqu/1F4OAhYQHUWEGoVxLPvHG8/FOcd9Xf/E77emqvNFGs3BJIBhxy
 hi2eNUDFesi3xnghnuJwUsXZZrsu+KJn6oI+clI+tSsMkW9/Bp8OSGVTD/1VrWSzf6wai3JkN
 JPLAU2yoA4lXL1TaP4BOGsqMhooDl2c20pjM/1nHYUHQoGH713dJLIiMFNxBW+5aVgk2MxI/u
 JtvUuBsr1f5Cmo6MPSfjLP2ogr5g6p62vA19CVEX1l6eNIotHhRK3RU8qVeV1i2K2Vi/Urhyh
 dd+Gg5K
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The diff machinery can optionally output to a file stream other than
stdout, by overriding diffopt.file. In such a case, the rest of the
log tree machinery should also write to that stream.

Currently, there is no user of the line level log that wants to
redirect output to a file. Therefore, one might argue that it is
superfluous to support that now. However, it is better to be
consistent now, rather than to face hard-to-debug problems later.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 line-log.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/line-log.c b/line-log.c
index bbe31ed..e62a7f4 100644
--- a/line-log.c
+++ b/line-log.c
@@ -841,7 +841,7 @@ static char *get_nth_line(long line, unsigned long *ends, void *data)
 
 static void print_line(const char *prefix, char first,
 		       long line, unsigned long *ends, void *data,
-		       const char *color, const char *reset)
+		       const char *color, const char *reset, FILE *file)
 {
 	char *begin = get_nth_line(line, ends, data);
 	char *end = get_nth_line(line+1, ends, data);
@@ -852,14 +852,14 @@ static void print_line(const char *prefix, char first,
 		had_nl = 1;
 	}
 
-	fputs(prefix, stdout);
-	fputs(color, stdout);
-	putchar(first);
-	fwrite(begin, 1, end-begin, stdout);
-	fputs(reset, stdout);
-	putchar('\n');
+	fputs(prefix, file);
+	fputs(color, file);
+	putc(first, file);
+	fwrite(begin, 1, end-begin, file);
+	fputs(reset, file);
+	putc('\n', file);
 	if (!had_nl)
-		fputs("\\ No newline at end of file\n", stdout);
+		fputs("\\ No newline at end of file\n", file);
 }
 
 static char *output_prefix(struct diff_options *opt)
@@ -898,12 +898,12 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 		fill_line_ends(pair->one, &p_lines, &p_ends);
 	fill_line_ends(pair->two, &t_lines, &t_ends);
 
-	printf("%s%sdiff --git a/%s b/%s%s\n", prefix, c_meta, pair->one->path, pair->two->path, c_reset);
-	printf("%s%s--- %s%s%s\n", prefix, c_meta,
+	fprintf(opt->file, "%s%sdiff --git a/%s b/%s%s\n", prefix, c_meta, pair->one->path, pair->two->path, c_reset);
+	fprintf(opt->file, "%s%s--- %s%s%s\n", prefix, c_meta,
 	       pair->one->sha1_valid ? "a/" : "",
 	       pair->one->sha1_valid ? pair->one->path : "/dev/null",
 	       c_reset);
-	printf("%s%s+++ b/%s%s\n", prefix, c_meta, pair->two->path, c_reset);
+	fprintf(opt->file, "%s%s+++ b/%s%s\n", prefix, c_meta, pair->two->path, c_reset);
 	for (i = 0; i < range->ranges.nr; i++) {
 		long p_start, p_end;
 		long t_start = range->ranges.ranges[i].start;
@@ -945,7 +945,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 		}
 
 		/* Now output a diff hunk for this range */
-		printf("%s%s@@ -%ld,%ld +%ld,%ld @@%s\n",
+		fprintf(opt->file, "%s%s@@ -%ld,%ld +%ld,%ld @@%s\n",
 		       prefix, c_frag,
 		       p_start+1, p_end-p_start, t_start+1, t_end-t_start,
 		       c_reset);
@@ -953,18 +953,18 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 			int k;
 			for (; t_cur < diff->target.ranges[j].start; t_cur++)
 				print_line(prefix, ' ', t_cur, t_ends, pair->two->data,
-					   c_context, c_reset);
+					   c_context, c_reset, opt->file);
 			for (k = diff->parent.ranges[j].start; k < diff->parent.ranges[j].end; k++)
 				print_line(prefix, '-', k, p_ends, pair->one->data,
-					   c_old, c_reset);
+					   c_old, c_reset, opt->file);
 			for (; t_cur < diff->target.ranges[j].end && t_cur < t_end; t_cur++)
 				print_line(prefix, '+', t_cur, t_ends, pair->two->data,
-					   c_new, c_reset);
+					   c_new, c_reset, opt->file);
 			j++;
 		}
 		for (; t_cur < t_end; t_cur++)
 			print_line(prefix, ' ', t_cur, t_ends, pair->two->data,
-				   c_context, c_reset);
+				   c_context, c_reset, opt->file);
 	}
 
 	free(p_ends);
@@ -977,7 +977,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
  */
 static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *range)
 {
-	puts(output_prefix(&rev->diffopt));
+	fprintf(rev->diffopt.file, "%s\n", output_prefix(&rev->diffopt));
 	while (range) {
 		dump_diff_hacky_one(rev, range);
 		range = range->next;
-- 
2.9.0.118.g0e1a633


