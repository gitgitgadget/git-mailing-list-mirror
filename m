From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin clone: support bundles
Date: Sun, 2 Mar 2008 07:46:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803020743170.22527@racer.site>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <alpine.LNX.1.00.0802261128360.19024@iabervon.org> <alpine.LSU.1.00.0803020556380.22527@racer.site> <alpine.LSU.1.00.0803020622190.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 08:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVivU-0003Xp-Tv
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbYCBHr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYCBHr2
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:47:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:38495 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752083AbYCBHr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:47:27 -0500
Received: (qmail invoked by alias); 02 Mar 2008 07:47:25 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp043) with SMTP; 02 Mar 2008 08:47:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18roMhRkG4rOF8WnwCYvKqr2/6QlLyn9HCvr3wyfH
	sWJlyDcKjgIYP2
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803020622190.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75743>


This forward-ports c6fef0bb(clone: support cloning full bundles) to the
builtin clone.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Now my private tree passes all tests again.

	Daniel, do you have a branch where you have your current version 
	of builting clone?  Mine is in "my-next" of 
	http://repo.or.cz/w/git/dscho.git.

 builtin-clone.c |   59 ++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index f27d205..29cd09d 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -64,42 +64,52 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
-static char *get_repo_path(const char *repo)
+static char *get_repo_path(const char *repo, int *is_bundle)
 {
-	const char *path;
-	struct stat buf;
-
-	path = mkpath("%s/.git", repo);
-	if (!stat(path, &buf) && S_ISDIR(buf.st_mode))
-		return xstrdup(make_absolute_path(path));
-
-	path = mkpath("%s.git", repo);
-	if (!stat(path, &buf) && S_ISDIR(buf.st_mode))
-		return xstrdup(make_absolute_path(path));
+	static char *suffix[] = { "/.git", ".git", "" };
+	static char *bundle_suffix[] = { ".bundle", "" };
+	struct stat st;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
+		const char *path;
+		path = mkpath("%s%s", repo, suffix[i]);
+		if (!stat(path, &st) && S_ISDIR(st.st_mode)) {
+			*is_bundle = 0;
+			return xstrdup(make_absolute_path(path));
+		}
+	}
 
-	if (!stat(repo, &buf) && S_ISDIR(buf.st_mode))
-		return xstrdup(make_absolute_path(repo));
+	for (i = 0; i < ARRAY_SIZE(bundle_suffix); i++) {
+		const char *path;
+		path = mkpath("%s%s", repo, bundle_suffix[i]);
+		if (!stat(path, &st) && S_ISREG(st.st_mode)) {
+			*is_bundle = 1;
+			return xstrdup(make_absolute_path(path));
+		}
+	}
 
 	return NULL;
 }
 
-static char *guess_dir_name(const char *repo)
+static char *guess_dir_name(const char *repo, int is_bundle)
 {
 	const char *p, *start, *end, *limit;
 	int after_slash_or_colon;
 
 	/* Guess dir name from repository: strip trailing '/',
-	 * strip trailing '[:/]*git', strip leading '.*[/:]'. */
+	 * strip trailing '[:/]*.{git,bundle}', strip leading '.*[/:]'. */
 
 	after_slash_or_colon = 1;
 	limit = repo + strlen(repo);
 	start = repo;
 	end = limit;
 	for (p = repo; p < limit; p++) {
-		if (!prefixcmp(p, ".git")) {
+		const char *prefix = is_bundle ? ".bundle" : ".git";
+		if (!prefixcmp(p, prefix)) {
 			if (!after_slash_or_colon)
 				end = p;
-			p += 3;
+			p += strlen(prefix) - 1;
 		} else if (*p == '/' || *p == ':') {
 			if (end == limit)
 				end = p;
@@ -287,7 +297,7 @@ walk_objects(char *src, char *dest)
 }
 
 static const struct ref *
-clone_local(const char *src_repo, const char *dest_repo)
+clone_local(const char *src_repo, const char *dest_repo, int is_bundle)
 {
 	const struct ref *ret;
 	char src[PATH_MAX];
@@ -295,7 +305,9 @@ clone_local(const char *src_repo, const char *dest_repo)
 	struct remote *remote;
 	struct transport *transport;
 
-	if (option_shared) {
+	if (is_bundle)
+		; /* do nothing */
+	else if (option_shared) {
 		write_alternates_file(dest_repo, src_repo);
 	} else {
 		snprintf(src, PATH_MAX, "%s/objects", src_repo);
@@ -307,6 +319,8 @@ clone_local(const char *src_repo, const char *dest_repo)
 	remote = remote_get(src_repo);
 	transport = transport_get(remote, src_repo);
 	ret = transport_get_remote_refs(transport);
+	if (is_bundle && transport_fetch_refs(transport, (struct ref *)ret))
+		die ("Could not read bundle");
 	transport_disconnect(transport);
 	return ret;
 }
@@ -339,6 +353,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int use_local_hardlinks = 1;
 	int use_separate_remote = 1;
+	int is_bundle;
 	struct stat buf;
 	const char *repo, *work_tree, *git_dir;
 	char *path, *dir, *head, *ref_temp;
@@ -369,12 +384,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_origin = "origin";
 
 	repo = argv[0];
-	path = get_repo_path(repo);
+	path = get_repo_path(repo, &is_bundle);
 
 	if (argc == 2) {
 		dir = xstrdup(argv[1]);
 	} else {
-		dir = guess_dir_name(repo);
+		dir = guess_dir_name(repo, is_bundle);
 	}
 
 	if (!stat(dir, &buf))
@@ -429,7 +444,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		git_config_set("core.bare", "true");
 
 	if (path != NULL) {
-		refs = clone_local(path, git_dir);
+		refs = clone_local(path, git_dir, is_bundle);
 		repo = make_absolute_path(path);
 	} else {
 		struct remote *remote = remote_get(argv[0]);
-- 
1.5.4.3.446.gbe8932


