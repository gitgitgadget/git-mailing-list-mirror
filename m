From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/4] --decorate: prefer shorter names
Date: Wed, 11 Jul 2007 02:30:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707110230030.4047@racer.site>
References: <Pine.LNX.4.64.0707110220340.4047@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 11 03:38:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8R9Y-0002No-UP
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 03:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758476AbXGKBh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 21:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758362AbXGKBhz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 21:37:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:47417 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758251AbXGKBhy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 21:37:54 -0400
Received: (qmail invoked by alias); 11 Jul 2007 01:37:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 11 Jul 2007 03:37:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199z65XxDd9f/LaaY6nQ2a/QUwhEotRMeXbfEl1jY
	MoPmzS4cU5OIjV
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707110220340.4047@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52127>


When saying "--decorate=any", the decoration could get huge pretty
quickly.  Especially in a project like git.git, where there is a
lot of back and forth merging, older commits can be named in a
thousand ways.

However, usually you are only interested in short names.  For example,
most people are not interested in the fact that the initial commit
can be named by ways like v0.99~31^2~37^2^2~508^2^2~195^2~114, if you
can reference it by v0.99~954 instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.c   |   39 +++++++++++++++++++++++++++++----------
 commit.h   |    4 ++--
 revision.c |   10 ++++++----
 3 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/commit.c b/commit.c
index 3aa21cc..4128ef4 100644
--- a/commit.c
+++ b/commit.c
@@ -1554,25 +1554,43 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	return ret;
 }
 
-void add_name_decoration(const char *prefix, const char *name, int generation, struct object *obj)
+void add_name_decoration(const char *prefix, const char *name, int generation, int distance, struct object *obj)
 {
 	int plen = strlen(prefix);
 	int nlen = strlen(name);
 	struct name_decoration *res, *existing;
+	int free_existing = 0;
+
+	existing = lookup_decoration(&name_decoration, obj);
+	if (existing && existing->distance < distance)
+		return;
+
+	if (existing && existing->distance > distance)
+		free_existing = 1;
 
 	res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
 	memcpy(res->name, prefix, plen);
 	memcpy(res->name + plen, name, nlen + 1);
 
-	for (existing = lookup_decoration(&name_decoration, obj);
-			existing; existing = existing->next)
-		if (!strcmp(existing->name, res->name)) {
-			free(res);
-			return;
-		}
+	if (!free_existing)
+		for (; existing; existing = existing->next)
+			if (!strcmp(existing->name, res->name)) {
+				free(res);
+				return;
+			}
 
 	res->generation = generation;
+	res->distance = distance;
 	res->next = add_decoration(&name_decoration, obj, res);
+
+	if (free_existing) {
+		for (existing = res->next; existing; ) {
+			struct name_decoration *next = existing->next;
+			free(existing);
+			existing = next;
+		}
+		res->next = NULL;
+	}
 }
 
 int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
@@ -1588,12 +1606,12 @@ int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags
 		refname += 13;
 	else if (!prefixcmp(refname, "refs/"))
 		refname += 5;
-	add_name_decoration("", refname, 0, obj);
+	add_name_decoration("", refname, 0, 0, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;
-		add_name_decoration("tag: ", refname, 0, obj);
+		add_name_decoration("tag: ", refname, 0, 0, obj);
 	}
 	return 0;
 }
@@ -1614,7 +1632,7 @@ void add_name_decoration_to_parents(struct commit *commit)
 
 	for (decor = decoration; decor; decor = decor->next)
 		add_name_decoration("", decor->name, decor->generation + 1,
-				&parents->item->object);
+				decor->distance + 1, &parents->item->object);
 
 	parent_nr = 1;
 	while (parents->next) {
@@ -1632,6 +1650,7 @@ void add_name_decoration_to_parents(struct commit *commit)
 						"%s~%d^%d", decor->name,
 						decor->generation, parent_nr);
 			add_name_decoration("", buffer, 0,
+					decor->distance + 256,
 					&parents->item->object);
 		}
 	}
diff --git a/commit.h b/commit.h
index 8dafc7b..9b2bd55 100644
--- a/commit.h
+++ b/commit.h
@@ -26,11 +26,11 @@ extern const char *commit_type;
 extern struct decoration name_decoration;
 struct name_decoration {
 	struct name_decoration *next;
-	int generation;
+	int generation, distance;
 	char name[1];
 };
 
-void add_name_decoration(const char *prefix, const char *name, int generation, struct object *obj);
+void add_name_decoration(const char *prefix, const char *name, int generation, int distance, struct object *obj);
 int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 void add_name_decoration_to_parents(struct commit *commit);
 
diff --git a/revision.c b/revision.c
index 79880b4..796275d 100644
--- a/revision.c
+++ b/revision.c
@@ -642,7 +642,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
 		return 0;
 	commit = (struct commit *)it;
 	if (revs->decorate & DECORATE_GIVEN_REFS)
-		add_name_decoration("", arg, 0, it);
+		add_name_decoration("", arg, 0, 0, it);
 	if (revs->decorate & DECORATE_RECURSIVE)
 		add_name_decoration_to_parents(commit);
 	for (parents = commit->parents; parents; parents = parents->next) {
@@ -783,8 +783,10 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 			}
 
 			if (revs->decorate & DECORATE_GIVEN_REFS) {
-				add_name_decoration("", this, 0, &a->object);
-				add_name_decoration("", next, 0, &b->object);
+				add_name_decoration("", this, 0, 0,
+						&a->object);
+				add_name_decoration("", next, 0, 0,
+						&b->object);
 			}
 
 			if (symmetric) {
@@ -827,7 +829,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
 	if (revs->decorate & DECORATE_GIVEN_REFS)
-		add_name_decoration("", arg, 0, object);
+		add_name_decoration("", arg, 0, 0, object);
 	add_pending_object_with_mode(revs, object, arg, mode);
 	return 0;
 }
-- 
1.5.3.rc0.2783.gf3f7
