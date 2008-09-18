From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/4] diff.c: associate a flag with each pattern and use it
 for compiling regex
Date: Wed, 17 Sep 2008 19:10:02 -0500
Message-ID: <GZAEBf1BcP9-dznrIesxaE4Rb8bim6DpwDWCb9yWl99UVoQC9Dog0A@cipher.nrlssc.navy.mil>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd
X-From: git-owner@vger.kernel.org Thu Sep 18 02:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg77c-0006Rn-3S
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 02:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbYIRAKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 20:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYIRAKk
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 20:10:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53264 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbYIRAKj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 20:10:39 -0400
Received: by mail.nrlssc.navy.mil id m8I0A3fS008916; Wed, 17 Sep 2008 19:10:03 -0500
In-Reply-To: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Sep 2008 00:10:03.0582 (UTC) FILETIME=[E60ACDE0:01C91922]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96153>

This is in preparation for allowing extended regular expression patterns.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 diff.c            |   28 ++++++++++++++++------------
 xdiff-interface.c |    4 ++--
 xdiff-interface.h |    2 +-
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index e040088..4363d0d 100644
--- a/diff.c
+++ b/diff.c
@@ -100,10 +100,11 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
 static struct funcname_pattern {
 	char *name;
 	char *pattern;
+	int cflags;
 	struct funcname_pattern *next;
 } *funcname_pattern_list;
 
-static int parse_funcname_pattern(const char *var, const char *ep, const char *value)
+static int parse_funcname_pattern(const char *var, const char *ep, const char *value, int cflags)
 {
 	const char *name;
 	int namelen;
@@ -123,6 +124,7 @@ static int parse_funcname_pattern(const char *var, const char *ep, const char *v
 	}
 	free(pp->pattern);
 	pp->pattern = xstrdup(value);
+	pp->cflags = cflags;
 	return 0;
 }
 
@@ -191,7 +193,8 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 			if (!strcmp(ep, ".funcname")) {
 				if (!value)
 					return config_error_nonbool(var);
-				return parse_funcname_pattern(var, ep, value);
+				return parse_funcname_pattern(var, ep, value,
+					0);
 			}
 		}
 	}
@@ -1391,24 +1394,25 @@ int diff_filespec_is_binary(struct diff_filespec *one)
 static struct funcname_pattern_entry {
 	const char *name;
 	const char *pattern;
+	const int cflags;
 } builtin_funcname_pattern[] = {
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
 
 static const struct funcname_pattern_entry *funcname_pattern(const char *ident)
@@ -1544,7 +1548,7 @@ static void builtin_diff(const char *name_a,
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
