From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Report information on branches from remote.h
Date: Mon, 9 Jul 2007 01:10:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707090107390.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 09 07:10:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7lWE-0005Pi-HF
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 07:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbXGIFKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 01:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbXGIFK3
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 01:10:29 -0400
Received: from iabervon.org ([66.92.72.58]:4742 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbXGIFK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 01:10:26 -0400
Received: (qmail 29230 invoked by uid 1000); 9 Jul 2007 05:10:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jul 2007 05:10:25 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51953>

This adds full parsing for branch.<name> sections and functions to
interpret the results usefully. It incidentally corrects the fetch
configuration information for legacy branches/* files with '#'
characters in the URLs.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |  157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 remote.h |   18 +++++++
 2 files changed, 164 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index 500ca4d..4ea15b9 100644
--- a/remote.c
+++ b/remote.c
@@ -5,6 +5,12 @@
 static struct remote **remotes;
 static int allocated_remotes;
 
+static struct branch **branches;
+static int allocated_branches;
+
+static struct branch *current_branch;
+static const char *default_remote_name;
+
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
 
@@ -67,6 +73,54 @@ static struct remote *make_remote(const char *name, int len)
 	return remotes[empty];
 }
 
+static void add_merge(struct branch *branch, const char *name)
+{
+	int nr = branch->merge_nr + 1;
+	branch->merge_name =
+		xrealloc(branch->merge_name, nr * sizeof(char *));
+	branch->merge_name[nr-1] = name;
+	branch->merge_nr = nr;
+}
+
+static struct branch *make_branch(const char *name, int len)
+{
+	int i, empty = -1;
+	char *refname;
+
+	for (i = 0; i < allocated_branches; i++) {
+		if (!branches[i]) {
+			if (empty < 0)
+				empty = i;
+		} else {
+			if (len ? (!strncmp(name, branches[i]->name, len) &&
+				   !branches[i]->name[len]) :
+			    !strcmp(name, branches[i]->name))
+				return branches[i];
+		}
+	}
+
+	if (empty < 0) {
+		empty = allocated_branches;
+		allocated_branches += allocated_branches ? allocated_branches : 1;
+		branches = xrealloc(branches,
+				   sizeof(*branches) * allocated_branches);
+		memset(branches + empty, 0,
+		       (allocated_branches - empty) * sizeof(*branches));
+	}
+	branches[empty] = xcalloc(1, sizeof(struct branch));
+	if (len)
+		branches[empty]->name = xstrndup(name, len);
+	else
+		branches[empty]->name = xstrdup(name);
+	refname = malloc(strlen(name) + strlen("refs/heads/") + 1);
+	strcpy(refname, "refs/heads/");
+	strcpy(refname + strlen("refs/heads/"),
+	       branches[empty]->name);
+	branches[empty]->refname = refname;
+
+	return branches[empty];
+}
+
 static void read_remotes_file(struct remote *remote)
 {
 	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
@@ -116,6 +170,8 @@ static void read_remotes_file(struct remote *remote)
 static void read_branches_file(struct remote *remote)
 {
 	const char *slash = strchr(remote->name, '/');
+	char *frag;
+	char *branch;
 	int n = slash ? slash - remote->name : 1000;
 	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
 	char *s, *p;
@@ -141,23 +197,40 @@ static void read_branches_file(struct remote *remote)
 	strcpy(p, s);
 	if (slash)
 		strcat(p, slash);
+	frag = strchr(p, '#');
+	if (frag) {
+		*(frag++) = '\0';
+		branch = xmalloc(strlen(frag) + 12);
+		strcpy(branch, "refs/heads/");
+		strcat(branch, frag);
+	} else {
+		branch = "refs/heads/master";
+	}
 	add_uri(remote, p);
+	add_fetch_refspec(remote, branch);
 }
 
-static char *default_remote_name = NULL;
-static const char *current_branch = NULL;
-static int current_branch_len = 0;
-
 static int handle_config(const char *key, const char *value)
 {
 	const char *name;
 	const char *subkey;
 	struct remote *remote;
-	if (!prefixcmp(key, "branch.") && current_branch &&
-	    !strncmp(key + 7, current_branch, current_branch_len) &&
-	    !strcmp(key + 7 + current_branch_len, ".remote")) {
-		free(default_remote_name);
-		default_remote_name = xstrdup(value);
+	struct branch *branch;
+	if (!prefixcmp(key, "branch.")) {
+		name = key + 7;
+		subkey = strrchr(name, '.');
+		branch = make_branch(name, subkey - name);
+		if (!subkey)
+			return 0;
+		if (!value)
+			return 0;
+		if (!strcmp(subkey, ".remote")) {
+			branch->remote_name = xstrdup(value);
+			if (branch == current_branch)
+				default_remote_name = branch->remote_name;
+		} else if (!strcmp(subkey, ".merge"))
+			add_merge(branch, xstrdup(value));
+		return 0;
 	}
 	if (prefixcmp(key,  "remote."))
 		return 0;
@@ -212,8 +285,8 @@ static void read_config(void)
 	head_ref = resolve_ref("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
 	    !prefixcmp(head_ref, "refs/heads/")) {
-		current_branch = head_ref + strlen("refs/heads/");
-		current_branch_len = strlen(current_branch);
+		current_branch =
+			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config);
 }
@@ -289,6 +362,25 @@ int remote_has_uri(struct remote *remote, const char *uri)
 	return 0;
 }
 
+/*
+ * Returns true if, under the matching rules for fetching, name is the
+ * same as the given full name.
+ */
+static int ref_matches_abbrev(const char *name, const char *full)
+{
+	if (!prefixcmp(name, "refs/") || !strcmp(name, "HEAD"))
+		return !strcmp(name, full);
+	if (prefixcmp(full, "refs/"))
+		return 0;
+	if (!prefixcmp(name, "heads/") ||
+	    !prefixcmp(name, "tags/") ||
+	    !prefixcmp(name, "remotes/"))
+		return !strcmp(name, full + 5);
+	if (prefixcmp(full + 5, "heads/"))
+		return 0;
+	return !strcmp(full + 11, name);
+}
+
 int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 {
 	int i;
@@ -574,3 +666,46 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	}
 	return 0;
 }
