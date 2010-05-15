From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 2/7] Change to call the new emit_line.
Date: Sat, 15 May 2010 04:02:06 -0700
Message-ID: <1273921331-32702-3-git-send-email-struggleyb.nku@gmail.com>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-2-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 13:02:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODF8V-0007jL-DH
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 13:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab0EOLCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 07:02:18 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56582 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab0EOLCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 07:02:15 -0400
Received: by pwi10 with SMTP id 10so1055800pwi.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lvb3CkOMHDx+wZZFUKw5b2k0P+4IR3xmFtaZwIJm0GM=;
        b=r3g60oyIADXkWnx9gHgIbx+6BGEMc+vFUOmz4zm/3nUiUbdaxV64PK1+1i24qBsVZI
         +RnaYeF+dQ33Ayqy/4j67CNgrFmirmmLe74PQn8DILiCmvbWUN+XpabChWwI6W6XEC0Z
         fF6fIKEGQ81CX6pJCMj8fc6Pa+HvSJFi+qBkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k9J7MAgkpasrxVLYaOdjLgtagLXw2qa8tnsvNuLuFfGof8ljMxMEY55+szdXtHUYZl
         sW+Q67tz/M8F8NRSXIbKypkxQgOKPr459ccLzjp8g5FHwyXD9PTCEcCIH6GIcxQ//WjL
         gU4B18UcstVVKr2RUEEr6p21td3Ft80SfURM4=
Received: by 10.115.39.17 with SMTP id r17mr2169169waj.40.1273921334392;
        Sat, 15 May 2010 04:02:14 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id d16sm28703988wam.12.2010.05.15.04.02.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 04:02:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1273921331-32702-2-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147140>

Call the new emit_line function.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 2a38bef..9bd9063 100644
--- a/diff.c
+++ b/diff.c
@@ -194,8 +194,8 @@ struct emit_callback {
 	sane_truncate_fn truncate;
 	const char **label_path;
 	struct diff_words_data *diff_words;
+	struct diff_options *opt;
 	int *found_changesp;
-	FILE *file;
 	struct strbuf *header;
 };
 
@@ -346,15 +346,15 @@ static void emit_add_line(const char *reset,
 	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_NEW);
 
 	if (!*ws)
-		emit_line_0(ecbdata->file, set, reset, '+', line, len);
+		emit_line_0(ecbdata->opt, set, reset, '+', line, len);
 	else if (new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->file, ws, reset, '+', line, len);
+		emit_line_0(ecbdata->opt, ws, reset, '+', line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->file, set, reset, '+', "", 0);
+		emit_line_0(ecbdata->opt, set, reset, '+', "", 0);
 		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->file, set, reset, ws);
+			      ecbdata->opt->file, set, reset, ws);
 	}
 }
 
@@ -375,23 +375,23 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->file, plain, reset, line, len);
+		emit_line(ecbdata->opt, plain, reset, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
 
 	/* The hunk header in fraginfo color */
-	emit_line(ecbdata->file, frag, reset, line, ep - line);
+	emit_line(ecbdata->opt, frag, reset, line, ep - line);
 
 	/* blank before the func header */
 	for (cp = ep; ep - line < len; ep++)
 		if (*ep != ' ' && *ep != '\t')
 			break;
 	if (ep != cp)
-		emit_line(ecbdata->file, plain, reset, cp, ep - cp);
+		emit_line(ecbdata->opt, plain, reset, cp, ep - cp);
 
 	if (ep < line + len)
-		emit_line(ecbdata->file, func, reset, ep, line + len - ep);
+		emit_line(ecbdata->opt, func, reset, ep, line + len - ep);
 }
 
 static struct diff_tempfile *claim_diff_tempfile(void) {
@@ -451,7 +451,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
 			ecb->lno_in_preimage++;
-			emit_line_0(ecb->file, old, reset, '-',
+			emit_line_0(ecb->opt, old, reset, '-',
 				    data, len);
 		} else {
 			ecb->lno_in_postimage++;
@@ -463,7 +463,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 	if (!endp) {
 		const char *plain = diff_get_color(ecb->color_diff,
 						   DIFF_PLAIN);
-		emit_line_0(ecb->file, plain, reset, '\\',
+		emit_line_0(ecb->opt, plain, reset, '\\',
 			    nneof, strlen(nneof));
 	}
 }
@@ -513,7 +513,7 @@ static void emit_rewrite_diff(const char *name_a,
 	ecbdata.color_diff = color_diff;
 	ecbdata.found_changesp = &o->found_changes;
 	ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
-	ecbdata.file = o->file;
+	ecbdata.opt = o;
 	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
 		mmfile_t mf1, mf2;
 		mf1.ptr = (char *)data_one;
@@ -828,7 +828,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	if (len < 1) {
-		emit_line(ecbdata->file, reset, reset, line, len);
+		emit_line(ecbdata->opt, reset, reset, line, len);
 		return;
 	}
 
@@ -845,7 +845,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		diff_words_flush(ecbdata);
 		line++;
 		len--;
-		emit_line(ecbdata->file, plain, reset, line, len);
+		emit_line(ecbdata->opt, plain, reset, line, len);
 		return;
 	}
 
@@ -856,7 +856,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->lno_in_preimage++;
 		if (line[0] == ' ')
 			ecbdata->lno_in_postimage++;
-		emit_line(ecbdata->file, color, reset, line, len);
+		emit_line(ecbdata->opt, color, reset, line, len);
 	} else {
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
@@ -1421,7 +1421,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		fprintf(data->o->file, "%s:%d: %s.\n",
 			data->filename, data->lineno, err);
 		free(err);
-		emit_line(data->o->file, set, reset, line, 1);
+		emit_line(data->o, set, reset, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
@@ -1731,7 +1731,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
-		ecbdata.file = o->file;
+		ecbdata.opt = o;
 		ecbdata.header = header.len ? &header : NULL;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
-- 
1.7.1.94.gc3269
