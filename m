Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A6D1F744
	for <e@80x24.org>; Sat, 18 Jun 2016 10:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbcFRKEF (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 06:04:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:64075 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbcFRKEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 06:04:04 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MCL6r-1b5AhI2Uyn-0095q0; Sat, 18 Jun 2016 12:03:57
 +0200
Date:	Sat, 18 Jun 2016 12:03:56 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] line-log: respect diffopt's configured output file
 stream
In-Reply-To: <cover.1466244194.git.johannes.schindelin@gmx.de>
Message-ID: <30c24f0e22085a4ba2fbfd16f8ba176e31420d5d.1466244194.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+RCGTrlCjnhjj+rjueWq9QSv0ZFec0Cs6RZsPWI7d1aikVPOlSf
 AF1vxf3JJnwoq9pRBWVNFa1lAGzYIFgG1U2g8wbCjVLl4A3+pB3jy3NgLOtVlbAsITde/md
 Wj6TIr3hD7AvhYxHyB/5iGnRNY8creWUKtwOgWFnWNs2U8osw1PpE4QZRuvf04f5zNMVgHb
 U7CmZdOajiEwftvu8UGxQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Ux5+EUTetbA=:aPbGu+N4vjfgHJtspGTMCy
 PZ/nQ4dYH1jXv4PIAuNge28W2G/L9HC7Q4YcxzPTcuq4e4CWbqA2684F1NZxWYteeJc7Gyvx0
 y38BpQ6wazhwYaUuCkhxCcJd3kSRnlte55yR4CXtC0eLZ7mUmH7984Jr+/PlSxqEMibPelsNt
 M6VwJYAtWBG2kYjTV1uGCzLC316Nc2t7GHFdxCUAC877QTAR/hJltUn6HKQNKjr5Uppwrbwwz
 Z7UHUsV/uHFKOeimtsJlVPWu+kyN/+4MwKm1omYdSjL6EzP3dqqVnzZwLhGZEyFjAoZYsme2H
 rnp8vslzLzkzMNSM7Skge2kT+CZTtElYG6hY9Ghyz6wu99qGmuIwyqogisiG3DWwxxPA14gAu
 JAIDr7+N8sDcqtroUQ+u4B2jHMshJ6xjkxvbYNpF9LE9cHe/fPVmYEIPmktSPhs+SDol/EZLO
 B7jEh9Ij81XPXG9kq7n9C2AvrJcx6wkUl8Rls1evy0TRWeT5a7P+c5HBISAVC3NLUWuxvn/W4
 MNDtKlxTSZoOx03mpY5WmBSnnZ1s4L4mgwY2qkAcOsklSQRK235rTqQXx9gli1bTZ326xsuD0
 Q0nXGbpzPAp6KKWzTGgugCFOcxDVVcD5WOJdZy8Q4rBhwR9kKwBJ0M0cu3wOfOtJSv/omMtyY
 5QHLZBwgBKM8g/0t7njE+AFsVuPejge4RbGry4gypUoYCKFeaMRa34V62mXao1qAGnCQOAXTI
 Mh1FKcqI0aYvXCf8M/WMYYWMrnMNUuu03PEIuQowBIT9FiZt6WrqW5Shtaw5qvKUZSPqkAREg
 9uD9ljF
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
index bbe31ed..c3b8563 100644
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
+	fputc(first, file);
+	fwrite(begin, 1, end-begin, file);
+	fputs(reset, file);
+	fputc('\n', file);
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
2.9.0.118.gce770ba.dirty


