From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/25] prune-safety
Date: Thu, 16 Oct 2014 17:39:18 -0400
Message-ID: <20141016213918.GA29397@peff.net>
References: <20141015223244.GA25368@peff.net>
 <xmqqsiinsoyk.fsf@gitster.dls.corp.google.com>
 <20141016212112.GA16054@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 23:39:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xesla-000676-B2
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 23:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbaJPVjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 17:39:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:59394 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752620AbaJPVjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 17:39:22 -0400
Received: (qmail 29653 invoked by uid 102); 16 Oct 2014 21:39:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 16:39:21 -0500
Received: (qmail 2863 invoked by uid 107); 16 Oct 2014 21:39:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 17:39:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2014 17:39:18 -0400
Content-Disposition: inline
In-Reply-To: <20141016212112.GA16054@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 05:21:12PM -0400, Jeff King wrote:

> Hrm. I cannot reproduce the clone failure...

Oh, because I have bitmaps turned on, and we do not run the list-objects
code at all in that case.

The bug unsurprisingly bisects to "traverse_commit_list: support
pending blobs/trees with paths". The problem is that I didn't notice
that handle_commit actually rewrites the "object" pointer when
unwrapping the tags, and that commit reuses the original pointer from
the entry. So we end up putting two copies of the tag object into the
pending list, rather than the tag and the blob.

The fix is:

diff --git a/revision.c b/revision.c
index 9a0f99a..8030fc8 100644
--- a/revision.c
+++ b/revision.c
@@ -231,12 +231,6 @@ static void add_pending_object_with_mode(struct rev_info *revs,
 	add_pending_object_with_path(revs, obj, name, mode, NULL);
 }
 
-static void add_pending_object_from_entry(struct rev_info *revs,
-					  struct object_array_entry *e)
-{
-	add_pending_object_with_path(revs, e->item, e->name, e->mode, e->path);
-}
-
 void add_pending_object(struct rev_info *revs,
 			struct object *obj, const char *name)
 {
@@ -283,6 +277,8 @@ static struct commit *handle_commit(struct rev_info *revs,
 {
 	struct object *object = entry->item;
 	const char *name = entry->name;
+	const char *path = entry->path;
+	unsigned int mode = entry->mode;
 	unsigned long flags = object->flags;
 
 	/*
@@ -301,6 +297,14 @@ static struct commit *handle_commit(struct rev_info *revs,
 			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
 		}
 		object->flags |= flags;
+		/*
+		 * We'll handle the tagged object by looping or dropping
+		 * through to the non-tag handlers below. Do not
+		 * propagate data from the tag's pending entry.
+		 */
+		name = NULL;
+		path = NULL;
+		mode = 0;
 	}
 
 	/*
@@ -332,7 +336,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			mark_tree_contents_uninteresting(tree);
 			return NULL;
 		}
-		add_pending_object_from_entry(revs, entry);
+		add_pending_object_with_path(revs, object, name, mode, path);
 		return NULL;
 	}
 
@@ -344,7 +348,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			return NULL;
 		if (flags & UNINTERESTING)
 			return NULL;
-		add_pending_object_from_entry(revs, entry);
+		add_pending_object_with_path(revs, object, name, mode, path);
 		return NULL;
 	}
 	die("%s is unknown object", name);

We should probably add a test for cloning a tag of an otherwise
unreferenced object, too.

-Peff
