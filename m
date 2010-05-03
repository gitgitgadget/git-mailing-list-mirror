From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] diff: fix coloring of extended diff headers
Date: Tue,  4 May 2010 00:38:07 +0200
Message-ID: <591c96c90ca049400a8c0df70f8b44061aeacba5.1272926169.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 04 00:38:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O94HU-0005lS-Vj
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 00:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab0ECWiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 18:38:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47658 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281Ab0ECWiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 18:38:22 -0400
Received: by wye20 with SMTP id 20so1944574wye.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 15:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hD7LaUyFuDmjdsdYMrY3pJu1tr663MBsQgeBdTyn1XQ=;
        b=W9xaWjxFkk1g4oKt2sjIrUf6YVrbStu52QsUxLCR8wYLCs4buTBbKSUV58rrT+QoTD
         MhTAYAdnr2cDnx+c6Qb4X76Jnsu0pR/+B/M61tD4Nz35vOZFp5nYKqfUUgdkNP8d8vZ/
         Kimes2PiL43kD8D7frDnjKErGGeH8xTpnuMKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CoPEeNGkm1M7ZLtCp1rdQNY0xe9K5oYgmX4OOt0F0it1/517a3mxTxfaNXcNt4FtWO
         8QCgx9rWyeRT5OugLaX12ItDXCWTdf0vb2SrAmlWCCxtM7WcBosj3DIhu+X2VWmdIgPx
         RG7tnFi+ODDlu8cphbpzS6b5aZGK7jPzSXU/4=
Received: by 10.227.153.211 with SMTP id l19mr438770wbw.228.1272926300409;
        Mon, 03 May 2010 15:38:20 -0700 (PDT)
Received: from localhost (drsd-4db3f31a.pool.mediaWays.net [77.179.243.26])
        by mx.google.com with ESMTPS id u8sm44478483wbc.11.2010.05.03.15.38.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 15:38:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc2.607.g01b23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146265>

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
1.7.1.rc2.620.g49a9d
