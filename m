From: Linus Torvalds <torvalds@osdl.org>
Subject: Make git diff-generation use a simpler spawn-like interface
Date: Sun, 26 Feb 2006 15:51:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602261547440.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Feb 27 00:51:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDVft-0004sl-1i
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 00:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWBZXvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 18:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWBZXvd
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 18:51:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31443 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750923AbWBZXvd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 18:51:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1QNpRDZ018771
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Feb 2006 15:51:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1QNpOhh030298;
	Sun, 26 Feb 2006 15:51:25 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16808>


Instead of depending of fork() and execve() and doing things in between
the two, make the git diff functions do everything up front, and then do
a single "spawn_prog()" invocation to run the actual external diff
program (if any is even needed).

This actually ends up simplifying the code, and should make it much
easier to make it efficient under broken operating systems (read: Windows).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Now, somebody else might disagree with my contention that this also makes 
things simpler, but I like how we separate out the "run an external 
program" phase from the actual setup and header printing phase.

Of course, it still uses fork/execvp here, but now it should be _trivial_ 
to just have a windows-optimized version of "spawn_prog()" that does that 
Windows thang.

		Linus


diff --git a/diff.c b/diff.c
index 804c08c..32da5d7 100644
--- a/diff.c
+++ b/diff.c
@@ -178,11 +178,12 @@ static void emit_rewrite_diff(const char
 		copy_file('+', temp[1].name);
 }
 
-static void builtin_diff(const char *name_a,
+static const char *builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_tempfile *temp,
 			 const char *xfrm_msg,
-			 int complete_rewrite)
+			 int complete_rewrite,
+			 const char **args)
 {
 	int i, next_at, cmd_size;
 	const char *const diff_cmd = "diff -L%s -L%s";
@@ -242,19 +243,24 @@ static void builtin_diff(const char *nam
 		}
 		if (xfrm_msg && xfrm_msg[0])
 			puts(xfrm_msg);
+		/*
+		 * we do not run diff between different kind
+		 * of objects.
+		 */
 		if (strncmp(temp[0].mode, temp[1].mode, 3))
-			/* we do not run diff between different kind
-			 * of objects.
-			 */
-			exit(0);
+			return NULL;
 		if (complete_rewrite) {
-			fflush(NULL);
 			emit_rewrite_diff(name_a, name_b, temp);
-			exit(0);
+			return NULL;
 		}
 	}
-	fflush(NULL);
-	execlp("/bin/sh","sh", "-c", cmd, NULL);
+
+	/* This is disgusting */
+	*args++ = "sh";
+	*args++ = "-c";
+	*args++ = cmd;
+	*args = NULL;
+	return "/bin/sh";
 }
 
 struct diff_filespec *alloc_filespec(const char *path)
@@ -559,6 +565,40 @@ static void remove_tempfile_on_signal(in
 	raise(signo);
 }
 
+static int spawn_prog(const char *pgm, const char **arg)
+{
+	pid_t pid;
+	int status;
+
+	fflush(NULL);
+	pid = fork();
+	if (pid < 0)
+		die("unable to fork");
+	if (!pid) {
+		execvp(pgm, (char *const*) arg);
+		exit(255);
+	}
+
+	while (waitpid(pid, &status, 0) < 0) {
+		if (errno == EINTR)
+			continue;
+		return -1;
+	}
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
+}
+
 /* An external diff command takes:
  *
  * diff-cmd name infile1 infile1-sha1 infile1-mode \
@@ -573,9 +613,9 @@ static void run_external_diff(const char
 			      const char *xfrm_msg,
 			      int complete_rewrite)
 {
+	const char *spawn_arg[10];
 	struct diff_tempfile *temp = diff_temp;
-	pid_t pid;
-	int status;
+	int retval;
 	static int atexit_asked = 0;
 	const char *othername;
 
@@ -592,59 +632,41 @@ static void run_external_diff(const char
 		signal(SIGINT, remove_tempfile_on_signal);
 	}
 
-	fflush(NULL);
-	pid = fork();
-	if (pid < 0)
-		die("unable to fork");
-	if (!pid) {
-		if (pgm) {
-			if (one && two) {
-				const char *exec_arg[10];
-				const char **arg = &exec_arg[0];
-				*arg++ = pgm;
-				*arg++ = name;
-				*arg++ = temp[0].name;
-				*arg++ = temp[0].hex;
-				*arg++ = temp[0].mode;
-				*arg++ = temp[1].name;
-				*arg++ = temp[1].hex;
-				*arg++ = temp[1].mode;
-				if (other) {
-					*arg++ = other;
-					*arg++ = xfrm_msg;
-				}
-				*arg = NULL;
-				execvp(pgm, (char *const*) exec_arg);
+	if (pgm) {
+		const char **arg = &spawn_arg[0];
+		if (one && two) {
+			*arg++ = pgm;
+			*arg++ = name;
+			*arg++ = temp[0].name;
+			*arg++ = temp[0].hex;
+			*arg++ = temp[0].mode;
+			*arg++ = temp[1].name;
+			*arg++ = temp[1].hex;
+			*arg++ = temp[1].mode;
+			if (other) {
+				*arg++ = other;
+				*arg++ = xfrm_msg;
 			}
-			else
-				execlp(pgm, pgm, name, NULL);
+		} else {
+			*arg++ = pgm;
+			*arg++ = name;
 		}
-		/*
-		 * otherwise we use the built-in one.
-		 */
-		if (one && two)
-			builtin_diff(name, othername, temp, xfrm_msg,
-				     complete_rewrite);
-		else
+		*arg = NULL;
+	} else {
+		if (one && two) {
+			pgm = builtin_diff(name, othername, temp, xfrm_msg, complete_rewrite, spawn_arg);
+		} else
 			printf("* Unmerged path %s\n", name);
-		exit(0);
 	}
-	if (waitpid(pid, &status, 0) < 0 ||
-	    !WIFEXITED(status) || WEXITSTATUS(status)) {
-		/* Earlier we did not check the exit status because
-		 * diff exits non-zero if files are different, and
-		 * we are not interested in knowing that.  It was a
-		 * mistake which made it harder to quit a diff-*
-		 * session that uses the git-apply-patch-script as
-		 * the GIT_EXTERNAL_DIFF.  A custom GIT_EXTERNAL_DIFF
-		 * should also exit non-zero only when it wants to
-		 * abort the entire diff-* session.
-		 */
-		remove_tempfile();
+
+	retval = 0;
+	if (pgm)	
+		retval = spawn_prog(pgm, spawn_arg);
+	remove_tempfile();
+	if (retval) {
 		fprintf(stderr, "external diff died, stopping at %s.\n", name);
 		exit(1);
 	}
-	remove_tempfile();
 }
 
 static void diff_fill_sha1_info(struct diff_filespec *one)
