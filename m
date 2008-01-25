From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Add support for host aliases in config files
Date: Fri, 25 Jan 2008 13:39:03 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801251336080.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 19:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JITSr-0004Lf-Qb
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 19:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbYAYSjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 13:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbYAYSjO
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 13:39:14 -0500
Received: from iabervon.org ([66.92.72.58]:37078 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754382AbYAYSjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 13:39:13 -0500
Received: (qmail 25115 invoked by uid 1000); 25 Jan 2008 18:39:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2008 18:39:03 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71725>

This allows users with different preferences for access methods to the
same remote repositories to rewrite each other's URLs to get the
desired access.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/config.txt |   15 ++++++
 remote.c                 |  112 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 877eda9..dae79ce 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -596,6 +596,21 @@ help.format::
 	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
 	the default. 'web' and 'html' are the same.
 
+host.<name>.base::
+	The base URL which should be used for this particular
+	host. This can be used by a user who has a better access
+	method to a repository than other users to make use of the
+	preferable path despite getting URLs from other users using
+	more commonly-available methods. Alternatively, a user who
+	only has less privileged access to a repository than the usual
+	audience can use this mechanism to replace disallowed methods
+	with public ones.
+
+host.<name>.alias::
+	Additional base URLs which refer to this host. If a URL
+	matches this, any access to it will use the URL formed with
+	the corresponding base URL instead of the given URL.
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see linkgit:curl[1]).  This can be overridden
diff --git a/remote.c b/remote.c
index 0e00680..76ed576 100644
--- a/remote.c
+++ b/remote.c
@@ -2,6 +2,15 @@
 #include "remote.h"
 #include "refs.h"
 
+struct host {
+	const char *name;
+
+	const char *base;
+
+	const char **alias;
+	int alias_nr;
+};
+
 static struct remote **remotes;
 static int allocated_remotes;
 
@@ -11,9 +20,32 @@ static int allocated_branches;
 static struct branch *current_branch;
 static const char *default_remote_name;
 
+static struct host **hosts;
+static int allocated_hosts;
+
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
 
+static const char *alias_url(const char *url)
+{
+	int i, j;
+	for (i = 0; i < allocated_hosts; i++) {
+		if (!hosts[i])
+			continue;
+		for (j = 0; j < hosts[i]->alias_nr; j++) {
+			if (!prefixcmp(url, hosts[i]->alias[j])) {
+				char *ret = malloc(strlen(hosts[i]->base) -
+						   strlen(hosts[i]->alias[j]) +
+						   strlen(url) + 1);
+				strcpy(ret, hosts[i]->base);
+				strcat(ret, url + strlen(hosts[i]->alias[j]));
+				return ret;
+			}
+		}
+	}
+	return url;
+}
+
 static void add_push_refspec(struct remote *remote, const char *ref)
 {
 	int nr = remote->push_refspec_nr + 1;
@@ -41,6 +73,11 @@ static void add_url(struct remote *remote, const char *url)
 	remote->url_nr = nr;
 }
 
+static void add_url_alias(struct remote *remote, const char *url)
+{
+	add_url(remote, alias_url(url));
+}
+
 static struct remote *make_remote(const char *name, int len)
 {
 	int i, empty = -1;
@@ -121,6 +158,48 @@ static struct branch *make_branch(const char *name, int len)
 	return branches[empty];
 }
 
+static struct host *make_host(const char *name, int len)
+{
+	int i, empty = -1;
+
+	for (i = 0; i < allocated_hosts; i++) {
+		if (!hosts[i]) {
+			if (empty < 0)
+				empty = i;
+		} else {
+			if (len ? (!strncmp(name, hosts[i]->name, len) &&
+				   !hosts[i]->name[len]) :
+			    !strcmp(name, hosts[i]->name))
+				return hosts[i];
+		}
+	}
+
+	if (empty < 0) {
+		empty = allocated_hosts;
+		allocated_hosts += allocated_hosts ? allocated_hosts : 1;
+		hosts = xrealloc(hosts,
+				 sizeof(*hosts) * allocated_hosts);
+		memset(hosts + empty, 0,
+		       (allocated_hosts - empty) * sizeof(*hosts));
+	}
+	hosts[empty] = xcalloc(1, sizeof(struct host));
+	if (len)
+		hosts[empty]->name = xstrndup(name, len);
+	else
+		hosts[empty]->name = xstrdup(name);
+
+	return hosts[empty];
+}
+
+static void add_alias(struct host *host, const char *name)
+{
+	int nr = host->alias_nr + 1;
+	host->alias =
+		xrealloc(host->alias, nr * sizeof(char *));
+	host->alias[nr-1] = name;
+	host->alias_nr = nr;
+}
+
 static void read_remotes_file(struct remote *remote)
 {
 	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
@@ -154,7 +233,7 @@ static void read_remotes_file(struct remote *remote)
 
 		switch (value_list) {
 		case 0:
-			add_url(remote, xstrdup(s));
+			add_url_alias(remote, xstrdup(s));
 			break;
 		case 1:
 			add_push_refspec(remote, xstrdup(s));
@@ -206,7 +285,7 @@ static void read_branches_file(struct remote *remote)
 	} else {
 		branch = "refs/heads/master";
 	}
-	add_url(remote, p);
+	add_url_alias(remote, p);
 	add_fetch_refspec(remote, branch);
 	remote->fetch_tags = 1; /* always auto-follow */
 }
@@ -233,6 +312,20 @@ static int handle_config(const char *key, const char *value)
 			add_merge(branch, xstrdup(value));
 		return 0;
 	}
+	if (!prefixcmp(key, "host.")) {
+		struct host *host;
+		name = key + 5;
+		subkey = strrchr(name, '.');
+		if (!subkey)
+			return 0;
+		host = make_host(name, subkey - name);
+		if (!value)
+			return 0;
+		if (!strcmp(subkey, ".base"))
+			host->base = xstrdup(value);
+	        else if (!strcmp(subkey, ".alias"))
+			add_alias(host, xstrdup(value));
+	}
 	if (prefixcmp(key,  "remote."))
 		return 0;
 	name = key + 7;
@@ -284,6 +377,18 @@ static int handle_config(const char *key, const char *value)
 	return 0;
 }
 
+static void alias_all_urls(void)
+{
+	int i, j;
+	for (i = 0; i < allocated_remotes; i++) {
+		if (!remotes[i])
+			continue;
+		for (j = 0; j < remotes[i]->url_nr; j++) {
+			remotes[i]->url[j] = alias_url(remotes[i]->url[j]);
+		}
+	}
+}
+
 static void read_config(void)
 {
 	unsigned char sha1[20];
@@ -300,6 +405,7 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config);
+	alias_all_urls();
 }
 
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
@@ -355,7 +461,7 @@ struct remote *remote_get(const char *name)
 			read_branches_file(ret);
 	}
 	if (!ret->url)
-		add_url(ret, name);
+		add_url_alias(ret, name);
 	if (!ret->url)
 		return NULL;
 	ret->fetch = parse_ref_spec(ret->fetch_refspec_nr, ret->fetch_refspec);
-- 
1.5.4.rc3.4.g16335
