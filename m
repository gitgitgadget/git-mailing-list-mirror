From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Thu, 28 Jun 2007 15:04:06 -0400
Message-ID: <20070628190406.GC29279@thunk.org>
References: <87r6nzu666.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org> <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org> <20070626171127.GA28810@thunk.org> <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 28 21:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3zHs-0001dZ-9h
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 21:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762301AbXF1TEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 15:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762915AbXF1TEO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 15:04:14 -0400
Received: from THUNK.ORG ([69.25.196.29]:37136 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760482AbXF1TEL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 15:04:11 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I3zPV-0001b4-Uh; Thu, 28 Jun 2007 15:12:10 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I3zHi-0006Ta-BO; Thu, 28 Jun 2007 15:04:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51125>

On Tue, Jun 26, 2007 at 10:32:23AM -0700, Linus Torvalds wrote:
> But we actually _do_ want fully buffered from a performance angle. 
> Especially for the big stuff, which is usually the *diffs*, not the commit 
> messages. Not so much an issue with git-rev-list, but with "git log -p" 
> you would normally not want it line-buffered, and it's actually much nicer 
> to let it be fully buffered and then do a flush at the end.
> 
> Even pipes are often used for "throughput" stuff if you end up doing some 
> post-processing (ie "git log -p | gather-statistics"), and yes, I actually 
> do things like that - it's nice for things like looking at how many lines 
> have been added during the last release cycle
> 
> 	git log -p v2.6.21.. | grep '^+' | wc -l
> 
> and I'd really like thigns like that to be close to optimal. 
> 
> How much the system call overhead is, I don't know, though. So it might be 
> worth testing out....

So just for yuks, I devised the following patch, and did some measurements....

For the above pipeline, the result was hardly worth mentioning:

With flushing:

% time  git log -p v2.6.21.. | grep '^+' | wc -l

real    0m22.330s
user    0m21.512s
sys     0m0.807s

# of write() system calls according to strace -c: 15167

Without flushing:

% time  git log -p v2.6.21.. | grep '^+' | wc -l

real    0m22.367s
user    0m21.355s
sys     0m0.720s

# of write() system calls according to strace -c: 11373

So here's the worst case:

% time   git-rev-list HEAD  > /dev/null
real    0m1.575s
user    0m1.477s
sys     0m0.053s
# of write() system calls according to strace -c: 582

% (export GIT_NEVER_FLUSH_STDOUT=t; time   git-rev-list HEAD  > /dev/null) 
real    0m1.535s
user    0m1.463s
sys     0m0.027s
# of write() system calls according to strace -c: 58055

> Under Linux, you'll probably have a fairly hard time 
> seeing any difference, but under other OS's you have both system call 
> latency issues *and* possible scheduling issues (ie the above kind of 
> pipeline can act very differently from a scheduling standpoint if you send 
> lots of small things rather than buffer things a bit on the generating 
> side)

Indeed.  So it's not at all clear this patch is worth applying, but
maybe it would make a difference on some other OS; of course, this
patch also obviates the original intent of Jim Meyering's patch, since
it means that we won't print a useful error message if stdout has been
redirected to a file and the write returns ENOSPC, since we won't be
fflush() when stdout is redirected to a file.  

The added fflush() calls to the incremental git-blame and the
git-log-*/git-whatchanged might make it worthwhile for tools that
depend on those outputs and want faster user response time.  So maybe
adding the fflush() call might be worthwhile for those programs.

						- Ted


commit 7f483ec6366f62d52199e3edefa292a110fcb5c8
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
    if the environment variable GIT_NEVER_FLUSH_STDOUT is set.  This
    latter can speed up a command such as:
    
    	(export GIT_NEVER_FLUSH_STDOUT=t; git-rev-list HEAD | wc -l)
    
    a tiny amount.
    
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

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
index 5c4bc85..2cebeb5 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,5 +1,43 @@
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
+
+	if (f == stdout) {
+		if (stdout_is_file < 0) {
+			if (getenv("GIT_NEVER_FLUSH_STDOUT") ||
+			    ((fstat(fileno(stdout), &st) == 0) &&
+			     S_ISREG(st.st_mode)))
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
