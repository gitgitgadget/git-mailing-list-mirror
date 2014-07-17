From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 08/13] Win32: don't copy the environment twice when
 spawning child processes
Date: Thu, 17 Jul 2014 17:38:01 +0200
Message-ID: <1405611486-10176-9-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com Thu Jul 17 17:38:18 2014
Return-path: <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>)
	id 1X7nlB-0008WF-4v
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:17 +0200
Received: by mail-we0-f186.google.com with SMTP id u56sf332939wes.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=UmH6PFHvK3KSRRIYlAWiw1xOYYgLHVwsjbleuvtDIBY=;
        b=hW++I8yaDahxuKRDKxTYJLGy6x42q+dUc/dGoLtjllmN5lYugow/SLAlci2GY+Lxht
         /33IWU9pkNjOOZwfhCUARLquOat1vnKeRojQcBU77OWB2SN2ehckRIGNrg2cpZWBrtOg
         YDA4F84IFinulGIk9LGlhmw7gms2iq68Lr6zsgHz8iTZzMWJQElP0q9nPm1GBJroxmmy
         pJdFM/50D0exXsBTxyhOP9IjMIsWDlXFUURSeKiw5LD0Vcx1/kzJqjs/+WlmwGr6lVad
         0o56ibajn2WYqYxeLQlTKxlWzCau05p9ZN8HHb14xhycq7dzpCMc2LYs1rmJ+a/zEC+V
         fQIg==
X-Received: by 10.152.2.195 with SMTP id 3mr9121law.34.1405611495898;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.97 with SMTP id j1ls219264laj.10.gmail; Thu, 17 Jul 2014
 08:38:14 -0700 (PDT)
X-Received: by 10.112.158.8 with SMTP id wq8mr2617754lbb.12.1405611494789;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id iz18si1071701wic.3.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 78DAD1C01AA; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253753>

From: Karsten Blees <blees@dcon.de>

When spawning child processes via start_command(), the environment and all
environment entries are copied twice. First by make_augmented_environ /
copy_environ to merge with child_process.env. Then a second time by
make_environment_block to create a sorted environment block string as
required by CreateProcess.

Move the merge logic to make_environment_block so that we only need to copy
the environment once. This changes semantics of the env parameter: it now
expects a delta (such as child_process.env) rather than a full environment.
This is not a problem as the parameter is only used by start_command()
(all other callers previously passed char **environ, and now pass NULL).

The merge logic no longer xstrdup()s the environment strings, so do_putenv
must not free them. Add a parameter to distinguish this from normal putenv.

Remove the now unused make_augmented_environ / free_environ API.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 76 ++++++++++++++++++++--------------------------------------
 compat/mingw.h |  8 ++-----
 run-command.c  | 10 ++------
 3 files changed, 30 insertions(+), 64 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3f81c90..ffff592 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -898,6 +898,8 @@ static char *path_lookup(const char *cmd, char **path, int exe_only)
 	return prog;
 }
 
+static char **do_putenv(char **env, const char *name, int free_old);
+
 static int compareenv(const void *a, const void *b)
 {
 	char *const *ea = a;
@@ -906,21 +908,30 @@ static int compareenv(const void *a, const void *b)
 }
 
 /*
- * Create environment block suitable for CreateProcess.
+ * Create environment block suitable for CreateProcess. Merges current
+ * process environment and the supplied environment changes.
  */
