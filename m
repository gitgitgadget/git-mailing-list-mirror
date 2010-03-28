From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] textconv: refactor calls to run_textconv
Date: Sun, 28 Mar 2010 10:53:42 -0400
Message-ID: <20100328145342.GA27970@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 28 16:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvtsD-00012A-RO
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 16:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab0C1Oxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 10:53:52 -0400
Received: from peff.net ([208.65.91.99]:60638 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687Ab0C1Oxv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 10:53:51 -0400
Received: (qmail 24146 invoked by uid 107); 28 Mar 2010 14:54:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 10:54:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 10:53:42 -0400
Content-Disposition: inline
In-Reply-To: <20100328145301.GA26213@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143390>

This patch adds a fill_textconv wrapper, which centralizes
some minor logic like error checking and handling the case
of no-textconv.

In addition to dropping the number of lines, this will make
it easier in future patches to handle multiple types of
textconv.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c |   58 ++++++++++++++++++++++++----------------------------------
 1 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/diff.c b/diff.c
index f5d93e9..3ddc05e 100644
--- a/diff.c
+++ b/diff.c
@@ -43,7 +43,8 @@ static char diff_colors[][COLOR_MAXLEN] = {
 };
 
 static void diff_filespec_load_driver(struct diff_filespec *one);
-static char *run_textconv(const char *, struct diff_filespec *, size_t *);
+static size_t fill_textconv(const char *cmd,
+		struct diff_filespec *df, char **outbuf);
 
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
 
@@ -501,24 +502,8 @@ static void emit_rewrite_diff(const char *name_a,
 
 	diff_populate_filespec(one, 0);
 	diff_populate_filespec(two, 0);
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
@@ -1713,20 +1698,8 @@ static void builtin_diff(const char *name_a,
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
@@ -3907,3 +3880,20 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 
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
1.7.0.3.294.g8e730.dirty
