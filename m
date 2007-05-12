From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/3] Move refspec parser from connect.c and cache.h to
 remote.{c,h}
Date: Sat, 12 May 2007 11:45:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705121144390.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 17:46:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmtnk-0003ns-VM
	for gcvg-git@gmane.org; Sat, 12 May 2007 17:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbXELPqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 11:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756423AbXELPqD
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 11:46:03 -0400
Received: from iabervon.org ([66.92.72.58]:3667 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756766AbXELPqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 11:46:01 -0400
Received: (qmail 27739 invoked by uid 1000); 12 May 2007 15:45:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2007 15:45:59 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47055>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 cache.h     |    2 -
 connect.c   |  240 +---------------------------------------------------------
 http-push.c |    1 +
 remote.c    |  246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h    |   12 +++
 send-pack.c |    1 +
 6 files changed, 261 insertions(+), 241 deletions(-)

diff --git a/cache.h b/cache.h
index 8e76152..46057f8 100644
--- a/cache.h
+++ b/cache.h
@@ -465,8 +465,6 @@ struct ref {
 extern pid_t git_connect(int fd[2], char *url, const char *prog);
 extern int finish_connect(pid_t pid);
 extern int path_match(const char *path, int nr, char **match);
-extern int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
-		      int nr_refspec, char **refspec, int all);
 extern int get_ack(int fd, unsigned char *result_sha1);
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags);
 extern int server_supports(const char *feature);
diff --git a/connect.c b/connect.c
index da89c9c..50ec559 100644
--- a/connect.c
+++ b/connect.c
@@ -4,6 +4,7 @@
 #include "quote.h"
 #include "refs.h"
 #include "run-command.h"
+#include "remote.h"
 
 static char *server_capabilities;
 
@@ -128,245 +129,6 @@ int path_match(const char *path, int nr, char **match)
 	return 0;
 }
 
