From: Etienne Buira <etienne.buira@gmail.com>
Subject: [PATCH v4] Handle atexit list internaly for unthreaded builds
Date: Mon, 13 Oct 2014 20:35:58 +0200
Message-ID: <2724eb56a7219e0ed341e734beb32aa236119998.1413225018.git.etienne.buira@gmail.com>
References: <87bnpg9b99.fsf@igel.home>
Cc: git@vger.kernel.org, etienne.buira@gmail.com
To: pclouds@gmail.com, schwab@linux-m68k.org
X-From: git-owner@vger.kernel.org Mon Oct 13 20:37:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdkUR-0008Li-BO
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 20:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbaJMSgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 14:36:55 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:43766 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbaJMSgy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 14:36:54 -0400
Received: by mail-wi0-f173.google.com with SMTP id fb4so8197486wid.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F26SKUQWhKYpR8f12uFJuYY7tvqIDu2b3RUo4Lf31oo=;
        b=w0bNZSG+ovvaUoA8+5ZnYs0ZuJL/r/I3MXDq/5dlGrMhNfeEZ3c5+1nuoudQcT5lyh
         ckFbU/vyymUpJscuXg47rC7X6vMEgGwpZnHUY1Aa/MeN6nZFxTn/ctInH7fxhDaezCXY
         B705JAFK5mOb4s5Yl0GQLt6dLfs6+jez+3rUhRovQuEcXSBiVOTUuH/bV3G7zZguvqBu
         XkAGLBfpuZJQFes7GAf4cbfDj5QxUMxH+2M5wGrApi0cckOMAYVAweNEvlqwt9qcG4Eo
         JePnTyvEQ1QUyMxA5O7VAnAlusCvni3vofPLNMc5UUrcEkfXa5H2igrkS0dWBl44FGkS
         ZNmw==
X-Received: by 10.180.96.226 with SMTP id dv2mr736620wib.49.1413225413333;
        Mon, 13 Oct 2014 11:36:53 -0700 (PDT)
Received: from localhost.localdomain (sbr22-2-88-185-151-243.fbx.proxad.net. [88.185.151.243])
        by mx.google.com with ESMTPSA id cx1sm13085494wib.1.2014.10.13.11.36.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2014 11:36:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <87bnpg9b99.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap atexit()s calls on unthreaded builds to handle callback list
internally.

This is needed because on unthreaded builds, asyncs inherits parent's
atexit() list, that gets run as soon as the async exit()s (and again at
the end of the parent process). That led to remove temporary and lock
files too early.

Fixes test 5537 (temporary shallow file vanished before unpack-objects
could open it)

V4: fix bogus preprocessor directives

Thanks-to: Duy Nguyen <pclouds@gmail.com>
Thanks-to: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Etienne Buira <etienne.buira@gmail.com>
---
 builtin/clone.c   |  5 -----
 git-compat-util.h |  5 +++++
 run-command.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 shallow.c         |  7 ++-----
 4 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bbd169c..e122f33 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -390,7 +390,6 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 
 static const char *junk_work_tree;
 static const char *junk_git_dir;
-static pid_t junk_pid;
 static enum {
 	JUNK_LEAVE_NONE,
 	JUNK_LEAVE_REPO,
@@ -417,8 +416,6 @@ static void remove_junk(void)
 		break;
 	}
 
-	if (getpid() != junk_pid)
-		return;
 	if (junk_git_dir) {
 		strbuf_addstr(&sb, junk_git_dir);
 		remove_dir_recursively(&sb, 0);
@@ -758,8 +755,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct refspec *refspec;
 	const char *fetch_pattern;
 
-	junk_pid = getpid();
-
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..6dd63dd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -577,6 +577,11 @@ int inet_pton(int af, const char *src, void *dst);
 const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 #endif
 
+#ifdef NO_PTHREADS
+#define atexit git_atexit
+extern int git_atexit(void (*handler)(void));
+#endif
+
 extern void release_pack_memory(size_t);
 
 typedef void (*try_to_free_t)(size_t);
diff --git a/run-command.c b/run-command.c
index 35a3ebf..0f9a9b0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -624,6 +624,45 @@ static int async_die_is_recursing(void)
 	return ret != NULL;
 }
 
+#else
+
+static struct {
+	void (**handlers)(void);
+	size_t nr;
+	size_t alloc;
+} git_atexit_hdlrs;
+
+static int git_atexit_installed;
+
+static void git_atexit_dispatch()
+{
+	size_t i;
+
+	for (i=git_atexit_hdlrs.nr ; i ; i--)
+		git_atexit_hdlrs.handlers[i-1]();
+}
+
+static void git_atexit_clear()
+{
+	free(git_atexit_hdlrs.handlers);
+	memset(&git_atexit_hdlrs, 0, sizeof(git_atexit_hdlrs));
+	git_atexit_installed = 0;
+}
+
+#undef atexit
+int git_atexit(void (*handler)(void))
+{
+	ALLOC_GROW(git_atexit_hdlrs.handlers, git_atexit_hdlrs.nr + 1, git_atexit_hdlrs.alloc);
+	git_atexit_hdlrs.handlers[git_atexit_hdlrs.nr++] = handler;
+	if (!git_atexit_installed) {
+		if (atexit(&git_atexit_dispatch))
+			return -1;
+		git_atexit_installed = 1;
+	}
+	return 0;
+}
+#define atexit git_atexit
+
 #endif
 
 int start_async(struct async *async)
@@ -682,6 +721,7 @@ int start_async(struct async *async)
 			close(fdin[1]);
 		if (need_out)
 			close(fdout[0]);
+		git_atexit_clear();
 		exit(!!async->proc(proc_in, proc_out, async->data));
 	}
 
diff --git a/shallow.c b/shallow.c
index de07709..f067811 100644
--- a/shallow.c
+++ b/shallow.c
@@ -226,7 +226,6 @@ static void remove_temporary_shallow_on_signal(int signo)
 
 const char *setup_temporary_shallow(const struct sha1_array *extra)
 {
-	static int installed_handler;
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
@@ -237,10 +236,8 @@ const char *setup_temporary_shallow(const struct sha1_array *extra)
 		strbuf_addstr(&temporary_shallow, git_path("shallow_XXXXXX"));
 		fd = xmkstemp(temporary_shallow.buf);
 
-		if (!installed_handler) {
-			atexit(remove_temporary_shallow);
-			sigchain_push_common(remove_temporary_shallow_on_signal);
-		}
+		atexit(remove_temporary_shallow);
+		sigchain_push_common(remove_temporary_shallow_on_signal);
 
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-- 
2.0.4
