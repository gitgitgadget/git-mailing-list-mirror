From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/4] Add matching and parsing for fetch-side refspec rules
Date: Wed, 11 Jul 2007 21:37:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707112107270.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 03:37:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ncJ-0000Ct-Te
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 03:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764084AbXGLBhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 21:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763262AbXGLBhJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 21:37:09 -0400
Received: from iabervon.org ([66.92.72.58]:1586 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761347AbXGLBhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 21:37:07 -0400
Received: (qmail 31933 invoked by uid 1000); 12 Jul 2007 01:37:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jul 2007 01:37:05 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52230>

Also exports parse_ref_spec() and reads the "tagopt" config option.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |  125 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 remote.h |   24 ++++++++++++
 2 files changed, 148 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index fa4af05..bba44c3 100644
--- a/remote.c
+++ b/remote.c
@@ -208,6 +208,7 @@ static void read_branches_file(struct remote *remote)
 	}
 	add_uri(remote, p);
 	add_fetch_refspec(remote, branch);
+	remote->fetch_tags = 1; /* always auto-follow */
 }
 
 static int handle_config(const char *key, const char *value)
@@ -274,6 +275,9 @@ static int handle_config(const char *key, const char *value)
 			remote->uploadpack = xstrdup(value);
 		else
 			error("more than one uploadpack given, using the first");
+	} else if (!strcmp(subkey, ".tagopt")) {
+		if (!strcmp(value, "--no-tags"))
+			remote->fetch_tags = -1;
 	}
 	return 0;
 }
@@ -296,7 +300,7 @@ static void read_config(void)
 	git_config(handle_config);
 }
 
-static struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
+struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
 {
 	int i;
 	struct refspec *rs = xcalloc(sizeof(*rs), nr_refspec);
@@ -352,6 +356,10 @@ struct remote *remote_get(const char *name)
 		add_uri(ret, name);
 	if (!ret->uri)
 		return NULL;
+	if (!strcmp(name, ".")) {
+		// we always fetch "refs/*:refs/*", which is trivial
+		add_fetch_refspec(ret, "refs/*:refs/*");
+	}
 	ret->fetch = parse_ref_spec(ret->fetch_refspec_nr, ret->fetch_refspec);
 	ret->push = parse_ref_spec(ret->push_refspec_nr, ret->push_refspec);
 	return ret;
@@ -424,6 +432,14 @@ struct ref *alloc_ref(unsigned namelen)
 	return ret;
 }
 
+static struct ref *copy_ref(struct ref *ref)
+{
+	struct ref *ret = xmalloc(sizeof(struct ref) + strlen(ref->name) + 1);
+	memcpy(ret, ref, sizeof(struct ref) + strlen(ref->name) + 1);
+	ret->next = NULL;
+	return ret;
+}
+
 void free_refs(struct ref *ref)
 {
 	struct ref *next;
@@ -734,3 +750,110 @@ int branch_merges(struct branch *branch, const char *refname)
 	}
 	return 0;
 }
