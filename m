From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC][PATCH] remarks about custom diff driver
Date: Tue, 28 Aug 2007 01:29:11 +0200
Message-ID: <vpqabsc8sl4.fsf@bauges.imag.fr>
References: <vpq8x7x5knh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 01:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPo1P-0001Ya-3U
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 01:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbXH0X3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 19:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbXH0X3X
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 19:29:23 -0400
Received: from imag.imag.fr ([129.88.30.1]:59633 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbXH0X3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 19:29:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7RNTBoE010890
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 28 Aug 2007 01:29:11 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IPo19-0001lP-7S; Tue, 28 Aug 2007 01:29:11 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IPo19-0004He-4T; Tue, 28 Aug 2007 01:29:11 +0200
In-Reply-To: <vpq8x7x5knh.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon\, 27 Aug 2007 12\:36\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 28 Aug 2007 01:29:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56896>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Indeed, what I would have needed is a custum text converter. In my
> case, I would have said something like
>
> # ~/.gitconfig
> [textconv "odt2txt"]
> 	command=odt2txt
>
> Then, in .gitattributes
>
> *.ods textconv=odt2txt
> *.odp textconv=odt2txt
> *.odt textconv=odt2txt

I started implementing something like this. The code is rather ugly
(I'm not so fluent in C, and not familiar with the git codebase ...),
but it gives an idea, and seems to work.

If you're interested in having a look (but I'll have to cleanup the
code before asking for a detailed review), here's the patch.

In the particular case of OpenDocument files, that makes a few tens of
lines of C in git itself (once and for all), but it makes it totally
trivial for the user to configure git to get all of "git diff". Sounds
promising to me.


>From 7e1bbb5fc6dc5c0adb8cad5b875d57ee17247f4a Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Tue, 28 Aug 2007 00:46:07 +0200
Subject: [PATCH] Prototype for a textconverter filter in git-diff.

That feature is similar to the custom diff driver, but the user only has
to provide a text filter (a command to convert a file into a plain-text
representation). Git takes care of diffing, mode change, ...

In particular, with

[textconv "odt2txt"]
          command=odt2txt

*.ods textconv=odt2txt
*.odp textconv=odt2txt
*.odt textconv=odt2txt

One can use "git diff" on OpenOffice files (including "git diff --color"
and friends).

This could be extended so that "git blame" can use it also.
---
 diff.c |  193 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 171 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index a7e7671..ad99f27 100644
--- a/diff.c
+++ b/diff.c
@@ -50,11 +50,12 @@ static int parse_diff_color_slot(const char *var, int ofs)
 	die("bad config variable '%s'", var);
 }
 
