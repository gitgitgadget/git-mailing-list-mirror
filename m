From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/3] Introduce trivial new pager.c helper infrastructure
Date: Tue, 28 Feb 2006 11:26:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602281124120.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Feb 28 20:26:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEAUT-0001hF-Ra
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 20:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWB1T0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 14:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWB1T0b
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 14:26:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14030 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932430AbWB1T0a (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 14:26:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1SJQRDZ007461
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Feb 2006 11:26:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1SJQLbB026013;
	Tue, 28 Feb 2006 11:26:24 -0800
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16948>


This introduces the new function

	void setup_pager(void);

to set up output to be written through a pager applocation.

All in preparation for doing the simple scripts in C.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Ok, this should be pretty obvious, which is not to say that it shouldn't 
be improved (ie it only handles trivial definitions of PAGER). Any obvious 
improvements are left as an exercise for the reader, as not important for 
my current goal of actually having something working.


diff --git a/Makefile b/Makefile
index 3575489..0b1a998 100644
--- a/Makefile
+++ b/Makefile
@@ -205,7 +205,7 @@ LIB_OBJS = \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
-	fetch-clone.o revision.o \
+	fetch-clone.o revision.o pager.o \
 	$(DIFF_OBJS)
 
 LIBS = $(LIB_FILE)
diff --git a/cache.h b/cache.h
index 58eec00..3af6b86 100644
--- a/cache.h
+++ b/cache.h
@@ -352,4 +352,7 @@ extern int copy_fd(int ifd, int ofd);
 extern int receive_unpack_pack(int fd[2], const char *me, int quiet);
 extern int receive_keep_pack(int fd[2], const char *me, int quiet);
 
+/* pager.c */
+extern void setup_pager(void);
+
 #endif /* CACHE_H */
diff --git a/pager.c b/pager.c
new file mode 100644
index 0000000..1364e15
--- /dev/null
+++ b/pager.c
@@ -0,0 +1,48 @@
+#include "cache.h"
+
+/*
+ * This is split up from the rest of git so that we might do
+ * something different on Windows, for example.
+ */
+
+static void run_pager(void)
+{
+	const char *prog = getenv("PAGER");
+	if (!prog)
+		prog = "less";
+	setenv("LESS", "-S", 0);
+	execlp(prog, prog, NULL);
+}
+
+void setup_pager(void)
+{
+	pid_t pid;
+	int fd[2];
+
+	if (!isatty(1))
+		return;
+	if (pipe(fd) < 0)
+		return;
+	pid = fork();
+	if (pid < 0) {
+		close(fd[0]);
+		close(fd[1]);
+		return;
+	}
+
+	/* return in the child */
+	if (!pid) {
+		dup2(fd[1], 1);
+		close(fd[0]);
+		close(fd[1]);
+		return;
+	}
+
+	/* The original process turns into the PAGER */
+	dup2(fd[0], 0);
+	close(fd[0]);
+	close(fd[1]);
+
+	run_pager();
+	exit(255);
+}
