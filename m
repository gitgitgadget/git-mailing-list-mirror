From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 13:43:53 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802201337060.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 19:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRtvl-00027a-DL
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 19:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbYBTSn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 13:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbYBTSn5
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 13:43:57 -0500
Received: from iabervon.org ([66.92.72.58]:38834 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbYBTSnz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 13:43:55 -0500
Received: (qmail 32255 invoked by uid 1000); 20 Feb 2008 18:43:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Feb 2008 18:43:53 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74535>

This allows users with different preferences for access methods to the
same remote repositories to rewrite each other's URLs by pattern
matching across a large set of similiarly set up repositories to each
get the desired access.

For example, if you don't have a kernel.org account, you might want
settings like:

[url "git://git.kernel.org/pub/"]
      aka = master.kernel.org:/pub

Then, if you give git a URL like:

  master.kernel.org:/pub/scm/linux/kernel/git/linville/wireless-2.6.git

it will act like you gave it:

  git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git

and you can cut-and-paste pull requests in email without fixing them
by hand, for example.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
The previous version of [PATCH 1/2] doesn't need any changes.

This version has the replacement base in the key, as discussed, and makes 
the whole thing about urls instead of hosts (so everything is renamed).

I also added some tests, which are a little bit lame in the particular 
context of the test setup. Also, using git-config to set options with 
complicated keys is a bit awkward. Perhaps it should have support for a 
command line like:

git config --set remote "This is my remote" url http://example.com/repo

 Documentation/config.txt |   16 ++++++++
 Documentation/urls.txt   |   23 +++++++++++
 remote.c                 |   97 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t5516-fetch-push.sh    |   31 +++++++++++++++
 4 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f2f6a77..44f4c4b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -646,6 +646,11 @@ help.format::
 	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
 	the default. 'web' and 'html' are the same.
 
+host.<name>.rewritebase::
+	Additional base URLs which refer to this host. If a URL
+	matches this, any access to it will use the URL formed with
+	the corresponding base URL instead of the given URL.
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see linkgit:curl[1]).  This can be overridden
@@ -886,6 +891,17 @@ tar.umask::
 	archiving user's umask will be used instead.  See umask(2) and
 	linkgit:git-archive[1].
 
+url.<base>.aka::
+	Any URL that starts with this value will be rewritten to
+	start, instead, with <base>. In cases where some site serves a
+	large number of repositories, and serves them with multiple
+	access methods, and some users need to use different access
+	methods, this feature allows people to specify any of the
+	equivalent URLs and have git automatically rewrite the URL to
+	the best alternative for the particular user, even for a
+	never-before-seen repository on the site. The effect of
+	having multiple aka values match is undefined.
+
 user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the 'GIT_AUTHOR_EMAIL', 'GIT_COMMITTER_EMAIL', and
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 81ac17f..0115af7 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -44,3 +44,26 @@ endif::git-clone[]
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
+	[url "<actual url base>"]
+		aka = <other url base>
+------------
+
+If you have a section:
+
+------------
+	[host "git://git.host.xz/"]
+		aka = host.xz:/path/to/
+		aka = work:
+------------
+
+a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
+rewritten in any context that takes a URL to be
+"git://git.host.xz/repo.git".
diff --git a/remote.c b/remote.c
index 457d8a4..f8ee38e 100644
--- a/remote.c
+++ b/remote.c
@@ -2,6 +2,13 @@
 #include "remote.h"
 #include "refs.h"
 
+struct rewrite {
+	const char *base;
+	const char **aka;
+	int aka_nr;
+	int aka_alloc;
+};
+
 static struct remote **remotes;
 static int remotes_alloc;
 static int remotes_nr;
@@ -13,9 +20,33 @@ static int branches_nr;
 static struct branch *current_branch;
 static const char *default_remote_name;
 
+static struct rewrite **rewrite;
+static int rewrite_alloc;
+static int rewrite_nr;
+
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
 
