From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Wed, 1 Feb 2012 04:10:09 -0500
Message-ID: <20120201091009.GA20984@sigill.intra.peff.net>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
 <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
 <20120125214625.GA4666@sigill.intra.peff.net>
 <7vhazb3rtm.fsf@alter.siamese.dyndns.org>
 <20120201082005.GA32348@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 10:10:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsWCt-0001jB-57
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 10:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab2BAJKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 04:10:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52078
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188Ab2BAJKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 04:10:11 -0500
Received: (qmail 7627 invoked by uid 107); 1 Feb 2012 09:17:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Feb 2012 04:17:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2012 04:10:09 -0500
Content-Disposition: inline
In-Reply-To: <20120201082005.GA32348@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189503>

On Wed, Feb 01, 2012 at 03:20:05AM -0500, Jeff King wrote:

> Here's the bug-fix patch. Not quite ready for inclusion, as it obviously
> needs tests and a commit message. Also, we can cache the result of the
> userdiff lookup so the funcname code doesn't have to look it up again.

Actually, it's a little bit more complicated. I was looking at a
slightly old version of grep.c. Since 0579f91 (grep: enable threading
with -p and -W using lazy attribute lookup, 2011-12-12), the lookup
happens in lots of sub-functions, and locking is required.

So this is what the patch looks like with proper locking and caching of
the looked-up driver. It's quite messy because the cached driver pointer
has to get passed around quite a bit. And I'm not sure it buys that much
in practice. The cost of attribute lookup _is_ noticeable (which I'll
discuss below), but funcname lookup only happens when we get a grep hit.
So unless you are searching for something extremely common, you're only
going to do a lookup very occasionally (compared to the load of actually
searching through the files). So all of the messiness and caching may
not be worth the effort, as I wasn't able to measure a performance gain.

But there's more. Respecting binary attributes does mean looking up
attributes for _every_ file. And that has a noticeable impact. My
best-of-five for "git grep foo" on linux-2.6 went from 0.302s to 0.392s.
Yuck.

Part of the problem, I suspect, is that the attribute lookup code is
optimized for locality. We only unwind as much of the stack as we need,
so looking at "foo/bar/baz.c" after "foo/bar/bleep.c" is much cheaper
than looking at "some/other/directory.c". But with threaded grep, that
locality is likely lost, as we are mixing up attribute requests from
different threads.

Given that binary lookup means we need every file's gitattribute, it
might be better to look them up serially at the beginning of the
program, and then pass the resulting userdiff driver to grep_buffer
along with each path.

---
diff --git a/grep.c b/grep.c
index 486230b..3ca840a 100644
--- a/grep.c
+++ b/grep.c
@@ -829,15 +829,28 @@ static inline void grep_attr_unlock(struct grep_opt *opt)
 #define grep_attr_unlock(opt)
 #endif
 