+
+struct branch *branch_get(const char *name)
+{
+	struct branch *ret;
+
+	read_config();
+	if (!name || !*name || !strcmp(name, "HEAD"))
+		ret = current_branch;
+	else
+		ret = make_branch(name, 0);
+	if (ret && ret->remote_name) {
+		ret->remote = remote_get(ret->remote_name);
+		if (ret->merge_nr) {
+			int i;
+			ret->merge = xcalloc(sizeof(*ret->merge),
+					     ret->merge_nr);
+			for (i = 0; i < ret->merge_nr; i++) {
+				ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
+				ret->merge[i]->src = ret->merge_name[i];
+				remote_find_tracking(ret->remote,
+						     ret->merge[i]);
+			}
+		}
+	}
+	return ret;
+}
+
+int branch_has_merge_config(struct branch *branch)
+{
+	return branch && !!branch->merge;
+}
+
+int branch_merges(struct branch *branch, const char *refname)
+{
+	int i;
+	if (!branch)
+		return 0;
+	for (i = 0; i < branch->merge_nr; i++) {
+		if (ref_matches_abbrev(branch->merge[i]->src, refname))
+			return 1;
+	}
+	return 0;
+}
diff --git a/remote.h b/remote.h
index 01dbcef..9824a0d 100644
--- a/remote.h
+++ b/remote.h
@@ -38,4 +38,22 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
  */
 int remote_find_tracking(struct remote *remote, struct refspec *refspec);
 
+struct branch {
+	const char *name;
+	const char *refname;
+
+	const char *remote_name;
+	struct remote *remote;
+
+	const char **merge_name;
+	struct refspec **merge;
+	int merge_nr;
+};
+
+struct branch *branch_get(const char *name);
+
+int branch_has_merge_config(struct branch *branch);
+
+int branch_merges(struct branch *branch, const char *refname);
+
 #endif
-- 
1.5.2.2.1399.g097d5-dirty
