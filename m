From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] shrink git-shell by avoiding redundant dependencies
Date: Sat, 28 Jun 2008 02:31:07 +0400
Message-ID: <20080627223107.GH5737@dpotapov.dyndns.org>
References: <1214602538-7888-1-git-send-email-dpotapov@gmail.com> <7vod5mpmp7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 00:32:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCMUI-0006t7-2a
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024AbYF0WbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757970AbYF0WbR
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:31:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:3609 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757967AbYF0WbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:31:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so333455fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JAkRKVij73EFaIPZM9OouaubI7UMAZ0izQ8f+VhsaoM=;
        b=x2MvB39l6xtnHX9JdXl5cfZzZ4fzPXBsl2BKTCGKpNXxepa5OrGgBQWHiAP3ikHnob
         pkbwlhhBcTJsdDIG/bsf2JIeTTbuGD8SfaYZrpU9zpKCow5m2BBwxRtrjf5qD9xLwR8h
         4iiwRnnr6trc4In3OzGW18dSy+kR6RB56eHLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=A8+HrCjuAjZHUF50kiwP0L42JTY+vZWpiKY0E4IJ52lg7vl92QM+/6b0clZVjJutgg
         Pkewqhs3e8kpjjPnOZQdq9/gj5rpR1mBUO6R2mV54oQ0oixTY+94heVtrxMZOI1YVBJO
         khlL71BHZSvIEqBFOWr913piL6NIOhHtp2r68=
Received: by 10.86.90.13 with SMTP id n13mr2583137fgb.3.1214605871844;
        Fri, 27 Jun 2008 15:31:11 -0700 (PDT)
Received: from localhost ( [85.140.169.188])
        by mx.google.com with ESMTPS id 3sm3803307fge.3.2008.06.27.15.31.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:31:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vod5mpmp7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86667>

On Fri, Jun 27, 2008 at 02:55:32PM -0700, Junio C Hamano wrote:
> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > diff --git a/abspath.c b/abspath.c
> > new file mode 100644
> > index 0000000..4becedf
> > --- /dev/null
> > +++ b/abspath.c
> > @@ -0,0 +1,80 @@
> > +/*
> > + * I'm tired of doing "vsnprintf()" etc just to open a
> > + * file, so here's a "return static buffer with printf"
> > + * interface for paths.
> > + *
> > + * It's obviously not thread-safe. Sue me. But it's quite
> > + * useful for doing things like
> > + *
> > + *   f = open(mkpath("%s/%s.git", base, name), O_RDONLY);
> > + *
> > + * which is what it's designed for.
> > + */
> 
> This is not a comment you would want to move to the resulting file that
> contains only make_absolute_path().

I am sorry... I removed this comment. Here is the corrected patch.

-- 8< --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Sat, 28 Jun 2008 00:46:42 +0400
Subject: [PATCH] shrink git-shell by avoiding redundant dependencies

A lot of modules that have nothing to do with git-shell functionality
were linked in, bloating git-shell more than 8 times.

This patch cuts off redundant dependencies by:
1. providing stubs for three functions that make no sense for git-shell;
2. moving quote_path_fully from environment.c to quote.c to make the
   later self sufficient;
3. moving make_absolute_path into a new separate file.

The following numbers have been received with the default optimization
settings on master using GCC 4.1.2:

Before:
   text    data     bss     dec     hex filename
 143915    1348   93168  238431   3a35f git-shell

After:
   text    data     bss     dec     hex filename
  17670     788    8232   26690    6842 git-shell
---
 Makefile      |    1 +
 abspath.c     |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 environment.c |    1 -
 path.c        |   67 --------------------------------------------------------
 quote.c       |    2 +
 shell.c       |    8 ++++++
 6 files changed, 79 insertions(+), 68 deletions(-)
 create mode 100644 abspath.c

diff --git a/Makefile b/Makefile
index 3584b8c..bf77292 100644
--- a/Makefile
+++ b/Makefile
@@ -378,6 +378,7 @@ LIB_H += unpack-trees.h
 LIB_H += utf8.h
 LIB_H += wt-status.h
 
+LIB_OBJS += abspath.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
 LIB_OBJS += archive.o
