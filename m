From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/5] Use remote functions in git-push
Date: Sat, 28 Apr 2007 13:05:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704281304190.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 19:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhqNP-0001U8-78
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 19:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416AbXD1RFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 13:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756427AbXD1RFh
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 13:05:37 -0400
Received: from iabervon.org ([66.92.72.58]:4835 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161866AbXD1RFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 13:05:15 -0400
Received: (qmail 7649 invoked by uid 1000); 28 Apr 2007 17:05:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2007 17:05:14 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45785>

Replace the local parsing implementation with the library
implementation. Note that this incidentally makes the config file
override remotes files.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-push.c |  188 ++++++--------------------------------------------------
 1 files changed, 20 insertions(+), 168 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index cb78401..2e944cd 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "run-command.h"
 #include "builtin.h"
+#include "remote.h"
 
 #define MAX_URI (16)
 
@@ -13,9 +14,6 @@ static const char push_usage[] = "git-push [--all] [--tags] [--receive-pack=<git
 static int all, tags, force, thin = 1, verbose;
 static const char *receivepack;
 
-#define BUF_SIZE (2084)
-static char buffer[BUF_SIZE];
-
 static const char **refspec;
 static int refspec_nr;
 
@@ -137,175 +135,29 @@ static void set_refspecs(const char **refs, int nr)
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
+	struct remote *remote;
+
+	remote = remote_get(repo);
 
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
+		refspec_nr = remote->push_refspec_nr;
+		refspec = remote->push_refspec;
+	}
+
 	argv = xmalloc((refspec_nr + 10) * sizeof(char *));
 	argv[0] = "dummy-send-pack";
 	argc = 1;
@@ -318,12 +170,12 @@ static int do_push(const char *repo)
 	common_argc = argc;
 
 	errs = 0;
-	for (i = 0; i < n; i++) {
+	for (i = 0; remote->uri[i]; i++) {
 		int err;
 		int dest_argc = common_argc;
 		int dest_refspec_nr = refspec_nr;
 		const char **dest_refspec = refspec;
-		const char *dest = uri[i];
+		const char *dest = remote->uri[i];
 		const char *sender = "send-pack";
 		if (!prefixcmp(dest, "http://") ||
 		    !prefixcmp(dest, "https://"))
@@ -341,7 +193,7 @@ static int do_push(const char *repo)
 		if (!err)
 			continue;
 
-		error("failed to push to '%s'", uri[i]);
+		error("failed to push to '%s'", remote->uri[i]);
 		switch (err) {
 		case -ERR_RUN_COMMAND_FORK:
 			error("unable to fork for %s", sender);
@@ -362,7 +214,7 @@ static int do_push(const char *repo)
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	const char *repo = "origin";	/* default repository */
+	const char *repo = NULL;	/* default repository */
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-- 
1.5.1.2.255.g6ead4-dirty
