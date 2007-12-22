From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't dereference NULL upon lookup_tree failure.
Date: Sat, 22 Dec 2007 14:41:55 +0100
Message-ID: <87prwyu9r0.fsf@rho.meyering.net>
References: <873atvwueq.fsf@rho.meyering.net>
	<7v4peb4qbj.fsf@gitster.siamese.dyndns.org>
	<87hcibveut.fsf@rho.meyering.net>
	<7vzlw33a1o.fsf@gitster.siamese.dyndns.org>
	<87bq8jvd1g.fsf@rho.meyering.net>
	<7vve6r39bp.fsf@gitster.siamese.dyndns.org>
	<8763yrvb3g.fsf@rho.meyering.net>
	<7vzlw3xeqy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Matthew Farrellee <mfarrellee@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 14:42:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J64cP-0001Ag-R1
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 14:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbXLVNl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 08:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbXLVNl6
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 08:41:58 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44559 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbXLVNl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 08:41:57 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E17A917B57A
	for <git@vger.kernel.org>; Sat, 22 Dec 2007 14:41:55 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C3BC717B561
	for <git@vger.kernel.org>; Sat, 22 Dec 2007 14:41:55 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 69A9C33610; Sat, 22 Dec 2007 14:41:55 +0100 (CET)
In-Reply-To: <7vzlw3xeqy.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 22 Dec 2007 01:25:41 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69133>

Junio C Hamano <gitster@pobox.com> wrote:
...
> Your fix is all we can sensibly do. I however think you would
> need similar fix to the same function for other object types, as
> they dereference a potentially NULL pointer the same way.

Good point.  Patch below.  I wondered if these lookup functions have
always been able to return NULL, since there are many remaining uses
where the possibility of a NULL return value is not handled.
Here are a few that stood out in the output of a quick search:

  git-grep -E -A3 'lookup_(commit|tag|blob|tree) *\('

Note: I did not look at cases where the return value is an argument
to some other function.

------------------
builtin-fmt-merge-msg.c:
		head = lookup_commit(head_sha1);
		...
		for (i = 0; i < origins.nr; i++)
			shortlog(origins.list[i], origins.payload[i],
					head, &rev, limit);
------------------
builtin-read-tree.c:                    struct tree *subtree = lookup_tree(entry.
sha1);
builtin-read-tree.c-                    if (!subtree->object.parsed)

------------------
combine-diff.c: struct commit *commit = lookup_commit(sha1);
combine-diff.c- struct commit_list *parents;

------------------
http-push.c:    struct commit *head = lookup_commit(head_sha1);
http-push.c:    struct commit *branch = lookup_commit(branch_sha1);
http-push.c-    struct commit_list *merge_bases = get_merge_bases(head, branch, 1);

------------------
reachable.c:    struct tree *tree = lookup_tree(sha1);
reachable.c-    add_pending_object(revs, &tree->object, "");

------------------
tag.c:          item->tagged = &lookup_blob(sha1)->object;
tag.c-  } else if (!strcmp(type, tree_type)) {
tag.c:          item->tagged = &lookup_tree(sha1)->object;
tag.c-  } else if (!strcmp(type, commit_type)) {
tag.c:          item->tagged = &lookup_commit(sha1)->object;
tag.c-  } else if (!strcmp(type, tag_type)) {
tag.c:          item->tagged = &lookup_tag(sha1)->object;
tag.c-  } else {

--------------------------
unpack-trees.c:                         struct tree *tree = lookup_tree(posns[i]->sha1);
...
unpack-trees.c-                         parse_tree(tree);


Here's the revised patch:

==================================================================
From 94152217e8e57d3932b4ba6f7ee014da1f4346d3 Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Fri, 21 Dec 2007 11:56:32 +0100
Subject: [PATCH] Don't dereference NULL upon lookup failure.


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 object.c |   42 +++++++++++++++++++++++++++++-------------
 1 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/object.c b/object.c
index 16793d9..9945b25 100644
--- a/object.c
+++ b/object.c
@@ -138,27 +138,43 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t

 	if (type == OBJ_BLOB) {
 		struct blob *blob = lookup_blob(sha1);
-		parse_blob_buffer(blob, buffer, size);
-		obj = &blob->object;
+		if (!blob)
+		    obj = NULL;
+		else {
+		    parse_blob_buffer(blob, buffer, size);
+		    obj = &blob->object;
+		}
 	} else if (type == OBJ_TREE) {
 		struct tree *tree = lookup_tree(sha1);
-		obj = &tree->object;
-		if (!tree->object.parsed) {
-			parse_tree_buffer(tree, buffer, size);
-			eaten = 1;
+		if (!tree)
+		    obj = NULL;
+		else {
+		    obj = &tree->object;
+		    if (!tree->object.parsed) {
+			    parse_tree_buffer(tree, buffer, size);
+			    eaten = 1;
+		    }
 		}
 	} else if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(sha1);
-		parse_commit_buffer(commit, buffer, size);
-		if (!commit->buffer) {
-			commit->buffer = buffer;
-			eaten = 1;
+		if (!commit)
+		    obj = NULL;
+		else {
+		    parse_commit_buffer(commit, buffer, size);
+		    if (!commit->buffer) {
+			    commit->buffer = buffer;
+			    eaten = 1;
+		    }
+		    obj = &commit->object;
 		}
-		obj = &commit->object;
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(sha1);
-		parse_tag_buffer(tag, buffer, size);
-		obj = &tag->object;
+		if (!tag)
+		    obj = NULL;
+		else {
+		    parse_tag_buffer(tag, buffer, size);
+		    obj = &tag->object;
+		}
 	} else {
 		warning("object %s has unknown type id %d\n", sha1_to_hex(sha1), type);
 		obj = NULL;
--
1.5.4.rc1.16.g60f3b
