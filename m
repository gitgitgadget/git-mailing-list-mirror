From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Sun, 5 Oct 2008 17:43:36 -0400
Message-ID: <20081005214336.GC21925@coredump.intra.peff.net>
References: <20081005214114.GA21875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Oct 05 23:44:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmbPH-0001rR-6d
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 23:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbYJEVnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 17:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbYJEVnj
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 17:43:39 -0400
Received: from peff.net ([208.65.91.99]:2848 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754797AbYJEVni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 17:43:38 -0400
Received: (qmail 17896 invoked by uid 111); 5 Oct 2008 21:43:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 17:43:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 17:43:36 -0400
Content-Disposition: inline
In-Reply-To: <20081005214114.GA21875@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97540>

The "diff" gitattribute is somewhat overloaded right now. It
can say one of three things:

  1. this file is definitely binary, or definitely not
     (i.e., diff or !diff)
  2. this file should use an external diff engine (i.e.,
     diff=foo, diff.foo.command = custom-script)
  3. this file should use particular funcname patterns
     (i.e., diff=foo, diff.foo.(x?)funcname = some-regex)

Most of the time, there is no conflict between these uses,
since using one implies that the other is irrelevant (e.g.,
an external diff engine will decide for itself whether the
file is binary).

However, there is at least one conflicting situation: there
is no way to say "use the regular rules to determine whether
this file is binary, but if we do diff it textually, use
this funcname pattern." That is, currently setting diff=foo
indicates that the file is definitely text.

This patch introduces a "binary" config option for a diff
driver, so that one can explicitly set diff.foo.binary. We
default this value to "don't know". That is, setting a diff
attribute to "foo" and using "diff.foo.funcname" will have
no effect on the binaryness of a file. To get the current
behavior, one can set diff.foo.binary to true.

This patch also has one additional advantage: it cleans up
the interface to the userdiff code a bit. Before, calling
code had to know more about whether attributes were false,
true, or unset to determine binaryness. Now that binaryness
is a property of a driver, we can represent these situations
just by passing back a driver struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c     |   52 ++++++++++++++++++++++------------------------------
 diffcore.h |    8 ++++++--
 userdiff.c |   19 ++++++++++++++++---
 userdiff.h |    4 +---
 4 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/diff.c b/diff.c
index 08f335f..ba4f6fa 100644
--- a/diff.c
+++ b/diff.c
@@ -1271,46 +1271,37 @@ static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two)
 	emit_binary_diff_body(file, two, one);
 }
 
-static void diff_filespec_check_attr(struct diff_filespec *one)
+void diff_filespec_load_driver(struct diff_filespec *one)
 {
-	struct userdiff_driver *drv;
-	int check_from_data = 0;
-
-	if (one->checked_attr)
-		return;
-
-	drv = userdiff_find_by_path(one->path);
-	one->is_binary = 0;
-
-	/* binaryness */
-	if (drv == USERDIFF_ATTR_TRUE)
-		;
-	else if (drv == USERDIFF_ATTR_FALSE)
-		one->is_binary = 1;
-	else
-		check_from_data = 1;
-
-	if (check_from_data) {
-		if (!one->data && DIFF_FILE_VALID(one))
-			diff_populate_filespec(one, 0);
-
-		if (one->data)
-			one->is_binary = buffer_is_binary(one->data, one->size);
-	}
+	if (!one->driver)
+		one->driver = userdiff_find_by_path(one->path);
+	if (!one->driver)
+		one->driver = userdiff_find_by_name("default");
 }
 
 int diff_filespec_is_binary(struct diff_filespec *one)
 {
-	diff_filespec_check_attr(one);
+	if (one->is_binary == -1) {
+		diff_filespec_load_driver(one);
+		if (one->driver->binary != -1)
+			one->is_binary = one->driver->binary;
+		else {
+			if (!one->data && DIFF_FILE_VALID(one))
+				diff_populate_filespec(one, 0);
+			if (one->data)
+				one->is_binary = buffer_is_binary(one->data,
+						one->size);
+			if (one->is_binary == -1)
+				one->is_binary = 0;
+		}
+	}
 	return one->is_binary;
 }
 
 static const struct userdiff_funcname *diff_funcname_pattern(struct diff_filespec *one)
 {
-	struct userdiff_driver *drv = userdiff_find_by_path(one->path);
-	if (!drv)
-		drv = userdiff_find_by_name("default");
-	return drv && drv->funcname.pattern ? &drv->funcname : NULL;
+	diff_filespec_load_driver(one);
+	return one->driver->funcname.pattern ? &one->driver->funcname : NULL;
 }
 
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b)
@@ -1558,6 +1549,7 @@ struct diff_filespec *alloc_filespec(const char *path)
 	spec->path = (char *)(spec + 1);
 	memcpy(spec->path, path, namelen+1);
 	spec->count = 1;
