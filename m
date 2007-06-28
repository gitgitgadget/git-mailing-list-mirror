From: Theodore Tso <tytso@mit.edu>
Subject: [PATCH] Don't fflush(stdout) when it's not helpful
Date: Thu, 28 Jun 2007 19:53:19 -0400
Message-ID: <20070628235319.GD29279@thunk.org>
References: <87r6nzu666.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org> <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org> <20070626171127.GA28810@thunk.org> <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org> <20070628190406.GC29279@thunk.org> <20070628213451.GB22455@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 29 01:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I43nk-0008UT-H3
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 01:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760948AbXF1Xx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 19:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759911AbXF1Xx0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 19:53:26 -0400
Received: from THUNK.ORG ([69.25.196.29]:36082 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756624AbXF1XxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 19:53:25 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I43vQ-0002qz-4R; Thu, 28 Jun 2007 20:01:24 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I43nb-0005f1-RM; Thu, 28 Jun 2007 19:53:19 -0400
Content-Disposition: inline
In-Reply-To: <20070628213451.GB22455@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51137>

On Thu, Jun 28, 2007 at 05:34:51PM -0400, Jeff King wrote:
> On top of which, in your patch the type of output trumps the environment
> variable, which seems backwards. In other words, I can't do this:
> 
> GIT_FLUSH_EVEN_THOUGH_ITS_A_FILE=1 git-rev-list HEAD >file
> [in another window] tail -f file
> 
> I would think an explicit preference from a variable should override any
> guesses.

Good point.  Here's a revised patch where GIT_FLUSH=0 and GIT_FLASH=1
trumps any hueristics.

My comments about this making only trivial differences on Linux still
apply (although it does make things slightly more optimal).  I suspect
it might make more of a difference on MacOS, but I haven't had time to
benchmark it.

							- Ted

---
commit 422becc0f8430d2386ceed92f224a94c9047751e
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Jun 28 14:10:58 2007 -0400

    Don't fflush(stdout) when it's not helpful
    
    This patch arose from a discussion started by Jim Meyering's patch
    whose intention was to provide better diagnostics for failed writes.
    Linus proposed a better way to do things, which also had the added
    benefit that adding a fflush() to git-log-* operations and incremental
    git-blame operations could improve interactive respose time feel, at
    the cost of making things a bit slower when we aren't piping the
    output to a downstream program.
    
    This patch skips the fflush() calls when stdout is a regular file, or
    if the environment variable GIT_FLUSH is set to "0".  This latter can
    speed up a command such as:
    
    GIT_FLUSH=0 strace -c -f -e write time git-rev-list HEAD | wc -l
    
    a tiny amount.
    
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 20b5b7b..8269148 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -396,6 +396,16 @@ other
 'GIT_PAGER'::
 	This environment variable overrides `$PAGER`.
 
+'GIT_FLUSH'::
+	If this environment variable is set to "1", then commands such
+	as git-blame (in incremental mode), git-rev-list, git-log,
+	git-whatchanged, etc., will force a flush of the output stream
+	after each commit-oriented record have been flushed.   If this
+	variable is set to "0", the output of these commands will be done
+	using completely buffered I/O.   If this environment variable is
+	not set, git will choose buffered or record-oriented flushing
+	based on whether stdout appears to be redirected to a file or not.
+
 'GIT_TRACE'::
 	If this variable is set to "1", "2" or "true" (comparison
 	is case insensitive), git will print `trace:` messages on
diff --git a/builtin-blame.c b/builtin-blame.c
index f7e2c13..da23a6f 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1459,6 +1459,7 @@ static void found_guilty_entry(struct blame_entry *ent)
 				printf("boundary\n");
 		}
 		write_filename_info(suspect->path);
+		maybe_flush_or_die(stdout, "stdout");
 	}
 }
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 813aadf..86db8b0 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -100,7 +100,7 @@ static void show_commit(struct commit *commit)
 		printf("%s%c", buf, hdr_termination);
 		free(buf);
 	}
-	fflush(stdout);
+	maybe_flush_or_die(stdout, "stdout");
 	if (commit->parents) {
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
diff --git a/cache.h b/cache.h
index ed83d92..0525c4e 100644
--- a/cache.h
+++ b/cache.h
@@ -532,6 +532,8 @@ extern char git_default_name[MAX_GITNAME];
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
 
+/* IO helper functions */
+extern void maybe_flush_or_die(FILE *, const char *);
 extern int copy_fd(int ifd, int ofd);
 extern int read_in_full(int fd, void *buf, size_t count);
 extern int write_in_full(int fd, const void *buf, size_t count);
diff --git a/log-tree.c b/log-tree.c
index 0cf21bc..ced3f33 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -408,5 +408,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		shown = 1;
 	}
 	opt->loginfo = NULL;
+	maybe_flush_or_die(stdout, "stdout");
 	return shown;
 }
diff --git a/write_or_die.c b/write_or_die.c
index 5c4bc85..9929a15 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,5 +1,47 @@
 #include "cache.h"
 
+/*
+ * Some cases use stdio, but want to flush after the write
+ * to get error handling (and to get better interactive
+ * behaviour - not buffering excessively).
+ *
+ * Of course, if the flush happened within the write itself,
+ * we've already lost the error code, and cannot report it any
+ * more. So we just ignore that case instead (and hope we get
+ * the right error code on the flush).
+ *
+ * If the file handle is stdout, and stdout is a file, then skip the
+ * flush entirely since it's not needed.
+ */
+void maybe_flush_or_die(FILE *f, const char *desc)
+{
+	static int stdout_is_file = -1;
+	struct stat st;
+	char *cp;
+
+	if (f == stdout) {
+		if (stdout_is_file < 0) {
+			cp = getenv("GIT_FLUSH");
+			if (cp)
+				stdout_is_file = (atoi(cp) == 0);
+			else if (getenv("GIT_NEVER_FLUSH_STDOUT") ||
+				 ((fstat(fileno(stdout), &st) == 0) &&
+				  S_ISREG(st.st_mode)))
+				stdout_is_file = 1;
+			else
+				stdout_is_file = 0;
+		}
+		if (stdout_is_file)
+			return;
+	}
+	if (fflush(f)) {
+		if (errno == EPIPE)
+			exit(0);
+		die("write failure on %s: %s",
+			desc, strerror(errno));
+	}
+}
+
 int read_in_full(int fd, void *buf, size_t count)
 {
 	char *p = buf;
