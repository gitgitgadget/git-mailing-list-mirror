From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Tue, 7 Feb 2012 13:23:02 -0500
Message-ID: <20120207182302.GA31059@sigill.intra.peff.net>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095346.GA4300@sigill.intra.peff.net>
 <7vbopb61cd.fsf@alter.siamese.dyndns.org>
 <20120207180625.GA27189@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 19:23:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruph9-0002oE-U1
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 19:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178Ab2BGSXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 13:23:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59342
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab2BGSXF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 13:23:05 -0500
Received: (qmail 9730 invoked by uid 107); 7 Feb 2012 18:30:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 13:30:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 13:23:02 -0500
Content-Disposition: inline
In-Reply-To: <20120207180625.GA27189@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190193>

On Tue, Feb 07, 2012 at 01:06:25PM -0500, Jeff King wrote:

> So I think we could go back and simplify the userdiff_config code now.

That patch would look like this.

-- >8 --
Subject: drop odd return value semantics from userdiff_config

When the userdiff_config function was introduced in be58e70
(diff: unify external diff and funcname parsing code,
2008-10-05), it used a return value convention unlike any
other config callback. Like other callbacks, it used "-1" to
signal error. But it returned "1" to indicate that it found
something, and "0" otherwise; other callbacks simply
returned "0" to indicate that no error occurred.

This distinction was necessary at the time, because the
userdiff namespace overlapped slightly with the color
configuration namespace. So "diff.color.foo" could mean "the
'foo' slot of diff coloring" or "the 'foo' component of the
"color" userdiff driver". Because the color-parsing code
would die on an unknown color slot, we needed the userdiff
code to indicate that it had matched the variable, letting
us bypass the color-parsing code entirely.

Later, in 8b8e862 (ignore unknown color configuration,
2009-12-12), the color-parsing code learned to silently
ignore unknown slots. This means we no longer need to
protect userdiff-matched variables from reaching the
color-parsing code.

We can therefore change the userdiff_config calling
convention to a more normal one. This drops some code from
each caller, which is nice. But more importantly, it reduces
the cognitive load for readers who may wonder why
userdiff_config is unlike every other config callback.

There's no need to add a new test confirming that this
works; t4020 already contains a test that sets
diff.color.external.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c    |    8 +-------
 builtin/cat-file.c |    8 +-------
 builtin/grep.c     |    7 ++-----
 diff.c             |    7 ++-----
 userdiff.c         |   19 ++++++-------------
 5 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 5a67c20..01956c8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2050,14 +2050,8 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	switch (userdiff_config(var, value)) {
-	case 0:
-		break;
-	case -1:
+	if (userdiff_config(var, value) < 0)
 		return -1;
-	default:
-		return 0;
-	}
 
 	return git_default_config(var, value, cb);
 }
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 07bd984..8ed501f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -226,14 +226,8 @@ static const char * const cat_file_usage[] = {
 
 static int git_cat_file_config(const char *var, const char *value, void *cb)
 {
-	switch (userdiff_config(var, value)) {
-	case 0:
-		break;
-	case -1:
+	if (userdiff_config(var, value) < 0)
 		return -1;
-	default:
-		return 0;
-	}
 
 	return git_default_config(var, value, cb);
 }
diff --git a/builtin/grep.c b/builtin/grep.c
index 5c2ae94..dc6de83 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -325,11 +325,8 @@ static int grep_config(const char *var, const char *value, void *cb)
 	struct grep_opt *opt = cb;
 	char *color = NULL;
 
-	switch (userdiff_config(var, value)) {
-	case 0: break;
-	case -1: return -1;
-	default: return 0;
-	}
+	if (userdiff_config(var, value) < 0)
+		return -1;
 
 	if (!strcmp(var, "grep.extendedregexp")) {
 		if (git_config_bool(var, value))
diff --git a/diff.c b/diff.c
index 7e15426..a656f5e 100644
--- a/diff.c
+++ b/diff.c
@@ -177,11 +177,8 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	switch (userdiff_config(var, value)) {
-		case 0: break;
-		case -1: return -1;
-		default: return 0;
-	}
+	if (userdiff_config(var, value) < 0)
+		return -1;
 
 	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
 		int slot = parse_diff_color_slot(var, 11);
diff --git a/userdiff.c b/userdiff.c
index 76109da..1e7184f 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -210,14 +210,7 @@ static int parse_funcname(struct userdiff_funcname *f, const char *k,
 	if (git_config_string(&f->pattern, k, v) < 0)
 		return -1;
 	f->cflags = cflags;
-	return 1;
-}
-
-static int parse_string(const char **d, const char *k, const char *v)
-{
-	if (git_config_string(d, k, v) < 0)
-		return -1;
-	return 1;
+	return 0;
 }
 
 static int parse_tristate(int *b, const char *k, const char *v)
@@ -226,13 +219,13 @@ static int parse_tristate(int *b, const char *k, const char *v)
 		*b = -1;
 	else
 		*b = git_config_bool(k, v);
-	return 1;
+	return 0;
 }
 
 static int parse_bool(int *b, const char *k, const char *v)
 {
 	*b = git_config_bool(k, v);
-	return 1;
+	return 0;
 }
 
 int userdiff_config(const char *k, const char *v)
@@ -246,13 +239,13 @@ int userdiff_config(const char *k, const char *v)
 	if ((drv = parse_driver(k, v, "binary")))
 		return parse_tristate(&drv->binary, k, v);
 	if ((drv = parse_driver(k, v, "command")))
-		return parse_string(&drv->external, k, v);
+		return git_config_string(&drv->external, k, v);
 	if ((drv = parse_driver(k, v, "textconv")))
-		return parse_string(&drv->textconv, k, v);
+		return git_config_string(&drv->textconv, k, v);
 	if ((drv = parse_driver(k, v, "cachetextconv")))
 		return parse_bool(&drv->textconv_want_cache, k, v);
 	if ((drv = parse_driver(k, v, "wordregex")))
-		return parse_string(&drv->word_regex, k, v);
+		return git_config_string(&drv->word_regex, k, v);
 
 	return 0;
 }
-- 
1.7.8.4.12.g3a22e3
