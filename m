From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2 1/4] diff.c: return pattern entry pointer rather than just
 the hunk header pattern
Date: Thu, 18 Sep 2008 17:40:48 -0500
Message-ID: <hvD4CKeY-shT7TB0JLaQn02KLTvzB720kcwBxBfYbo3S2ySzNzsn9g@cipher.nrlssc.navy.mil>
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
X-From: git-owner@vger.kernel.org Fri Sep 19 00:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgSEY-0006ED-Vb
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 00:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601AbYIRWmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 18:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755038AbYIRWmu
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 18:42:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33097 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbYIRWmt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 18:42:49 -0400
Received: by mail.nrlssc.navy.mil id m8IMeo20001680; Thu, 18 Sep 2008 17:40:50 -0500
In-Reply-To: <7vskry1485.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Sep 2008 22:40:50.0052 (UTC) FILETIME=[9980B440:01C919DF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96247>

This is in preparation for associating a flag with each pattern which will
control how the pattern is interpreted. For example, as a basic or extended
regular expression.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> diff --git a/diff.c b/diff.c
>> index 998dcaa..e040088 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -94,6 +94,8 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
>>   * 'diff.<what>.funcname' attribute can be specified in the configuration
>>   * to define a customized regexp to find the beginning of a function to
>>   * be used for hunk header lines of "diff -p" style output.
>> + * Note: If this structure is modified, it must retain the ability to be cast
>> + * to a struct funcname_pattern_entry, defined elsewhere.
>>   */
> 
> Yuck.  Why not do:
> 
> 	struct funcname_pattern_entry {
>         	/* whatever fields one entry needs */
> 	};
>         static struct funcname_pattern_list {
>         	struct funcname_pattern_list *next;
>         	struct funcname_pattern_entry e;
> 	} *funcname_pattern_list;

<...>

> Then you do not have to worry about casting things up and down, right?


 diff.c |   55 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/diff.c b/diff.c
index 998dcaa..3928124 100644
--- a/diff.c
+++ b/diff.c
@@ -95,32 +95,35 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
  * to define a customized regexp to find the beginning of a function to
  * be used for hunk header lines of "diff -p" style output.
  */
-static struct funcname_pattern {
+struct funcname_pattern_entry {
 	char *name;
 	char *pattern;
-	struct funcname_pattern *next;
+};
+static struct funcname_pattern_list {
+	struct funcname_pattern_list *next;
+	struct funcname_pattern_entry e;
 } *funcname_pattern_list;
 
 static int parse_funcname_pattern(const char *var, const char *ep, const char *value)
 {
 	const char *name;
 	int namelen;
-	struct funcname_pattern *pp;
+	struct funcname_pattern_list *pp;
 
 	name = var + 5; /* "diff." */
 	namelen = ep - name;
 
 	for (pp = funcname_pattern_list; pp; pp = pp->next)
-		if (!strncmp(pp->name, name, namelen) && !pp->name[namelen])
+		if (!strncmp(pp->e.name, name, namelen) && !pp->e.name[namelen])
 			break;
 	if (!pp) {
 		pp = xcalloc(1, sizeof(*pp));
-		pp->name = xmemdupz(name, namelen);
+		pp->e.name = xmemdupz(name, namelen);
 		pp->next = funcname_pattern_list;
 		funcname_pattern_list = pp;
 	}
-	free(pp->pattern);
-	pp->pattern = xstrdup(value);
+	free(pp->e.pattern);
+	pp->e.pattern = xstrdup(value);
 	return 0;
 }
 
@@ -1382,20 +1385,17 @@ int diff_filespec_is_binary(struct diff_filespec *one)
 	return one->is_binary;
 }
 
-static const char *funcname_pattern(const char *ident)
+static const struct funcname_pattern_entry *funcname_pattern(const char *ident)
 {
-	struct funcname_pattern *pp;
+	struct funcname_pattern_list *pp;
 
 	for (pp = funcname_pattern_list; pp; pp = pp->next)
-		if (!strcmp(ident, pp->name))
-			return pp->pattern;
+		if (!strcmp(ident, pp->e.name))
+			return &pp->e;
 	return NULL;
 }
 
-static struct builtin_funcname_pattern {
-	const char *name;
-	const char *pattern;
-} builtin_funcname_pattern[] = {
+static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
 	{ "bibtex", "\\(@[a-zA-Z]\\{1,\\}[ \t]*{\\{0,1\\}[ \t]*[^ \t\"@',\\#}{~%]*\\).*$" },
 	{ "html", "^\\s*\\(<[Hh][1-6]\\s.*>.*\\)$" },
 	{ "java", "!^[ 	]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
@@ -1415,9 +1415,10 @@ static struct builtin_funcname_pattern {
 	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$" },
 };
 
-static const char *diff_funcname_pattern(struct diff_filespec *one)
+static const struct funcname_pattern_entry *diff_funcname_pattern(struct diff_filespec *one)
 {
-	const char *ident, *pattern;
+	const char *ident;
+	const struct funcname_pattern_entry *pe;
 	int i;
 
 	diff_filespec_check_attr(one);
@@ -1432,9 +1433,9 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 		return funcname_pattern("default");
 
 	/* Look up custom "funcname.$ident" regexp from config. */
-	pattern = funcname_pattern(ident);
-	if (pattern)
-		return pattern;
+	pe = funcname_pattern(ident);
+	if (pe)
+		return pe;
 
 	/*
 	 * And define built-in fallback patterns here.  Note that
@@ -1442,7 +1443,7 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 	 */
 	for (i = 0; i < ARRAY_SIZE(builtin_funcname_pattern); i++)
 		if (!strcmp(ident, builtin_funcname_pattern[i].name))
-			return builtin_funcname_pattern[i].pattern;
+			return &builtin_funcname_pattern[i];
 
 	return NULL;
 }
@@ -1520,11 +1521,11 @@ static void builtin_diff(const char *name_a,
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
-		const char *funcname_pattern;
+		const struct funcname_pattern_entry *pe;
 
-		funcname_pattern = diff_funcname_pattern(one);
-		if (!funcname_pattern)
-			funcname_pattern = diff_funcname_pattern(two);
+		pe = diff_funcname_pattern(one);
+		if (!pe)
+			pe = diff_funcname_pattern(two);
 
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
@@ -1536,8 +1537,8 @@ static void builtin_diff(const char *name_a,
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
-		if (funcname_pattern)
-			xdiff_set_find_func(&xecfg, funcname_pattern);
+		if (pe)
+			xdiff_set_find_func(&xecfg, pe->pattern);
 		if (!diffopts)
 			;
 		else if (!prefixcmp(diffopts, "--unified="))
-- 
1.6.0.1.244.gdc19
