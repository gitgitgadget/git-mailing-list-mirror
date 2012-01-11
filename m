From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] get_sha1_with_context: report features used in resolution
Date: Wed, 11 Jan 2012 14:42:10 -0500
Message-ID: <20120111194210.GA12441@sigill.intra.peff.net>
References: <20120111193916.GA12333@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:42:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl43v-0000Rd-09
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 20:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab2AKTmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 14:42:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35293
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755907Ab2AKTmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 14:42:13 -0500
Received: (qmail 22686 invoked by uid 107); 11 Jan 2012 19:49:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jan 2012 14:49:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2012 14:42:10 -0500
Content-Disposition: inline
In-Reply-To: <20120111193916.GA12333@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188386>

Most callers generally treat get_sha1 as a black box, giving
it a string from the user and expecting to get a sha1 in
return. The get_sha1_with_context function gives callers
more information about what happened while resolving the
object name so they can make better decisions about how to
use the result. We currently use this only to provide
information about the path entry used to find a blob.

We don't currently provide any information about the
resolution rules that were used to reach the final object.
Some callers may want these in order to enforce a policy
that a particular subset of the lookup rules are used (e.g.,
when serving remote requests).

This patch adds a set of bit-fields that document the use of
particular features during an object lookup.

Signed-off-by: Jeff King <peff@peff.net>
---
The diffstat looks a little scary, but it is mostly just the internal
get_sha1 functions learning to pass the object_context around.

 cache.h     |    7 +++++
 sha1_name.c |   73 +++++++++++++++++++++++++++++++++++++---------------------
 2 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/cache.h b/cache.h
index 10afd71..ac25a37 100644
--- a/cache.h
+++ b/cache.h
@@ -809,6 +809,13 @@ struct object_context {
 	unsigned char tree[20];
 	char path[PATH_MAX];
 	unsigned mode;
+	unsigned used_ref:1,
+		 used_reflog:1,
+		 used_index:1,
+		 used_nth_checkout:1,
+		 used_describe_name:1,
+		 used_oneline:1,
+		 used_raw_hex:1;
 };
 
 extern int get_sha1(const char *str, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index 03ffc2c..ad7c52a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -7,7 +7,8 @@
 #include "refs.h"
 #include "remote.h"
 
-static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
+static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *,
+			    struct object_context *);
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -158,7 +159,7 @@ static int find_unique_short_object(int len, char *canonical,
 }
 
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
-			  int quietly)
+			  int quietly, struct object_context *oc)
 {
 	int i, status;
 	char canonical[40];
@@ -190,6 +191,8 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	status = find_unique_short_object(i, canonical, res, sha1);
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
 		return error("short SHA1 %.*s is ambiguous.", len, canonical);
+	if (!status)
+		oc->used_raw_hex = 1;
 	return status;
 }
 
@@ -204,7 +207,8 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
-		status = get_short_sha1(hex, len, sha1_ret, 1);
+		struct object_context unused;
+		status = get_short_sha1(hex, len, sha1_ret, 1, &unused);
 		if (exists
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
@@ -255,17 +259,21 @@ static inline int upstream_mark(const char *string, int len)
 	return 0;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1);
+static int get_sha1_1(const char *name, int len, unsigned char *sha1,
+		      struct object_context *oc);
 
-static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
+static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
+			  struct object_context *oc)
 {
 	static const char *warn_msg = "refname '%.*s' is ambiguous.";
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len;
 
-	if (len == 40 && !get_sha1_hex(str, sha1))
+	if (len == 40 && !get_sha1_hex(str, sha1)) {
+		oc->used_raw_hex = 1;
 		return 0;
+	}
 
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len = at = 0;
@@ -292,7 +300,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		ret = interpret_branch_name(str+at, &buf);
 		if (ret > 0) {
 			/* substitute this branch name and restart */
-			return get_sha1_1(buf.buf, buf.len, sha1);
+			oc->used_nth_checkout = 1;
+			return get_sha1_1(buf.buf, buf.len, sha1, oc);
 		} else if (ret == 0) {
 			return -1;
 		}
@@ -305,6 +314,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 
 	if (!refs_found)
 		return -1;
+	oc->used_ref = 1;
 
 	if (warn_ambiguous_refs && refs_found > 1)
 		warning(warn_msg, len, str);
@@ -352,6 +362,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 				    len, str, co_cnt);
 			}
 		}
+		oc->used_reflog = 1;
 	}
 
 	free(real_ref);
