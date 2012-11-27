From: Michael Weiser <M.Weiser@science-computing.de>
Subject: [PATCH] Extend runtime prefix computation
Date: Tue, 27 Nov 2012 17:30:05 +0100
Message-ID: <20121127163004.GC7499@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 17:40:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdOCt-0000nW-FM
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 17:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab2K0QkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 11:40:04 -0500
Received: from mx3.science-computing.de ([193.197.16.20]:26224 "EHLO
	mx3.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935Ab2K0QkD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 11:40:03 -0500
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2012 11:40:03 EST
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 21D8D414006;
	Tue, 27 Nov 2012 17:30:06 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zjjR8ABWLKSg; Tue, 27 Nov 2012 17:30:05 +0100 (CET)
Received: from verus.science-computing.de (verus.science-computing.de [10.160.1.22])
	by scmail.science-computing.de (Postfix) with ESMTP id 75354414001;
	Tue, 27 Nov 2012 17:30:05 +0100 (CET)
Received: by verus.science-computing.de (Postfix, from userid 1176)
	id 4FFBD104498; Tue, 27 Nov 2012 17:30:05 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210562>

Support determining the binaries' installation path at runtime even if
called without any path components (i.e. via search path). Implement
fallback to compiled-in prefix if determination fails or is impossible.

Signed-off-by: Michael Weiser <weiser@science-computing.de>
---
- Has two very minor memory leaks - function is called only once per
  program execution. Do we care? Alternative: Use static buffer instead.

 exec_cmd.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 125fa6f..d50d7f8 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -4,28 +4,22 @@
 #define MAX_ARGS	32
 
 static const char *argv_exec_path;
-static const char *argv0_path;
+static const char *argv0_path = NULL;
 
 const char *system_path(const char *path)
 {
-#ifdef RUNTIME_PREFIX
-	static const char *prefix;
-#else
 	static const char *prefix = PREFIX;
-#endif
 	struct strbuf d = STRBUF_INIT;
 
 	if (is_absolute_path(path))
 		return path;
 
 #ifdef RUNTIME_PREFIX
-	assert(argv0_path);
-	assert(is_absolute_path(argv0_path));
-
-	if (!prefix &&
-	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
-	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
-	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
+	if (!argv0_path ||
+	    !is_absolute_path(argv0_path) ||
+	    (!(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
+	     !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
+	     !(prefix = strip_path_suffix(argv0_path, "git")))) {
 		prefix = PREFIX;
 		trace_printf("RUNTIME_PREFIX requested, "
 				"but prefix computation failed.  "
@@ -41,20 +35,64 @@ const char *system_path(const char *path)
 const char *git_extract_argv0_path(const char *argv0)
 {
 	const char *slash;
+	char *abs_argv0 = NULL;
 
 	if (!argv0 || !*argv0)
 		return NULL;
 	slash = argv0 + strlen(argv0);
 
+	/* walk to the first slash from the end */
 	while (argv0 <= slash && !is_dir_sep(*slash))
 		slash--;
 
+	/* if there was a slash ... */
 	if (slash >= argv0) {
-		argv0_path = xstrndup(argv0, slash - argv0);
-		return slash + 1;
+		/* ... it's either an absolute path */
+		if (is_absolute_path(argv0)) {
+			/* FIXME: memory leak here */
+			argv0_path = xstrndup(argv0, slash - argv0);
+			return slash + 1;
+		}
+
+		/* ... or a relative path, in which case we have to make it
+		 * absolute first and do the whole thing again */
+		abs_argv0 = xstrdup(real_path(argv0));
+	} else {
+		/* argv0 is no path at all, just a name. Resolve it into a
+		 * path. Unfortunately, this gets system specific. */
+#if defined(__linux__)
+		struct stat st;
+		if (!stat("/proc/self/exe", &st)) {
+			abs_argv0 = xstrdup(real_path("/proc/self/exe"));
+		}
+#elif defined(__APPLE__)
+		/* Mac OS X has realpath, which incidentally allocates its own
+		 * memory, which in turn is why we do all the xstrdup's in the
+		 * other cases. */
+		abs_argv0 = realpath(argv0, NULL);
+#endif
+
+		/* if abs_argv0 is still NULL here, something failed above or
+		 * we are on an unsupported system. system_path() will warn
+		 * and fall back to the static prefix */
+		if (!abs_argv0) {
+			argv0_path = NULL;
+			return argv0;
+		}
 	}
 
-	return argv0;
+	/* abs_argv0 is an absolute path now for which memory was allocated
+	 * with malloc */
+
+	slash = abs_argv0 + strlen(abs_argv0);
+	while (abs_argv0 <= slash && !is_dir_sep(*slash))
+		slash--;
+
+	/* FIXME: memory leaks here */
+	argv0_path = xstrndup(abs_argv0, slash - abs_argv0);
+	slash = xstrdup(slash + 1);
+	free(abs_argv0);
+	return slash;
 }
 
 void git_set_argv_exec_path(const char *exec_path)
-- 
1.7.3.4
-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Michael Heinrichs, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
