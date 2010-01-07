From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 5/5] Windows: avoid the "dup dance" when spawning a 
	child process
Date: Thu,  7 Jan 2010 22:55:01 +0100
Message-ID: <6132a6e771d688116def5a64eb198e41bb46ead1.1262895937.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: 3p1hGSwMIB5E4RE5yw1.9C17DJD13E19916z1C9FAD.x97@listserv.bounces.google.com Thu Jan 07 22:57:14 2010
Return-path: <3p1hGSwMIB5E4RE5yw1.9C17DJD13E19916z1C9FAD.x97@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f143.google.com ([209.85.210.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0Lx-0002HP-0t
	for gcvm-msysgit@m.gmane.org; Thu, 07 Jan 2010 22:57:13 +0100
Received: by yxe7 with SMTP id 7sf50088252yxe.25
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Jan 2010 13:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:from:to
         :cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        bh=lqQi0Qyh1hfrrGrcBz/o49jF2Dh+TcFKSsHcfyoR2vc=;
        b=CMmJvjvJz3aSEeoAyAxT2n583qU63+N1KXLE9su43ANvPQA4I3XFxgO2zwVtKZ53EG
         YxglEVLPaVXH28zLSr3CwU4w5LcbaTJlIg5O8khyk/DdYgwUCMLNwEW+D5alKdPbr8+s
         bxmRQX7a9aRoubORLx9KXs5Y9WUpzsMuSTml0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        b=iEbnTEgQo5Ye+t9n5DzFYhCJaae71+ITtxEh9l0iV4AlFRTmiFp/eVvInabirxA9O0
         Vq9NfFWZqKRkLjoqjtcSMzLw7LMcg35d/ruGsGUbJvnOKlu8G3v99KxCbqqSCkDTzwCB
         HQClhXSlHwUzpu0I9HKEvhOyTXq9ET7em0uIs=
Received: by 10.101.131.28 with SMTP id i28mr1571584ann.17.1262901415620;
        Thu, 07 Jan 2010 13:56:55 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.151.83 with SMTP id b19ls300167bkw.2.p; Thu, 07 Jan 2010 
	13:56:54 -0800 (PST)
Received: by 10.204.136.195 with SMTP id s3mr705362bkt.9.1262901414016;
        Thu, 07 Jan 2010 13:56:54 -0800 (PST)
Received: by 10.204.136.195 with SMTP id s3mr705361bkt.9.1262901413979;
        Thu, 07 Jan 2010 13:56:53 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 12si2322682bwz.14.2010.01.07.13.56.53;
        Thu, 07 Jan 2010 13:56:53 -0800 (PST)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 819F3CDF85;
	Thu,  7 Jan 2010 22:56:53 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1862819F610;
	Thu,  7 Jan 2010 22:56:06 +0100 (CET)
X-Mailer: git-send-email 1.6.6.115.gd1ab3
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	195.3.86.186 is neither permitted nor denied by best guess record for domain 
	of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/89026b66486ea92e
X-Message-Url: http://groups.google.com/group/msysgit/msg/6fb4bbc02cf415fb
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136394>

When stdin, stdout, or stderr must be redirected for a child process that
on Windows is spawned using one of the spawn() functions of Microsoft's
C runtime, then there is no choice other than to

1. make a backup copy of fd 0,1,2 with dup
2. dup2 the redirection source fd into 0,1,2
3. spawn
4. dup2 the backup back into 0,1,2
5. close the backup copy and the redirection source

We used this idiom as well -- but we are not using the spawn() functions!

Instead, we have our own implementation (originally, because we have to
override the environment, too). We had hardcoded that stdin, stdout, and
stderr of the child process were inherited from the parent's fds 0, 1,
and 2. But we can actually specify any fd.

With this patch, the fds to inherit are passed from start_command()'s
WIN32 section to our spawn implementation. This way, we can avoid the
backup copies of the fds.

The backup copies were a bug waiting to surface: The OS handles underlying
the dup()ed fds were inherited by the child process (but were not
associated with a file descriptor in the child). Consequently, the file or
pipe represented by the OS handle remained open even after the backup copy
was closed in the parent process.

Since our implementation of pipe() creates non-inheritable OS handles, we
still dup()s file descriptors in start_command() because dup() happens to
create inheritable duplicates. (A nice side effect is that the fd cleanup
in start_command is the same for Windows and Unix and remains unchanged.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c |   25 +++++++++++++------
 compat/mingw.h |    3 +-
 run-command.c  |   71 ++++++++++++++++++++++++-------------------------------
 3 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9f4fab3..74ffc18 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -615,8 +615,8 @@ static int env_compare(const void *a, const void *b)
 	return strcasecmp(*ea, *eb);
 }
 
-static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
-			   int prepend_cmd)
+static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
+			      int prepend_cmd, int fhin, int fhout, int fherr)
 {
 	STARTUPINFO si;
 	PROCESS_INFORMATION pi;
@@ -652,9 +652,9 @@ static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
 	memset(&si, 0, sizeof(si));
 	si.cb = sizeof(si);
 	si.dwFlags = STARTF_USESTDHANDLES;
-	si.hStdInput = (HANDLE) _get_osfhandle(0);
-	si.hStdOutput = (HANDLE) _get_osfhandle(1);
-	si.hStdError = (HANDLE) _get_osfhandle(2);
+	si.hStdInput = (HANDLE) _get_osfhandle(fhin);
+	si.hStdOutput = (HANDLE) _get_osfhandle(fhout);
+	si.hStdError = (HANDLE) _get_osfhandle(fherr);
 
 	/* concatenate argv, quoting args as we go */
 	strbuf_init(&args, 0);
@@ -709,7 +709,14 @@ static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
 	return (pid_t)pi.hProcess;
 }
 
-pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env)
+static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
+			   int prepend_cmd)
+{
+	return mingw_spawnve_fd(cmd, argv, env, prepend_cmd, 0, 1, 2);
+}
+
+pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
+		     int fhin, int fhout, int fherr)
 {
 	pid_t pid;
 	char **path = get_path_split();
@@ -731,13 +738,15 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env)
 				pid = -1;
 			}
 			else {
-				pid = mingw_spawnve(iprog, argv, env, 1);
+				pid = mingw_spawnve_fd(iprog, argv, env, 1,
+						       fhin, fhout, fherr);
 				free(iprog);
 			}
 			argv[0] = argv0;
 		}
 		else
-			pid = mingw_spawnve(prog, argv, env, 0);
+			pid = mingw_spawnve_fd(prog, argv, env, 0,
+					       fhin, fhout, fherr);
 		free(prog);
 	}
 	free_path_split(path);
diff --git a/compat/mingw.h b/compat/mingw.h
index e681135..238fd70 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -220,7 +220,8 @@ int mingw_fstat(int fd, struct stat *buf);
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
 
-pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env);
+pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
+		     int fhin, int fhout, int fherr);
 void mingw_execvp(const char *cmd, char *const *argv);
 #define execvp mingw_execvp
 
diff --git a/run-command.c b/run-command.c
index cf2d8f7..d270664 100644
--- a/run-command.c
+++ b/run-command.c
@@ -8,12 +8,14 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
+#ifndef WIN32
 static inline void dup_devnull(int to)
 {
 	int fd = open("/dev/null", O_RDWR);
 	dup2(fd, to);
 	close(fd);
 }
+#endif
 
 int start_command(struct child_process *cmd)
 {
@@ -135,42 +137,30 @@ fail_pipe:
 			strerror(failed_errno = errno));
 #else
 {
-	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
+	int fhin = 0, fhout = 1, fherr = 2;
 	const char **sargv = cmd->argv;
 	char **env = environ;
 
-	if (cmd->no_stdin) {
-		s0 = dup(0);
-		dup_devnull(0);
-	} else if (need_in) {
-		s0 = dup(0);
-		dup2(fdin[0], 0);
-	} else if (cmd->in) {
-		s0 = dup(0);
-		dup2(cmd->in, 0);
-	}
-
-	if (cmd->no_stderr) {
-		s2 = dup(2);
-		dup_devnull(2);
-	} else if (need_err) {
-		s2 = dup(2);
-		dup2(fderr[1], 2);
-	}
-
-	if (cmd->no_stdout) {
-		s1 = dup(1);
-		dup_devnull(1);
-	} else if (cmd->stdout_to_stderr) {
-		s1 = dup(1);
-		dup2(2, 1);
-	} else if (need_out) {
-		s1 = dup(1);
-		dup2(fdout[1], 1);
-	} else if (cmd->out > 1) {
-		s1 = dup(1);
-		dup2(cmd->out, 1);
-	}
+	if (cmd->no_stdin)
+		fhin = open("/dev/null", O_RDWR);
+	else if (need_in)
+		fhin = dup(fdin[0]);
+	else if (cmd->in)
+		fhin = dup(cmd->in);
+
+	if (cmd->no_stderr)
+		fherr = open("/dev/null", O_RDWR);
+	else if (need_err)
+		fherr = dup(fderr[1]);
+
+	if (cmd->no_stdout)
+		fhout = open("/dev/null", O_RDWR);
+	else if (cmd->stdout_to_stderr)
+		fhout = dup(fherr);
+	else if (need_out)
+		fhout = dup(fdout[1]);
+	else if (cmd->out > 1)
+		fhout = dup(cmd->out);
 
 	if (cmd->dir)
 		die("chdir in start_command() not implemented");
@@ -181,7 +171,8 @@ fail_pipe:
 		cmd->argv = prepare_git_cmd(cmd->argv);
 	}
 
-	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
+	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env,
+				  fhin, fhout, fherr);
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error("cannot spawn %s: %s", cmd->argv[0], strerror(errno));
@@ -192,12 +183,12 @@ fail_pipe:
 		free(cmd->argv);
 
 	cmd->argv = sargv;
-	if (s0 >= 0)
-		dup2(s0, 0), close(s0);
-	if (s1 >= 0)
-		dup2(s1, 1), close(s1);
-	if (s2 >= 0)
-		dup2(s2, 2), close(s2);
+	if (fhin != 0)
+		close(fhin);
+	if (fhout != 1)
+		close(fhout);
+	if (fherr != 2)
+		close(fherr);
 }
 #endif
 
-- 
1.6.6.115.gd1ab3
