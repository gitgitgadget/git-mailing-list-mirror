From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] git builtin "push"
Date: Sat, 29 Apr 2006 21:22:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 30 06:23:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fa3SV-0004rC-4g
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 06:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWD3EWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 00:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWD3EWz
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 00:22:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750911AbWD3EWz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 00:22:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3U4MotH011553
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 29 Apr 2006 21:22:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3U4MnpB027047;
	Sat, 29 Apr 2006 21:22:49 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-9 required=5 tests=PATCH_SUBJECT_OSDL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19326>


This adds a builtin "push" command, which is largely just a C'ification of 
the "git-push.sh" script.

Now, the reason I did it as a built-in is partly because it's yet another 
step on relying less on shell, but it's actually mostly because I've 
wanted to be able to push to _multiple_ repositories, and the most obvious 
and simplest interface for that would seem be to just have a "remotes" 
file that has multiple URL entries.

(For "pull", having multiple entries should either just select the first 
one, or you could fall back on the others on failure - your choice).

And quite frankly, it just became too damn messy to do that in shell. 
Besides, we actually have a fair amount of infrastructure in C, so it just 
wasn't that hard to do.

Of course, this is almost totally untested. It probably doesn't work for 
anything but the one trial I threw at it. "Simple" doesn't necessarily 
mean "obviously correct".

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Comments?  I wrote it so that it _should_ be fairly easy to re-use at 
least the branches/remotes helper functions for a built-in "git fetch" as 
well. But I didn't have the multi-URI issue with anything but pushing.

Junio - I currently have a "push-all" script in each of the repos I 
maintain. That has worked, but I'd just rather do something like

	git push all

instead, and have it pick up the list of URI's from .git/remotes/all.

How do you do multi-targeted pushes?

diff --git a/Makefile b/Makefile
index 8ce27a6..9919992 100644
--- a/Makefile
+++ b/Makefile
@@ -214,7 +214,7 @@ LIB_OBJS = \
 	$(DIFF_OBJS)
 
 BUILTIN_OBJS = \