+
+static struct ref *get_expanded_map(struct ref *remote_refs,
+				    const struct refspec *refspec)
+{
+	struct ref *ref;
+	struct ref *ret = NULL;
+	struct ref **tail = &ret;
+
+	int remote_prefix_len = strlen(refspec->src);
+	int local_prefix_len = strlen(refspec->dst);
+
+	for (ref = remote_refs; ref; ref = ref->next) {
+		if (strchr(ref->name, '^'))
+			continue; /* a dereference item */
+		if (!prefixcmp(ref->name, refspec->src)) {
+			char *match;
+			struct ref *cpy = copy_ref(ref);
+			match = ref->name + remote_prefix_len;
+
+			cpy->peer_ref = alloc_ref(local_prefix_len +
+						  strlen(match) + 1);
+			sprintf(cpy->peer_ref->name, "%s%s",
+				refspec->dst, match);
+			if (refspec->force)
+				cpy->peer_ref->force = 1;
+			*tail = cpy;
+			tail = &cpy->next;
+		}
+	}
+
+	return ret;
+}
+
+static struct ref *find_ref_by_name_abbrev(struct ref *refs, const char *name)
+{
+	struct ref *ref;
+	for (ref = refs; ref; ref = ref->next) {
+		if (ref_matches_abbrev(name, ref->name))
+			return ref;
+	}
+	return NULL;
+}
+
+struct ref *get_remote_ref(struct ref *remote_refs, const char *name)
+{
+	struct ref *ref = find_ref_by_name_abbrev(remote_refs, name);
+
+	if (!ref)
+		die("Couldn't find remote ref %s\n", name);
+
+	return copy_ref(ref);
+}
+
+static struct ref *get_local_ref(const char *name)
+{
+	struct ref *ret;
+	if (!name)
+		return NULL;
+
+	if (!prefixcmp(name, "refs/")) {
+		ret = alloc_ref(strlen(name) + 1);
+		strcpy(ret->name, name);
+		return ret;
+	}
+
+	if (!prefixcmp(name, "heads/") ||
+	    !prefixcmp(name, "tags/") ||
+	    !prefixcmp(name, "remotes/")) {
+		ret = alloc_ref(strlen(name) + 6);
+		sprintf(ret->name, "refs/%s", name);
+		return ret;
+	}
+
+	ret = alloc_ref(strlen(name) + 12);
+	sprintf(ret->name, "refs/heads/%s", name);
+	return ret;
+}
+
+int get_fetch_map(struct ref *remote_refs,
+		  const struct refspec *refspec,
+		  struct ref ***tail)
+{
+	struct ref *ref_map, *rm;
+
+	if (refspec->pattern) {
+		ref_map = get_expanded_map(remote_refs, refspec);
+	} else {
+		ref_map = get_remote_ref(remote_refs,
+					 refspec->src[0] ?
+					 refspec->src : "HEAD");
+
+		ref_map->peer_ref = get_local_ref(refspec->dst);
+
+		if (refspec->force)
+			ref_map->peer_ref->force = 1;
+	}
+
+	for (rm = ref_map; rm; rm = rm->next) {
+		if (rm->peer_ref && check_ref_format(rm->peer_ref->name + 5))
+			die("* refusing to create funny ref '%s' locally",
+			    rm->peer_ref->name);
+	}
+
+	tail_link_ref(ref_map, tail);
+
+	return 0;
+}
diff --git a/remote.h b/remote.h
index 56e0ba6..2a5e87e 100644
--- a/remote.h
+++ b/remote.h
@@ -15,6 +15,14 @@ struct remote {
 	struct refspec *fetch;
 	int fetch_refspec_nr;
 
+	/*
+	 * -1 to never fetch tags
+	 * 0 to auto-follow tags on heuristic (default)
+	 * 1 to always auto-follow tags
+	 * 2 to always fetch tags
+	 */
+	int fetch_tags;
+
 	const char *receivepack;
 	const char *uploadpack;
 };
@@ -38,10 +46,26 @@ struct ref *alloc_ref(unsigned namelen);
  */
 void free_refs(struct ref *ref);
 
+struct refspec *parse_ref_spec(int nr_refspec, const char **refspec);
+
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, char **refspec, int all);
 
 /*
+ * Given a list of the remote refs and the specification of things to
+ * fetch, makes a (separate) list of the refs to fetch and the local
+ * refs to store into.
+ *
+ * *tail is the pointer to the tail pointer of the list of results
+ * beforehand, and will be set to the tail pointer of the list of
+ * results afterward.
+ */
+int get_fetch_map(struct ref *remote_refs, const struct refspec *refspec,
+		  struct ref ***tail);
+
+struct ref *get_remote_ref(struct ref *remote_refs, const char *name);
+
+/*
  * For the given remote, reads the refspec's src and sets the other fields.
  */
 int remote_find_tracking(struct remote *remote, struct refspec *refspec);
-- 
1.5.2.2.1600.ga4e5