-static int match_funcname(struct grep_opt *opt, const char *name, char *bol, char *eol)
+static struct userdiff_driver *get_cached_userdiff(struct grep_opt *opt,
+						   const char *path,
+						   struct userdiff_driver **drv)
 {
-	xdemitconf_t *xecfg = opt->priv;
-	if (xecfg && !xecfg->find_func) {
-		struct userdiff_driver *drv;
+	if (!*drv) {
 		grep_attr_lock(opt);
-		drv = userdiff_find_by_path(name);
+		*drv = userdiff_find_by_path(path);
+		if (!*drv)
+			*drv = userdiff_find_by_name("default");
 		grep_attr_unlock(opt);
-		if (drv && drv->funcname.pattern) {
+	}
+	return *drv;
+}
+
+static int match_funcname(struct grep_opt *opt, const char *name,
+			  struct userdiff_driver **drv_p,
+			  char *bol, char *eol)
+{
+	xdemitconf_t *xecfg = opt->priv;
+	if (xecfg && !xecfg->find_func) {
+		struct userdiff_driver *drv = get_cached_userdiff(opt, name, drv_p);
+		if (drv->funcname.pattern) {
 			const struct userdiff_funcname *pe = &drv->funcname;
 			xdiff_set_find_func(xecfg, pe->pattern, pe->cflags);
 		} else {
@@ -859,6 +872,7 @@ static int match_funcname(struct grep_opt *opt, const char *name, char *bol, cha
 }
 
 static void show_funcname_line(struct grep_opt *opt, const char *name,
+			       struct userdiff_driver **drv_p,
 			       char *buf, char *bol, unsigned lno)
 {
 	while (bol > buf) {
@@ -871,20 +885,21 @@ static void show_funcname_line(struct grep_opt *opt, const char *name,
 		if (lno <= opt->last_shown)
 			break;
 
-		if (match_funcname(opt, name, bol, eol)) {
+		if (match_funcname(opt, name, drv_p, bol, eol)) {
 			show_line(opt, bol, eol, name, lno, '=');
 			break;
 		}
 	}
 }
 
-static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
-			     char *bol, char *end, unsigned lno)
+static void show_pre_context(struct grep_opt *opt, const char *name,
+			     struct userdiff_driver **drv_p,
+			     char *buf, char *bol, char *end, unsigned lno)
 {
 	unsigned cur = lno, from = 1, funcname_lno = 0;
 	int funcname_needed = !!opt->funcname;
 
-	if (opt->funcbody && !match_funcname(opt, name, bol, end))
+	if (opt->funcbody && !match_funcname(opt, name, drv_p, bol, end))
 		funcname_needed = 2;
 
 	if (opt->pre_context < lno)
@@ -900,7 +915,7 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 		while (bol > buf && bol[-1] != '\n')
 			bol--;
 		cur--;
-		if (funcname_needed && match_funcname(opt, name, bol, eol)) {
+		if (funcname_needed && match_funcname(opt, name, drv_p, bol, eol)) {
 			funcname_lno = cur;
 			funcname_needed = 0;
 		}
@@ -908,7 +923,7 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 
 	/* We need to look even further back to find a function signature. */
 	if (opt->funcname && funcname_needed)
-		show_funcname_line(opt, name, buf, bol, cur);
+		show_funcname_line(opt, name, drv_p, buf, bol, cur);
 
 	/* Back forward. */
 	while (cur < lno) {
@@ -983,6 +998,17 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 	fwrite(buf, size, 1, stdout);
 }
 
+static int grep_buffer_is_binary(struct grep_opt *opt,
+				 const char *path,
+				 char *buf, unsigned long size,
+				 struct userdiff_driver **drv_p)
+{
+	struct userdiff_driver *drv = get_cached_userdiff(opt, path, drv_p);
+	if (drv && drv->binary != -1)
+		return drv->binary;
+	return buffer_is_binary(buf, size);
+}
+
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 char *buf, unsigned long size, int collect_hits)
 {
@@ -996,6 +1022,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	int show_function = 0;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 	xdemitconf_t xecfg;
+	struct userdiff_driver *drv = NULL;
 
 	if (!opt->output)
 		opt->output = std_output;
@@ -1017,11 +1044,11 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 
 	switch (opt->binary) {
 	case GREP_BINARY_DEFAULT:
-		if (buffer_is_binary(buf, size))
+		if (grep_buffer_is_binary(opt, name, buf, size, &drv))
 			binary_match_only = 1;
 		break;
 	case GREP_BINARY_NOMATCH:
-		if (buffer_is_binary(buf, size))
+		if (grep_buffer_is_binary(opt, name, buf, size, &drv))
 			return 0; /* Assume unmatch */
 		break;
 	case GREP_BINARY_TEXT:
@@ -1099,16 +1126,16 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 * pre-context lines, we would need to show them.
 			 */
 			if (opt->pre_context || opt->funcbody)
-				show_pre_context(opt, name, buf, bol, eol, lno);
+				show_pre_context(opt, name, &drv, buf, bol, eol, lno);
 			else if (opt->funcname)
-				show_funcname_line(opt, name, buf, bol, lno);
+				show_funcname_line(opt, name, &drv, buf, bol, lno);
 			show_line(opt, bol, eol, name, lno, ':');
 			last_hit = lno;
 			if (opt->funcbody)
 				show_function = 1;
 			goto next_line;
 		}
-		if (show_function && match_funcname(opt, name, bol, eol))
+		if (show_function && match_funcname(opt, name, &drv, bol, eol))
 			show_function = 0;
 		if (show_function ||
 		    (last_hit && lno <= last_hit + opt->post_context)) {
