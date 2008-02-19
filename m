From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Add support for host aliases in config files
Date: Mon, 18 Feb 2008 23:28:38 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802182317520.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 05:29:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRK6a-0000MU-Qf
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 05:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbYBSE2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 23:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbYBSE2l
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 23:28:41 -0500
Received: from iabervon.org ([66.92.72.58]:55628 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbYBSE2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 23:28:40 -0500
Received: (qmail 23374 invoked by uid 1000); 19 Feb 2008 04:28:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 04:28:38 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74373>

This allows users with different preferences for access methods to the
same remote repositories to rewrite each other's URLs by pattern
matching across a large set of similiarly set up repositories to each
get the desired access.

For example, if you don't have a kernel.org account, you might want
settings like:

[host "kernel.org"]
      base = git://git.kernel.org/pub/
      rewritebase = master.kernel.org:/pub

Then, if you give git a URL like:

  master.kernel.org:/pub/scm/linux/kernel/git/linville/wireless-2.6.git

it will act like you gave it:

  git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git

and you can cut-and-paste pull requests in email without fixing them
by hand, for example.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I believe this takes care of all the comments I've gotten on this patch.

I looked at how the documentation appears in (for example) git-fetch.1 
with the change to urls.txt, and it looks informative to me and not 
unbalanced. Of course, in order to be perfectly accurate, git clone needs 
to be converted to using the same code as everything else, because it 
won't yet actually support these alises, unfortunately for my dreams of 
being able to set up a default host and then have "git clone :module" work.

 Documentation/config.txt |   23 ++++++++++
 Documentation/urls.txt   |   25 +++++++++++
 remote.c                 |  102 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f2f6a77..7a9cba4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -646,6 +646,29 @@ help.format::
 	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
 	the default. 'web' and 'html' are the same.
 
+host.<name>.*::
+	These options provide a way to rewrite URLs when there is a
+	pattern of URLs with a common prefix which should be replaced
+	with a different prefix. For every 'rewritebase' prefix given,
+	any URL git receives that starts with that prefix will be
+	rewritten to have the 'base' prefix instead. In cases where
+	some site serves a large number of repositories, and serves
+	them with multiple access methods, and some users need to use
+	different access methods, this feature allows people to
+	specify any of the equivalent URLs and have git automatically
+	rewrite the URL to the best alternative for the particular
+	user, even for a never-before-seen repository on the site. The
+	effect of multiple matching rewritebase prefixes is undefined.
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
index 457d8a4..fc83e2d 100644
--- a/remote.c
+++ b/remote.c
@@ -2,6 +2,14 @@
 #include "remote.h"
 #include "refs.h"
 
+struct host {
+	const char *name;
+	const char *base;
+	const char **alias;
+	int alias_nr;
+	int alias_alloc;
+};
+
 static struct remote **remotes;
 static int remotes_alloc;
 static int remotes_nr;
@@ -13,9 +21,33 @@ static int branches_nr;
 static struct branch *current_branch;
 static const char *default_remote_name;
 
+static struct host **hosts;
+static int hosts_alloc;
+static int hosts_nr;
+
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
 
+static const char *alias_url(const char *url)
+{
+	int i, j;
+	for (i = 0; i < hosts_nr; i++) {
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
 	ALLOC_GROW(remote->push_refspec,
@@ -38,6 +70,11 @@ static void add_url(struct remote *remote, const char *url)
 	remote->url[remote->url_nr++] = url;
 }
 
+static void add_url_alias(struct remote *remote, const char *url)
+{
+	add_url(remote, alias_url(url));
+}
+
 static struct remote *make_remote(const char *name, int len)
 {
 	struct remote *ret;
@@ -95,6 +132,35 @@ static struct branch *make_branch(const char *name, int len)
 	return ret;
 }
 
+static struct host *make_host(const char *name, int len)
+{
+	struct host *ret;
+	int i;
+
+	for (i = 0; i < hosts_nr; i++) {
+		if (len ? (!strncmp(name, hosts[i]->name, len) &&
+			   !hosts[i]->name[len]) :
+		    !strcmp(name, hosts[i]->name))
+			return hosts[i];
+	}
+
+	ALLOC_GROW(hosts, hosts_nr + 1, hosts_alloc);
+	ret = xcalloc(1, sizeof(struct host));
+	hosts[hosts_nr++] = ret;
+	if (len)
+		ret->name = xstrndup(name, len);
+	else
+		ret->name = xstrdup(name);
+
+	return ret;
+}
+
+static void add_alias(struct host *host, const char *name)
+{
+	ALLOC_GROW(host->alias, host->alias_nr + 1, host->alias_alloc);
+	host->alias[host->alias_nr++] = name;
+}
+
 static void read_remotes_file(struct remote *remote)
 {
 	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
@@ -128,7 +194,7 @@ static void read_remotes_file(struct remote *remote)
 
 		switch (value_list) {
 		case 0:
-			add_url(remote, xstrdup(s));
+			add_url_alias(remote, xstrdup(s));
 			break;
 		case 1:
 			add_push_refspec(remote, xstrdup(s));
@@ -180,7 +246,7 @@ static void read_branches_file(struct remote *remote)
 	} else {
 		branch = "refs/heads/master";
 	}
-	add_url(remote, p);
+	add_url_alias(remote, p);
 	add_fetch_refspec(remote, branch);
 	remote->fetch_tags = 1; /* always auto-follow */
 }
@@ -210,6 +276,23 @@ static int handle_config(const char *key, const char *value)
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
+		if (!strcmp(subkey, ".base")) {
+			if (!value)
+				return config_error_nonbool(key);
+			host->base = xstrdup(value);
+		} else if (!strcmp(subkey, ".rewritebase")) {
+			if (!value)
+				return config_error_nonbool(key);
+			add_alias(host, xstrdup(value));
+		}
+	}
 	if (prefixcmp(key,  "remote."))
 		return 0;
 	name = key + 7;
@@ -261,6 +344,18 @@ static int handle_config(const char *key, const char *value)
 	return 0;
 }
 
+static void alias_all_urls(void)
+{
+	int i, j;
+	for (i = 0; i < remotes_nr; i++) {
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
@@ -277,6 +372,7 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config);
+	alias_all_urls();
 }
 
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
@@ -342,7 +438,7 @@ struct remote *remote_get(const char *name)
 			read_branches_file(ret);
 	}
 	if (!ret->url)
-		add_url(ret, name);
+		add_url_alias(ret, name);
 	if (!ret->url)
 		return NULL;
 	ret->fetch = parse_ref_spec(ret->fetch_refspec_nr, ret->fetch_refspec);
-- 
1.5.4.1.191.gfbf10
