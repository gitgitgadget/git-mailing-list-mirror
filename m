From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 094/104] diff: fix coloring of extended diff headers
Date: Wed, 26 May 2010 18:01:04 +1200
Message-ID: <1274853674-18521-94-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:06:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lA-0004LR-Jx
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933776Ab0EZGGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:25 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49309 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933652Ab0EZGGY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id D806C3390A;
	Wed, 26 May 2010 18:02:03 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qSvkMjJNRXdf; Wed, 26 May 2010 18:02:02 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 38B3B338DF;
	Wed, 26 May 2010 18:01:38 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147749>

From: Bert Wesarg <bert.wesarg@googlemail.com>

Coloring the extended headers where done as a whole not per line. less with
option -R (which is the default from git) does not support this coloring
mode because of performance reasons. The -r option would be an alternative
but has problems with lines that are longer than the screen. Therefore
stick to the idiom to color each line separately. The problem is, that the
result of ill_metainfo() will also be used as an parameter to an external
diff driver, so we need to disable coloring in this case.

Because coloring is now done inside fill_metainfo() we can simply add this
string to the diff header and therefore keep the last newline in the
extended header. This results also into the fact that the external diff
driver now gets this last newline too. Which is a change in behavior
but a good one.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |   61 +++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/diff.c b/diff.c
index d0ecbc3..7e508dd 100644
--- a/diff.c
+++ b/diff.c
@@ -1650,21 +1650,21 @@ static void builtin_diff(const char *name_a,
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
 		strbuf_addf(&header, "%snew file mode %06o%s\n", set, two->mode, reset);
-		if (xfrm_msg && xfrm_msg[0])
-			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
+		if (xfrm_msg)
+			strbuf_addstr(&header, xfrm_msg);
 	}
 	else if (lbl[1][0] == '/') {
 		strbuf_addf(&header, "%sdeleted file mode %06o%s\n", set, one->mode, reset);
-		if (xfrm_msg && xfrm_msg[0])
-			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
+		if (xfrm_msg)
+			strbuf_addstr(&header, xfrm_msg);
 	}
 	else {
 		if (one->mode != two->mode) {
 			strbuf_addf(&header, "%sold mode %06o%s\n", set, one->mode, reset);
 			strbuf_addf(&header, "%snew mode %06o%s\n", set, two->mode, reset);
 		}
-		if (xfrm_msg && xfrm_msg[0])
-			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
+		if (xfrm_msg)
+			strbuf_addstr(&header, xfrm_msg);
 
 		/*
 		 * we do not run diff between different kind
@@ -2323,30 +2323,36 @@ static void fill_metainfo(struct strbuf *msg,
 			  struct diff_filespec *one,
 			  struct diff_filespec *two,
 			  struct diff_options *o,
-			  struct diff_filepair *p)
+			  struct diff_filepair *p,
+			  int use_color)
 {
+	const char *set = diff_get_color(use_color, DIFF_METAINFO);
+	const char *reset = diff_get_color(use_color, DIFF_RESET);
+
 	strbuf_init(msg, PATH_MAX * 2 + 300);
 	switch (p->status) {
 	case DIFF_STATUS_COPIED:
-		strbuf_addf(msg, "similarity index %d%%", similarity_index(p));
-		strbuf_addstr(msg, "\ncopy from ");
+		strbuf_addf(msg, "%ssimilarity index %d%%",
+			    set, similarity_index(p));
+		strbuf_addf(msg, "%s\n%scopy from ", reset, set);
 		quote_c_style(name, msg, NULL, 0);
-		strbuf_addstr(msg, "\ncopy to ");
+		strbuf_addf(msg, "%s\n%scopy to ", reset, set);
 		quote_c_style(other, msg, NULL, 0);
-		strbuf_addch(msg, '\n');
+		strbuf_addf(msg, "%s\n", reset);
 		break;
 	case DIFF_STATUS_RENAMED:
-		strbuf_addf(msg, "similarity index %d%%", similarity_index(p));
-		strbuf_addstr(msg, "\nrename from ");
+		strbuf_addf(msg, "%ssimilarity index %d%%",
+			    set, similarity_index(p));
+		strbuf_addf(msg, "%s\n%srename from ", reset, set);
 		quote_c_style(name, msg, NULL, 0);
-		strbuf_addstr(msg, "\nrename to ");
+		strbuf_addf(msg, "%s\n%srename to ", reset, set);
 		quote_c_style(other, msg, NULL, 0);
-		strbuf_addch(msg, '\n');
+		strbuf_addf(msg, "%s\n", reset);
 		break;
 	case DIFF_STATUS_MODIFIED:
 		if (p->score) {
-			strbuf_addf(msg, "dissimilarity index %d%%\n",
-				    similarity_index(p));
+			strbuf_addf(msg, "%sdissimilarity index %d%%%s\n",
+				    set, similarity_index(p), reset);
 			break;
 		}
 		/* fallthru */
@@ -2363,15 +2369,13 @@ static void fill_metainfo(struct strbuf *msg,
 			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
 				abbrev = 40;
 		}
-		strbuf_addf(msg, "index %.*s..%.*s",
+		strbuf_addf(msg, "%sindex %.*s..%.*s", set,
 			    abbrev, sha1_to_hex(one->sha1),
 			    abbrev, sha1_to_hex(two->sha1));
 		if (one->mode == two->mode)
 			strbuf_addf(msg, " %06o", one->mode);
-		strbuf_addch(msg, '\n');
+		strbuf_addf(msg, "%s\n", reset);
 	}
-	if (msg->len)
-		strbuf_setlen(msg, msg->len - 1);
 }
 
 static void run_diff_cmd(const char *pgm,
@@ -2387,11 +2391,6 @@ static void run_diff_cmd(const char *pgm,
 	const char *xfrm_msg = NULL;
 	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
 
-	if (msg) {
-		fill_metainfo(msg, name, other, one, two, o, p);
-		xfrm_msg = msg->len ? msg->buf : NULL;
-	}
-
 	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
 		pgm = NULL;
 	else {
@@ -2400,6 +2399,16 @@ static void run_diff_cmd(const char *pgm,
 			pgm = drv->external;
 	}
 
+	if (msg) {
+		/*
+		 * don't use colors when the header is intended for an
+		 * external diff driver
+		 */
+		fill_metainfo(msg, name, other, one, two, o, p,
+			      DIFF_OPT_TST(o, COLOR_DIFF) && !pgm);
+		xfrm_msg = msg->len ? msg->buf : NULL;
+	}
+
 	if (pgm) {
 		run_external_diff(pgm, name, other, one, two, xfrm_msg,
 				  complete_rewrite);
-- 
1.7.1.rc2.333.gb2668
