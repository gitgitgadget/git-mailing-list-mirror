From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/3] Move remote parsing into a library file out of builtin-push.
Date: Fri, 11 May 2007 22:39:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705112238260.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 04:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmhW5-0001b6-9z
	for gcvg-git@gmane.org; Sat, 12 May 2007 04:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761616AbXELCj1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 22:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546AbXELCj1
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 22:39:27 -0400
Received: from iabervon.org ([66.92.72.58]:3648 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761616AbXELCjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 22:39:25 -0400
Received: (qmail 6075 invoked by uid 1000); 12 May 2007 02:39:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2007 02:39:23 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47016>

The new parser is different from the one in builtin-push in two ways:
the default is to use the current branch's remote, if there is one,
before "origin"; and config is used in preference to remotes.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile       |    5 +-
 builtin-push.c |  190 ++++++-----------------------------------------------
 remote.c       |  203 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h       |   18 +++++
 4 files changed, 244 insertions(+), 172 deletions(-)
 create mode 100644 remote.c
 create mode 100644 remote.h

diff --git a/Makefile b/Makefile
index 7cf146b..134fbd2 100644
--- a/Makefile
+++ b/Makefile
@@ -296,7 +296,8 @@ LIB_H = \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h mailmap.h
+	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
+	mailmap.h remote.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -318,7 +319,7 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o mailmap.o
+	convert.o attr.o decorate.o progress.o mailmap.o remote.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-push.c b/builtin-push.c
index cb78401..0e602f3 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -5,17 +5,13 @@
 #include "refs.h"
 #include "run-command.h"
 #include "builtin.h"
-
-#define MAX_URI (16)
+#include "remote.h"
 
 static const char push_usage[] = "git-push [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
 
 static int all, tags, force, thin = 1, verbose;
 static const char *receivepack;
 
-#define BUF_SIZE (2084)
-static char buffer[BUF_SIZE];
-
 static const char **refspec;
 static int refspec_nr;
 
@@ -137,175 +133,29 @@ static void set_refspecs(const char **refs, int nr)
 	expand_refspecs();
 }
 
