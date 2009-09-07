From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 2/2] Add url.<base>.pushInsteadOf: URL rewriting for push
 only
Date: Mon, 7 Sep 2009 00:00:20 -0700
Message-ID: <0be9995dcd7d48c918fa75f4d9e557a6144a047c.1252306396.git.josh@joshtriplett.org>
References: <cover.1252306396.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 07 09:07:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkYK9-0000kF-9T
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 09:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbZIGHHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 03:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbZIGHHJ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 03:07:09 -0400
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:47534 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZIGHHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 03:07:05 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id AB3973B47C
	for <git@vger.kernel.org>; Mon,  7 Sep 2009 09:01:03 +0200 (CEST)
Received: from feather (pool-173-50-250-234.ptldor.fios.verizon.net [173.50.250.234])
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8A0A7225187;
	Mon,  7 Sep 2009 08:59:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cover.1252306396.git.josh@joshtriplett.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127891>

This configuration option allows systematically rewriting fetch-only
URLs to push-capable URLs when used with push.  For instance:

[url "ssh://example.org/"]
    pushInsteadOf = "git://example.org/"

This will allow clones of "git://example.org/path/to/repo" to
subsequently push to "ssh://example.org/path/to/repo", without manually
configuring pushurl for that remote.

Includes documentation for the new option, bash completion updates, and
test cases (both that pushInsteadOf applies to push and that it does
*not* apply to fetch).

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 Documentation/config.txt               |   12 +++++++++++
 Documentation/urls.txt                 |   18 +++++++++++++++++
 contrib/completion/git-completion.bash |    2 +-
 remote.c                               |   33 +++++++++++++++++++++++--------
 t/t5516-fetch-push.sh                  |   31 ++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5256c7f..726aa89 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1500,6 +1500,18 @@ url.<base>.insteadOf::
 	never-before-seen repository on the site.  When more than one
 	insteadOf strings match a given URL, the longest match is used.
 
+url.<base>.pushInsteadOf::
+	Any URL that starts with this value will not be pushed to;
+	instead, it will be rewritten to start with <base>, and the
+	resulting URL will be pushed to. In cases where some site serves
+	a large number of repositories, and serves them with multiple
+	access methods, some of which do not allow push, this feature
+	allows people to specify a pull-only URL and have git
+	automatically use an appropriate URL to push, even for a
+	never-before-seen repository on the site.  When more than one
+	pushInsteadOf strings match a given URL, the longest match is
+	used.
+
 user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the 'GIT_AUTHOR_EMAIL', 'GIT_COMMITTER_EMAIL', and
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 5355ebc..d813ceb 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -67,3 +67,21 @@ For example, with this:
 a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
 rewritten in any context that takes a URL to be "git://git.host.xz/repo.git".
 
+If you want to rewrite URLs for push only, you can create a
+configuration section of the form:
+
+------------
+	[url "<actual url base>"]
+		pushInsteadOf = <other url base>
+------------
+
+For example, with this:
+
+------------
+	[url "ssh://example.org/"]
+		pushInsteadOf = git://example.org/
+------------
+
+a URL like "git://example.org/path/to/repo.git" will be rewritten to
+"ssh://example.org/path/to/repo.git" for pushes, but pulls will still
+use the original URL.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bf688e1..9859204 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1532,7 +1532,7 @@ _git_config ()
 	url.*.*)
 		local pfx="${cur%.*}."
 		cur="${cur##*.}"
-		__gitcomp "insteadof" "$pfx" "$cur"
+		__gitcomp "insteadOf pushInsteadOf" "$pfx" "$cur"
 		return
 		;;
 	esac
diff --git a/remote.c b/remote.c
index ff8e71f..6789786 100644
--- a/remote.c
+++ b/remote.c
@@ -47,6 +47,7 @@ static const char *default_remote_name;
 static int explicit_default_remote_name;
 
 static struct rewrites rewrites;
+static struct rewrites rewrites_push;
 
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
@@ -104,17 +105,25 @@ static void add_url(struct remote *remote, const char *url)
 	remote->url[remote->url_nr++] = url;
 }
 
-static void add_url_alias(struct remote *remote, const char *url)
-{
-	add_url(remote, alias_url(url, &rewrites));
-}
-
 static void add_pushurl(struct remote *remote, const char *pushurl)
 {
 	ALLOC_GROW(remote->pushurl, remote->pushurl_nr + 1, remote->pushurl_alloc);
 	remote->pushurl[remote->pushurl_nr++] = pushurl;
 }
 
+static void add_pushurl_alias(struct remote *remote, const char *url)
+{
+	const char *pushurl = alias_url(url, &rewrites_push);
+	if (pushurl != url)
+		add_pushurl(remote, pushurl);
+}
+
+static void add_url_alias(struct remote *remote, const char *url)
+{
+	add_url(remote, alias_url(url, &rewrites));
+	add_pushurl_alias(remote, url);
+}
+
 static struct remote *make_remote(const char *name, int len)
 {
 	struct remote *ret;
@@ -358,8 +367,13 @@ static int handle_config(const char *key, const char *value, void *cb)
 		subkey = strrchr(name, '.');
 		if (!subkey)
 			return 0;
-		rewrite = make_rewrite(&rewrites, name, subkey - name);
 		if (!strcmp(subkey, ".insteadof")) {
+			rewrite = make_rewrite(&rewrites, name, subkey - name);
+			if (!value)
+				return config_error_nonbool(key);
+			add_instead_of(rewrite, xstrdup(value));
+		} else if (!strcmp(subkey, ".pushinsteadof")) {
+			rewrite = make_rewrite(&rewrites_push, name, subkey - name);
 			if (!value)
 				return config_error_nonbool(key);
 			add_instead_of(rewrite, xstrdup(value));
@@ -435,12 +449,13 @@ static void alias_all_urls(void)
 	for (i = 0; i < remotes_nr; i++) {
 		if (!remotes[i])
 			continue;
-		for (j = 0; j < remotes[i]->url_nr; j++) {
-			remotes[i]->url[j] = alias_url(remotes[i]->url[j], &rewrites);
-		}
 		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
 			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
 		}
+		for (j = 0; j < remotes[i]->url_nr; j++) {
+			remotes[i]->url[j] = alias_url(remotes[i]->url[j], &rewrites);
+			add_pushurl_alias(remotes[i], remotes[i]->url[j]);
+		}
 	}
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2d2633f..8f455c7 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -122,6 +122,23 @@ test_expect_success 'fetch with insteadOf' '
 	)
 '
 
+test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
+	mk_empty &&
+	(
+		TRASH=$(pwd)/ &&
+		cd testrepo &&
+		git config "url.trash/.pushInsteadOf" "$TRASH" &&
+		git config remote.up.url "$TRASH." &&
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
 
@@ -162,6 +179,20 @@ test_expect_success 'push with insteadOf' '
 	)
 '
 
+test_expect_success 'push with pushInsteadOf' '
+	mk_empty &&
+	TRASH="$(pwd)/" &&
+	git config "url.$TRASH.pushInsteadOf" trash/ &&
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
1.6.3.3