-struct refspec {
-	char *src;
-	char *dst;
-	char force;
-};
-
-/*
- * A:B means fast forward remote B with local A.
- * +A:B means overwrite remote B with local A.
- * +A is a shorthand for +A:A.
- * A is a shorthand for A:A.
- * :B means delete remote B.
- */
-static struct refspec *parse_ref_spec(int nr_refspec, char **refspec)
-{
-	int i;
-	struct refspec *rs = xcalloc(sizeof(*rs), (nr_refspec + 1));
-	for (i = 0; i < nr_refspec; i++) {
-		char *sp, *dp, *ep;
-		sp = refspec[i];
-		if (*sp == '+') {
-			rs[i].force = 1;
-			sp++;
-		}
-		ep = strchr(sp, ':');
-		if (ep) {
-			dp = ep + 1;
-			*ep = 0;
-		}
-		else
-			dp = sp;
-		rs[i].src = sp;
-		rs[i].dst = dp;
-	}
-	rs[nr_refspec].src = rs[nr_refspec].dst = NULL;
-	return rs;
-}
-
-static int count_refspec_match(const char *pattern,
-			       struct ref *refs,
-			       struct ref **matched_ref)
-{
-	int patlen = strlen(pattern);
-	struct ref *matched_weak = NULL;
-	struct ref *matched = NULL;
-	int weak_match = 0;
-	int match = 0;
-
-	for (weak_match = match = 0; refs; refs = refs->next) {
-		char *name = refs->name;
-		int namelen = strlen(name);
-		int weak_match;
-
-		if (namelen < patlen ||
-		    memcmp(name + namelen - patlen, pattern, patlen))
-			continue;
-		if (namelen != patlen && name[namelen - patlen - 1] != '/')
-			continue;
-
-		/* A match is "weak" if it is with refs outside
-		 * heads or tags, and did not specify the pattern
-		 * in full (e.g. "refs/remotes/origin/master") or at
-		 * least from the toplevel (e.g. "remotes/origin/master");
-		 * otherwise "git push $URL master" would result in
-		 * ambiguity between remotes/origin/master and heads/master
-		 * at the remote site.
-		 */
-		if (namelen != patlen &&
-		    patlen != namelen - 5 &&
-		    prefixcmp(name, "refs/heads/") &&
-		    prefixcmp(name, "refs/tags/")) {
-			/* We want to catch the case where only weak
-			 * matches are found and there are multiple
-			 * matches, and where more than one strong
-			 * matches are found, as ambiguous.  One
-			 * strong match with zero or more weak matches
-			 * are acceptable as a unique match.
-			 */
-			matched_weak = refs;
-			weak_match++;
-		}
-		else {
-			matched = refs;
-			match++;
-		}
-	}
-	if (!matched) {
-		*matched_ref = matched_weak;
-		return weak_match;
-	}
-	else {
-		*matched_ref = matched;
-		return match;
-	}
-}
-
-static void link_dst_tail(struct ref *ref, struct ref ***tail)
-{
-	**tail = ref;
-	*tail = &ref->next;
-	**tail = NULL;
-}
-
-static struct ref *try_explicit_object_name(const char *name)
-{
-	unsigned char sha1[20];
-	struct ref *ref;
-	int len;
-
-	if (!*name) {
-		ref = xcalloc(1, sizeof(*ref) + 20);
-		strcpy(ref->name, "(delete)");
-		hashclr(ref->new_sha1);
-		return ref;
-	}
-	if (get_sha1(name, sha1))
-		return NULL;
-	len = strlen(name) + 1;
-	ref = xcalloc(1, sizeof(*ref) + len);
-	memcpy(ref->name, name, len);
-	hashcpy(ref->new_sha1, sha1);
-	return ref;
-}
-
-static int match_explicit_refs(struct ref *src, struct ref *dst,
-			       struct ref ***dst_tail, struct refspec *rs)
-{
-	int i, errs;
-	for (i = errs = 0; rs[i].src; i++) {
-		struct ref *matched_src, *matched_dst;
-
-		matched_src = matched_dst = NULL;
-		switch (count_refspec_match(rs[i].src, src, &matched_src)) {
-		case 1:
-			break;
-		case 0:
-			/* The source could be in the get_sha1() format
-			 * not a reference name.  :refs/other is a
-			 * way to delete 'other' ref at the remote end.
-			 */
-			matched_src = try_explicit_object_name(rs[i].src);
-			if (matched_src)
-				break;
-			errs = 1;
-			error("src refspec %s does not match any.",
-			      rs[i].src);
-			break;
-		default:
-			errs = 1;
-			error("src refspec %s matches more than one.",
-			      rs[i].src);
-			break;
-		}
-		switch (count_refspec_match(rs[i].dst, dst, &matched_dst)) {
-		case 1:
-			break;
-		case 0:
-			if (!memcmp(rs[i].dst, "refs/", 5)) {
-				int len = strlen(rs[i].dst) + 1;
-				matched_dst = xcalloc(1, sizeof(*dst) + len);
-				memcpy(matched_dst->name, rs[i].dst, len);
-				link_dst_tail(matched_dst, dst_tail);
-			}
-			else if (!strcmp(rs[i].src, rs[i].dst) &&
-				 matched_src) {
-				/* pushing "master:master" when
-				 * remote does not have master yet.
-				 */
-				int len = strlen(matched_src->name) + 1;
-				matched_dst = xcalloc(1, sizeof(*dst) + len);
-				memcpy(matched_dst->name, matched_src->name,
-				       len);
-				link_dst_tail(matched_dst, dst_tail);
-			}
-			else {
-				errs = 1;
-				error("dst refspec %s does not match any "
-				      "existing ref on the remote and does "
-				      "not start with refs/.", rs[i].dst);
-			}
-			break;
-		default:
-			errs = 1;
-			error("dst refspec %s matches more than one.",
-			      rs[i].dst);
-			break;
-		}
-		if (errs)
-			continue;
-		if (matched_dst->peer_ref) {
-			errs = 1;
-			error("dst ref %s receives from more than one src.",
-			      matched_dst->name);
-		}
-		else {
-			matched_dst->peer_ref = matched_src;
-			matched_dst->force = rs[i].force;
-		}
-	}
-	return -errs;
-}
-
-static struct ref *find_ref_by_name(struct ref *list, const char *name)
-{
-	for ( ; list; list = list->next)
-		if (!strcmp(list->name, name))
-			return list;
-	return NULL;
-}
-
-int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
-	       int nr_refspec, char **refspec, int all)
-{
-	struct refspec *rs = parse_ref_spec(nr_refspec, refspec);
-
-	if (nr_refspec)
-		return match_explicit_refs(src, dst, dst_tail, rs);
-
-	/* pick the remainder */
-	for ( ; src; src = src->next) {
-		struct ref *dst_peer;
-		if (src->peer_ref)
-			continue;
-		dst_peer = find_ref_by_name(dst, src->name);
-		if ((dst_peer && dst_peer->peer_ref) || (!dst_peer && !all))
-			continue;
-		if (!dst_peer) {
-			/* Create a new one and link it */
-			int len = strlen(src->name) + 1;
-			dst_peer = xcalloc(1, sizeof(*dst_peer) + len);
-			memcpy(dst_peer->name, src->name, len);
-			hashcpy(dst_peer->new_sha1, src->new_sha1);
-			link_dst_tail(dst_peer, dst_tail);
-		}
-		dst_peer->peer_ref = src;
-	}
-	return 0;
-}
-
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_SSH,
diff --git a/http-push.c b/http-push.c
index e3f7675..79d2c38 100644
--- a/http-push.c
+++ b/http-push.c
@@ -9,6 +9,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "exec_cmd.h"
+#include "remote.h"
 
 #include <expat.h>
 
