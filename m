From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] remote: fix "update [group...]"
Date: Tue, 4 Mar 2008 11:23:53 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041120300.22527@racer.site>
References: <alpine.LSU.1.00.0803040029440.22527@racer.site> <7v4pbne013.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 12:25:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVGs-0000gm-8x
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297AbYCDLYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 06:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756094AbYCDLYm
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:24:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:58207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756346AbYCDLYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 06:24:41 -0500
Received: (qmail invoked by alias); 04 Mar 2008 11:24:39 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp032) with SMTP; 04 Mar 2008 12:24:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+GUqgHAoWGwplge3quBOok7Ph5wAVX4Ps35RukDI
	AHuzdp3xzL+8Jx
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pbne013.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76067>


The rewrite in C inadvertently broke updating with remote groups: when you
pass parameters to "git remote update", it used to look up "remotes.<group>"
for every parameter, and interpret the value as a list of remotes to update.

Also, no parameter, or a single parameter "default" should update all
remotes that have not been marked with "skipDefaultUpdate".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 3 Mar 2008, Junio C Hamano wrote:

	> > +static int get_one_remote_for_update([...]
	>
	> This is called when no extra parameter is given or the name is 
	> default. It behaves differently from the scripted version if 
	> remote.default configuration exists, doesn't it?

	remotes.default, yes.  Fixed.

	> > +static int get_remote_group(const char *key, const char *value)
	> > +{
	> > +	if (!prefixcmp(key, "remotes.") &&
	> > +			!strcmp(key + 8, remote_group.name)) {
	> > +		char *space = strchr(value, ' ');
	> > +		while (space) {
	> > +			path_list_append(xstrndup(value, space - value),
	> > +					remote_group.list);
	> > +			value = space + 1;
	> > +			space = strchr(value, ' ');
	> > +		}
	> > +		path_list_append(xstrdup(value), remote_group.list);
	> > +	}
	> > +
	> 
	> This does not mimick the magic "split(' ', $conf)" in the scripted
	> version.

	I was not aware of that Perl feature.  Fixed.

	> > +	list.strdup_paths = 1;
	> > +	path_list_clear(&list, 0);
	> 
	> This setting of strdup_paths after the fact and causing clear to 
	> free things that were allocated while strdup_paths were set to 0 
	> made me go "Huh?", which means it needs explanation or code 
	> clarification.

	Fixed with a comment.

	> > +	return result;
	> 
	> The scripted one did not stop fetching upon error and this does 
	> not regress it, but it reports error, which I think is a good 
	> change.

	I overlooked that regression, but yes, it was out of a habit to 
	expect programs to fail when some part of them fails.

 builtin-remote.c  |   59 +++++++++++++++++++++++++++++-----
 t/t5505-remote.sh |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 9 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index fc01bcc..aa90cc9 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -477,24 +477,65 @@ cleanup_states:
 	return result;
 }
 
-static int update_one(struct remote *remote, void *priv)
+static int get_one_remote_for_update(struct remote *remote, void *priv)
 {
+	struct path_list *list = priv;
 	if (!remote->skip_default_update)
-		return fetch_remote(remote->name);
+		path_list_append(xstrdup(remote->name), list);
+	return 0;
+}
+
+struct remote_group {
+	const char *name;
+	struct path_list *list;
+} remote_group;
+
+static int get_remote_group(const char *key, const char *value)
+{
+	if (!prefixcmp(key, "remotes.") &&
+			!strcmp(key + 8, remote_group.name)) {
+		/* split list by white space */
+		int space = strcspn(value, " \t\n");
+		while (*value) {
+			if (space > 1)
+				path_list_append(xstrndup(value, space),
+						remote_group.list);
+			value += space + (value[space] != '\0');
+			space = strcspn(value, " \t\n");
+		}
+	}
+
 	return 0;
 }
 
 static int update(int argc, const char **argv)
 {
-	int i;
+	int i, result = 0;
+	struct path_list list = { NULL, 0, 0, 0 };
+	static const char *default_argv[] = { NULL, "default", NULL };
 
-	if (argc < 2)
-		return for_each_remote(update_one, NULL);
+	if (argc < 2) {
+		argc = 2;
+		argv = default_argv;
+	}
 
-	for (i = 1; i < argc; i++)
-		if (fetch_remote(argv[i]))
-			return 1;
-	return 0;
+	remote_group.list = &list;
+	for (i = 1; i < argc; i++) {
+		remote_group.name = argv[i];
+		result = git_config(get_remote_group);
+	}
+
+	if (!result && !list.nr  && argc == 2 && !strcmp(argv[1], "default"))
+		result = for_each_remote(get_one_remote_for_update, &list);
+
+	for (i = 0; i < list.nr; i++)
+		result |= fetch_remote(list.items[i].path);
+
+	/* all names were strdup()ed or strndup()ed */
+	list.strdup_paths = 1;
+	path_list_clear(&list, 0);
+
+	return result;
 }
 
 static int get_one_entry(struct remote *remote, void *priv)
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0a25c8b..f45ea68 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -10,10 +10,12 @@ setup_repository () {
 	git init &&
 	>file &&
 	git add file &&
+	test_tick &&
 	git commit -m "Initial" &&
 	git checkout -b side &&
 	>elif &&
 	git add elif &&
+	test_tick &&
 	git commit -m "Second" &&
 	git checkout master
 	)
@@ -113,6 +115,7 @@ test_expect_success 'show' '
 	 git branch -d -r origin/master &&
 	 (cd ../one &&
 	  echo 1 > file &&
+	  test_tick &&
 	  git commit -m update file) &&
 	 git remote show origin > output &&
 	 git diff expect output)