diff --git a/abspath.c b/abspath.c
new file mode 100644
index 0000000..4f95a95
--- /dev/null
+++ b/abspath.c
@@ -0,0 +1,68 @@
+#include "cache.h"
+
+/* We allow "recursive" symbolic links. Only within reason, though. */
+#define MAXDEPTH 5
+
+const char *make_absolute_path(const char *path)
+{
+	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
+	char cwd[1024] = "";
+	int buf_index = 1, len;
+
+	int depth = MAXDEPTH;
+	char *last_elem = NULL;
+	struct stat st;
+
+	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
+		die ("Too long path: %.*s", 60, path);
+
+	while (depth--) {
+		if (stat(buf, &st) || !S_ISDIR(st.st_mode)) {
+			char *last_slash = strrchr(buf, '/');
+			if (last_slash) {
+				*last_slash = '\0';
+				last_elem = xstrdup(last_slash + 1);
+			} else {
+				last_elem = xstrdup(buf);
+				*buf = '\0';
+			}
+		}
+
+		if (*buf) {
+			if (!*cwd && !getcwd(cwd, sizeof(cwd)))
+				die ("Could not get current working directory");
+
+			if (chdir(buf))
+				die ("Could not switch to '%s'", buf);
+		}
+		if (!getcwd(buf, PATH_MAX))
+			die ("Could not get current working directory");
+
+		if (last_elem) {
+			int len = strlen(buf);
+			if (len + strlen(last_elem) + 2 > PATH_MAX)
+				die ("Too long path name: '%s/%s'",
+						buf, last_elem);
+			buf[len] = '/';
+			strcpy(buf + len + 1, last_elem);
+			free(last_elem);
+			last_elem = NULL;
+		}
+
+		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
+			len = readlink(buf, next_buf, PATH_MAX);
+			if (len < 0)
+				die ("Invalid symlink: %s", buf);
+			next_buf[len] = '\0';
+			buf = next_buf;
+			buf_index = 1 - buf_index;
+			next_buf = bufs[buf_index];
+		} else
+			break;
+	}
+
+	if (*cwd && chdir(cwd))
+		die ("Could not change back to '%s'", cwd);
+
+	return buf;
+}
diff --git a/environment.c b/environment.c
index 084ac8a..4a88a17 100644
--- a/environment.c
+++ b/environment.c
@@ -13,7 +13,6 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int user_ident_explicitly_given;
 int trust_executable_bit = 1;
-int quote_path_fully = 1;
 int has_symlinks = 1;
 int ignore_case;
 int assume_unchanged;
diff --git a/path.c b/path.c
index 6e3df18..496123c 100644
--- a/path.c
+++ b/path.c
@@ -327,9 +327,6 @@ const char *make_nonrelative_path(const char *path)
 	return buf;
 }
 
-/* We allow "recursive" symbolic links. Only within reason, though. */
-#define MAXDEPTH 5
-
 const char *make_relative_path(const char *abs, const char *base)
 {
 	static char buf[PATH_MAX + 1];
@@ -346,67 +343,3 @@ const char *make_relative_path(const char *abs, const char *base)
 	strcpy(buf, abs + baselen);
 	return buf;
 }
-
-const char *make_absolute_path(const char *path)
-{
-	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
-	char cwd[1024] = "";
-	int buf_index = 1, len;
-
-	int depth = MAXDEPTH;
-	char *last_elem = NULL;
-	struct stat st;
-
-	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
-		die ("Too long path: %.*s", 60, path);
-
-	while (depth--) {
-		if (stat(buf, &st) || !S_ISDIR(st.st_mode)) {
-			char *last_slash = strrchr(buf, '/');
-			if (last_slash) {
-				*last_slash = '\0';
-				last_elem = xstrdup(last_slash + 1);
-			} else {
-				last_elem = xstrdup(buf);
-				*buf = '\0';
-			}
-		}
-
-		if (*buf) {
-			if (!*cwd && !getcwd(cwd, sizeof(cwd)))
-				die ("Could not get current working directory");
-
-			if (chdir(buf))
-				die ("Could not switch to '%s'", buf);
-		}
-		if (!getcwd(buf, PATH_MAX))
-			die ("Could not get current working directory");
-
-		if (last_elem) {
-			int len = strlen(buf);
-			if (len + strlen(last_elem) + 2 > PATH_MAX)
-				die ("Too long path name: '%s/%s'",
-						buf, last_elem);
-			buf[len] = '/';
-			strcpy(buf + len + 1, last_elem);
-			free(last_elem);
-			last_elem = NULL;
-		}
-
-		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
-			len = readlink(buf, next_buf, PATH_MAX);
-			if (len < 0)
-				die ("Invalid symlink: %s", buf);
-			next_buf[len] = '\0';
-			buf = next_buf;
-			buf_index = 1 - buf_index;
-			next_buf = bufs[buf_index];
-		} else
-			break;
-	}
-
-	if (*cwd && chdir(cwd))
-		die ("Could not change back to '%s'", cwd);
-
-	return buf;
-}
diff --git a/quote.c b/quote.c
index d5cf9d8..6a52085 100644
--- a/quote.c
+++ b/quote.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "quote.h"
 
+int quote_path_fully = 1;
+
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', any exclamation point
  * is replaced with '\!', and the whole thing is enclosed in a
diff --git a/shell.c b/shell.c
index b27d01c..91ca7de 100644
--- a/shell.c
+++ b/shell.c
@@ -3,6 +3,14 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 
+/* Stubs for functions that make no sense for git-shell. These stubs
+ * are provided here to avoid linking in external redundant modules.
+ */
+void release_pack_memory(size_t need, int fd){}
+void trace_argv_printf(const char **argv, const char *fmt, ...){}
+void trace_printf(const char *fmt, ...){}
+
+
 static int do_generic_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];
-- 
1.5.6.1