diff --git a/remote.c b/remote.c
index dbcc74e..1deada1 100644
--- a/remote.c
+++ b/remote.c
@@ -182,6 +182,44 @@ static void read_config(void)
 	git_config(handle_config);
 }
 
+static struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
+{
+	int i;
+	struct refspec *rs = xcalloc(sizeof(*rs), nr_refspec);
+	for (i = 0; i < nr_refspec; i++) {
+		const char *sp, *ep, *gp;
+		sp = refspec[i];
+		if (*sp == '+') {
+			rs[i].force = 1;
+			sp++;
+		}
+		gp = strchr(sp, '*');
+		ep = strchr(sp, ':');
+		if (gp && ep && gp > ep)
+			gp = NULL;
+		if (ep) {
+			if (ep[1]) {
+				const char *glob = strchr(ep + 1, '*');
+				if (!glob)
+					gp = NULL;
+				if (gp)
+					rs[i].dst = xstrndup(ep + 1,
+							     glob - ep - 1);
+				else
+					rs[i].dst = xstrdup(ep + 1);
+			}
+		} else {
+			ep = sp + strlen(sp);
+		}
+		if (gp) {
+			rs[i].pattern = 1;
+			ep = gp;
+		}
+		rs[i].src = xstrndup(sp, ep - sp);
+	}
+	return rs;
+}
+
 struct remote *remote_get(const char *name)
 {
 	struct remote *ret;
@@ -200,5 +238,213 @@ struct remote *remote_get(const char *name)
 		add_uri(ret, name);
 	if (!ret->uri)
 		return NULL;
+	ret->push = parse_ref_spec(ret->push_refspec_nr, ret->push_refspec);
 	return ret;
 }
