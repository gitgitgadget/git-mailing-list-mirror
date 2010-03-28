From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] textconv: refactor to handle multiple textconv types
Date: Sun, 28 Mar 2010 10:53:52 -0400
Message-ID: <20100328145352.GB27970@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 28 16:54:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvtsQ-00018G-6E
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 16:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab0C1OyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 10:54:05 -0400
Received: from peff.net ([208.65.91.99]:60640 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687Ab0C1OyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 10:54:03 -0400
Received: (qmail 24168 invoked by uid 107); 28 Mar 2010 14:54:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 10:54:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 10:53:52 -0400
Content-Disposition: inline
In-Reply-To: <20100328145301.GA26213@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143391>

We pass around textconv information as a string which is
either NULL (no textconv) or not (and contains the textconv
command). In preparation for handling multiple types of
textconv interface, this patch converts it into a struct
with an "interface" field.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c     |   26 ++++++++++++++++----------
 userdiff.c |    9 ++++++++-
 userdiff.h |   12 +++++++++++-
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 3ddc05e..0d31320 100644
--- a/diff.c
+++ b/diff.c
@@ -43,7 +43,7 @@ static char diff_colors[][COLOR_MAXLEN] = {
 };
 
 static void diff_filespec_load_driver(struct diff_filespec *one);
-static size_t fill_textconv(const char *cmd,
+static size_t fill_textconv(struct userdiff_extcmd *cmd,
 		struct diff_filespec *df, char **outbuf);
 
 static int parse_diff_color_slot(const char *var, int ofs)
@@ -466,8 +466,8 @@ static void emit_rewrite_diff(const char *name_a,
 			      const char *name_b,
 			      struct diff_filespec *one,
 			      struct diff_filespec *two,
-			      const char *textconv_one,
-			      const char *textconv_two,
+			      struct userdiff_extcmd *textconv_one,
+			      struct userdiff_extcmd *textconv_two,
 			      struct diff_options *o)
 {
 	int lc_a, lc_b;
@@ -1567,14 +1567,16 @@ void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const
 		options->b_prefix = b;
 }
 
-static const char *get_textconv(struct diff_filespec *one)
+static struct userdiff_extcmd *get_textconv(struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return NULL;
 	if (!S_ISREG(one->mode))
 		return NULL;
 	diff_filespec_load_driver(one);
-	return one->driver->textconv;
+	if (!one->driver->textconv.interface)
+		return NULL;
+	return &one->driver->textconv;
 }
 
 static void builtin_diff(const char *name_a,
@@ -1591,7 +1593,7 @@ static void builtin_diff(const char *name_a,
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 	const char *a_prefix, *b_prefix;
-	const char *textconv_one = NULL, *textconv_two = NULL;
+	struct userdiff_extcmd *textconv_one = NULL, *textconv_two = NULL;
 	struct strbuf header = STRBUF_INIT;
 
 	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
@@ -3848,7 +3850,7 @@ void diff_unmerge(struct diff_options *options,
 	diff_queue(&diff_queued_diff, one, two)->is_unmerged = 1;
 }
 
-static char *run_textconv(const char *pgm, struct diff_filespec *spec,
+static char *run_textconv_simple(const char *pgm, struct diff_filespec *spec,
 		size_t *outsize)
 {
 	struct diff_tempfile *temp;
@@ -3881,18 +3883,22 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	return strbuf_detach(&buf, outsize);
 }
 
-static size_t fill_textconv(const char *cmd,
+static size_t fill_textconv(struct userdiff_extcmd *cmd,
 			    struct diff_filespec *df,
 			    char **outbuf)
 {
 	size_t size;
 
-	if (!cmd) {
+	if (!cmd || !cmd->interface) {
 		*outbuf = df->data;
 		return df->size;
 	}
 
-	*outbuf = run_textconv(cmd, df, &size);
+	if (cmd->interface == USERDIFF_EXTCMD_SIMPLE)
+		*outbuf = run_textconv_simple(cmd->cmd, df, &size);
+	else
+		die("BUG: invalid internal textconv type");
+
 	if (!*outbuf)
 		die("unable to read files to diff");
 	return size;
diff --git a/userdiff.c b/userdiff.c
index df99249..6850f21 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -158,6 +158,13 @@ static int parse_string(const char **d, const char *k, const char *v)
 	return 1;
 }
 
+static int parse_extcmd(struct userdiff_extcmd *e, const char *k,
+		const char *v)
+{
+	e->interface = USERDIFF_EXTCMD_SIMPLE;
+	return parse_string(&e->cmd, k, v);
+}
+
 static int parse_tristate(int *b, const char *k, const char *v)
 {
 	if (v && !strcasecmp(v, "auto"))
@@ -180,7 +187,7 @@ int userdiff_config(const char *k, const char *v)
 	if ((drv = parse_driver(k, v, "command")))
 		return parse_string(&drv->external, k, v);
 	if ((drv = parse_driver(k, v, "textconv")))
-		return parse_string(&drv->textconv, k, v);
+		return parse_extcmd(&drv->textconv, k, v);
 	if ((drv = parse_driver(k, v, "wordregex")))
 		return parse_string(&drv->word_regex, k, v);
 
diff --git a/userdiff.h b/userdiff.h
index c315159..0c1ac06 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -6,13 +6,23 @@ struct userdiff_funcname {
 	int cflags;
 };
 
+enum userdiff_extcmd_interface {
+	USERDIFF_EXTCMD_NONE = 0,
+	USERDIFF_EXTCMD_SIMPLE,
+};
+
+struct userdiff_extcmd {
+	const char *cmd;
+	enum userdiff_extcmd_interface interface;
+};
+
 struct userdiff_driver {
 	const char *name;
 	const char *external;
 	int binary;
 	struct userdiff_funcname funcname;
 	const char *word_regex;
-	const char *textconv;
+	struct userdiff_extcmd textconv;
 };
 
 int userdiff_config(const char *k, const char *v);
-- 
1.7.0.3.294.g8e730.dirty
