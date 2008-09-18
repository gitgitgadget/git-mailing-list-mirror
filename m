From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2 2/4] diff.c: associate a flag with each pattern and use
 it for compiling regex
Date: Thu, 18 Sep 2008 17:42:48 -0500
Message-ID: <vc3PiW75EtfA2s7uG7Mc0ZZihWefo_j7-_zka5gGEunnBX0XH27qfg@cipher.nrlssc.navy.mil>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 00:45:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgSF9-0006PW-Sq
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 00:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370AbYIRWnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 18:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755298AbYIRWnt
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 18:43:49 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33113 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbYIRWnt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 18:43:49 -0400
Received: by mail.nrlssc.navy.mil id m8IMgnPB001735; Thu, 18 Sep 2008 17:42:49 -0500
In-Reply-To: <7vskry1485.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Sep 2008 22:42:49.0057 (UTC) FILETIME=[E06F6D10:01C919DF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96248>

This is in preparation for allowing extended regular expression patterns.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 diff.c            |   27 +++++++++++++++------------
 xdiff-interface.c |    4 ++--
 xdiff-interface.h |    2 +-
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 3928124..08cdd8f 100644
--- a/diff.c
+++ b/diff.c
@@ -98,13 +98,14 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
 struct funcname_pattern_entry {
 	char *name;
 	char *pattern;
+	int cflags;
 };
 static struct funcname_pattern_list {
 	struct funcname_pattern_list *next;
 	struct funcname_pattern_entry e;
 } *funcname_pattern_list;
 
-static int parse_funcname_pattern(const char *var, const char *ep, const char *value)
+static int parse_funcname_pattern(const char *var, const char *ep, const char *value, int cflags)
 {
 	const char *name;
 	int namelen;
@@ -124,6 +125,7 @@ static int parse_funcname_pattern(const char *var, const char *ep, const char *v
 	}
 	free(pp->e.pattern);
 	pp->e.pattern = xstrdup(value);
+	pp->e.cflags = cflags;
 	return 0;
 }
 
@@ -192,7 +194,8 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 			if (!strcmp(ep, ".funcname")) {
 				if (!value)
 					return config_error_nonbool(var);
-				return parse_funcname_pattern(var, ep, value);
+				return parse_funcname_pattern(var, ep, value,
+					0);
 			}
 		}
 	}
@@ -1396,23 +1399,23 @@ static const struct funcname_pattern_entry *funcname_pattern(const char *ident)
 }
 
 static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
-	{ "bibtex", "\\(@[a-zA-Z]\\{1,\\}[ \t]*{\\{0,1\\}[ \t]*[^ \t\"@',\\#}{~%]*\\).*$" },
-	{ "html", "^\\s*\\(<[Hh][1-6]\\s.*>.*\\)$" },
+	{ "bibtex", "\\(@[a-zA-Z]\\{1,\\}[ \t]*{\\{0,1\\}[ \t]*[^ \t\"@',\\#}{~%]*\\).*$", 0 },
+	{ "html", "^\\s*\\(<[Hh][1-6]\\s.*>.*\\)$", 0 },
 	{ "java", "!^[ 	]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
 			"new\\|return\\|switch\\|throw\\|while\\)\n"
 			"^[ 	]*\\(\\([ 	]*"
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
-			"[ 	]*([^;]*\\)$" },
+			"[ 	]*([^;]*\\)$", 0 },
 	{ "pascal", "^\\(\\(procedure\\|function\\|constructor\\|"
 			"destructor\\|interface\\|implementation\\|"
 			"initialization\\|finalization\\)[ \t]*.*\\)$"
 			"\\|"
-			"^\\(.*=[ \t]*\\(class\\|record\\).*\\)$"
-			},
-	{ "php", "^[\t ]*\\(\\(function\\|class\\).*\\)" },
-	{ "python", "^\\s*\\(\\(class\\|def\\)\\s.*\\)$" },
-	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
-	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$" },
+			"^\\(.*=[ \t]*\\(class\\|record\\).*\\)$",
+			0 },
+	{ "php", "^[\t ]*\\(\\(function\\|class\\).*\\)", 0 },
+	{ "python", "^\\s*\\(\\(class\\|def\\)\\s.*\\)$", 0 },
+	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$", 0 },
+	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$", 0 },
 };
 
 static const struct funcname_pattern_entry *diff_funcname_pattern(struct diff_filespec *one)
@@ -1538,7 +1541,7 @@ static void builtin_diff(const char *name_a,
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (pe)
-			xdiff_set_find_func(&xecfg, pe->pattern);
+			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
 		if (!diffopts)
 			;
 		else if (!prefixcmp(diffopts, "--unified="))
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 944ad98..7f1a7d3 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -218,7 +218,7 @@ static long ff_regexp(const char *line, long len,
 	return result;
 }
 
-void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value)
+void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value, int cflags)
 {
 	int i;
 	struct ff_regs *regs;
@@ -243,7 +243,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value)
 			expression = buffer = xstrndup(value, ep - value);
 		else
 			expression = value;
-		if (regcomp(&reg->re, expression, 0))
+		if (regcomp(&reg->re, expression, cflags))
 			die("Invalid regexp to look for hunk header: %s", expression);
 		free(buffer);
 		value = ep + 1;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 558492b..23c49b9 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -16,6 +16,6 @@ int parse_hunk_header(char *line, int len,
 int read_mmfile(mmfile_t *ptr, const char *filename);
 int buffer_is_binary(const char *ptr, unsigned long size);
 
-extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line);
+extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 
 #endif
-- 
1.6.0.1.244.gdc19
