From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Mon, 25 Jun 2007 15:56:11 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
References: <87r6nzu666.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
 <878xa7u2gh.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 00:56:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2xUP-0005KN-AI
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 00:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbXFYW4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 18:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbXFYW4u
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 18:56:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33868 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751811AbXFYW4u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 18:56:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PMuHW3017532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jun 2007 15:56:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PMuBeK013100;
	Mon, 25 Jun 2007 15:56:12 -0700
In-Reply-To: <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
X-Spam-Status: No, hits=-7.581 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50934>



On Mon, 25 Jun 2007, Linus Torvalds wrote:
> 
> If you really really *must* get that ENOSPC error string output, create a 
> helper function like
> 
> 	void flush_or_die(FILE *f, const char *desc)
> 	{
> 		if (ferror(f))
> 			die("write failure on %s", desc)

Actually, even this is really nasty, and it's a case where the current 
"git.c" code can also fail.

It's an example of where EPIPE can actually cause a write failure that you 
can never figure out what the reason for the error was, because the flush 
was caused by something earlier (write too much for the buffer or 
whatever), exactly because stdio throws the error away.

So after thinking about it some more, I would suggest just ignoring ferror 
entirely, and hoping that any errors are caught by the fflush().

I do hate stdio error checking. In my opinion, there really is only *one* 
correct way to use stdio error checking: ignore it. It doesn't work. The 
thing is fundamentally mis-designed for error handling.

So I think the right solution would literally be to either not do this 
broken error checking at all, or to rewrite the code that cares about 
errors to not use stdio.

There's also another issue: regular files really *are* different from 
pipes and sockets and other things. Not because of EPIPE, but because you 
want different buffering behaviour. For a regular file, we really don't 
even care about the line buffering, and we'd actually be better off (from 
a performance angle) without it.

But we don't have any sane way to save that kind of information (and we 
definitely do *not* want to do the "fstat()" thing on every flush). We 
could use the stdio buffering mode, but

 - it's too weak (we want not line buffered or block buffered, we want 
   basically "record buffered")

 - I don't think there are any portable ways to read it (only set it, 
   using "setbuf()" and friends).

Anyway, getting rid of stdio for writes we care about really *would* be a 
nice thing. But it's a lot of boring, nasty work.

So here's a patch that I think is acceptable. IT IS NOT PERFECT. Stdio 
simply cannot do a good job on errors, but it has a comment about the case 
where it just decides to ignore ferror() instead of doing what I suggest 
above.

I'm not saying this is great. But doing this right really does require 
avoiding stdio entirely.

Does this work for you?

(I pass the "desc" string thing in case there is some future use where we 
also want to use stdio, but we use it for something else than just regular 
stdout. Dunno).

		Linus

---
 builtin-rev-list.c |    2 +-
 cache.h            |    2 ++
 log-tree.c         |    1 +
 write_or_die.c     |   20 ++++++++++++++++++++
 4 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 813aadf..3980bf4 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -100,7 +100,7 @@ static void show_commit(struct commit *commit)
 		printf("%s%c", buf, hdr_termination);
 		free(buf);
 	}
-	fflush(stdout);
+	flush_or_die(stdout, "stdout");
 	if (commit->parents) {
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
diff --git a/cache.h b/cache.h
index ed83d92..aae9e2a 100644
--- a/cache.h
+++ b/cache.h
@@ -532,6 +532,8 @@ extern char git_default_name[MAX_GITNAME];
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
 
+/* IO helper functions */
+extern void flush_or_die(FILE *, const char *);
 extern int copy_fd(int ifd, int ofd);
 extern int read_in_full(int fd, void *buf, size_t count);
 extern int write_in_full(int fd, const void *buf, size_t count);
diff --git a/log-tree.c b/log-tree.c
index 0cf21bc..061ecf7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -408,5 +408,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		shown = 1;
 	}
 	opt->loginfo = NULL;
+	flush_or_die(stdout, "stdout");
 	return shown;
 }
diff --git a/write_or_die.c b/write_or_die.c
index 5c4bc85..84f411d 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,5 +1,25 @@
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
+ */
+void flush_or_die(FILE *f, const char *desc)
+{
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