@@ -144,4 +147,93 @@ test_expect_success 'add --mirror && prune' '
 	 git rev-parse --verify refs/heads/side)
 '
 
+cat > one/expect << EOF
+  apis/master
+  apis/side
+  drosophila/another
+  drosophila/master
+  drosophila/side
+EOF
+
+test_expect_success 'update' '
+
+	(cd one &&
+	 git remote add drosophila ../two &&
+	 git remote add apis ../mirror &&
+	 git remote update &&
+	 git branch -r > output &&
+	 git diff expect output)
+
+'
+
+cat > one/expect << EOF
+  drosophila/another
+  drosophila/master
+  drosophila/side
+  manduca/master
+  manduca/side
+  megaloprepus/master
+  megaloprepus/side
+EOF
+
+test_expect_success 'update with arguments' '
+
+	(cd one &&
+	 for b in $(git branch -r)
+	 do
+		git branch -r -d $b || break
+	 done &&
+	 git remote add manduca ../mirror &&
+	 git remote add megaloprepus ../mirror &&
+	 git config remotes.phobaeticus "drosophila megaloprepus" &&
+	 git config remotes.titanus manduca &&
+	 git remote update phobaeticus titanus &&
+	 git branch -r > output &&
+	 git diff expect output)
+
+'
+
+cat > one/expect << EOF
+  apis/master
+  apis/side
+  manduca/master
+  manduca/side
+  megaloprepus/master
+  megaloprepus/side
+EOF
+
+test_expect_success 'update default' '
+
+	(cd one &&
+	 for b in $(git branch -r)
+	 do
+		git branch -r -d $b || break
+	 done &&
+	 git config remote.drosophila.skipDefaultUpdate true &&
+	 git remote update default &&
+	 git branch -r > output &&
+	 git diff expect output)
+
+'
+
+cat > one/expect << EOF
+  drosophila/another
+  drosophila/master
+  drosophila/side
+EOF
+
+test_expect_success 'update default (overridden, with funny whitespace)' '
+
+	(cd one &&
+	 for b in $(git branch -r)
+	 do
+		git branch -r -d $b || break
+	 done &&
+	 git config remotes.default "$(printf "\t drosophila  \n")" &&
+	 git remote update default &&
+	 git branch -r > output &&
+	 git diff expect output)
+
+'
+
 test_done
-- 
1.5.4.3.570.g97e7d

