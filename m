From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Add 'filter' attribute and external filter driver definition.
Date: Sat, 21 Apr 2007 23:08:23 -0700
Message-ID: <11772221051597-git-send-email-junkio@cox.net>
References: <11772221041630-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 08:08:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfVFY-0007Eb-VG
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 08:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbXDVGI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 02:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbXDVGI1
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 02:08:27 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:32885 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbXDVGI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 02:08:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422060825.FVDW1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sun, 22 Apr 2007 02:08:25 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q68R1W0041kojtg0000100; Sun, 22 Apr 2007 02:08:25 -0400
X-Mailer: git-send-email 1.5.1.2.919.g280f4
In-Reply-To: <11772221041630-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45216>

The interface is similar to the custom low-level merge drivers.

First you configure your filter driver by defining 'filter.<name>.*'
variables in the configuration.

	filter.<name>.clean	filter command to run upon checkin
	filter.<name>.smudge	filter command to run upon checkout

Then you assign filter attribute to each path, whose name
matches the custom filter driver's name.

Example:

	(in .gitattributes)
	*.c	filter=indent

	(in config)
	[filter "indent"]
		clean = indent
		smudge = cat

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 convert.c         |  259 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 t/t0021-filter.sh |   36 ++++++++
 2 files changed, 286 insertions(+), 9 deletions(-)
 create mode 100755 t/t0021-filter.sh

diff --git a/convert.c b/convert.c
index 37239ac..1fa8f2a 100644
--- a/convert.c
+++ b/convert.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "attr.h"
+#include "run-command.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -200,18 +201,214 @@ static char *crlf_to_worktree(const char *path, const char *src, unsigned long *
 	return buffer;
 }
 
+static int filter_buffer(const char *path, const char *src,
+			 unsigned long size, const char *cmd)
+{
+	/*
+	 * Spawn cmd and feed the buffer contents through its stdin.
+	 */
+	struct child_process child_process;
+	int pipe_feed[2];
+	int write_err, status;
+
+	memset(&child_process, 0, sizeof(child_process));
+
+	if (pipe(pipe_feed) < 0) {
+		error("cannot create pipe to run external filter %s", cmd);
+		return 1;
+	}
+
+	child_process.pid = fork();
+	if (child_process.pid < 0) {
+		error("cannot fork to run external filter %s", cmd);
+		close(pipe_feed[0]);
+		close(pipe_feed[1]);
+		return 1;
+	}
+	if (!child_process.pid) {
+		dup2(pipe_feed[0], 0);
+		close(pipe_feed[0]);
+		close(pipe_feed[1]);
+		execlp(cmd, cmd, NULL);
+		return 1;
+	}
+	close(pipe_feed[0]);
+	close(1);
+
+	write_err = (write_in_full(pipe_feed[1], src, size) < 0);
+	if (close(pipe_feed[1]))
+		write_err = 1;
+	if (write_err)
+		error("cannot feed the input to external filter %s", cmd);
+
+	status = finish_command(&child_process);
+	if (status)
+		error("external filter %s failed %d", cmd, -status);
+	return (write_err || status);
+}
+
+static char *apply_filter(const char *path, const char *src,
+			  unsigned long *sizep, const char *cmd)
+{
+	/*
+	 * Create a pipeline to have the command filter the buffer's
+	 * contents.
+	 *
+	 * (child --> cmd) --> us
+	 */
+	const int SLOP = 4096;
+	int pipe_feed[2];
+	int status;
+	char *dst;
+	unsigned long dstsize, dstalloc;
+	struct child_process child_process;
+
+	if (!cmd)
+		return NULL;
+
+	memset(&child_process, 0, sizeof(child_process));
+
+	if (pipe(pipe_feed) < 0) {
+		error("cannot create pipe to run external filter %s", cmd);
+		return NULL;
+	}
+
+	child_process.pid = fork();
+	if (child_process.pid < 0) {
+		error("cannot fork to run external filter %s", cmd);
+		close(pipe_feed[0]);
+		close(pipe_feed[1]);
+		return NULL;
+	}
+	if (!child_process.pid) {
+		dup2(pipe_feed[1], 1);
+		close(pipe_feed[0]);
+		close(pipe_feed[1]);
+		exit(filter_buffer(path, src, *sizep, cmd));
+	}
+	close(pipe_feed[1]);
+
+	dstalloc = *sizep;
+	dst = xmalloc(dstalloc);
+	dstsize = 0;
+
+	while (1) {
+		ssize_t numread = xread(pipe_feed[0], dst + dstsize,
+					dstalloc - dstsize);
+
+		if (numread <= 0) {
+			if (!numread)
+				break;
+			error("read from external filter %s failed", cmd);
+			free(dst);
+			dst = NULL;
+			break;
+		}
+		dstsize += numread;
+		if (dstalloc <= dstsize + SLOP) {
+			dstalloc = dstsize + SLOP;
+			dst = xrealloc(dst, dstalloc);
+		}
+	}
+	if (close(pipe_feed[0])) {
+		error("read from external filter %s failed", cmd);
+		free(dst);
+		dst = NULL;
+	}
+
+	status = finish_command(&child_process);
+	if (status) {
+		error("external filter %s failed %d", cmd, -status);
+		free(dst);
+		dst = NULL;
+	}
+
+	if (dst)
+		*sizep = dstsize;
+	return dst;
+}
+
+static struct convert_driver {
+	const char *name;
+	struct convert_driver *next;
+	char *smudge;
+	char *clean;
+} *user_convert, **user_convert_tail;
+
+static int read_convert_config(const char *var, const char *value)
+{
+	const char *ep, *name;
+	int namelen;
+	struct convert_driver *drv;
+
+	/*
+	 * External conversion drivers are configured using
+	 * "filter.<name>.variable".
+	 */
+	if (prefixcmp(var, "filter.") || (ep = strrchr(var, '.')) == var + 6)
+		return 0;
+	name = var + 7;
+	namelen = ep - name;
+	for (drv = user_convert; drv; drv = drv->next)
+		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
+			break;
+	if (!drv) {
+		char *namebuf;
+		drv = xcalloc(1, sizeof(struct convert_driver));
+		namebuf = xmalloc(namelen + 1);
+		memcpy(namebuf, name, namelen);
+		namebuf[namelen] = 0;
+		drv->name = namebuf;
+		drv->next = NULL;
+		*user_convert_tail = drv;
+		user_convert_tail = &(drv->next);
+	}
+
+	ep++;
+
+	/*
+	 * filter.<name>.smudge and filter.<name>.clean specifies
+	 * the command line:
+	 *
+	 *	command-line
+	 *
+	 * The command-line will not be interpolated in any way.
+	 */
+
+	if (!strcmp("smudge", ep)) {
+		if (!value)
+			return error("%s: lacks value", var);
+		drv->smudge = strdup(value);
+		return 0;
+	}
+
+	if (!strcmp("clean", ep)) {
+		if (!value)
+			return error("%s: lacks value", var);
+		drv->clean = strdup(value);
+		return 0;
+	}
+	return 0;
+}
+
 static void setup_convert_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_crlf;
