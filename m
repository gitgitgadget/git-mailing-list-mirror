From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: [PATCH] Use macro HANDLER_WRAPPER in sigchain to wrap clean function
 of sigchain
Date: Tue, 13 Mar 2012 15:52:56 +0800
Message-ID: <CAMocUqRsEvwnoV32Cr05dJeUj7iNDj1cLP5kAzgyMNEo1O0kCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: =?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 08:53:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7MXY-0008Ao-Da
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 08:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899Ab2CMHw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 03:52:59 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47008 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab2CMHw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 03:52:57 -0400
Received: by bkcik5 with SMTP id ik5so146665bkc.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=K30F2RoCyi8uIx63AFBYh6HAJCNNppBBA5Y+WuVhGUM=;
        b=zc1uzU/xdpmguzXZvXhqk8uInpxIsDjiMAwQ+N88UOQ/r5xPW7g24nIBvUNoj/FV31
         5tWykQYR3PcowrSxvduVasK0kfRpVyq2U5XYC6WXu8Oyx05msEsNlNKfeSrOagF+4vWq
         MxJmzM3p6kEv3Pr0YJDn/jeHQ5don4VHHdXvooTlJxXJMHEvs0ZWjLColQbG/PNo/Rbj
         LcoGnCiLb3NmyzhQUgPcUkI5dFq2jXLK34jcAdt++HSGMUmupu3n/7g8aV9z0tqq1ydU
         QqIHNrB650haD1xnUwZSrxR2ydKoNfjoONX0JyxB9AiF3d4B5CGBhBW9S7+gApDZq1J2
         U6gA==
Received: by 10.205.133.13 with SMTP id hw13mr5750986bkc.25.1331625176352;
 Tue, 13 Mar 2012 00:52:56 -0700 (PDT)
Received: by 10.204.36.85 with HTTP; Tue, 13 Mar 2012 00:52:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192986>

The sigchain APIs require user to code like:

void clean_foo_on_signal(int sig)
{
 clean_foo();
 sigchain_pop(sig);
 raise(sig);
}

this force user to know how sigchain works internally, and
sigchain_pop is something like hard-coded constant value, if we change
it someday, we shall change it everywhere where we use sigchain APIs.
We could use macro to override this. The HANDLER_WRAPPER take two
arguments: one for the function name it will define, and another for
clean function which handler should call before sigchain_pop(sig) and
raise(sig).

The only problem of this patch is HANDLER_WRAPPER is not generic
enough, some clean function requires one argument which is signo to
finish its work, but the only example of this is the function named
'cleanup_children' from run-command.c. Maybe we should force every
clean function take signo argument?

Signed-off-by: Xu Di <xudifsd@gmail.com>
---
 Documentation/technical/api-sigchain.txt |   19 +++++++++++++------
 credential-cache--daemon.c               |    7 +------
 diff.c                                   |    7 +------
 http-push.c                              |    7 +------
 lockfile.c                               |    7 +------
 pager.c                                  |    7 +------
 sigchain.h                               |    8 ++++++++
 7 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/Documentation/technical/api-sigchain.txt
b/Documentation/technical/api-sigchain.txt
index 9e1189e..b6a0b88 100644
--- a/Documentation/technical/api-sigchain.txt
+++ b/Documentation/technical/api-sigchain.txt
@@ -17,12 +17,7 @@ Sigchain is a tiny library for keeping a stack of
handlers. Your handler
 and installation code should look something like:

 ------------------------------------------
-  void clean_foo_on_signal(int sig)
-  {
-	  clean_foo();
-	  sigchain_pop(sig);
-	  raise(sig);
-  }
+  HANDLER_WRAPPER(clean_foo_on_signal, clean_foo)

   void other_func()
   {
@@ -32,6 +27,18 @@ and installation code should look something like:
   }
 ------------------------------------------

+We use the macro which is named HANDLER_WRAPPER to help us wrap the
+clean function, the macro above will finally expanded into:
+
+------------------------------------------
+  void clean_foo_on_signal(int sig)
+  {
+	  clean_foo();
+	  sigchain_pop(sig);
+	  raise(sig);
+  }
+------------------------------------------
+
 Handlers are given the typedef of sigchain_fun. This is the same type
 that is given to signal() or sigaction(). It is perfectly reasonable to
 push SIG_DFL or SIG_IGN onto the stack.
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 390f194..8bb983d 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -11,12 +11,7 @@ static void cleanup_socket(void)
 		unlink(socket_path);
 }

-static void cleanup_socket_on_signal(int sig)
-{
-	cleanup_socket();
-	sigchain_pop(sig);
-	raise(sig);
-}
+static HANDLER_WRAPPER(cleanup_socket_on_signal, cleanup_socket)

 struct credential_cache_entry {
 	struct credential item;
diff --git a/diff.c b/diff.c
index 377ec1e..9535171 100644
--- a/diff.c
+++ b/diff.c
@@ -525,12 +525,7 @@ static void remove_tempfile(void)
 	}
 }

-static void remove_tempfile_on_signal(int signo)
-{
-	remove_tempfile();
-	sigchain_pop(signo);
-	raise(signo);
-}
+static HANDLER_WRAPPER(remove_tempfile_on_signal, remove_tempfile)

 static void print_line_count(FILE *file, int count)
 {
diff --git a/http-push.c b/http-push.c
index f22f7e4..b2e33a7 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1027,12 +1027,7 @@ static void remove_locks(void)
 	}
 }

-static void remove_locks_on_signal(int signo)
-{
-	remove_locks();
-	sigchain_pop(signo);
-	raise(signo);
-}
+static HANDLER_WRAPPER(remove_locks_on_signal, remove_locks)

 static void remote_ls(const char *path, int flags,
 		      void (*userFunc)(struct remote_ls_ctx *ls),
diff --git a/lockfile.c b/lockfile.c
index c6fb77b..fd972f3 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -22,12 +22,7 @@ static void remove_lock_file(void)
 	}
 }

-static void remove_lock_file_on_signal(int signo)
-{
-	remove_lock_file();
-	sigchain_pop(signo);
-	raise(signo);
-}
+static HANDLER_WRAPPER(remove_lock_file_on_signal, remove_lock_file)

 /*
  * p = absolute or relative path name
diff --git a/pager.c b/pager.c
index 05584de..4ba2b41 100644
--- a/pager.c
+++ b/pager.c
@@ -39,12 +39,7 @@ static void wait_for_pager(void)
 	finish_command(&pager_process);
 }

-static void wait_for_pager_signal(int signo)
-{
-	wait_for_pager();
-	sigchain_pop(signo);
-	raise(signo);
-}
+static HANDLER_WRAPPER(wait_for_pager_signal, wait_for_pager)

 const char *git_pager(int stdout_is_tty)
 {
diff --git a/sigchain.h b/sigchain.h
index 618083b..949f0d4 100644
--- a/sigchain.h
+++ b/sigchain.h
@@ -1,6 +1,14 @@
 #ifndef SIGCHAIN_H
 #define SIGCHAIN_H

+#define HANDLER_WRAPPER(name, handler) \
+void name(int sig)				\
+{								\
+		handler();			\
+		sigchain_pop(sig);		\
+		raise(sig);				\
+}
+
 typedef void (*sigchain_fun)(int);

 int sigchain_push(int sig, sigchain_fun f);
-- 
1.7.9.1.265.gb3a76
