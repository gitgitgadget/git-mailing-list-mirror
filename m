From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sun, 14 May 2006 20:49:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605142044550.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
 <7vzmhlsksm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605131404391.3866@g5.osdl.org>
 <7vpsihsjq6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605131518390.3866@g5.osdl.org>
 <7vbqu0yvda.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605141745410.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 05:49:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfU5M-0007oW-1C
	for gcvg-git@gmane.org; Mon, 15 May 2006 05:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWEODtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 23:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWEODtW
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 23:49:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751312AbWEODtV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 23:49:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4F3nGtH017344
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 May 2006 20:49:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4F3nFdd022902;
	Sun, 14 May 2006 20:49:16 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0605141745410.3866@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20014>



On Sun, 14 May 2006, Linus Torvalds wrote:
> 
> So I would actually assume that the solution is to simply make 
> grep_cache() have a simple
> 
> 	#ifdef __unix__
> 		if (!cached) {
> 			hit = external_grep(opt, paths, cached);
> 			if (hit >= 0)
> 				return hit;
> 		}
> 	#endif
> 
> at the top, so that we'd have the best of both worlds.

Ok. Here's a slightly tested version, my out-lined thing from the email 
was pretty close to working already.

It's not perfect, but it gets the "git grep some-random-string" down to 
the good old half-a-second range for the kernel.

It should convert more of the argument flags for "grep", that should be 
trivial to expand (I did a few just as an example). It should also bother 
to try to return the right "hit" value (which it doesn't, right now - the 
code is kind of there, but I didn't actually bother to do it _right_).

Also, right now it _just_ limits by number of arguments, but it should 
also strictly speaking limit by total argument size (ie add up the length 
of the filenames, and do the "exec_grep()" flush call if it's bigger than 
some random value like 32kB).

But I think that it's _conceptually_ doing all the right things, and it 
seems to work. So maybe somebody else can do some of the final polish.

		Linus

----
diff --git a/builtin-grep.c b/builtin-grep.c
index fead356..14471db 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -12,6 +12,7 @@ #include "tree-walk.h"
 #include "builtin.h"
 #include <regex.h>
 #include <fnmatch.h>
+#include <sys/wait.h>
 
 /*
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
@@ -409,12 +410,90 @@ static int grep_file(struct grep_opt *op
 	return i;
 }
 
+static int exec_grep(int argc, const char **argv)
+{
+	pid_t pid;
+	int status;
+
+	argv[argc] = NULL;
+	pid = fork();
+	if (pid < 0)
+		return pid;
+	if (!pid) {
+		execvp("grep", (char **) argv);
+		exit(255);
+	}
+	while (waitpid(pid, &status, 0) < 0) {
+		if (errno == EINTR)
+			continue;
+		return -1;
+	}
+	if (WIFEXITED(status)) {
+		if (!WEXITSTATUS(status))
+			return 1;
+		return 0;
+	}
+	return -1;
+}
+
+#define MAXARGS 1000
+
+static int external_grep(struct grep_opt *opt, const char **paths, int cached)
+{
+	int i, nr, argc, hit;
+	const char *argv[MAXARGS+1];
+	struct grep_pat *p;
+
+	nr = 0;
+	argv[nr++] = "grep";
+	if (opt->word_regexp)
+		argv[nr++] = "-w";
+	if (opt->name_only)
+		argv[nr++] = "-l";
+	for (p = opt->pattern_list; p; p = p->next) {
+		argv[nr++] = "-e";
+		argv[nr++] = p->pattern;
+	}
+	argv[nr++] = "--";
+
+	hit = 0;
+	argc = nr;
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (ce_stage(ce) || !S_ISREG(ntohl(ce->ce_mode)))
+			continue;
+		if (!pathspec_matches(paths, ce->name))
+			continue;
+		argv[argc++] = ce->name;
+		if (argc < MAXARGS)
+			continue;
+		hit += exec_grep(argc, argv);
+		argc = nr;
+	}
+	if (argc > nr)
+		hit += exec_grep(argc, argv);
+	return 0;
+}
+
 static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 {
 	int hit = 0;
 	int nr;
 	read_cache();
 
+#ifdef __unix__
+	/*
+	 * Use the external "grep" command for the case where
+	 * we grep through the checked-out files. It tends to
+	 * be a lot more optimized
+	 */
+	if (!cached) {
+		hit = external_grep(opt, paths, cached);
+		if (hit >= 0)
+			return hit;
+	}
+#endif
+
 	for (nr = 0; nr < active_nr; nr++) {
 		struct cache_entry *ce = active_cache[nr];
 		if (ce_stage(ce) || !S_ISREG(ntohl(ce->ce_mode)))