+	static struct git_attr *attr_filter;
 
-	if (!attr_crlf)
+	if (!attr_crlf) {
 		attr_crlf = git_attr("crlf", 4);
-	check->attr = attr_crlf;
+		attr_filter = git_attr("filter", 6);
+		user_convert_tail = &user_convert;
+		git_config(read_convert_config);
+	}
+	check[0].attr = attr_crlf;
+	check[1].attr = attr_filter;
 }
 
 static int git_path_check_crlf(const char *path, struct git_attr_check *check)
 {
-	const char *value = check->value;
+	const char *value = check[0].value;
 
 	if (ATTR_TRUE(value))
 		return CRLF_TEXT;
@@ -224,26 +421,70 @@ static int git_path_check_crlf(const char *path, struct git_attr_check *check)
 	return CRLF_GUESS;
 }
 
+static struct convert_driver *git_path_check_convert(const char *path,
+					     struct git_attr_check *check)
+{
+	const char *value = check[1].value;
+	struct convert_driver *drv;
+
+	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value))
+		return NULL;
+	for (drv = user_convert; drv; drv = drv->next)
+		if (!strcmp(value, drv->name))
+			return drv;
+	return NULL;
+}
+
 char *convert_to_git(const char *path, const char *src, unsigned long *sizep)
 {
-	struct git_attr_check check[1];
+	struct git_attr_check check[2];
 	int crlf = CRLF_GUESS;
+	char *filter = NULL;
+	char *buf, *buf2;
 
 	setup_convert_check(check);
-	if (!git_checkattr(path, 1, check)) {
+	if (!git_checkattr(path, 2, check)) {
+		struct convert_driver *drv;
 		crlf = git_path_check_crlf(path, check);
+		drv = git_path_check_convert(path, check);
+		if (drv && drv->clean)
+			filter = drv->clean;
 	}
-	return crlf_to_git(path, src, sizep, crlf);
+
+	buf = apply_filter(path, src, sizep, filter);
+
+	buf2 = crlf_to_git(path, buf ? buf : src, sizep, crlf);
+	if (buf2) {
+		free(buf);
+		buf = buf2;
+	}
+
+	return buf;
 }
 
 char *convert_to_working_tree(const char *path, const char *src, unsigned long *sizep)
 {
-	struct git_attr_check check[1];
+	struct git_attr_check check[2];
 	int crlf = CRLF_GUESS;
+	char *filter = NULL;
+	char *buf, *buf2;
 
 	setup_convert_check(check);
-	if (!git_checkattr(path, 1, check)) {
+	if (!git_checkattr(path, 2, check)) {
+		struct convert_driver *drv;
 		crlf = git_path_check_crlf(path, check);
+		drv = git_path_check_convert(path, check);
+		if (drv && drv->smudge)
+			filter = drv->smudge;
 	}
-	return crlf_to_worktree(path, src, sizep, crlf);
+
+	buf = crlf_to_worktree(path, src, sizep, crlf);
+
+	buf2 = apply_filter(path, buf ? buf : src, sizep, filter);
+	if (buf2) {
+		free(buf);
+		buf = buf2;
+	}
+
+	return buf;
 }
diff --git a/t/t0021-filter.sh b/t/t0021-filter.sh
new file mode 100755
index 0000000..d6bb1c6
--- /dev/null
+++ b/t/t0021-filter.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='external filter conversion'
+
+. ./test-lib.sh
+
+cat <<\EOF >rot13.sh
+tr '[a-zA-Z]' '[n-za-mN-ZA-M]'
+EOF
+chmod +x rot13.sh
+
+test_expect_success setup '
+	git config filter.rot13.smudge ./rot13.sh &&
+	git config filter.rot13.clean ./rot13.sh &&
+
+	echo "*.t filter=rot13" >.gitattributes &&
+
+	{
+	    echo a b c d e f g h i j k l m
+	    echo n o p q r s t u v w x y z
+	} >test &&
+	cat test >test.t &&
+	cat test >test.o &&
+	git add test test.t &&
+	rm -f test test.t &&
+	git checkout -- test test.t
+'
+
+test_expect_success check '
+
+	cmp test.o test &&
+	cmp test.o test.t
+
+'
+
+test_done
-- 
1.5.1.2.919.g280f4
