From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 3/3] Tie it all together: "git log"
Date: Tue, 28 Feb 2006 11:30:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602281126340.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Feb 28 20:30:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEAYJ-00031A-9N
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 20:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWB1Ta2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 14:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWB1Ta2
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 14:30:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26319 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932458AbWB1Ta1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 14:30:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1SJUNDZ007771
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Feb 2006 11:30:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1SJUJKH026215;
	Tue, 28 Feb 2006 11:30:21 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16949>


This is what the previous diffs all built up to.

We can do "git log" as a trivial small helper function inside git.c, 
because the infrastructure is all there for us to use as a library.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

Again, this may not do exactly what the current "git log" does. That's not 
the point. The point is to introduce the fundamental functionality, so 
that people can play with this and improve on it, and fix any of my stupid 
bugs.

It should be pretty easy to change some of the other rev-list-walking 
functions to use the library interfaces too, instead of executing an 
external "git-rev-list" process. This was a perfect example of how to get 
something working, though.

		Linus

diff --git a/Makefile b/Makefile
index 0b1a998..ead13be 100644
--- a/Makefile
+++ b/Makefile
@@ -450,7 +450,7 @@ strip: $(PROGRAMS) git$X
 
 git$X: git.c $(LIB_FILE)
 	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
-		$(CFLAGS) $(COMPAT_CFLAGS) -o $@ $(filter %.c,$^) $(LIB_FILE)
+		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) $(LIB_FILE) $(LIBS)
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	rm -f $@
diff --git a/git.c b/git.c
index 993cd0d..b0da6b1 100644
--- a/git.c
+++ b/git.c
@@ -12,6 +12,10 @@
 #include "git-compat-util.h"
 #include "exec_cmd.h"
 
+#include "cache.h"
+#include "commit.h"
+#include "revision.h"
+
 #ifndef PATH_MAX
 # define PATH_MAX 4096
 #endif
@@ -245,6 +249,25 @@ static int cmd_help(int argc, char **arg
 	return 0;
 }
 
+#define LOGSIZE (65536)
+
+static int cmd_log(int argc, char **argv, char **envp)
+{
+	struct rev_info rev;
+	struct commit *commit;
+	char *buf = xmalloc(LOGSIZE);
+
+	argc = setup_revisions(argc, argv, &rev, "HEAD");
+	prepare_revision_walk(&rev);
+	setup_pager();
+	while ((commit = get_revision(&rev)) != NULL) {
+		pretty_print_commit(CMIT_FMT_DEFAULT, commit, ~0, buf, LOGSIZE, 18);
+		printf("%s\n", buf);
+	}
+	free(buf);
+	return 0;
+}
+
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
 static void handle_internal_command(int argc, char **argv, char **envp)
@@ -256,6 +279,7 @@ static void handle_internal_command(int 
 	} commands[] = {
 		{ "version", cmd_version },
 		{ "help", cmd_help },
+		{ "log", cmd_log },
 	};
 	int i;
 
