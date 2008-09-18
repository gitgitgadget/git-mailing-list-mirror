From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/4] diff.c: return pattern entry pointer rather than just
 the hunk header pattern
Date: Wed, 17 Sep 2008 19:08:39 -0500
Message-ID: <bM_-9C7AsEGzvM1pnb0gAo_24GfK0SpJFM36WzkP4Ho@cipher.nrlssc.navy.mil>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 02:10:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg75v-0005l2-AC
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 02:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbYIRAIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 20:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbYIRAIo
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 20:08:44 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53253 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbYIRAIo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 20:08:44 -0400
Received: by mail.nrlssc.navy.mil id m8I08eXL008733; Wed, 17 Sep 2008 19:08:40 -0500
In-Reply-To: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Sep 2008 00:08:40.0954 (UTC) FILETIME=[B4CAC5A0:01C91922]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96152>

This is in preparation for associating a flag with each pattern which will
control how the pattern is interpreted. For example, as a basic or extended
regular expression.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Sorry for the dup, I forgot to add the list.


Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> It's too late to change diff.*.funcname now, but an alternative fix
>> which would probably not require every other platform to use GNU regex,
>> is to introduce a new funcname option which would allow extended regular
>> expression syntax and to convert the internal regular expressions to
>> that format.
> 
> That's a very sensible approach, I would agree.


 diff.c |   53 ++++++++++++++++++++++++++++++-----------------------
 1 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index 998dcaa..e040088 100644
--- a/diff.c
+++ b/diff.c
@@ -94,6 +94,8 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
  * 'diff.<what>.funcname' attribute can be specified in the configuration
  * to define a customized regexp to find the beginning of a function to
  * be used for hunk header lines of "diff -p" style output.
+ * Note: If this structure is modified, it must retain the ability to be cast
+ * to a struct funcname_pattern_entry, defined elsewhere.
  */
 static struct funcname_pattern {
 	char *name;
@@ -1382,17 +1384,11 @@ int diff_filespec_is_binary(struct diff_filespec *one)
 	return one->is_binary;
 }
 
-static const char *funcname_pattern(const char *ident)
-{
-	struct funcname_pattern *pp;
-
-	for (pp = funcname_pattern_list; pp; pp = pp->next)
-		if (!strcmp(ident, pp->name))
-			return pp->pattern;
-	return NULL;
-}
-
-static struct builtin_funcname_pattern {
+/*
+ * Note: The elements of this structure must be arranged so that they are
+ *       compatible with the elements of the funcname_pattern structure.
+ */
+static struct funcname_pattern_entry {
 	const char *name;
 	const char *pattern;
 } builtin_funcname_pattern[] = {
@@ -1415,9 +1411,20 @@ static struct builtin_funcname_pattern {
 	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$" },
 };
 
-static const char *diff_funcname_pattern(struct diff_filespec *one)
+static const struct funcname_pattern_entry *funcname_pattern(const char *ident)
+{
+	struct funcname_pattern *pp;
+
+	for (pp = funcname_pattern_list; pp; pp = pp->next)
+		if (!strcmp(ident, pp->name))
+			return (struct funcname_pattern_entry*) pp;
+	return NULL;
+}
+
+static const struct funcname_pattern_entry *diff_funcname_pattern(struct diff_filespec *one)
 {
-	const char *ident, *pattern;
+	const char *ident;
+	const struct funcname_pattern_entry *pe;
 	int i;
 
 	diff_filespec_check_attr(one);
@@ -1432,9 +1439,9 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
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
@@ -1442,7 +1449,7 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 	 */
 	for (i = 0; i < ARRAY_SIZE(builtin_funcname_pattern); i++)
 		if (!strcmp(ident, builtin_funcname_pattern[i].name))
-			return builtin_funcname_pattern[i].pattern;
+			return &builtin_funcname_pattern[i];
 
 	return NULL;
 }
@@ -1520,11 +1527,11 @@ static void builtin_diff(const char *name_a,
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
@@ -1536,8 +1543,8 @@ static void builtin_diff(const char *name_a,
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