-static wchar_t *make_environment_block(char **env)
+static wchar_t *make_environment_block(char **deltaenv)
 {
 	wchar_t *wenvblk = NULL;
 	int count = 0;
 	char **e, **tmpenv;
 	int size = 0, wenvsz = 0, wenvpos = 0;
 
-	for (e = env; *e; e++)
+	while (environ[count])
 		count++;
 
-	/* environment must be sorted */
+	/* copy the environment */
 	tmpenv = xmalloc(sizeof(*tmpenv) * (count + 1));
-	memcpy(tmpenv, env, sizeof(*tmpenv) * (count + 1));
+	memcpy(tmpenv, environ, sizeof(*tmpenv) * (count + 1));
+
+	/* merge supplied environment changes into the temporary environment */
+	for (e = deltaenv; e && *e; e++)
+		tmpenv = do_putenv(tmpenv, *e, 0);
+
+	/* environment must be sorted */
+	for (count = 0; tmpenv[count]; )
+		count++;
 	qsort(tmpenv, count, sizeof(*tmpenv), compareenv);
 
 	/* create environment block from temporary environment */
@@ -943,7 +954,7 @@ struct pinfo_t {
 static struct pinfo_t *pinfo = NULL;
 CRITICAL_SECTION pinfo_cs;
 
-static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
+static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaenv,
 			      const char *dir,
 			      int prepend_cmd, int fhin, int fhout, int fherr)
 {
@@ -1011,8 +1022,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 	xutftowcs(wargs, args.buf, 2 * args.len + 1);
 	strbuf_release(&args);
 
-	if (env)
-		wenvblk = make_environment_block(env);
+	wenvblk = make_environment_block(deltaenv);
 
 	memset(&pi, 0, sizeof(pi));
 	ret = CreateProcessW(wcmd, wargs, NULL, NULL, TRUE, flags,
@@ -1050,10 +1060,10 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 
 static pid_t mingw_spawnv(const char *cmd, const char **argv, int prepend_cmd)
 {
-	return mingw_spawnve_fd(cmd, argv, environ, NULL, prepend_cmd, 0, 1, 2);
+	return mingw_spawnve_fd(cmd, argv, NULL, NULL, prepend_cmd, 0, 1, 2);
 }
 
-pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
+pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **deltaenv,
 		     const char *dir,
 		     int fhin, int fhout, int fherr)
 {
@@ -1077,14 +1087,14 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
 				pid = -1;
 			}
 			else {
-				pid = mingw_spawnve_fd(iprog, argv, env, dir, 1,
+				pid = mingw_spawnve_fd(iprog, argv, deltaenv, dir, 1,
 						       fhin, fhout, fherr);
 				free(iprog);
 			}
 			argv[0] = argv0;
 		}
 		else
-			pid = mingw_spawnve_fd(prog, argv, env, dir, 0,
+			pid = mingw_spawnve_fd(prog, argv, deltaenv, dir, 0,
 					       fhin, fhout, fherr);
 		free(prog);
 	}
@@ -1181,27 +1191,6 @@ int mingw_kill(pid_t pid, int sig)
 	return -1;
 }
 
-static char **copy_environ(void)
-{
-	char **env;
-	int i = 0;
-	while (environ[i])
-		i++;
-	env = xmalloc((i+1)*sizeof(*env));
-	for (i = 0; environ[i]; i++)
-		env[i] = xstrdup(environ[i]);
-	env[i] = NULL;
-	return env;
-}
-
-void free_environ(char **env)
-{
-	int i;
-	for (i = 0; env[i]; i++)
-		free(env[i]);
-	free(env);
-}
-
 static int lookupenv(char **env, const char *name, size_t nmln)
 {
 	int i;
@@ -1217,7 +1206,7 @@ static int lookupenv(char **env, const char *name, size_t nmln)
 /*
  * If name contains '=', then sets the variable, otherwise it unsets it
  */
-static char **do_putenv(char **env, const char *name)
+static char **do_putenv(char **env, const char *name, int free_old)
 {
 	char *eq = strchrnul(name, '=');
 	int i = lookupenv(env, name, eq-name);
@@ -1232,7 +1221,8 @@ static char **do_putenv(char **env, const char *name)
 		}
 	}
 	else {
-		free(env[i]);
+		if (free_old)
+			free(env[i]);
 		if (*eq)
 			env[i] = (char*) name;
 		else
@@ -1242,20 +1232,6 @@ static char **do_putenv(char **env, const char *name)
 	return env;
 }
 
-/*
- * Copies global environ and adjusts variables as specified by vars.
- */
-char **make_augmented_environ(const char *const *vars)
-{
-	char **env = copy_environ();
-
-	while (*vars) {
-		const char *v = *vars++;
-		env = do_putenv(env, strchr(v, '=') ? xstrdup(v) : v);
-	}
-	return env;
-}
-
 #undef getenv
 char *mingw_getenv(const char *name)
 {
@@ -1271,7 +1247,7 @@ char *mingw_getenv(const char *name)
 
 int mingw_putenv(const char *namevalue)
 {
-	environ = do_putenv(environ, namevalue);
+	environ = do_putenv(environ, namevalue, 1);
 	return 0;
 }
 
diff --git a/compat/mingw.h b/compat/mingw.h
index ef94194..df0e320 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -360,12 +360,8 @@ int mingw_offset_1st_component(const char *path);
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
 
-/*
- * helpers
- */
-
-char **make_augmented_environ(const char *const *vars);
-void free_environ(char **env);
+void mingw_mark_as_git_dir(const char *dir);
+#define mark_as_git_dir mingw_mark_as_git_dir
 
 /**
  * Converts UTF-8 encoded string to UTF-16LE.
diff --git a/run-command.c b/run-command.c
index 614b8ac..8e558ad 100644
--- a/run-command.c
+++ b/run-command.c
@@ -454,7 +454,6 @@ fail_pipe:
 {
 	int fhin = 0, fhout = 1, fherr = 2;
 	const char **sargv = cmd->argv;
-	char **env = environ;
 
 	if (cmd->no_stdin)
 		fhin = open("/dev/null", O_RDWR);
@@ -479,24 +478,19 @@ fail_pipe:
 	else if (cmd->out > 1)
 		fhout = dup(cmd->out);
 
-	if (cmd->env)
-		env = make_augmented_environ(cmd->env);
-
 	if (cmd->git_cmd)
 		cmd->argv = prepare_git_cmd(cmd->argv);
 	else if (cmd->use_shell)
 		cmd->argv = prepare_shell_cmd(cmd->argv);
 
-	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env, cmd->dir,
-				  fhin, fhout, fherr);
+	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, (char**) cmd->env,
+			cmd->dir, fhin, fhout, fherr);
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error("cannot spawn %s: %s", cmd->argv[0], strerror(errno));
 	if (cmd->clean_on_exit && cmd->pid >= 0)
 		mark_child_for_cleanup(cmd->pid);
 
-	if (cmd->env)
-		free_environ(env);
 	if (cmd->git_cmd)
 		free(cmd->argv);
 
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
