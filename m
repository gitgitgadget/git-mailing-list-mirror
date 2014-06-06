From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git autocorrect bug
Date: Fri, 6 Jun 2014 18:09:35 +0700
Message-ID: <20140606110935.GA14446@lanh>
References: <1401940145.18134.170.camel@stross>
 <CACsJy8BSHAUiF_BR_Vi4_LOW0CSP-N09UpAg-UJvZJ1fvipejg@mail.gmail.com>
 <1401956903.18134.173.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 13:09:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wss1m-0007hG-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 13:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbaFFLJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 07:09:38 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37345 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaFFLJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 07:09:37 -0400
Received: by mail-ig0-f172.google.com with SMTP id l13so659620iga.17
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 04:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qPhVtFI/7GDNy575wCS6nuSGrRPMJWJN6HMx6ZVujzY=;
        b=EnRCP+kiAl3H54nIP7X8b2cW2gcjLug3yAeJ06T6421qQsKnjcfbaMOef2OV9zdsGp
         KHt3X49MwXAL3lvL0cFpUk/K1VSvVcqYMSYosbS2beP8PkQ51wbC2aBRPtOO1zrKOTnc
         KApOEIQsR4JKbaKFABQPODQgeWlzSpqbx+LS39k5NGP+8Z++Ybcv1VG+V/bY3MwlVXRp
         Krwo6thychKEoKFjFS+/vnKJH/EJFEeunqyBUnyw5INKgDY7gfP2qxl87SkQDcOYm50E
         9AcvD3k5RQd77LaB1XbudAFXtsOxI2hRMlhtQMctlfmd0gAlIb+AjukxtlhzvNlGjq9i
         mInw==
X-Received: by 10.50.43.136 with SMTP id w8mr4527195igl.20.1402052976600;
        Fri, 06 Jun 2014 04:09:36 -0700 (PDT)
Received: from lanh ([115.73.251.64])
        by mx.google.com with ESMTPSA id gw8sm34574504pbc.28.2014.06.06.04.09.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jun 2014 04:09:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 06 Jun 2014 18:09:35 +0700
Content-Disposition: inline
In-Reply-To: <1401956903.18134.173.camel@stross>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250898>

On Thu, Jun 05, 2014 at 04:28:23AM -0400, David Turner wrote:
> On Thu, 2014-06-05 at 13:29 +0700, Duy Nguyen wrote:
> > On Thu, Jun 5, 2014 at 10:49 AM, David Turner <dturner@twopensource.com> wrote:
> > > fatal: internal error: work tree has already been set
> > > Current worktree: /home/dturner/git
> > > New worktree: /home/dturner/git/foo
> > 
> > This is the part you complain about, right? 
> 
> Yes.
> 
> > I think I might know
> > what's going on here. But do you expect "git git foo" to turn to "git
> > init foo" in the first place?
> 
> Yes.

I was hoping you would say no so I could get away without doing
anything :) The problem is "setup pollution". When somebody looks up
an alias (autocorrect does), $GIT_DIR must be searched because
$GIT_DIR/config may have repo-local aliases. But 'git init' (and
clone) expects a clean no-setup state.

This is a known issue. You can reproduce by aliasing init to
something, then init a new repo using that alias. In fact Jonathan
wrote a few test to catch this. The solution is we start out fresh in
a new process. The fork/exec overhead should not matter because this
is interactive session.

I'm just wondering if I should remove the "only applicable to init and
clone" check in the patch because there's another companion problem:
if we find $GIT_DIR automatically, then $GIT_DIR/config points out
that work-tree must be moved, it'll get nasty because we already set
everything up for the auto-found worktree. But maybe I already solved
that, not sure..

