From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Move refspec pattern matching to match_refs().
Date: Fri, 25 May 2007 01:20:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705250111200.9778@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 07:21:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrSEb-0002ku-Ir
	for gcvg-git@gmane.org; Fri, 25 May 2007 07:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbXEYFU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 01:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbXEYFU6
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 01:20:58 -0400
Received: from iabervon.org ([66.92.72.58]:3779 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbXEYFU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 01:20:57 -0400
Received: (qmail 31879 invoked by uid 1000); 25 May 2007 05:20:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 May 2007 05:20:56 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48342>

This means that send-pack and http-push will support pattern refspecs,
so builtin-push.c doesn't have to expand them, and also git push can
just turn --tags into "refs/tags/*", further simplifying
builtin-push.c

check_ref_format() gets a third "conditionally okay" result for
something that's valid as a pattern but not as a particular ref.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
On top of my "remote" series. Shouldn't change any significant behavior, 
and simplifies a lot of logic. This version takes into account the 
comments from the previous round (assuming that the ruling on coding style 
is that:

if (condition)
	/* Comment */
	statement;

shouldn't have braces).

 builtin-push.c |  133 +++++++++----------------------------------------------
 refs.c         |   27 ++++++++---
 remote.c       |   31 ++++++++++++-
 send-pack.c    |    1 +
 4 files changed, 70 insertions(+), 122 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 6084899..2612f07 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -9,7 +9,7 @@
 
 static const char push_usage[] = "git-push [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
 
-static int all, tags, force, thin = 1, verbose;
+static int all, force, thin = 1, verbose;
 static const char *receivepack;
 
 static const char **refspec;
@@ -23,114 +23,24 @@ static void add_refspec(const char *ref)
 	refspec_nr = nr;
 }
 
-static int expand_one_ref(const char *ref, const unsigned char *sha1, int flag, void *cb_data)
-{
-	/* Ignore the "refs/" at the beginning of the refname */
-	ref += 5;
-
-	if (!prefixcmp(ref, "tags/"))
-		add_refspec(xstrdup(ref));
-	return 0;
-}
-
-static void expand_refspecs(void)
-{
-	if (all) {
-		if (refspec_nr)
-			die("cannot mix '--all' and a refspec");
-
-		/*
-		 * No need to expand "--all" - we'll just use
-		 * the "--all" flag to send-pack
-		 */
-		return;
-	}
-	if (!tags)
-		return;
-	for_each_ref(expand_one_ref, NULL);
-}
-
-struct wildcard_cb {
-	const char *from_prefix;
-	int from_prefix_len;
-	const char *to_prefix;
-	int to_prefix_len;
-	int force;
-};
-
-static int expand_wildcard_ref(const char *ref, const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct wildcard_cb *cb = cb_data;
-	int len = strlen(ref);
-	char *expanded, *newref;
-
-	if (len < cb->from_prefix_len ||
-	    memcmp(cb->from_prefix, ref, cb->from_prefix_len))
-		return 0;
-	expanded = xmalloc(len * 2 + cb->force +
-			   (cb->to_prefix_len - cb->from_prefix_len) + 2);
-	newref = expanded + cb->force;
-	if (cb->force)
-		expanded[0] = '+';
-	memcpy(newref, ref, len);
-	newref[len] = ':';
-	memcpy(newref + len + 1, cb->to_prefix, cb->to_prefix_len);
-	strcpy(newref + len + 1 + cb->to_prefix_len,
-	       ref + cb->from_prefix_len);
-	add_refspec(expanded);
-	return 0;
-}
-
-static int wildcard_ref(const char *ref)
-{
-	int len;
-	const char *colon;
-	struct wildcard_cb cb;
-
-	memset(&cb, 0, sizeof(cb));
-	if (ref[0] == '+') {
-		cb.force = 1;
-		ref++;
-	}
-	len = strlen(ref);
-	colon = strchr(ref, ':');
-	if (! (colon && ref < colon &&
-	       colon[-2] == '/' && colon[-1] == '*' &&
-	       /* "<mine>/<asterisk>:<yours>/<asterisk>" is at least 7 bytes */
-	       7 <= len &&
-	       ref[len-2] == '/' && ref[len-1] == '*') )
-		return 0 ;
-	cb.from_prefix = ref;
-	cb.from_prefix_len = colon - ref - 1;
-	cb.to_prefix = colon + 1;
-	cb.to_prefix_len = len - (colon - ref) - 2;
-	for_each_ref(expand_wildcard_ref, &cb);
-	return 1;
-}
-
 static void set_refspecs(const char **refs, int nr)
 {
-	if (nr) {
-		int i;
-		for (i = 0; i < nr; i++) {
-			const char *ref = refs[i];
-			if (!strcmp("tag", ref)) {
-				char *tag;
-				int len;
-				if (nr <= ++i)
-					die("tag shorthand without <tag>");
-				len = strlen(refs[i]) + 11;
-				tag = xmalloc(len);
-				strcpy(tag, "refs/tags/");
-				strcat(tag, refs[i]);
-				ref = tag;
-			}
-			else if (wildcard_ref(ref))
-				continue;
-			add_refspec(ref);
+	int i;
+	for (i = 0; i < nr; i++) {
+		const char *ref = refs[i];
+		if (!strcmp("tag", ref)) {
+			char *tag;
+			int len;
+			if (nr <= ++i)
+				die("tag shorthand without <tag>");
+			len = strlen(refs[i]) + 11;
+			tag = xmalloc(len);
+			strcpy(tag, "refs/tags/");
+			strcat(tag, refs[i]);
+			ref = tag;
 		}
+		add_refspec(ref);
 	}
-	expand_refspecs();
 }
 
 static int do_push(const char *repo)
@@ -149,11 +59,9 @@ static int do_push(const char *repo)
 		sprintf(rp, "--receive-pack=%s", remote->receivepack);
 		receivepack = rp;
 	}
-	if (!refspec && !all && !tags && remote->push_refspec_nr) {
-		for (i = 0; i < remote->push_refspec_nr; i++) {
-			if (!wildcard_ref(remote->push_refspec[i]))
-				add_refspec(remote->push_refspec[i]);
-		}
+	if (!refspec && !all && remote->push_refspec_nr) {
+		refspec = remote->push_refspec;
+		refspec_nr = remote->push_refspec_nr;
 	}
 
 	argv = xmalloc((refspec_nr + 10) * sizeof(char *));
@@ -240,7 +148,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--tags")) {
-			tags = 1;
+			add_refspec("refs/tags/*");
 			continue;
 		}
 		if (!strcmp(arg, "--force") || !strcmp(arg, "-f")) {
@@ -266,5 +174,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		usage(push_usage);
 	}
 	set_refspecs(argv + i, argc - i);
+	if (all && refspec)
+		usage(push_usage);
+
 	return do_push(repo);
 }
diff --git a/refs.c b/refs.c
index 2ae3235..ef4484d 100644
--- a/refs.c
+++ b/refs.c
@@ -603,15 +603,20 @@ int get_ref_sha1(const char *ref, unsigned char *sha1)
 
 static inline int bad_ref_char(int ch)
 {
-	return (((unsigned) ch) <= ' ' ||
-		ch == '~' || ch == '^' || ch == ':' ||
-		/* 2.13 Pattern Matching Notation */
-		ch == '?' || ch == '*' || ch == '[');
+	if (((unsigned) ch) <= ' ' ||
+	    ch == '~' || ch == '^' || ch == ':')
+		return 1;
+	/* 2.13 Pattern Matching Notation */
+	if (ch == '?' || ch == '[') /* Unsupported */
+		return 1;
+	if (ch == '*') /* Supported at the end */
+		return 2;
+	return 0;
 }
 
 int check_ref_format(const char *ref)
 {
-	int ch, level;
+	int ch, level, bad_type;
 	const char *cp = ref;
 
 	level = 0;
@@ -622,13 +627,19 @@ int check_ref_format(const char *ref)
 			return -1; /* should not end with slashes */
 
 		/* we are at the beginning of the path component */
-		if (ch == '.' || bad_ref_char(ch))
+		if (ch == '.')
 			return -1;
+		bad_type = bad_ref_char(ch);
+		if (bad_type) {
+			return (bad_type == 2 && !*cp) ? -3 : -1;
+		}
 
 		/* scan the rest of the path component */
 		while ((ch = *cp++) != 0) {
-			if (bad_ref_char(ch))
-				return -1;
+			bad_type = bad_ref_char(ch);
+			if (bad_type) {
+				return (bad_type == 2 && !*cp) ? -3 : -1;
+			}
 			if (ch == '/')
 				break;
 			if (ch == '.' && *cp == '.')
diff --git a/remote.c b/remote.c
index 46fe8d9..d904616 100644
--- a/remote.c
+++ b/remote.c
@@ -415,6 +415,10 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 		struct ref *matched_src, *matched_dst;
 
 		const char *dst_value = rs[i].dst;
+
+		if (rs[i].pattern)
+			continue;
+
 		if (dst_value == NULL)
 			dst_value = rs[i].src;
 
@@ -497,22 +501,43 @@ static struct ref *find_ref_by_name(struct ref *list, const char *name)
 	return NULL;
 }
 
+static int check_pattern_match(struct refspec *rs, int rs_nr, struct ref *src)
+{
+	int i;
+	if (!rs_nr)
+		return 1;
+	for (i = 0; i < rs_nr; i++) {
+		if (rs[i].pattern && !prefixcmp(src->name, rs[i].src))
+			return 1;
+	}
+	return 0;
+}
+
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, char **refspec, int all)
 {
 	struct refspec *rs =
 		parse_ref_spec(nr_refspec, (const char **) refspec);
 
-	if (nr_refspec)
-		return match_explicit_refs(src, dst, dst_tail, rs, nr_refspec);
+	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
+		return -1;
 
 	/* pick the remainder */
 	for ( ; src; src = src->next) {
 		struct ref *dst_peer;
 		if (src->peer_ref)
 			continue;
+		if (!check_pattern_match(rs, nr_refspec, src))
+			continue;
+
 		dst_peer = find_ref_by_name(dst, src->name);
-		if ((dst_peer && dst_peer->peer_ref) || (!dst_peer && !all))
+		if (dst_peer && dst_peer->peer_ref)
+			/* We're already sending something to this ref. */
+			continue;
+		if (!dst_peer && !nr_refspec && !all)
+			/* Remote doesn't have it, and we have no
+			 * explicit pattern, and we don't have
+			 * --all. */
 			continue;
 		if (!dst_peer) {
 			/* Create a new one and link it */
diff --git a/send-pack.c b/send-pack.c
index 59352c8..697dbbc 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -354,6 +354,7 @@ static void verify_remote_names(int nr_heads, char **heads)
 		case -2: /* ok but a single level -- that is fine for
 			  * a match pattern.
 			  */
+		case -3: /* ok but ends with a pattern-match character */
 			continue;
 		}
 		die("remote part of refspec is not a valid name in %s",
-- 
1.5.2.rc2.90.gc593-dirty