+	spec->is_binary = -1;
 	return spec;
 }
 
diff --git a/diffcore.h b/diffcore.h
index 8ae3578..713cca7 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -22,6 +22,8 @@
 
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
 
+struct userdiff_driver;
+
 struct diff_filespec {
 	unsigned char sha1[20];
 	char *path;
@@ -40,8 +42,10 @@ struct diff_filespec {
 #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
-	unsigned checked_attr : 1;
-	unsigned is_binary : 1; /* data should be considered "binary" */
+
+	struct userdiff_driver *driver;
+	/* data should be considered "binary"; -1 means "don't know yet" */
+	int is_binary;
 };
 
 extern struct diff_filespec *alloc_filespec(const char *);
diff --git a/userdiff.c b/userdiff.c
index 3406adc..ac6d4a1 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -7,7 +7,7 @@ static int ndrivers;
 static int drivers_alloc;
 
 #define FUNCNAME(name, pattern) \
-	{ name, NULL, { pattern, REG_EXTENDED } }
+	{ name, NULL, -1, { pattern, REG_EXTENDED } }
 static struct userdiff_driver builtin_drivers[] = {
 FUNCNAME("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$"),
 FUNCNAME("java",
@@ -23,22 +23,23 @@ FUNCNAME("python", "^[ \t]*((class|def)[ \t].*)$"),
 FUNCNAME("ruby", "^[ \t]*((class|module|def)[ \t].*)$"),
 FUNCNAME("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$"),
 FUNCNAME("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$"),
+{ "default", NULL, -1, { NULL, 0 } },
 };
 #undef FUNCNAME
 
 static struct userdiff_driver driver_true = {
 	"diff=true",
 	NULL,
+	0,
 	{ NULL, 0 }
 };
-struct userdiff_driver *USERDIFF_ATTR_TRUE = &driver_true;
 
 static struct userdiff_driver driver_false = {
 	"!diff",
 	NULL,
+	1,
 	{ NULL, 0 }
 };
-struct userdiff_driver *USERDIFF_ATTR_FALSE = &driver_false;
 
 static struct userdiff_driver *userdiff_find_by_namelen(const char *k, int len)
 {
@@ -80,6 +81,7 @@ static struct userdiff_driver *parse_driver(const char *var,
 		drv = &drivers[ndrivers++];
 		memset(drv, 0, sizeof(*drv));
 		drv->name = xmemdupz(name, namelen);
+		drv->binary = -1;
 	}
 	return drv;
 }
@@ -100,6 +102,15 @@ static int parse_string(const char **d, const char *k, const char *v)
 	return 1;
 }
 
+static int parse_tristate(int *b, const char *k, const char *v)
+{
+	if (v && !strcasecmp(v, "auto"))
+		*b = -1;
+	else
+		*b = git_config_bool(k, v);
+	return 1;
+}
+
 int userdiff_config_basic(const char *k, const char *v)
 {
 	struct userdiff_driver *drv;
@@ -108,6 +119,8 @@ int userdiff_config_basic(const char *k, const char *v)
 		return parse_funcname(&drv->funcname, k, v, 0);
 	if ((drv = parse_driver(k, v, "xfuncname")))
 		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
+	if ((drv = parse_driver(k, v, "binary")))
+		return parse_tristate(&drv->binary, k, v);
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index c64c5f5..1c1eb04 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -9,12 +9,10 @@ struct userdiff_funcname {
 struct userdiff_driver {
 	const char *name;
 	const char *external;
+	int binary;
 	struct userdiff_funcname funcname;
 };
 
-extern struct userdiff_driver *USERDIFF_ATTR_TRUE;
-extern struct userdiff_driver *USERDIFF_ATTR_FALSE;
-
 int userdiff_config_basic(const char *k, const char *v);
 int userdiff_config_porcelain(const char *k, const char *v);
 struct userdiff_driver *userdiff_find_by_name(const char *name);
-- 
1.6.0.2.639.g4d7f.dirty