-	builtin-log.o builtin-help.o
+	builtin-log.o builtin-help.o builtin-push.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-push.c b/builtin-push.c
new file mode 100644
index 0000000..a0c1caa
--- /dev/null
+++ b/builtin-push.c
@@ -0,0 +1,255 @@
+/*
+ * "git push"
+ */
+#include "cache.h"
+#include "refs.h"
+#include "run-command.h"
+#include "builtin.h"
+
+#define MAX_URI (16)
+
+static const char push_usage[] = "git push [--all] [--tags] [--force] <repository> [<refspec>...]";
+
+static int all = 0, tags = 0, force = 0, thin = 1;
+static const char *execute = NULL;
+
+#define BUF_SIZE (2084)
+static char buffer[BUF_SIZE];
+
+static const char **refspec = NULL;
+static int refspec_nr = 0;
+
+static void add_refspec(const char *ref)
+{
+	int nr = refspec_nr + 1;
+	refspec = xrealloc(refspec, nr * sizeof(char *));
+	refspec[nr-1] = ref;
+	refspec_nr = nr;
+}
+
+static int expand_one_ref(const char *ref, const unsigned char *sha1)
+{
+	/* Ignore the "refs/" at the beginning of the refname */
+	ref += 5;
+
+	if (strncmp(ref, "tags/", 5))
+		return 0;
+
+	add_refspec(strdup(ref));
+	return 0;
+}
+
+static void expand_refspecs(void)
+{
+	if (all) {
+		if (refspec_nr)
+			die("cannot mix '--all' and a refspec");
+
+		/*
+		 * No need to expand "--all" - we'll just use
+		 * the "--all" flag to send-pack
+		 */
+		return;
+	}
+	if (!tags)
+		return;
+	for_each_ref(expand_one_ref);
+}
+
+static void set_refspecs(const char **refs, int nr)
+{
+	if (nr) {
+		size_t bytes = nr * sizeof(char *);
+
+		refspec = xrealloc(refspec, bytes);
+		memcpy(refspec, refs, bytes);
+		refspec_nr = nr;
+	}
+	expand_refspecs();
+}
+
+static int get_remotes_uri(const char *repo, const char *uri[MAX_URI])
+{
+	int n = 0;
+	FILE *f = fopen(git_path("remotes/%s", repo), "r");
+
+	if (!f)
+		return -1;
+	while (fgets(buffer, BUF_SIZE, f)) {
+		char *s, *p;
+
+		if (strncmp("URL: ", buffer, 5))
+			continue;
+		s = buffer + 5;
+
+		/* Remove whitespace at the head.. */
+		while (isspace(*s))
+			s++;
+		if (!*s)
+			continue;
+
+		/* ..and at the end */
+		p = s + strlen(s);
+		while (isspace(p[-1]))
+			*--p = 0;
+
+		uri[n++] = strdup(s);
+		if (n == MAX_URI)
+			break;
+	}
+	fclose(f);
+	if (!n)
+		die("remote '%s' has no URL", repo);
+	return n;
+}
+
+static int get_branches_uri(const char *repo, const char *uri[MAX_URI])
+{
+	const char *slash = strchr(repo, '/');
+	int n = slash ? slash - repo : 1000;
+	FILE *f = fopen(git_path("branches/%.*s", n, repo), "r");
+	char *s, *p;
+	int len;
+
+	if (!f)
+		return 0;
+	s = fgets(buffer, BUF_SIZE, f);
+	fclose(f);
+	if (!s)
+		return 0;
+	while (isspace(*s))
+		s++;
+	if (!*s)
+		return 0;
+	p = s + strlen(s);
+	while (isspace(p[-1]))
+		*--p = 0;
+	len = p - s;
+	if (slash)
+		len += strlen(slash);
+	p = xmalloc(len + 1);
+	strcpy(p, s);
+	if (slash)
+		strcat(p, slash);
+	uri[0] = p;
+	return 1;
+}
+
+static int get_uri(const char *repo, const char *uri[MAX_URI])
+{
+	int n;
+
+	if (*repo != '/') {
+		n = get_remotes_uri(repo, uri);
+		if (n > 0)
+			return n;
+
+		n = get_branches_uri(repo, uri);
+		if (n > 0)
+			return n;
+	}
+
+	uri[0] = repo;
+	return 1;
+}
+
+static int do_push(const char *repo)
+{
+	const char *uri[MAX_URI];
+	int i, n = get_uri(repo, uri);
+	int remote;
+	const char **argv;
+	int argc;
+
+	n = get_uri(repo, uri);
+	if (n <= 0)
+		die("bad repository '%s'", repo);
+
+	argv = xmalloc((refspec_nr + 10) * sizeof(char *));
+	argv[0] = "dummy-send-pack";
+	argc = 1;
+	if (all)
+		argv[argc++] = "--all";
+	if (force)
+		argv[argc++] = "--force";
+	if (execute)
+		argv[argc++] = execute;
+	if (thin)
+		argv[argc++] = "--thin";
+	remote = argc;
+	argv[argc++] = "dummy-remote";
+	while (refspec_nr--)
+		argv[argc++] = *refspec++;
+	argv[argc] = NULL;
+
+	for (i = 0; i < n; i++) {
+		int error;
+		const char *dest = uri[i];
+		const char *sender = "git-send-pack";
+		if (!strncmp(dest, "http://", 7) ||
+		    !strncmp(dest, "https://", 8))
+			sender = "git-http-push";
+		argv[0] = sender;
+		argv[remote] = dest;
+		error = run_command_v(argc, argv);
+		if (!error)
+			continue;
+		switch (error) {
+		case -ERR_RUN_COMMAND_FORK:
+			die("unable to fork for %s", sender);
+		case -ERR_RUN_COMMAND_EXEC:
+			die("unable to exec %s", sender);
+		case -ERR_RUN_COMMAND_WAITPID:
+		case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
+		case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
+		case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
+			die("%s died with strange error", sender);
+		default:
+			return -error;
+		}
+	}
+	return 0;
+}
+
+int cmd_push(int argc, const char **argv, char **envp)
+{
+	int i;
+	const char *repo = "origin";	// default repository
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (arg[0] != '-') {
+			repo = arg;
+			i++;
+			break;
+		}
+		if (!strcmp(arg, "--all")) {
+			all = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--tags")) {
+			tags = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--force")) {
+			force = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--thin")) {
+			thin = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--no-thin")) {
+			thin = 0;
+			continue;
+		}
+		if (!strncmp(arg, "--exec=", 7)) {
+			execute = arg;
+			continue;
+		}
+		usage(push_usage);
+	}
+	set_refspecs(argv + i, argc - i);
+	return do_push(repo);
+}
diff --git a/builtin.h b/builtin.h
index 47408a0..94fa9b5 100644
--- a/builtin.h
+++ b/builtin.h
@@ -20,4 +20,6 @@ extern int cmd_whatchanged(int argc, con
 extern int cmd_show(int argc, const char **argv, char **envp);
 extern int cmd_log(int argc, const char **argv, char **envp);
 
+extern int cmd_push(int argc, const char **argv, char **envp);
+
 #endif
diff --git a/git.c b/git.c
index 01b7e28..fd479e9 100644
--- a/git.c
+++ b/git.c
@@ -46,6 +46,7 @@ static void handle_internal_command(int 
 		{ "log", cmd_log },
 		{ "whatchanged", cmd_whatchanged },
 		{ "show", cmd_show },
+		{ "push", cmd_push },
 	};
 	int i;
 
