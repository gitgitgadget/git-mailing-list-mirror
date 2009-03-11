From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Give error when no remote is configured
Date: Wed, 11 Mar 2009 01:47:20 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903110139450.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Giovanni Bajo <rasky@develer.com>
To: bernie@codewiz.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 06:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhHJe-0006w9-Fm
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 06:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbZCKFrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 01:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbZCKFrX
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 01:47:23 -0400
Received: from iabervon.org ([66.92.72.58]:43864 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbZCKFrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 01:47:23 -0400
Received: (qmail 1154 invoked by uid 1000); 11 Mar 2009 05:47:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Mar 2009 05:47:20 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112885>

When there's no explicitly-named remote, we use the remote specified
for the current branch, which in turn defaults to "origin". But it
this case should require the remote to actually be configured, and not
fall back to the path "origin".

Possibly, the config file's "remote = something" should require the
something to be a configured remote instead of a bare repository URL,
but we actually test with a bare repository URL.

In fetch, we were giving the sensible error message when coming up
with a URL failed, but this wasn't actually reachable, so move that
error up and use it when appropriate.

In push, we need a new error message, because the old one (formerly
unreachable without a lot of help) used the repo name, which was NULL.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I think the main way to reach this in actual usage would be to use git-svn 
to create a repository and then forget that you used it and therefore 
don't have an origin.

 builtin-fetch.c |    6 +++---
 builtin-push.c  |    7 +++++--
 remote.c        |   30 +++++++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 1e4a3d9..7fb35fc 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -636,6 +636,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	else
 		remote = remote_get(argv[0]);
 
+	if (!remote)
+		die("Where do you want to fetch from today?");
+
 	transport = transport_get(remote, remote->url[0]);
 	if (verbosity >= 2)
 		transport->verbose = 1;
@@ -648,9 +651,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth)
 		set_option(TRANS_OPT_DEPTH, depth);
 
-	if (!transport->url)
-		die("Where do you want to fetch from today?");
-
 	if (argc > 1) {
 		int j = 0;
 		refs = xcalloc(argc + 1, sizeof(const char *));
diff --git a/builtin-push.c b/builtin-push.c
index 122fdcf..ca36fb1 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -53,8 +53,11 @@ static int do_push(const char *repo, int flags)
 	int i, errs;
 	struct remote *remote = remote_get(repo);
 
-	if (!remote)
-		die("bad repository '%s'", repo);
+	if (!remote) {
+		if (repo)
+			die("bad repository '%s'", repo);
+		die("No destination configured to push to.");
+	}
 
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
diff --git a/remote.c b/remote.c
index d7079c6..199830e 100644
--- a/remote.c
+++ b/remote.c
@@ -38,6 +38,7 @@ static int branches_nr;
 
 static struct branch *current_branch;
 static const char *default_remote_name;
+static int explicit_default_remote_name;
 
 static struct rewrite **rewrite;
 static int rewrite_alloc;
@@ -104,6 +105,16 @@ static void add_url_alias(struct remote *remote, const char *url)
 	add_url(remote, alias_url(url));
 }
 
+static struct remote *get_remote_by_name(const char *name)
+{
+	int i;
+	for (i = 0; i < remotes_nr; i++) {
+		if (!strcmp(name, remotes[i]->name))
+			return remotes[i];
+	}
+	return NULL;
+}
+
 static struct remote *make_remote(const char *name, int len)
 {
 	struct remote *ret;
@@ -330,8 +341,10 @@ static int handle_config(const char *key, const char *value, void *cb)
 			if (!value)
 				return config_error_nonbool(key);
 			branch->remote_name = xstrdup(value);
-			if (branch == current_branch)
+			if (branch == current_branch) {
 				default_remote_name = branch->remote_name;
+				explicit_default_remote_name = 1;
+			}
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
 				return config_error_nonbool(key);
@@ -643,11 +656,22 @@ static int valid_remote_nick(const char *name)
 struct remote *remote_get(const char *name)
 {
 	struct remote *ret;
+	int name_given = 0;
 
 	read_config();
-	if (!name)
+	if (name)
+		name_given = 1;
+	else {
 		name = default_remote_name;
-	ret = make_remote(name, 0);
+		name_given = explicit_default_remote_name;
+	}
+	if (name_given)
+		ret = make_remote(name, 0);
+	else {
+		ret = get_remote_by_name(name);
+		if (!ret)
+			return NULL;
+	}
 	if (valid_remote_nick(name)) {
 		if (!ret->url)
 			read_remotes_file(ret);
-- 
1.6.2.104.g7aeb2.dirty
