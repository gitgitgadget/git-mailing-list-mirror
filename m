From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/3] Parse and report branch configuration along with remote
 configuration.
Date: Mon, 11 Jun 2007 23:10:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706112306220.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 05:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxwmg-0005uE-3I
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 05:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbXFLDKq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 23:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbXFLDKp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 23:10:45 -0400
Received: from iabervon.org ([66.92.72.58]:3094 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbXFLDKo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 23:10:44 -0400
Received: (qmail 1954 invoked by uid 1000); 12 Jun 2007 03:10:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2007 03:10:43 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49913>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 remote.h |   13 +++++++++
 2 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index d904616..1fbceeb 100644
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
 
@@ -67,6 +73,45 @@ static struct remote *make_remote(const char *name, int len)
 	return remotes[empty];
 }
 
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
@@ -144,20 +189,25 @@ static void read_branches_file(struct remote *remote)
 	add_uri(remote, p);
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
+		if (!value)
+			return 0;
+		if (!strcmp(subkey, ".remote")) {
+			branch->remote_name = xstrdup(value);
+			if (branch == current_branch)
+				default_remote_name = branch->remote_name;
+		} else if (!strcmp(subkey, ".merge"))
+			branch->merge_name = xstrdup(value);
+		return 0;
 	}
 	if (prefixcmp(key,  "remote."))
 		return 0;
@@ -212,8 +262,8 @@ static void read_config(void)
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
@@ -551,3 +601,23 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	}
 	return 0;
 }
+
+struct branch *branch_get(const char *name)
+{
+	struct branch *ret;
+
+	read_config();
+	if (!name || !strcmp(name, "HEAD"))
+		ret = current_branch;
+	else
+		ret = make_branch(name, 0);
+	if (ret->remote_name) {
+		ret->remote = remote_get(ret->remote_name);
+		if (ret->merge_name) {
+			ret->merge = malloc(sizeof(*ret->merge));
+			ret->merge->src = ret->merge_name;
+			remote_find_tracking(ret->remote, ret->merge);
+		}
+	}
+	return ret;
+}
diff --git a/remote.h b/remote.h
index 01dbcef..14615e8 100644
--- a/remote.h
+++ b/remote.h
@@ -38,4 +38,17 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
  */
 int remote_find_tracking(struct remote *remote, struct refspec *refspec);
 
+struct branch {
+	const char *name;
+	const char *refname;
+
+	const char *remote_name;
+	struct remote *remote;
+
+	const char *merge_name;
+	struct refspec *merge;
+};
+
+struct branch *branch_get(const char *name);
+
 #endif
-- 
1.5.2.901.g27ad4-dirty