+static const char *alias_url(const char *url)
+{
+	int i, j;
+	for (i = 0; i < rewrite_nr; i++) {
+		if (!rewrite[i])
+			continue;
+		for (j = 0; j < rewrite[i]->aka_nr; j++) {
+			if (!prefixcmp(url, rewrite[i]->aka[j])) {
+				char *ret = malloc(strlen(rewrite[i]->base) -
+						   strlen(rewrite[i]->aka[j]) +
+						   strlen(url) + 1);
+				strcpy(ret, rewrite[i]->base);
+				strcat(ret, url + strlen(rewrite[i]->aka[j]));
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
@@ -38,6 +69,11 @@ static void add_url(struct remote *remote, const char *url)
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
@@ -95,6 +131,35 @@ static struct branch *make_branch(const char *name, int len)
 	return ret;
 }
 
+static struct rewrite *make_rewrite(const char *base, int len)
+{
+	struct rewrite *ret;
+	int i;
+
+	for (i = 0; i < rewrite_nr; i++) {
+		if (len ? (!strncmp(base, rewrite[i]->base, len) &&
+			   !rewrite[i]->base[len]) :
+		    !strcmp(base, rewrite[i]->base))
+			return rewrite[i];
+	}
+
+	ALLOC_GROW(rewrite, rewrite_nr + 1, rewrite_alloc);
+	ret = xcalloc(1, sizeof(struct rewrite));
+	rewrite[rewrite_nr++] = ret;
+	if (len)
+		ret->base = xstrndup(base, len);
+	else
+		ret->base = xstrdup(base);
+
+	return ret;
+}
+
+static void add_aka(struct rewrite *rewrite, const char *aka)
+{
+	ALLOC_GROW(rewrite->aka, rewrite->aka_nr + 1, rewrite->aka_alloc);
+	rewrite->aka[rewrite->aka_nr++] = aka;
+}
+
 static void read_remotes_file(struct remote *remote)
 {
 	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
@@ -128,7 +193,7 @@ static void read_remotes_file(struct remote *remote)
 
 		switch (value_list) {
 		case 0:
-			add_url(remote, xstrdup(s));
+			add_url_alias(remote, xstrdup(s));
 			break;
 		case 1:
 			add_push_refspec(remote, xstrdup(s));
@@ -180,7 +245,7 @@ static void read_branches_file(struct remote *remote)
 	} else {
 		branch = "refs/heads/master";
 	}
-	add_url(remote, p);
+	add_url_alias(remote, p);
 	add_fetch_refspec(remote, branch);
 	remote->fetch_tags = 1; /* always auto-follow */
 }
@@ -210,6 +275,19 @@ static int handle_config(const char *key, const char *value)
 		}
 		return 0;
 	}
+	if (!prefixcmp(key, "url.")) {
+		struct rewrite *rewrite;
+		name = key + 5;
+		subkey = strrchr(name, '.');
+		if (!subkey)
+			return 0;
+		rewrite = make_rewrite(name, subkey - name);
+		if (!strcmp(subkey, ".aka")) {
+			if (!value)
+				return config_error_nonbool(key);
+			add_aka(rewrite, xstrdup(value));
+		}
+	}
 	if (prefixcmp(key,  "remote."))
 		return 0;
 	name = key + 7;
@@ -261,6 +339,18 @@ static int handle_config(const char *key, const char *value)
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
@@ -277,6 +367,7 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config);
+	alias_all_urls();
 }
 
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
@@ -342,7 +433,7 @@ struct remote *remote_get(const char *name)
 			read_branches_file(ret);
 	}
 	if (!ret->url)
-		add_url(ret, name);
+		add_url_alias(ret, name);
 	if (!ret->url)
 		return NULL;
 	ret->fetch = parse_ref_spec(ret->fetch_refspec_nr, ret->fetch_refspec);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9d2dc33..4ffe2a1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -100,6 +100,23 @@ test_expect_success 'fetch with wildcard' '
 	)
 '
 
+test_expect_success 'fetch with aka' '
+	mk_empty &&
+	(
+		TRASH=$(pwd) &&
+		cd testrepo &&
+		git config url./$TRASH/.aka trash/
+		git config remote.up.url trash/. &&
+		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
+		git fetch up &&
+
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+	)
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty &&
 
@@ -126,6 +143,20 @@ test_expect_success 'push with wildcard' '
 	)
 '
 
+test_expect_success 'push with aka' '
+	mk_empty &&
+	TRASH=$(pwd) &&
+	git config url./$TRASH/.aka trash/ &&
+	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
+	(
+		cd testrepo &&
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+	)
+'
+
 test_expect_success 'push with matching heads' '
 
 	mk_test heads/master &&
-- 
1.5.4.1.1350.g2b9ee
