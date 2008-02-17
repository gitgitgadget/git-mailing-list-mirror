From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Add support for host aliases in config files
Date: Sun, 17 Feb 2008 13:38:51 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802171337000.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQoQN-00061y-V9
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbYBQSiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbYBQSiz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:38:55 -0500
Received: from iabervon.org ([66.92.72.58]:45698 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbYBQSiy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:38:54 -0500
Received: (qmail 7050 invoked by uid 1000); 17 Feb 2008 18:38:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 18:38:52 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74161>

This allows users with different preferences for access methods to the
same remote repositories to rewrite each other's URLs by pattern
matching across a large set of similiarly set up repositories to each
get the desired access.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I still need to work more on the documentation (and I think I'd failed to 
come up with an organization for it that I liked), but I'd like to get the 
code portion out there are reviewed, at least, since I think last time, 
the patch only got as far as a discussion of how I should explain what it 
does.

 Documentation/config.txt |   22 +++++++++
 Documentation/urls.txt   |   25 ++++++++++
 remote.c                 |  112 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 156 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f2f6a77..6ccd59f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -646,6 +646,28 @@ help.format::
 	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
 	the default. 'web' and 'html' are the same.
 
+host.<name>.*::
+	These options provide a way to rewrite URLs when there is a
+	pattern of URLs with a common prefix which should be replaced
+	with a different prefix. For every 'alias' prefix given, any
+	URL git receives that starts with that prefix will be
+	rewritten to have the 'base' prefix instead. In cases where
+	some site serves a large number of repositories, and serves
+	them with multiple access methods, and some users need to use
+	different access methods, this feature allows people to
+	specify any of the equivalent URLs and have git automatically
+	rewrite the URL to the best alternative for the particular
+	user, even for a never-before-seen repository on the site.
+
+host.<name>.base::
+	The base URL which should be used for this particular
+	host.
+
+host.<name>.rewritebase::
+	Additional base URLs which refer to this host. If a URL
+	matches this, any access to it will use the URL formed with
+	the corresponding base URL instead of the given URL.
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see linkgit:curl[1]).  This can be overridden
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 81ac17f..11c05db 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -44,3 +44,28 @@ endif::git-clone[]
 ifdef::git-clone[]
 They are equivalent, except the former implies --local option.
 endif::git-clone[]
+
+
+If there are a large number of similarly-named remote repositories and
+you want to use a different format for them (such that the URLs you
+use will be rewritten into URLs that work), you can create a
+configuration section of the form:
+
+------------
+	[host "<host>"]
+		base = <actual url base>
+		rewritebase = <other url base>
+------------
+
+If you have a section:
+
+------------
+	[host "xz"]
+		base = git://git.host.xz/
+		rewritebase = host.xz:/path/to/
+		rewritebase = work:
+------------
+
+a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
+rewritten in any context that takes a URL to be
+"git://git.host.xz/repo.git".
diff --git a/remote.c b/remote.c
index 6b56473..59338a3 100644
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
@@ -236,6 +315,20 @@ static int handle_config(const char *key, const char *value)
 		}
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
+		else if (!strcmp(subkey, ".rewritebase"))
+			add_alias(host, xstrdup(value));
+	}
 	if (prefixcmp(key,  "remote."))
 		return 0;
 	name = key + 7;
@@ -287,6 +380,18 @@ static int handle_config(const char *key, const char *value)
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
@@ -303,6 +408,7 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config);
+	alias_all_urls();
 }
 
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
@@ -368,7 +474,7 @@ struct remote *remote_get(const char *name)
 			read_branches_file(ret);
 	}
 	if (!ret->url)
-		add_url(ret, name);
+		add_url_alias(ret, name);
 	if (!ret->url)
 		return NULL;
 	ret->fetch = parse_ref_spec(ret->fetch_refspec_nr, ret->fetch_refspec);
-- 
1.5.4.1.1350.g2b9ee
