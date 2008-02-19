From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Use ALLOC_GROW in remote.{c,h}
Date: Mon, 18 Feb 2008 23:41:41 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802182316500.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 05:42:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRKJB-0003LR-2w
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 05:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbYBSEln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 23:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbYBSEln
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 23:41:43 -0500
Received: from iabervon.org ([66.92.72.58]:45086 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbYBSElm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 23:41:42 -0500
Received: (qmail 23765 invoked by uid 1000); 19 Feb 2008 04:41:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 04:41:41 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74375>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
The relevance of this patch, which is of general applicability, to this 
series is that it cleans up the style of this file such that the next 
patch, which now uses the modern style, fits in.

 remote.c |  118 ++++++++++++++++++++++++--------------------------------------
 remote.h |    4 ++
 2 files changed, 50 insertions(+), 72 deletions(-)

diff --git a/remote.c b/remote.c
index 6b56473..457d8a4 100644
--- a/remote.c
+++ b/remote.c
@@ -3,10 +3,12 @@
 #include "refs.h"
 
 static struct remote **remotes;
-static int allocated_remotes;
+static int remotes_alloc;
+static int remotes_nr;
 
 static struct branch **branches;
-static int allocated_branches;
+static int branches_alloc;
+static int branches_nr;
 
 static struct branch *current_branch;
 static const char *default_remote_name;
@@ -16,109 +18,81 @@ static char buffer[BUF_SIZE];
 
 static void add_push_refspec(struct remote *remote, const char *ref)
 {
-	int nr = remote->push_refspec_nr + 1;
-	remote->push_refspec =
-		xrealloc(remote->push_refspec, nr * sizeof(char *));
-	remote->push_refspec[nr-1] = ref;
-	remote->push_refspec_nr = nr;
+	ALLOC_GROW(remote->push_refspec,
+		   remote->push_refspec_nr + 1,
+		   remote->push_refspec_alloc);
+	remote->push_refspec[remote->push_refspec_nr++] = ref;
 }
 
 static void add_fetch_refspec(struct remote *remote, const char *ref)
 {
-	int nr = remote->fetch_refspec_nr + 1;
-	remote->fetch_refspec =
-		xrealloc(remote->fetch_refspec, nr * sizeof(char *));
-	remote->fetch_refspec[nr-1] = ref;
-	remote->fetch_refspec_nr = nr;
+	ALLOC_GROW(remote->fetch_refspec,
+		   remote->fetch_refspec_nr + 1,
+		   remote->fetch_refspec_alloc);
+	remote->fetch_refspec[remote->fetch_refspec_nr++] = ref;
 }
 
 static void add_url(struct remote *remote, const char *url)
 {
-	int nr = remote->url_nr + 1;
-	remote->url =
-		xrealloc(remote->url, nr * sizeof(char *));
-	remote->url[nr-1] = url;
-	remote->url_nr = nr;
+	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
+	remote->url[remote->url_nr++] = url;
 }
 
 static struct remote *make_remote(const char *name, int len)
 {
-	int i, empty = -1;
+	struct remote *ret;
+	int i;
 
-	for (i = 0; i < allocated_remotes; i++) {
-		if (!remotes[i]) {
-			if (empty < 0)
-				empty = i;
-		} else {
-			if (len ? (!strncmp(name, remotes[i]->name, len) &&
-				   !remotes[i]->name[len]) :
-			    !strcmp(name, remotes[i]->name))
-				return remotes[i];
-		}
+	for (i = 0; i < remotes_nr; i++) {
+		if (len ? (!strncmp(name, remotes[i]->name, len) &&
+			   !remotes[i]->name[len]) :
+		    !strcmp(name, remotes[i]->name))
+			return remotes[i];
 	}
 
-	if (empty < 0) {
-		empty = allocated_remotes;
-		allocated_remotes += allocated_remotes ? allocated_remotes : 1;
-		remotes = xrealloc(remotes,
-				   sizeof(*remotes) * allocated_remotes);
-		memset(remotes + empty, 0,
-		       (allocated_remotes - empty) * sizeof(*remotes));
-	}
-	remotes[empty] = xcalloc(1, sizeof(struct remote));
+	ret = xcalloc(1, sizeof(struct remote));
+	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
+	remotes[remotes_nr++] = ret;
 	if (len)
-		remotes[empty]->name = xstrndup(name, len);
+		ret->name = xstrndup(name, len);
 	else
-		remotes[empty]->name = xstrdup(name);
-	return remotes[empty];
+		ret->name = xstrdup(name);
+	return ret;
 }
 
 static void add_merge(struct branch *branch, const char *name)
 {
-	int nr = branch->merge_nr + 1;
-	branch->merge_name =
-		xrealloc(branch->merge_name, nr * sizeof(char *));
-	branch->merge_name[nr-1] = name;
-	branch->merge_nr = nr;
+	ALLOC_GROW(branch->merge_name, branch->merge_nr + 1,
+		   branch->merge_alloc);
+	branch->merge_name[branch->merge_nr++] = name;
 }
 
 static struct branch *make_branch(const char *name, int len)
 {
-	int i, empty = -1;
+	struct branch *ret;
+	int i;
 	char *refname;
 
-	for (i = 0; i < allocated_branches; i++) {
-		if (!branches[i]) {
-			if (empty < 0)
-				empty = i;
-		} else {
-			if (len ? (!strncmp(name, branches[i]->name, len) &&
-				   !branches[i]->name[len]) :
-			    !strcmp(name, branches[i]->name))
-				return branches[i];
-		}
+	for (i = 0; i < branches_nr; i++) {
+		if (len ? (!strncmp(name, branches[i]->name, len) &&
+			   !branches[i]->name[len]) :
+		    !strcmp(name, branches[i]->name))
+			return branches[i];
 	}
 
-	if (empty < 0) {
-		empty = allocated_branches;
-		allocated_branches += allocated_branches ? allocated_branches : 1;
-		branches = xrealloc(branches,
-				   sizeof(*branches) * allocated_branches);
-		memset(branches + empty, 0,
-		       (allocated_branches - empty) * sizeof(*branches));
-	}
-	branches[empty] = xcalloc(1, sizeof(struct branch));
+	ALLOC_GROW(branches, branches_nr + 1, branches_alloc);
+	ret = xcalloc(1, sizeof(struct branch));
+	branches[branches_nr++] = ret;
 	if (len)
-		branches[empty]->name = xstrndup(name, len);
+		ret->name = xstrndup(name, len);
 	else
-		branches[empty]->name = xstrdup(name);
+		ret->name = xstrdup(name);
 	refname = malloc(strlen(name) + strlen("refs/heads/") + 1);
 	strcpy(refname, "refs/heads/");
-	strcpy(refname + strlen("refs/heads/"),
-	       branches[empty]->name);
-	branches[empty]->refname = refname;
+	strcpy(refname + strlen("refs/heads/"), ret->name);
+	ret->refname = refname;
 
-	return branches[empty];
+	return ret;
 }
 
 static void read_remotes_file(struct remote *remote)
@@ -380,7 +354,7 @@ int for_each_remote(each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
 	read_config();
-	for (i = 0; i < allocated_remotes && !result; i++) {
+	for (i = 0; i < remotes_nr && !result; i++) {
 		struct remote *r = remotes[i];
 		if (!r)
 			continue;
diff --git a/remote.h b/remote.h
index 86e036d..0f6033f 100644
--- a/remote.h
+++ b/remote.h
@@ -6,14 +6,17 @@ struct remote {
 
 	const char **url;
 	int url_nr;
+	int url_alloc;
 
 	const char **push_refspec;
 	struct refspec *push;
 	int push_refspec_nr;
+	int push_refspec_alloc;
 
 	const char **fetch_refspec;
 	struct refspec *fetch;
 	int fetch_refspec_nr;
+	int fetch_refspec_alloc;
 
 	/*
 	 * -1 to never fetch tags
@@ -100,6 +103,7 @@ struct branch {
 	const char **merge_name;
 	struct refspec **merge;
 	int merge_nr;
+	int merge_alloc;
 };
 
 struct branch *branch_get(const char *name);
-- 
1.5.4.1.191.gfbf10
