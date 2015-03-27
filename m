From: Jeff King <peff@peff.net>
Subject: [PATCH] reachable: only mark local objects as recent
Date: Fri, 27 Mar 2015 07:32:41 -0400
Message-ID: <20150327113240.GA7781@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 12:32:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbSVP-0004JN-Ns
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 12:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbbC0Lcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 07:32:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:39052 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752226AbbC0Lcp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 07:32:45 -0400
Received: (qmail 12456 invoked by uid 102); 27 Mar 2015 11:32:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Mar 2015 06:32:44 -0500
Received: (qmail 31269 invoked by uid 107); 27 Mar 2015 11:32:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Mar 2015 07:32:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Mar 2015 07:32:41 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266370>

When pruning and repacking a repository that has an
alternate object store configured, we may traverse a large
number of objects in the alternate. This serves no purpose,
and may be expensive to do. A longer explanation is below.

Commits d3038d2 and abcb865 taught prune and pack-objects
(respectively) to treat "recent" objects as tips for
reachability, so that we keep whole chunks of history. They
built on the object traversal in 660c889 (sha1_file: add
for_each iterators for loose and packed objects,
2014-10-15), which covers both local and alternate objects.

In both cases, covering alternate objects is unnecessary, as
both commands can only drop objects from the local
repository. In the case of prune, we traverse only the local
object directory. And in the case of repacking, while we may
or may not include local objects in our pack, we will never
reach into the alternate with "repack -d". The "-l" option
is only a question of whether we are migrating objects from
the alternate into our repository, or leaving them
untouched.

It is possible that we may drop an object that is depended
upon by another object in the alternate. For example,
imagine two repositories, A and B, with A pointing to B as
an alternate. Now imagine a commit that is in B which
references a tree that is only in A. Traversing from recent
objects in B might prevent A from dropping that tree. But
this case isn't worth covering. Repo B should take
responsibility for its own objects. It would never have had
the commit in the first place if it did not also have the
tree, and assuming it is using the same "keep recent chunks
of history" scheme, then it would itself keep the tree, as
well.

So checking the alternate objects is not worth doing, and
come with a significant performance impact. In both cases,
we skip any recent objects that have already been marked
SEEN (i.e., that we know are already reachable for prune, or
included in the pack for a repack). So there is a slight
waste of time in opening the alternate packs at all, only to
notice that we have already considered each object. But much
worse, the alternate repository may have a large number of
objects that are not reachable from the local repository at
all, and we end up adding them to the traversal.

We can fix this by considering only local unseen objects.

Signed-off-by: Jeff King <peff@peff.net>
---
The problem presumably started in v2.2.0, so this is not a high-priority
regression for 2.4.0-rc0. Certainly I encountered some cases in the wild
that have a very serious slowdown (e.g., going from a few seconds to
several minutes), but those were rather pathological and related to the
way we use alternates at GitHub. So definitely worth fixing, but I'm not
sure if anybody is as strongly affected as GitHub was.

Also, a keen observer may notice in the code below that all callers pass
the new LOCAL_ONLY flag. So it would also be fine to just change the
semantics of for_each_loose_object and for_each_packed_object. What I
have here is more flexible, but I don't know if that flexibility would
ever be useful or not.

 cache.h     | 8 +++++---
 reachable.c | 6 ++++--
 sha1_file.c | 9 +++++++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 3d3244b..2391c9f 100644
--- a/cache.h
+++ b/cache.h
@@ -1289,14 +1289,16 @@ int for_each_loose_file_in_objdir_buf(struct strbuf *path,
 
 /*
  * Iterate over loose and packed objects in both the local
- * repository and any alternates repositories.
+ * repository and any alternates repositories (unless the
+ * LOCAL_ONLY flag is set).
  */
+#define FOR_EACH_OBJECT_LOCAL_ONLY 0x1
 typedef int each_packed_object_fn(const unsigned char *sha1,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
-extern int for_each_loose_object(each_loose_object_fn, void *);
-extern int for_each_packed_object(each_packed_object_fn, void *);
+extern int for_each_loose_object(each_loose_object_fn, void *, unsigned flags);
+extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
 struct object_info {
 	/* Request */
diff --git a/reachable.c b/reachable.c
index a647267..69fa685 100644
--- a/reachable.c
+++ b/reachable.c
@@ -142,10 +142,12 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 	data.revs = revs;
 	data.timestamp = timestamp;
 
-	r = for_each_loose_object(add_recent_loose, &data);
+	r = for_each_loose_object(add_recent_loose, &data,
+				  FOR_EACH_OBJECT_LOCAL_ONLY);
 	if (r)
 		return r;
-	return for_each_packed_object(add_recent_packed, &data);
+	return for_each_packed_object(add_recent_packed, &data,
+				      FOR_EACH_OBJECT_LOCAL_ONLY);
 }
 
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
diff --git a/sha1_file.c b/sha1_file.c
index 88f06ba..3e34eb5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3418,7 +3418,7 @@ static int loose_from_alt_odb(struct alternate_object_database *alt,
 	return r;
 }
 
-int for_each_loose_object(each_loose_object_fn cb, void *data)
+int for_each_loose_object(each_loose_object_fn cb, void *data, unsigned flags)
 {
 	struct loose_alt_odb_data alt;
 	int r;
@@ -3428,6 +3428,9 @@ int for_each_loose_object(each_loose_object_fn cb, void *data)
 	if (r)
 		return r;
 
+	if (flags & FOR_EACH_OBJECT_LOCAL_ONLY)
+		return 0;
+
 	alt.cb = cb;
 	alt.data = data;
 	return foreach_alt_odb(loose_from_alt_odb, &alt);
@@ -3452,13 +3455,15 @@ static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn c
 	return r;
 }
 
-int for_each_packed_object(each_packed_object_fn cb, void *data)
+int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 {
 	struct packed_git *p;
 	int r = 0;
 
 	prepare_packed_git();
 	for (p = packed_git; p; p = p->next) {
+		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+			continue;
 		r = for_each_object_in_pack(p, cb, data);
 		if (r)
 			break;
-- 
2.4.0.rc0.327.g6ec0264
