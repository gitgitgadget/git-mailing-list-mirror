From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 22:26:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701212137370.14248@woody.osdl.org>
References: <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net> <20070119034404.GA17521@spearce.org>
 <20070119104935.GA5189@moooo.ath.cx> <7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
 <20070120111832.GA30368@moooo.ath.cx> <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
 <20070121103724.GA23256@moooo.ath.cx> <7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
 <20070121220114.GA24729@coredump.intra.peff.net> <45B415B1.30407@midwinter.com>
 <20070122015252.GA26934@coredump.intra.peff.net> <7vwt3fx1am.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701211813410.14248@woody.osdl.org> <7virezwzpz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701211851310.14248@woody.osdl.org> <7v3b63wsh3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 07:26:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8sdl-0000Ch-Qj
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 07:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbXAVG0r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 01:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXAVG0r
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 01:26:47 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35598 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbXAVG0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 01:26:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0M6QghB016833
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Jan 2007 22:26:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0M6QfNt018429;
	Sun, 21 Jan 2007 22:26:42 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3b63wsh3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.66 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37398>



On Sun, 21 Jan 2007, Junio C Hamano wrote:
> 
> I've been annoyed by those scary messages fsck-objects enough
> and was wondering if we could make it less scary.  Especially
> annoying is that the message about missing blobs and trees that
> are only referred to by dangling commits.

Yeah. Something like this, which really just changes the order in which we 
print out the warnings, might be a good idea.

This patch does that, and also adds a lot of commentary on what it is 
doing. It also splits out the "object unreachable" case from the reachable 
case, since they end up being really really different. An unreachable 
object we don't even care about broken links for etc.

The diffstat says that it adds a lot more lines than it removed, but all 
the really new lines are either just the added comments, or a result of 
just splitting the object checking up into a few separate functions. The 
actual code is largely the same (but with the improved semantics).

I actually tested this a bit by trying to force a few corruption cases. 
And the changes _look_ obvious, and yes, it improved reporting (I think). 
At the same time, git-fsck-objects is too important to have just one pair 
of eyes looking at it, so I would suggest others really double-check my 
changes and the logic.

(Btw, the "parsed but unparsed because it was in a pack-file" test should 
probably be tightened up a bit. That part is not new code, it's the old 
code in a new place with a newly added comment about what it is all about. 
So it's not a regression, it's just something I thought I'd point out when 
I looked at the code).

Add my sign-off on the patch as appropriate. I do think it's mergeable, 
but I'd _really_ like somebody else to double-check me here.

NOTE! One of the new things is that it doesn't complain about missing 
unreachable objects at all any more. It used to complain about missing 
objects even if they were only missing because _another_ unreachable 
object wanted to access them, which was obviously just useless noise (it 
could happen if you ^C in the middle of a fetch, for example.

Anyway, somebody should double- and triple-check me.

		Linus

---

 fsck-objects.c |  133 ++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 95 insertions(+), 38 deletions(-)

diff --git a/fsck-objects.c b/fsck-objects.c
index 81f00db..ecfb014 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -54,6 +54,99 @@ static int objwarning(struct object *obj, const char *err, ...)
 	return -1;
 }
 
+/*
+ * Check a single reachable object
+ */
+static void check_reachable_object(struct object *obj)
+{
+	const struct object_refs *refs;
+
+	/*
+	 * We obviously want the object to be parsed,
+	 * except if it was in a pack-file and we didn't
+	 * do a full fsck
+	 */
+	if (!obj->parsed) {
+		if (has_sha1_file(obj->sha1))
+			return; /* it is in pack - forget about it */
+		printf("missing %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
+		return;
+	}
+
+	/*
+	 * Check that everything that we try to reference is also good.
+	 */
+	refs = lookup_object_refs(obj);
+	if (refs) {
+		unsigned j;
+		for (j = 0; j < refs->count; j++) {
+			struct object *ref = refs->ref[j];
+			if (ref->parsed ||
+			    (has_sha1_file(ref->sha1)))
+				continue;
+			printf("broken link from %7s %s\n",
+			       typename(obj->type), sha1_to_hex(obj->sha1));
+			printf("              to %7s %s\n",
+			       typename(ref->type), sha1_to_hex(ref->sha1));
+		}
+	}
+}
+
+/*
+ * Check a single unreachable object
+ */
+static void check_unreachable_object(struct object *obj)
+{
+	/*
+	 * Missing unreachable object? Ignore it. It's not like
+	 * we miss it (since it can't be reached), nor do we want
+	 * to complain about it being unreachable (since it does
+	 * not exist).
+	 */
+	if (!obj->parsed)
+		return;
+
+	/*
+	 * Unreachable object that exists? Show it if asked to,
+	 * since this is something that is prunable.
+	 */
+	if (show_unreachable) {
+		printf("unreachable %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
+		return;
+	}
+
+	/*
+	 * "!used" means that nothing at all points to it, including
+	 * other unreacahble objects. In other words, it's the "tip"
+	 * of some set of unreachable objects, usually a commit that
+	 * got dropped.
+	 *
+	 * Such starting points are more interesting than some random
+	 * set of unreachable objects, so we show them even if the user
+	 * hasn't asked for _all_ unreachable objects. If you have
+	 * deleted a branch by mistake, this is a prime candidate to
+	 * start looking at, for example.
+	 */
+	if (!obj->used) {
+		printf("dangling %s %s\n", typename(obj->type),
+		       sha1_to_hex(obj->sha1));
+		return;
+	}
+
+	/*
+	 * Otherwise? It's there, it's unreachable, and some other unreachable
+	 * object points to it. Ignore it - it's not interesting, and we showed
+	 * all the interesting cases above.
+	 */
+}
+
+static void check_object(struct object *obj)
+{
+	if (obj->flags & REACHABLE)
+		check_reachable_object(obj);
+	else
+		check_unreachable_object(obj);
+}
 
 static void check_connectivity(void)
 {
@@ -62,46 +155,10 @@ static void check_connectivity(void)
 	/* Look up all the requirements, warn about missing objects.. */
 	max = get_max_object_index();
 	for (i = 0; i < max; i++) {
-		const struct object_refs *refs;
 		struct object *obj = get_indexed_object(i);
 
-		if (!obj)
-			continue;
-
-		if (!obj->parsed) {
-			if (has_sha1_file(obj->sha1))
-				; /* it is in pack */
-			else
-				printf("missing %s %s\n",
-				       typename(obj->type), sha1_to_hex(obj->sha1));
-			continue;
-		}
-
-		refs = lookup_object_refs(obj);
-		if (refs) {
-			unsigned j;
-			for (j = 0; j < refs->count; j++) {
-				struct object *ref = refs->ref[j];
-				if (ref->parsed ||
-				    (has_sha1_file(ref->sha1)))
-					continue;
-				printf("broken link from %7s %s\n",
-				       typename(obj->type), sha1_to_hex(obj->sha1));
-				printf("              to %7s %s\n",
-				       typename(ref->type), sha1_to_hex(ref->sha1));
-			}
-		}
-
-		if (show_unreachable && !(obj->flags & REACHABLE)) {
-			printf("unreachable %s %s\n",
-			       typename(obj->type), sha1_to_hex(obj->sha1));
-			continue;
-		}
-
-		if (!obj->used) {
-			printf("dangling %s %s\n", typename(obj->type),
-			       sha1_to_hex(obj->sha1));
-		}
+		if (obj)
+			check_object(obj);
 	}
 }
 
