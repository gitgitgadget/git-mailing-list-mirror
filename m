Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D1E2018C
	for <e@80x24.org>; Wed, 22 Jun 2016 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbcFVPDF (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:03:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:61427 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbcFVPCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:02:07 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MQ7sF-1bJsec49Kt-005EIS; Wed, 22 Jun 2016 17:01:42
 +0200
Date:	Wed, 22 Jun 2016 17:01:39 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 03/10] line-log: respect diffopt's configured output file
 stream
In-Reply-To: <cover.1466607667.git.johannes.schindelin@gmx.de>
Message-ID: <778b8c0712a6a4baf8b25664e0682fe769cd3622.1466607667.git.johannes.schindelin@gmx.de>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ct6dz2LunII4IaX7dQ8VVpCQe3eb5BFISTxPhJb3YG1FK8qMX1s
 RRfqfKOuGkDjCwNKn8AJw6VttBazOQm0+gtmrD7UBsj79fQaGPvqDojMbKbuyVy4rj3ajXs
 a4QHEQqvjHYa/3QStwPyh3mhKbChIcb6Vmu0FG7cy6+lWbglEqauhHBzoVr1njDLunWT3J2
 IpOH237uSxjHAqqBjnH2A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:rcuknen1TK0=:wqkmTj/jgmfFntQnvaYi3e
 Tbj7xUmRC48aeC1otp9HFSJTadfp6MNBCFy8vDK9XpvnKOJJCPSQLilaWXEukYqFfVRwYwYXD
 KsQmSs4FK+riIcBYy9la5mtLLbHbioSEaST+VmFCuKipE8XEVHKjY4bGrR3GHNUTewpbh+rlu
 EISIJ9nz9aMeXNupgZincDlnJWduqEEXWZCaKRO69hGeyIoOF3Zr3dYWtRupW2HuK7cdBfqaO
 YW6B2kwzxR7i5tubjNNnyTTAtqXND2gLwCSdEayLXsuGxliD+b8kGMUi9Y2LDneQhhB8ubuW/
 r4VEtxd28NazNysCf1LKzW2yTYASvVURNsotBtXpA2vlngSDVjYuNd8O4y9FZHdJXHXPyX5nK
 1ekJYw09ZFtgILT8aVHH42vcn8odaXgc5PN+mhIw3OMk5EAiTgOGEOzQ5ragPMDIb7FJUHeul
 CZtBKePL77yZfnH4H+TBrb/dgJjHNLXE0e9Sm+bLb+a2Kwlasjzwt6LD+sqSc0l1izzo8vzK5
 S4mYCCVzzjbe+3ndt/+yB4fQDLKHQLqVJXP0+dH8YBHC70kz8wtLhsHe4G65/KvhF/mS/AVC7
 TSM8xm1Th+yOXMgD2/jbaZlEqwH7i8hmJ3P79/eU+7M6fUDzWscSH6OtOzAuqCCLG/Ey4O2bm
 PjwCOJuZyevBGBfSUZIFf10oP2fS//i1lPQyS16krkHFuepioXI1Ol6LhXvdRcprSezl0GW5z
 MJcIBT0Cbowkc9N8Kg/2WLDOLxL1e5kEDbv+6WNpn7p8pbmmYHL+HwdmtEBb28NubG+ggRl/S
 QPopI06
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