-static struct ll_diff_driver {
+static struct ll_cmd_driver {
 	const char *name;
-	struct ll_diff_driver *next;
+	struct ll_cmd_driver *next;
 	char *cmd;
-} *user_diff, **user_diff_tail;
+} *user_diff, **user_diff_tail,
+	*user_textconv, **user_textconv_tail;
 
 static void read_config_if_needed(void)
 {
@@ -70,29 +71,30 @@ static void read_config_if_needed(void)
  * this in a bit convoluted way to allow low level diff driver
  * called "color".
  */
-static int parse_lldiff_command(const char *var, const char *ep, const char *value)
+static int parse_ll_command(const char *var, const char *name,
+			    const char *ep, const char *value,
+			    struct ll_cmd_driver **user_driver,
+			    struct ll_cmd_driver ***user_driver_tail)
 {
-	const char *name;
 	int namelen;
-	struct ll_diff_driver *drv;
+	struct ll_cmd_driver *drv;
 
-	name = var + 5;
 	namelen = ep - name;
-	for (drv = user_diff; drv; drv = drv->next)
+	for (drv = *user_driver; drv; drv = drv->next)
 		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
 			break;
 	if (!drv) {
 		char *namebuf;
-		drv = xcalloc(1, sizeof(struct ll_diff_driver));
+		drv = xcalloc(1, sizeof(struct ll_cmd_driver));
 		namebuf = xmalloc(namelen + 1);
 		memcpy(namebuf, name, namelen);
 		namebuf[namelen] = 0;
 		drv->name = namebuf;
 		drv->next = NULL;
-		if (!user_diff_tail)
-			user_diff_tail = &user_diff;
-		*user_diff_tail = drv;
-		user_diff_tail = &(drv->next);
+		if (!*user_driver_tail)
+			*user_driver_tail = &*user_driver;
+		**user_driver_tail = drv;
+		*user_driver_tail = &(drv->next);
 	}
 
 	if (!value)
@@ -101,6 +103,38 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
 	return 0;
 }
 
+static void setup_textconv_attr_check(struct git_attr_check *check)
+{
+	static struct git_attr *attr_textconv;
+
+	if (!attr_textconv) {
+		attr_textconv = git_attr("textconv", 8);
+	}
+	check[0].attr = attr_textconv;
+}
+
+static const char *external_textconv_attr(const char *name)
+{
+	struct git_attr_check attr_textconv_check;
+
+	setup_textconv_attr_check(&attr_textconv_check);
+	if (!git_checkattr(name, 1, &attr_textconv_check)) {
+		const char *value = attr_textconv_check.value;
+		if (!ATTR_TRUE(value) &&
+		    !ATTR_FALSE(value) &&
+		    !ATTR_UNSET(value)) {
+			struct ll_cmd_driver *drv;
+
+			read_config_if_needed();
+			for (drv = user_textconv; drv; drv = drv->next) {
+				if (!strcmp(drv->name, value))
+					return drv->cmd;
+			}
+		}
+	}
+	return NULL;
+}
+
 /*
  * 'diff.<what>.funcname' attribute can be specified in the configuration
  * to define a customized regexp to find the beginning of a function to
@@ -171,11 +205,21 @@ int git_diff_ui_config(const char *var, const char *value)
 
 		if (ep != var + 4) {
 			if (!strcmp(ep, ".command"))
-				return parse_lldiff_command(var, ep, value);
+				return parse_ll_command(var, var + 5, ep, value,
+							&user_diff, &user_diff_tail);
 			if (!strcmp(ep, ".funcname"))
 				return parse_funcname_pattern(var, ep, value);
 		}
 	}
+	if (!prefixcmp(var, "textconv.")) {
+		const char *ep = strrchr(var, '.');
+
+		if (ep != var + 8) {
+			if (!strcmp(ep, ".command"))
+				return parse_ll_command(var, var + 9, ep, value,
+							&user_textconv, &user_textconv_tail);
+		}
+	}
 	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
 		int slot = parse_diff_color_slot(var, 11);
 		color_parse(value, var, diff_colors[slot]);
@@ -244,6 +288,13 @@ static struct diff_tempfile {
 	char tmp_path[PATH_MAX];
 } diff_temp[2];
 
+/* Forward declarations */
+static void prepare_temp_file(const char *name,
+			      struct diff_tempfile *temp,
+			      struct diff_filespec *one);
+static int spawn_prog(const char *pgm, const char **arg);
+/* End forward declarations */
+
 static int count_lines(const char *data, int size)
 {
 	int count, ch, completely_empty = 1, nl_just_seen = 0;
@@ -1260,6 +1311,72 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 	return NULL;
 }
 
+static int spawn_prog_to_buf(const char *pgm, const char **arg, char **buf, unsigned long * size)
+{
+	pid_t pid;
+	int status;
+	int fd[2];
+
+#define INCREMENT 1024
+	ssize_t got;
+
+	fflush(NULL);
+	if (pipe(fd) < 0)
+		die("unable to create pipe");
+	pid = fork();
+	if (pid < 0)
+		die("unable to fork");
+	if (!pid) {
+		dup2(fd[1], 1);
+		close(fd[0]);
+		close(fd[1]);
+		execvp(pgm, (char *const*) arg);
+		exit(255);
+	}
+	close(fd[1]);
+
+	*size = 0;
+	*buf = NULL;
+	while (1) {
+		*buf = xrealloc(*buf, *size + INCREMENT);
+		got = xread(fd[0], *buf + *size, INCREMENT);
+		if (!got)
+			break; /* EOF */
+		if (got < 0)
+			return error("error while reading from stdin %s",
+				     strerror(errno));
+		*size += got;
+	}
+
+	while (waitpid(pid, &status, 0) < 0) {
+		if (errno == EINTR)
+			continue;
+		return -1;
+	}
+
+#if 0
+	/*
+	 * copied from the external diff spawn_prog. Is it needed
+	 * here, too ?
+	 */
+
+	/* Earlier we did not check the exit status because
+	 * diff exits non-zero if files are different, and
+	 * we are not interested in knowing that.  It was a
+	 * mistake which made it harder to quit a diff-*
+	 * session that uses the git-apply-patch-script as
+	 * the GIT_EXTERNAL_DIFF.  A custom GIT_EXTERNAL_DIFF
+	 * should also exit non-zero only when it wants to
+	 * abort the entire diff-* session.
+	 */
+	if (WIFEXITED(status) && !WEXITSTATUS(status))
+		return 0;
+	return -1;
+#endif
+}
+
+
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -1314,6 +1431,38 @@ static void builtin_diff(const char *name_a,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
+	const char * textconv = external_textconv_attr(name_a);
+	const char * textconvb = external_textconv_attr(name_b);
+
+	/*
+	 * Only use the textconv driver is it is set, and is the same
+	 * for source and destination file.
+	 */
+	if (textconv && textconvb && !strcmp(textconv, textconvb)) {
+		const char * spawn_arg[3];
+		const char ** arg = &spawn_arg[0];
+		char *bufa, *bufb;
+		unsigned long sizea, sizeb;
+		struct diff_tempfile *temp = diff_temp;
+		prepare_temp_file(name_a, &temp[0], one);
+		*arg++ = textconv;
+		*arg++ = temp[0].name;
+		*arg++ = NULL;
+		spawn_prog_to_buf(textconv, spawn_arg, &(mf1.ptr), &(mf1.size));
+		one->data = mf1.ptr;
+		one->size = mf1.size;
+		one->should_free = 1;
+		one->should_munmap = 1;
+
+		prepare_temp_file(name_b, &temp[1], two);
+		spawn_arg[1] = temp[1].name;
+		spawn_prog_to_buf(textconv, spawn_arg, &(mf2.ptr), &(mf2.size));
+		two->data = mf2.ptr;
+		two->size = mf2.size;
+		two->should_free = 1;
+		two->should_munmap = 1;
+	}
+
 	if (!o->text &&
 	    (diff_filespec_is_binary(one) || diff_filespec_is_binary(two))) {
 		/* Quite common confusing case */
@@ -1890,7 +2039,7 @@ static const char *external_diff_attr(const char *name)
 		if (!ATTR_TRUE(value) &&
 		    !ATTR_FALSE(value) &&
 		    !ATTR_UNSET(value)) {
-			struct ll_diff_driver *drv;
+			struct ll_cmd_driver *drv;
 
 			read_config_if_needed();
 			for (drv = user_diff; drv; drv = drv->next)
@@ -2853,14 +3002,14 @@ struct patch_id_t {
 static int remove_space(char *line, int len)
 {
 	int i;
-        char *dst = line;
-        unsigned char c;
+	char *dst = line;
+	unsigned char c;
 
-        for (i = 0; i < len; i++)
-                if (!isspace((c = line[i])))
-                        *dst++ = c;
+	for (i = 0; i < len; i++)
+		if (!isspace((c = line[i])))
+			*dst++ = c;
 
-        return dst - line;
+	return dst - line;
 }
 
 static void patch_id_consume(void *priv, char *line, unsigned long len)
-- 
1.5.3.rc6.21.g153d-dirty



-- 
Matthieu
