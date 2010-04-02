From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] textconv: refactor calls to run_textconv
Date: Thu, 1 Apr 2010 20:09:26 -0400
Message-ID: <20100402000926.GE16462@coredump.intra.peff.net>
References: <20100402000159.GA15101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 02:09:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxUSG-0001Hl-2W
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 02:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759054Ab0DBAJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 20:09:40 -0400
Received: from peff.net ([208.65.91.99]:60286 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755611Ab0DBAJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 20:09:38 -0400
Received: (qmail 5227 invoked by uid 107); 2 Apr 2010 00:10:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Apr 2010 20:10:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Apr 2010 20:09:26 -0400
Content-Disposition: inline
In-Reply-To: <20100402000159.GA15101@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143766>

This patch adds a fill_textconv wrapper, which centralizes
some minor logic like error checking and handling the case
of no-textconv.

In addition to dropping the number of lines, this will make
it easier in future patches to handle multiple types of
textconv.

Signed-off-by: Jeff King <peff@peff.net>
---
Similar to 1/3 from the previous series, but fixes some deficiencies
there. Specifically, it handles !DIFF_FILE_VALID and filespec population
better, which makes fill_textconv a full replacement for fill_mmfile,
just with optional textconv-ing.

 diff.c |   66 +++++++++++++++++++++++++++++----------------------------------
 1 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/diff.c b/diff.c
index db2cd5d..9665d6d 100644
--- a/diff.c
+++ b/diff.c
@@ -43,7 +43,8 @@ static char diff_colors[][COLOR_MAXLEN] = {
 };
 
 static void diff_filespec_load_driver(struct diff_filespec *one);
-static char *run_textconv(const char *, struct diff_filespec *, size_t *);
+static size_t fill_textconv(const char *cmd,
+			    struct diff_filespec *df, char **outbuf);
 
 static int parse_diff_color_slot(const char *var, int ofs)
 {
@@ -477,7 +478,7 @@ static void emit_rewrite_diff(const char *name_a,
 	const char *reset = diff_get_color(color_diff, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
 	const char *a_prefix, *b_prefix;
-	const char *data_one, *data_two;
+	char *data_one, *data_two;
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
 
@@ -499,26 +500,8 @@ static void emit_rewrite_diff(const char *name_a,
 	quote_two_c_style(&a_name, a_prefix, name_a, 0);
 	quote_two_c_style(&b_name, b_prefix, name_b, 0);
 
-	diff_populate_filespec(one, 0);
-	diff_populate_filespec(two, 0);
-	if (textconv_one) {
-		data_one = run_textconv(textconv_one, one, &size_one);
-		if (!data_one)
-			die("unable to read files to diff");
-	}
-	else {
-		data_one = one->data;
-		size_one = one->size;
-	}
-	if (textconv_two) {
-		data_two = run_textconv(textconv_two, two, &size_two);
-		if (!data_two)
-			die("unable to read files to diff");
-	}
-	else {
-		data_two = two->data;
-		size_two = two->size;
-	}
+	size_one = fill_textconv(textconv_one, one, &data_one);
+	size_two = fill_textconv(textconv_two, two, &data_two);
 
 	memset(&ecbdata, 0, sizeof(ecbdata));
 	ecbdata.color_diff = color_diff;
@@ -1717,20 +1700,8 @@ static void builtin_diff(const char *name_a,
 			strbuf_reset(&header);
 		}
 
-		if (textconv_one) {
-			size_t size;
-			mf1.ptr = run_textconv(textconv_one, one, &size);
-			if (!mf1.ptr)
-				die("unable to read files to diff");
-			mf1.size = size;
-		}
-		if (textconv_two) {
-			size_t size;
-			mf2.ptr = run_textconv(textconv_two, two, &size);
-			if (!mf2.ptr)
-				die("unable to read files to diff");
-			mf2.size = size;
-		}
+		mf1.size = fill_textconv(textconv_one, one, &mf1.ptr);
+		mf2.size = fill_textconv(textconv_two, two, &mf2.ptr);
 
 		pe = diff_funcname_pattern(one);
 		if (!pe)
@@ -3916,3 +3887,26 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 
 	return strbuf_detach(&buf, outsize);
 }
+
+static size_t fill_textconv(const char *cmd,
+			    struct diff_filespec *df,
+			    char **outbuf)
+{
+	size_t size;
+
+	if (!cmd) {
+		if (!DIFF_FILE_VALID(df)) {
+			*outbuf = "";
+			return 0;
+		}
+		if (diff_populate_filespec(df, 0))
+			die("unable to read files to diff");
+		*outbuf = df->data;
+		return df->size;
+	}
+
+	*outbuf = run_textconv(cmd, df, &size);
+	if (!*outbuf)
+		die("unable to read files to diff");
+	return size;
+}
-- 
1.7.0.4.299.gba9d4