-- 8< --
diff --git a/compat/mingw.c b/compat/mingw.c
index e9892f8..34722fe 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1080,19 +1080,6 @@ int mingw_kill(pid_t pid, int sig)
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
 void free_environ(char **env)
 {
 	int i;
diff --git a/git-compat-util.h b/git-compat-util.h
index 76910e6..1db4dec 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -732,4 +732,6 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define gmtime_r git_gmtime_r
 #endif
 
+char **copy_environ(void);
+
 #endif
diff --git a/git.c b/git.c
index 7780572..77d9204 100644
--- a/git.c
+++ b/git.c
@@ -20,6 +20,22 @@ const char git_more_info_string[] =
 
 static struct startup_info git_startup_info;
 static int use_pager = -1;
+static char orig_cwd[PATH_MAX];
+static char **orig_environ;
+
+static void save_env(void)
+{
+	getcwd(orig_cwd, sizeof(orig_cwd));
+	orig_environ = copy_environ();
+}
+
+static void restore_env(void)
+{
+	if (*orig_cwd && chdir(orig_cwd))
+		die_errno("could not move to %s", orig_cwd);
+	if (orig_environ)
+		environ = orig_environ;
+}
 
 static void commit_pager_choice(void) {
 	switch (use_pager) {
@@ -459,7 +475,7 @@ int is_builtin(const char *s)
 	return 0;
 }
 
-static void handle_builtin(int argc, const char **argv)
+static void handle_builtin(int argc, const char **argv, int preprocessed)
 {
 	const char *cmd = argv[0];
 	int i;
@@ -484,6 +500,11 @@ static void handle_builtin(int argc, const char **argv)
 		struct cmd_struct *p = commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
+		if (preprocessed &&
+		    (p->fn == cmd_init_db || p->fn == cmd_clone)) {
+			restore_env();
+			break;
+		}
 		exit(run_builtin(p, argc, argv));
 	}
 }
@@ -524,13 +545,13 @@ static void execv_dashed_external(const char **argv)
 	strbuf_release(&cmd);
 }
 
-static int run_argv(int *argcp, const char ***argv)
+static int run_argv(int *argcp, const char ***argv, int done_help)
 {
 	int done_alias = 0;
 
 	while (1) {
 		/* See if it's a builtin */
-		handle_builtin(*argcp, *argv);
+		handle_builtin(*argcp, *argv, done_help || done_alias);
 
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
@@ -539,7 +560,10 @@ static int run_argv(int *argcp, const char ***argv)
 		 * of overriding "git log" with "git show" by having
 		 * alias.log = show
 		 */
-		if (done_alias || !handle_alias(argcp, argv))
+		if (done_alias)
+			break;
+		save_env();
+		if (!handle_alias(argcp, argv))
 			break;
 		done_alias = 1;
 	}
@@ -581,7 +605,7 @@ int main(int argc, char **av)
 	if (starts_with(cmd, "git-")) {
 		cmd += 4;
 		argv[0] = cmd;
-		handle_builtin(argc, argv);
+		handle_builtin(argc, argv, 0);
 		die("cannot handle %s as a builtin", cmd);
 	}
 
@@ -613,7 +637,7 @@ int main(int argc, char **av)
 	while (1) {
 		static int done_help = 0;
 		static int was_alias = 0;
-		was_alias = run_argv(&argc, &argv);
+		was_alias = run_argv(&argc, &argv, done_help);
 		if (errno != ENOENT)
 			break;
 		if (was_alias) {
@@ -623,6 +647,7 @@ int main(int argc, char **av)
 			exit(1);
 		}
 		if (!done_help) {
+			save_env();
 			cmd = argv[0] = help_unknown_cmd(cmd);
 			done_help = 1;
 		} else
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 2f30203..e62c0ff 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -56,7 +56,7 @@ test_expect_success 'plain through aliased command, outside any git repo' '
 	check_config plain-aliased/.git false unset
 '
 
-test_expect_failure 'plain nested through aliased command' '
+test_expect_success 'plain nested through aliased command' '
 	(
 		git init plain-ancestor-aliased &&
 		cd plain-ancestor-aliased &&
@@ -68,7 +68,7 @@ test_expect_failure 'plain nested through aliased command' '
 	check_config plain-ancestor-aliased/plain-nested/.git false unset
 '
 
-test_expect_failure 'plain nested in bare through aliased command' '
+test_expect_success 'plain nested in bare through aliased command' '
 	(
 		git init --bare bare-ancestor-aliased.git &&
 		cd bare-ancestor-aliased.git &&
diff --git a/wrapper.c b/wrapper.c
index bc1bfb8..8a82097 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -493,3 +493,16 @@ struct passwd *xgetpwuid_self(void)
 		    errno ? strerror(errno) : _("no such user"));
 	return pw;
 }
+
+char **copy_environ(void)
+{
+	char **env;
+	int i = 0;
+	while (environ[i])
+		i++;
+	env = xmalloc((i+1)*sizeof(*env));
+	for (i = 0; environ[i]; i++)
+		env[i] = xstrdup(environ[i]);
+	env[i] = NULL;
+	return env;
+}
-- 8< --
