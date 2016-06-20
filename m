Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17FF220179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbcFTK66 (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:58:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:60880 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545AbcFTK64 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:58:56 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lug4m-1bNZph0My0-00zmm0; Mon, 20 Jun 2016 12:58:49
 +0200
Date:	Mon, 20 Jun 2016 12:55:26 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/7] line-log: respect diffopt's configured output file
 stream
In-Reply-To: <cover.1466420060.git.johannes.schindelin@gmx.de>
Message-ID: <30c24f0e22085a4ba2fbfd16f8ba176e31420d5d.1466420060.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:J90cda2KvtPdm2RW1gA0VJ0SNlHQWyxvGSDMCOijEZJslVm9xIL
 31l30iq5uqH9/d4cUEhJtdmJ1O+yyeMgI9h9AAX7hKWzphAQhbl+6/Fd1tIW+WKKfjiCgyV
 U208ghbaybPvSHOTQ9qpJcO5UnvNTf/dPloaSQUKz136gbEfJWEEH5NDqH5gRFkxw6VPxJ1
 QQ7drD/i0S7W0z4KElIDA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:XhAJyXjQGxQ=:yJ4T9lK+/0wPzcHzSl6a6u
 tyrHK09IvATbOcLnhxymmVKO/anXFQ/kKuEpXLQTlVCgNiMvt4Dy8N2xm0E2hNWS0LtVc8UtG
 +KD1P+XFv8apEex+a2DIzD3C8cILv3oemI8NuoWNh9kVx7VajKCpyoT1DLu+Vo/VwYv9hrVVG
 ZYNrDvG1WVcdWwQpurtThj+BozKS0dgntEjMkmAqrafceESEPF8ePB9Haoek9G4M/XRr6nHrg
 CnbGGBtB/1EroyAMunavjuheQJYs7DbhLY2EYzHevQwdYtny4HM7A/Iubn88JQrImOH6yL3ax
 IW0n8F7X8q1+01iiHhoC/tUHfkfH6vta4Zw9DSfNCNU3C9PrB1tx2n2C17FEwvSvsqaNVprVW
 rLFUr7P9TmnafKSMzJ+eY9hQ6Qi3ENwpOM0I7Qsb79ytE1zdZOT580EAiLDKQW/mhWobTg595
 cU4EOb0j9htjjspYQ/GKap66SdJsvpVPHrj0lPqooWIQwRX9dRuQdn2Dh5I8zBc3HfKlyy5JR
 7FYcHB95Rc2UKKY3rfu7QiP+3vjkDSPgOs5Ubuogqlio7GvRy8T7N20lLWSKH/yQdUaolSeG3
 H/4Y+IBfcLLo1DVpEdjqBLmS/zajZyA6xCF2uCo6aXQaqYGXZRYB53Ii1lMiuM4/uT5JfegRc
 QnnxPfXUAyRfJnfoNDZaATte0ednLU/HXH9b0przbvh/7w2Uz2wth6B8EPa37F1XEb8T2K8ub
 Askz1TMcutVCB8s7MyXW9cWd97W66SeHSBH3pg9SfziMQ1DEoKRg/qKT6LSw532274zpiB3sy
 qEc7mbr
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
2.9.0.119.g370c5a9


