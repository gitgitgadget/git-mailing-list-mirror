Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D590220706
	for <e@80x24.org>; Tue,  5 Jul 2016 13:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbcGENAr (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 09:00:47 -0400
Received: from mail.torek.net ([96.90.199.121]:15057 "EHLO elf.torek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754979AbcGENAq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2016 09:00:46 -0400
X-Greylist: delayed 722 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jul 2016 09:00:46 EDT
Received: from elf.torek.net (localhost [127.0.0.1])
	by elf.torek.net (8.14.9/8.14.9) with ESMTP id u65Cmg1x073897
	for <git@vger.kernel.org>; Tue, 5 Jul 2016 05:48:42 -0700 (PDT)
	(envelope-from chris.torek@gmail.com)
Message-Id: <201607051248.u65Cmg1x073897@elf.torek.net>
From:	Chris Torek <chris.torek@gmail.com>
To:	git@vger.kernel.org
Subject: git diff A...B is both overly forgiving and weird
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73895.1467722922.1@elf.torek.net>
Content-Transfer-Encoding: 8BIT
Date:	Tue, 05 Jul 2016 05:48:42 -0700
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (elf.torek.net [127.0.0.1]); Tue, 05 Jul 2016 05:48:42 -0700 (PDT)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

(This is not a big bug, but it is clearly not right.)

The problem is mostly described in the patch below.

This patch can perhaps be improved a bit by using an abbreviated
hash for the chosen merge base, in the case of multiple merge
bases, and/or by removing some of the paranoia-style checking (but
as I'm not terribly familiar with Git internals, I left these in).

Extra negative references given on the command line, as in "git
diff master~5...master^^2 ^origin/master^", now pass undetected; I
am not sure if there is a good way to catch them.  (In the
original code, they apparently substituted in for the merge-base.)

Chris


commit 2b9288cc90175557766ef33e350e0514470b6ad4
Author: Chris Torek <chris.torek@gmail.com>
Date:   Tue Jul 5 05:15:23 2016 -0700

    git diff: improve A...B merge-base handling
    
    When git diff is given a symmetric difference A...B, it chooses
    some merge base between the two specified commits.
    
    This fails, however, if there is *no* merge base: instead, you
    see the difference between A and B, which is certainly not what
    is expected:
    
        git diff origin/master...origin/todo
        [same output as "git diff origin/master origin/todo"]
    
    Moreover, if additional revisions are specified on the command
    line:
    
        git diff origin/master...origin/todo origin/master^
        git diff master~5...master^^2 origin/master^
        git diff master~5...master^^2 ^origin/master^
    
    the result gets a bit weird.  If there is a symmetric difference
    merge base, that will provide the left side of the diff.  An
    extra positive ref, if given, becomes the right side.  If there
    is no merge base, the symmetric difference is completely lost:
    for the Git repository, "origin/master...origin/todo origin/master^"
    runs a combined diff!  (This follows from treating the lack of
    a merge base as an ordinary diff of the two specified revisions.)
    
    To avoid all this, add a routine to catch the A...B case and
    verify that there is at least one merge base.  As a side effect,
    produce a warning showing *which* merge base is being used when
    there are multiple choices; die if there is no merge base.

diff --git a/builtin/diff.c b/builtin/diff.c
index b7a9405..c040b47 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -256,6 +256,97 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 	return run_diff_files(revs, options);
 }
 
+/*
+ * Check for symmetric-difference arguments, and if present,
+ * convert A...B to $(merge-base A B) B.
+ */
+static int builtin_diff_sdiff(struct rev_info *rev, struct object_array *ent)
+{
+	int i;
+	int on_left = 0, uninteresting = 0, unflagged = 0;
+	int lpos = -1, rpos = -1, upos = -1;
+	char *lname, *rname, *uname;
+	struct object *robj, *uobj;
+
+	/*
+	 * If there were any A...B symmetric differences specified,
+	 * we'll have A marked with SYMMETRIC_LEFT | UNINTERESTING,
+	 * and each merge base marked with UNINTERESTING.  B will
+	 * be unmarked.  If we were given additional revisions they
+	 * may have other markings, so remember the first A and B
+	 * for error messages as well.
+	 *
+	 * The actual order of these are that the merge bases come
+	 * first, then A, then B, but we don't depend on that in
+	 * this code.
+	 *
+	 * If we don't have just one merge base, we pick one
+	 * at (essentially) random (by using the first).
+	 *
+	 * Note that we don't check obj->parsed, since symmetric
+	 * difference objects are always pre-parsed: a non-parsed
+	 * object is by definition not part of a symmetric difference.
+	 */
+	for (i = 0; i < rev->pending.nr; i++) {
+		struct object *obj = rev->pending.objects[i].item;
+
+		if (obj->flags & SYMMETRIC_LEFT) {
+			on_left++;
+			if (lpos < 0)
+				lpos = i;
+		} else if (obj->flags & UNINTERESTING) {
+			uninteresting++;
+			if (upos < 0)
+				upos = i;
+		} else {
+			unflagged++;
+			if (lpos >= 0 && rpos < 0)
+				rpos = i;
+		}
+	}
+
+	if (on_left == 0)	/* no symmetric differences */
+		return (0);
+
+	/*
+	 * N.B.: lname retains the three dots.  The name of
+	 * the right hand side object (there should be one) is
+	 * a subset of this string.
+	 */
+	lname = rev->pending.objects[lpos].name;
+	/* demand exactly 1 on left and 1 unflagged */
+	if (unflagged > 1)
+		die(_("%s: must not list additional revs"), lname);
+	if (unflagged < 1)
+		die(_("%s: internal error: '...' but no unflagged revs"), lname);
+	if (uninteresting == 0)
+		die(_("%s: no merge base"), lname);
+
+	/*
+	 * Pick the tree from an "uninteresting" commit for the left
+	 * side, and the tree from the right hand side commit (rname)
+	 * for the other.  If there is more than one uninteresting
+	 * tree, print a warning.
+	 *
+	 * Note that the two objects (at upos and rpos) are by
+	 * definition commit objects.
+	 */
+	rname = rev->pending.objects[rpos].name;
+	uname = rev->pending.objects[upos].name;
+	if (uninteresting > 1)
+		warning(_("%s: multiple merge bases, using %s"), lname, uname);
+	robj = rev->pending.objects[rpos].item;
+	uobj = rev->pending.objects[upos].item;
+	if (uobj->type != OBJ_COMMIT || robj->type != OBJ_COMMIT)
+		die(_("internal error: uobj type %d, robj type %d"),
+		    uobj->type, robj->type);
+	robj = &((struct commit *)robj)->tree->object;
+	uobj = &((struct commit *)uobj)->tree->object;
+	add_object_array(uobj, uname, ent);
+	add_object_array(robj, rname, ent);
+	return (1);
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -391,32 +482,40 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	for (i = 0; i < rev.pending.nr; i++) {
-		struct object_array_entry *entry = &rev.pending.objects[i];
-		struct object *obj = entry->item;
-		const char *name = entry->name;
-		int flags = (obj->flags & UNINTERESTING);
-		if (!obj->parsed)
-			obj = parse_object(obj->oid.hash);
-		obj = deref_tag(obj, NULL, 0);
-		if (!obj)
-			die(_("invalid object '%s' given."), name);
-		if (obj->type == OBJ_COMMIT)
-			obj = &((struct commit *)obj)->tree->object;
-
-		if (obj->type == OBJ_TREE) {
-			obj->flags |= flags;
-			add_object_array(obj, name, &ent);
-		} else if (obj->type == OBJ_BLOB) {
-			if (2 <= blobs)
-				die(_("more than two blobs given: '%s'"), name);
-			hashcpy(blob[blobs].sha1, obj->oid.hash);
-			blob[blobs].name = name;
-			blob[blobs].mode = entry->mode;
-			blobs++;
-
-		} else {
-			die(_("unhandled object '%s' given."), name);
+	/*
+	 * We treat symmetric difference specially.  Check that first;
+	 * if it handled the arguments, it will put exactly two trees
+	 * into ent.  Otherwise go on to convert objects to blobs
+	 * and/or trees, putting any trees into the ent array.
+	 */
+	if (!builtin_diff_sdiff(&rev, &ent)) {
+		for (i = 0; i < rev.pending.nr; i++) {
+			struct object_array_entry *entry = &rev.pending.objects[i];
+			struct object *obj = entry->item;
+			const char *name = entry->name;
+			int flags = (obj->flags & UNINTERESTING);
+			if (!obj->parsed)
+				obj = parse_object(obj->oid.hash);
+			obj = deref_tag(obj, NULL, 0);
+			if (!obj)
+				die(_("invalid object '%s' given."), name);
+			if (obj->type == OBJ_COMMIT)
+				obj = &((struct commit *)obj)->tree->object;
+
+			if (obj->type == OBJ_TREE) {
+				obj->flags |= flags;
+				add_object_array(obj, name, &ent);
+			} else if (obj->type == OBJ_BLOB) {
+				if (2 <= blobs)
+					die(_("more than two blobs given: '%s'"), name);
+				hashcpy(blob[blobs].sha1, obj->oid.hash);
+				blob[blobs].name = name;
+				blob[blobs].mode = entry->mode;
+				blobs++;
+
+			} else {
+				die(_("unhandled object '%s' given."), name);
+			}
 		}
 	}
 	if (rev.prune_data.nr)
@@ -451,19 +550,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	else if (ent.nr == 2)
 		result = builtin_diff_tree(&rev, argc, argv,
 					   &ent.objects[0], &ent.objects[1]);
-	else if (ent.objects[0].item->flags & UNINTERESTING) {
-		/*
-		 * diff A...B where there is at least one merge base
-		 * between A and B.  We have ent.objects[0] ==
-		 * merge-base, ent.objects[ents-2] == A, and
-		 * ent.objects[ents-1] == B.  Show diff between the
-		 * base and B.  Note that we pick one merge base at
-		 * random if there are more than one.
-		 */
-		result = builtin_diff_tree(&rev, argc, argv,
-					   &ent.objects[0],
-					   &ent.objects[ent.nr-1]);
-	} else
+	else
 		result = builtin_diff_combined(&rev, argc, argv,
 					       ent.objects, ent.nr);
 	result = diff_result_code(&rev.diffopt, result);