+
+static int count_refspec_match(const char *pattern,
+			       struct ref *refs,
+			       struct ref **matched_ref)
+{
+	int patlen = strlen(pattern);
+	struct ref *matched_weak = NULL;
+	struct ref *matched = NULL;
+	int weak_match = 0;
+	int match = 0;
+
+	for (weak_match = match = 0; refs; refs = refs->next) {
+		char *name = refs->name;
+		int namelen = strlen(name);
+		int weak_match;
+
+		if (namelen < patlen ||
+		    memcmp(name + namelen - patlen, pattern, patlen))
+			continue;
+		if (namelen != patlen && name[namelen - patlen - 1] != '/')
+			continue;
+
+		/* A match is "weak" if it is with refs outside
+		 * heads or tags, and did not specify the pattern
+		 * in full (e.g. "refs/remotes/origin/master") or at
+		 * least from the toplevel (e.g. "remotes/origin/master");
+		 * otherwise "git push $URL master" would result in
+		 * ambiguity between remotes/origin/master and heads/master
+		 * at the remote site.
+		 */
+		if (namelen != patlen &&
+		    patlen != namelen - 5 &&
+		    prefixcmp(name, "refs/heads/") &&
+		    prefixcmp(name, "refs/tags/")) {
+			/* We want to catch the case where only weak
+			 * matches are found and there are multiple
+			 * matches, and where more than one strong
+			 * matches are found, as ambiguous.  One
+			 * strong match with zero or more weak matches
+			 * are acceptable as a unique match.
+			 */
+			matched_weak = refs;
+			weak_match++;
+		}
+		else {
+			matched = refs;
+			match++;
+		}
+	}
+	if (!matched) {
+		*matched_ref = matched_weak;
+		return weak_match;
+	}
+	else {
+		*matched_ref = matched;
+		return match;
+	}
+}
+
+static void link_dst_tail(struct ref *ref, struct ref ***tail)
+{
+	**tail = ref;
+	*tail = &ref->next;
+	**tail = NULL;
+}
+
+static struct ref *try_explicit_object_name(const char *name)
+{
+	unsigned char sha1[20];
+	struct ref *ref;
+	int len;
+
+	if (!*name) {
+		ref = xcalloc(1, sizeof(*ref) + 20);
+		strcpy(ref->name, "(delete)");
+		hashclr(ref->new_sha1);
+		return ref;
+	}
+	if (get_sha1(name, sha1))
+		return NULL;
+	len = strlen(name) + 1;
+	ref = xcalloc(1, sizeof(*ref) + len);
+	memcpy(ref->name, name, len);
+	hashcpy(ref->new_sha1, sha1);
+	return ref;
+}
+
+static int match_explicit_refs(struct ref *src, struct ref *dst,
+			       struct ref ***dst_tail, struct refspec *rs,
+			       int rs_nr)
+{
+	int i, errs;
+	for (i = errs = 0; i < rs_nr; i++) {
+		struct ref *matched_src, *matched_dst;
+
+		const char *dst_value = rs[i].dst;
+		if (dst_value == NULL)
+			dst_value = rs[i].src;
+
+		matched_src = matched_dst = NULL;
+		switch (count_refspec_match(rs[i].src, src, &matched_src)) {
+		case 1:
+			break;
+		case 0:
+			/* The source could be in the get_sha1() format
+			 * not a reference name.  :refs/other is a
+			 * way to delete 'other' ref at the remote end.
+			 */
+			matched_src = try_explicit_object_name(rs[i].src);
+			if (matched_src)
+				break;
+			errs = 1;
+			error("src refspec %s does not match any.",
+			      rs[i].src);
+			break;
+		default:
+			errs = 1;
+			error("src refspec %s matches more than one.",
+			      rs[i].src);
+			break;
+		}
+		switch (count_refspec_match(dst_value, dst, &matched_dst)) {
+		case 1:
+			break;
+		case 0:
+			if (!memcmp(dst_value, "refs/", 5)) {
+				int len = strlen(dst_value) + 1;
+				matched_dst = xcalloc(1, sizeof(*dst) + len);
+				memcpy(matched_dst->name, dst_value, len);
+				link_dst_tail(matched_dst, dst_tail);
+			}
+			else if (!strcmp(rs[i].src, dst_value) &&
+				 matched_src) {
+				/* pushing "master:master" when
+				 * remote does not have master yet.
+				 */
+				int len = strlen(matched_src->name) + 1;
+				matched_dst = xcalloc(1, sizeof(*dst) + len);
+				memcpy(matched_dst->name, matched_src->name,
+				       len);
+				link_dst_tail(matched_dst, dst_tail);
+			}
+			else {
+				errs = 1;
+				error("dst refspec %s does not match any "
+				      "existing ref on the remote and does "
+				      "not start with refs/.", dst_value);
+			}
+			break;
+		default:
+			errs = 1;
+			error("dst refspec %s matches more than one.",
+			      dst_value);
+			break;
+		}
+		if (errs)
+			continue;
+		if (matched_dst->peer_ref) {
+			errs = 1;
+			error("dst ref %s receives from more than one src.",
+			      matched_dst->name);
+		}
+		else {
+			matched_dst->peer_ref = matched_src;
+			matched_dst->force = rs[i].force;
+		}
+	}
+	return -errs;
+}
+
+static struct ref *find_ref_by_name(struct ref *list, const char *name)
+{
+	for ( ; list; list = list->next)
+		if (!strcmp(list->name, name))
+			return list;
+	return NULL;
+}
+
+int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
+	       int nr_refspec, char **refspec, int all)
+{
+	struct refspec *rs =
+		parse_ref_spec(nr_refspec, (const char **) refspec);
+
+	if (nr_refspec)
+		return match_explicit_refs(src, dst, dst_tail, rs, nr_refspec);
+
+	/* pick the remainder */
+	for ( ; src; src = src->next) {
+		struct ref *dst_peer;
+		if (src->peer_ref)
+			continue;
+		dst_peer = find_ref_by_name(dst, src->name);
+		if ((dst_peer && dst_peer->peer_ref) || (!dst_peer && !all))
+			continue;
+		if (!dst_peer) {
+			/* Create a new one and link it */
+			int len = strlen(src->name) + 1;
+			dst_peer = xcalloc(1, sizeof(*dst_peer) + len);
+			memcpy(dst_peer->name, src->name, len);
+			hashcpy(dst_peer->new_sha1, src->new_sha1);
+			link_dst_tail(dst_peer, dst_tail);
+		}
+		dst_peer->peer_ref = src;
+	}
+	return 0;
+}
diff --git a/remote.h b/remote.h
index 73747a8..3bc035b 100644
--- a/remote.h
+++ b/remote.h
@@ -8,6 +8,7 @@ struct remote {
 	int uri_nr;
 
 	const char **push_refspec;
+	struct refspec *push;
 	int push_refspec_nr;
 
 	const char *receivepack;
@@ -15,4 +16,15 @@ struct remote {
 
 struct remote *remote_get(const char *name);
 
+struct refspec {
+	unsigned force : 1;
+	unsigned pattern : 1;
+
+	const char *src;
+	char *dst;
+};
+
+int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
+	       int nr_refspec, char **refspec, int all);
+
 #endif
diff --git a/send-pack.c b/send-pack.c
index d5b5162..6851043 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "pkt-line.h"
 #include "run-command.h"
+#include "remote.h"
 
 static const char send_pack_usage[] =
 "git-send-pack [--all] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
-- 
1.5.2.rc2.45.g3d9b43-dirty