-static int get_remotes_uri(const char *repo, const char *uri[MAX_URI])
-{
-	int n = 0;
-	FILE *f = fopen(git_path("remotes/%s", repo), "r");
-	int has_explicit_refspec = refspec_nr || all || tags;
-
-	if (!f)
-		return -1;
-	while (fgets(buffer, BUF_SIZE, f)) {
-		int is_refspec;
-		char *s, *p;
-
-		if (!prefixcmp(buffer, "URL:")) {
-			is_refspec = 0;
-			s = buffer + 4;
-		} else if (!prefixcmp(buffer, "Push:")) {
-			is_refspec = 1;
-			s = buffer + 5;
-		} else
-			continue;
-
-		/* Remove whitespace at the head.. */
-		while (isspace(*s))
-			s++;
-		if (!*s)
-			continue;
-
-		/* ..and at the end */
-		p = s + strlen(s);
-		while (isspace(p[-1]))
-			*--p = 0;
-
-		if (!is_refspec) {
-			if (n < MAX_URI)
-				uri[n++] = xstrdup(s);
-			else
-				error("more than %d URL's specified, ignoring the rest", MAX_URI);
-		}
-		else if (is_refspec && !has_explicit_refspec) {
-			if (!wildcard_ref(s))
-				add_refspec(xstrdup(s));
-		}
-	}
-	fclose(f);
-	if (!n)
-		die("remote '%s' has no URL", repo);
-	return n;
-}
-
-static const char **config_uri;
-static const char *config_repo;
-static int config_repo_len;
-static int config_current_uri;
-static int config_get_refspecs;
-static int config_get_receivepack;
-
-static int get_remote_config(const char* key, const char* value)
-{
-	if (!prefixcmp(key, "remote.") &&
-	    !strncmp(key + 7, config_repo, config_repo_len)) {
-		if (!strcmp(key + 7 + config_repo_len, ".url")) {
-			if (config_current_uri < MAX_URI)
-				config_uri[config_current_uri++] = xstrdup(value);
-			else
-				error("more than %d URL's specified, ignoring the rest", MAX_URI);
-		}
-		else if (config_get_refspecs &&
-			 !strcmp(key + 7 + config_repo_len, ".push")) {
-			if (!wildcard_ref(value))
-				add_refspec(xstrdup(value));
-		}
-		else if (config_get_receivepack &&
-			 !strcmp(key + 7 + config_repo_len, ".receivepack")) {
-			if (!receivepack) {
-				char *rp = xmalloc(strlen(value) + 16);
-				sprintf(rp, "--receive-pack=%s", value);
-				receivepack = rp;
-			} else
-				error("more than one receivepack given, using the first");
-		}
-	}
-	return 0;
-}
-
-static int get_config_remotes_uri(const char *repo, const char *uri[MAX_URI])
-{
-	config_repo_len = strlen(repo);
-	config_repo = repo;
-	config_current_uri = 0;
-	config_uri = uri;
-	config_get_refspecs = !(refspec_nr || all || tags);
-	config_get_receivepack = (receivepack == NULL);
-
-	git_config(get_remote_config);
-	return config_current_uri;
-}
-
-static int get_branches_uri(const char *repo, const char *uri[MAX_URI])
-{
-	const char *slash = strchr(repo, '/');
-	int n = slash ? slash - repo : 1000;
-	FILE *f = fopen(git_path("branches/%.*s", n, repo), "r");
-	char *s, *p;
-	int len;
-
-	if (!f)
-		return 0;
-	s = fgets(buffer, BUF_SIZE, f);
-	fclose(f);
-	if (!s)
-		return 0;
-	while (isspace(*s))
-		s++;
-	if (!*s)
-		return 0;
-	p = s + strlen(s);
-	while (isspace(p[-1]))
-		*--p = 0;
-	len = p - s;
-	if (slash)
-		len += strlen(slash);
-	p = xmalloc(len + 1);
-	strcpy(p, s);
-	if (slash)
-		strcat(p, slash);
-	uri[0] = p;
-	return 1;
-}
-
-/*
- * Read remotes and branches file, fill the push target URI
- * list.  If there is no command line refspecs, read Push: lines
- * to set up the *refspec list as well.
- * return the number of push target URIs
- */
-static int read_config(const char *repo, const char *uri[MAX_URI])
-{
-	int n;
-
-	if (*repo != '/') {
-		n = get_remotes_uri(repo, uri);
-		if (n > 0)
-			return n;
-
-		n = get_config_remotes_uri(repo, uri);
-		if (n > 0)
-			return n;
-
-		n = get_branches_uri(repo, uri);
-		if (n > 0)
-			return n;
-	}
-
-	uri[0] = repo;
-	return 1;
-}
-
 static int do_push(const char *repo)
 {
-	const char *uri[MAX_URI];
-	int i, n, errs;
+	int i, errs;
 	int common_argc;
 	const char **argv;
 	int argc;
+	struct remote *remote = remote_get(repo);
 
-	n = read_config(repo, uri);
-	if (n <= 0)
+	if (!remote)
 		die("bad repository '%s'", repo);
 
+	if (remote->receivepack) {
+		char *rp = xmalloc(strlen(remote->receivepack) + 16);
+		sprintf(rp, "--receive-pack=%s", remote->receivepack);
+		receivepack = rp;
+	}
+	if (!refspec && !all && !tags && remote->push_refspec_nr) {
+		for (i = 0; i < remote->push_refspec_nr; i++) {
+			if (!wildcard_ref(remote->push_refspec[i]))
+				add_refspec(remote->push_refspec[i]);
+		}
+	}
+
 	argv = xmalloc((refspec_nr + 10) * sizeof(char *));
 	argv[0] = "dummy-send-pack";
 	argc = 1;
@@ -318,12 +168,12 @@ static int do_push(const char *repo)
 	common_argc = argc;
 
 	errs = 0;
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < remote->uri_nr; i++) {
 		int err;
 		int dest_argc = common_argc;
 		int dest_refspec_nr = refspec_nr;
 		const char **dest_refspec = refspec;
-		const char *dest = uri[i];
+		const char *dest = remote->uri[i];
 		const char *sender = "send-pack";
 		if (!prefixcmp(dest, "http://") ||
 		    !prefixcmp(dest, "https://"))
@@ -341,7 +191,7 @@ static int do_push(const char *repo)
 		if (!err)
 			continue;
 
-		error("failed to push to '%s'", uri[i]);
+		error("failed to push to '%s'", remote->uri[i]);
 		switch (err) {
 		case -ERR_RUN_COMMAND_FORK:
 			error("unable to fork for %s", sender);
@@ -362,7 +212,7 @@ static int do_push(const char *repo)
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	const char *repo = "origin";	/* default repository */
+	const char *repo = NULL;	/* default repository */
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/remote.c b/remote.c
new file mode 100644
index 0000000..1dd2e77
--- /dev/null
+++ b/remote.c
@@ -0,0 +1,203 @@
+#include "cache.h"
+#include "remote.h"
+#include "refs.h"
+
+static struct remote **remotes;
+static int allocated_remotes;
+
+#define BUF_SIZE (2084)
+static char buffer[BUF_SIZE];
+
+static void add_push_refspec(struct remote *remote, const char *ref)
+{
+	int nr = remote->push_refspec_nr + 1;
+	remote->push_refspec =
+		xrealloc(remote->push_refspec, nr * sizeof(char *));
+	remote->push_refspec[nr-1] = ref;
+	remote->push_refspec_nr = nr;
+}
+
+static void add_uri(struct remote *remote, const char *uri)
+{
+	int nr = remote->uri_nr + 1;
+	remote->uri =
+		xrealloc(remote->uri, nr * sizeof(char *));
+	remote->uri[nr-1] = uri;
+	remote->uri_nr = nr;
+}
+
+static struct remote *make_remote(const char *name, int len)
+{
+	int i, empty = -1;
+
+	for (i = 0; i < allocated_remotes; i++) {
+		if (!remotes[i]) {
+			if (empty < 0)
+				empty = i;
+		} else {
+			if (len ? (!strncmp(name, remotes[i]->name, len) &&
+				   !remotes[i]->name[len]) :
+			    !strcmp(name, remotes[i]->name))
+				return remotes[i];
+		}
+	}
+
+	if (empty < 0) {
+		empty = allocated_remotes;
+		allocated_remotes += allocated_remotes ? allocated_remotes : 1;
+		remotes = xrealloc(remotes,
+				   sizeof(*remotes) * allocated_remotes);
+		memset(remotes + empty, 0,
+		       (allocated_remotes - empty) * sizeof(*remotes));
+	}
+	remotes[empty] = xcalloc(1, sizeof(struct remote));
+	if (len)
+		remotes[empty]->name = xstrndup(name, len);
+	else
+		remotes[empty]->name = xstrdup(name);
+	return remotes[empty];
+}
+
+static void read_remotes_file(struct remote *remote)
+{
+	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
+
+	if (!f)
+		return;
+	while (fgets(buffer, BUF_SIZE, f)) {
+		int value_list;
+		char *s, *p;
+
+		if (!prefixcmp(buffer, "URL:")) {
+			value_list = 0;
+			s = buffer + 4;
+		} else if (!prefixcmp(buffer, "Push:")) {
+			value_list = 1;
+			s = buffer + 5;
+		} else
+			continue;
+
+		while (isspace(*s))
+			s++;
+		if (!*s)
+			continue;
+
+		p = s + strlen(s);
+		while (isspace(p[-1]))
+			*--p = 0;
+
+		switch (value_list) {
+		case 0:
+			add_uri(remote, xstrdup(s));
+			break;
+		case 1:
+			add_push_refspec(remote, xstrdup(s));
+			break;
+		}
+	}
+}
+
+static void read_branches_file(struct remote *remote)
+{
+	const char *slash = strchr(remote->name, '/');
+	int n = slash ? slash - remote->name : 1000;
+	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
+	char *s, *p;
+	int len;
+
+	if (!f)
+		return;
+	s = fgets(buffer, BUF_SIZE, f);
+	fclose(f);
+	if (!s)
+		return;
+	while (isspace(*s))
+		s++;
+	if (!*s)
+		return;
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
+	add_uri(remote, p);
+}
+
+static char *default_remote_name = NULL;
+static const char *current_branch = NULL;
+static int current_branch_len = 0;
+
+static int handle_config(const char *key, const char *value)
+{
+	const char *name;
+	const char *subkey;
+	struct remote *remote;
+	if (!prefixcmp(key, "branch.") && current_branch &&
+	    !strncmp(key + 7, current_branch, current_branch_len) &&
+	    !strcmp(key + 7 + current_branch_len, ".remote")) {
+		free(default_remote_name);
+		default_remote_name = xstrdup(value);
+	}
+	if (prefixcmp(key,  "remote."))
+		return 0;
+	name = key + 7;
+	subkey = strrchr(name, '.');
+	if (!subkey)
+		return error("Config with no key for remote %s", name);
+	remote = make_remote(name, subkey - name);
+	if (!strcmp(subkey, ".url")) {
+		add_uri(remote, xstrdup(value));
+	} else if (!strcmp(subkey, ".push")) {
+		add_push_refspec(remote, xstrdup(value));
+	} else if (!strcmp(subkey, ".receivepack")) {
+		if (!remote->receivepack)
+			remote->receivepack = xstrdup(value);
+		else
+			error("more than one receivepack given, using the first");
+	}
+	return 0;
+}
+
+static void read_config(void)
+{
+	unsigned char sha1[20];
+	const char *head_ref;
+	int flag;
+	if (default_remote_name) // did this already
+		return;
+	default_remote_name = xstrdup("origin");
+	current_branch = NULL;
+	head_ref = resolve_ref("HEAD", sha1, 0, &flag);
+	if (head_ref && (flag & REF_ISSYMREF) &&
+	    !prefixcmp(head_ref, "refs/heads/")) {
+		current_branch = head_ref + strlen("refs/heads/");
+		current_branch_len = strlen(current_branch);
+	}
+	git_config(handle_config);
+}
+
+struct remote *remote_get(const char *name)
+{
+	struct remote *ret;
+
+	read_config();
+	if (!name)
+		name = default_remote_name;
+	ret = make_remote(name, 0);
+	if (name[0] != '/') {
+		if (!ret->uri)
+			read_remotes_file(ret);
+		if (!ret->uri)
+			read_branches_file(ret);
+	}
+	if (!ret->uri)
+		add_uri(ret, name);
+	if (!ret->uri)
+		return NULL;
+	return ret;
+}
diff --git a/remote.h b/remote.h
new file mode 100644
index 0000000..73747a8
--- /dev/null
+++ b/remote.h
@@ -0,0 +1,18 @@
+#ifndef REMOTE_H
+#define REMOTE_H
+
+struct remote {
+	const char *name;
+
+	const char **uri;
+	int uri_nr;
+
+	const char **push_refspec;
+	int push_refspec_nr;
+
+	const char *receivepack;
+};
+
+struct remote *remote_get(const char *name);
+
+#endif
-- 
1.5.2.rc2.45.g3d9b43-dirty