@@ -359,10 +370,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 }
 
 static int get_parent(const char *name, int len,
-		      unsigned char *result, int idx)
+		      unsigned char *result, int idx,
+		      struct object_context *oc)
 {
 	unsigned char sha1[20];
-	int ret = get_sha1_1(name, len, sha1);
+	int ret = get_sha1_1(name, len, sha1, oc);
 	struct commit *commit;
 	struct commit_list *p;
 
@@ -389,13 +401,14 @@ static int get_parent(const char *name, int len,
 }
 
 static int get_nth_ancestor(const char *name, int len,
-			    unsigned char *result, int generation)
+			    unsigned char *result, int generation,
+			    struct object_context *oc)
 {
 	unsigned char sha1[20];
 	struct commit *commit;
 	int ret;
 
-	ret = get_sha1_1(name, len, sha1);
+	ret = get_sha1_1(name, len, sha1, oc);
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(sha1);
@@ -436,7 +449,8 @@ struct object *peel_to_type(const char *name, int namelen,
 	}
 }
 
-static int peel_onion(const char *name, int len, unsigned char *sha1)
+static int peel_onion(const char *name, int len, unsigned char *sha1,
+		      struct object_context *oc)
 {
 	unsigned char outer[20];
 	const char *sp;
@@ -476,7 +490,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	else
 		return -1;
 
-	if (get_sha1_1(name, sp - name - 2, outer))
+	if (get_sha1_1(name, sp - name - 2, outer, oc))
 		return -1;
 
 	o = parse_object(outer);
@@ -515,14 +529,15 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 
 		prefix = xstrndup(sp + 1, name + len - 1 - (sp + 1));
 		commit_list_insert((struct commit *)o, &list);
-		ret = get_sha1_oneline(prefix, sha1, list);
+		ret = get_sha1_oneline(prefix, sha1, list, oc);
 		free(prefix);
 		return ret;
 	}
 	return 0;
 }
 
-static int get_describe_name(const char *name, int len, unsigned char *sha1)
+static int get_describe_name(const char *name, int len, unsigned char *sha1,
+			     struct object_context *oc)
 {
 	const char *cp;
 
@@ -535,14 +550,15 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_sha1(cp, len, sha1, 1);
+				return get_short_sha1(cp, len, sha1, 1, oc);
 			}
 		}
 	}
 	return -1;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1)
+static int get_sha1_1(const char *name, int len, unsigned char *sha1,
+		      struct object_context *oc)
 {
 	int ret, has_suffix;
 	const char *cp;
@@ -569,25 +585,25 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 		if (!num && len1 == len - 1)
 			num = 1;
 		if (has_suffix == '^')
-			return get_parent(name, len1, sha1, num);
+			return get_parent(name, len1, sha1, num, oc);
 		/* else if (has_suffix == '~') -- goes without saying */
-		return get_nth_ancestor(name, len1, sha1, num);
+		return get_nth_ancestor(name, len1, sha1, num, oc);
 	}
 
-	ret = peel_onion(name, len, sha1);
+	ret = peel_onion(name, len, sha1, oc);
 	if (!ret)
 		return 0;
 
-	ret = get_sha1_basic(name, len, sha1);
+	ret = get_sha1_basic(name, len, sha1, oc);
 	if (!ret)
 		return 0;
 
 	/* It could be describe output that is "SOMETHING-gXXXX" */
-	ret = get_describe_name(name, len, sha1);
+	ret = get_describe_name(name, len, sha1, oc);
 	if (!ret)
 		return 0;
 
-	return get_short_sha1(name, len, sha1, 0);
+	return get_short_sha1(name, len, sha1, 0, oc);
 }
 
 /*
@@ -619,7 +635,8 @@ static int handle_one_ref(const char *path,
 }
 
 static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
-			    struct commit_list *list)
+			    struct commit_list *list,
+			    struct object_context *oc)
 {
 	struct commit_list *backup = NULL, *l;
 	int found = 0;
@@ -672,6 +689,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 	for (l = backup; l; l = l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
 	free_commit_list(backup);
+	oc->used_oneline = found;
 	return found ? 0 : -1;
 }
 
@@ -1029,7 +1047,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
-	ret = get_sha1_1(name, namelen, sha1);
+	ret = get_sha1_1(name, namelen, sha1, oc);
 	if (!ret)
 		return ret;
 	/* sha1:path --> object name of path in ent sha1
@@ -1046,7 +1064,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 		if (!only_to_die && namelen > 2 && name[1] == '/') {
 			struct commit_list *list = NULL;
 			for_each_ref(handle_one_ref, &list);
-			return get_sha1_oneline(name + 2, sha1, list);
+			return get_sha1_oneline(name + 2, sha1, list, oc);
 		}
 		if (namelen < 3 ||
 		    name[2] != ':' ||
@@ -1081,6 +1099,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			if (ce_stage(ce) == stage) {
 				hashcpy(sha1, ce->sha1);
 				oc->mode = ce->ce_mode;
+				oc->used_index = 1;
 				free(new_path);
 				return 0;
 			}
@@ -1107,7 +1126,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			strncpy(object_name, name, cp-name);
 			object_name[cp-name] = '\0';
 		}
-		if (!get_sha1_1(name, cp-name, tree_sha1)) {
+		if (!get_sha1_1(name, cp-name, tree_sha1, oc)) {
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
-- 
1.7.9.rc0.33.gd3c17
