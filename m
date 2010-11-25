From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 02/18] revert: change many die() calls into "return
	error()" calls
Date: Thu, 25 Nov 2010 22:20:33 +0100
Message-ID: <20101125212050.5188.21758.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrGa-0006bE-0e
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab0KZFyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:54:24 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47231 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab0KZFyX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:54:23 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D95ECA6176;
	Fri, 26 Nov 2010 06:54:15 +0100 (CET)
X-git-sha1: 906a616d379dbdb53b34b44bc8c564c70689dd68 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162185>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   43 ++++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index bb6e9e8..9649d37 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -280,16 +280,18 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
-static NORETURN void die_dirty_index(const char *me)
+static int error_dirty_index(const char *me)
 {
 	if (read_cache_unmerged()) {
-		die_resolve_conflict(me);
+		return error_resolve_conflict(me);
 	} else {
 		if (advice_commit_before_merge)
-			die("Your local changes would be overwritten by %s.\n"
-			    "Please, commit your changes or stash them to proceed.", me);
+			return error("Your local changes would be overwritten "
+				     "by %s.\nPlease, commit your changes or "
+				     "stash them to proceed.", me);
 		else
-			die("Your local changes would be overwritten by %s.\n", me);
+			return error("Your local changes would be overwritten "
+				     "by %s.\n", me);
 	}
 }
 
@@ -339,7 +341,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (active_cache_changed &&
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     commit_locked_index(&index_lock)))
-		die("%s: Unable to write new index file", me);
+		return error("%s: Unable to write new index file", me);
 	rollback_lock_file(&index_lock);
 
 	if (!clean) {
@@ -405,18 +407,18 @@ static int do_pick_commit(void)
 		 * to work on.
 		 */
 		if (write_cache_as_tree(head, 0, NULL))
-			die ("Your index file is unmerged.");
+			return error("Your index file is unmerged.");
 	} else {
 		if (get_sha1("HEAD", head))
-			die ("You do not have a valid HEAD");
+			return error("You do not have a valid HEAD");
 		if (index_differs_from("HEAD", 0))
-			die_dirty_index(me);
+			return error_dirty_index(me);
 	}
 	discard_cache();
 
 	if (!commit->parents) {
 		if (action == REVERT)
-			die ("Cannot revert a root commit");
+			return error("Cannot revert a root commit");
 		parent = NULL;
 	}
 	else if (commit->parents->next) {
@@ -425,20 +427,19 @@ static int do_pick_commit(void)
 		struct commit_list *p;
 
 		if (!mainline)
-			die("Commit %s is a merge but no -m option was given.",
-			    sha1_to_hex(commit->object.sha1));
-
+			return error("Commit %s is a merge but no -m option "
+				     "was given.", sha1_to_hex(commit->object.sha1));
 		for (cnt = 1, p = commit->parents;
 		     cnt != mainline && p;
 		     cnt++)
 			p = p->next;
 		if (cnt != mainline || !p)
-			die("Commit %s does not have parent %d",
-			    sha1_to_hex(commit->object.sha1), mainline);
+			return error("Commit %s does not have parent %d",
+				     sha1_to_hex(commit->object.sha1), mainline);
 		parent = p->item;
 	} else if (0 < mainline)
-		die("Mainline was specified but commit %s is not a merge.",
-		    sha1_to_hex(commit->object.sha1));
+		return error("Mainline was specified but commit %s is not a merge.",
+			     sha1_to_hex(commit->object.sha1));
 	else
 		parent = commit->parents->item;
 
@@ -446,12 +447,12 @@ static int do_pick_commit(void)
 		return fast_forward_to(commit->object.sha1, head);
 
 	if (parent && parse_commit(parent) < 0)
-		die("%s: cannot parse parent commit %s",
-		    me, sha1_to_hex(parent->object.sha1));
+		return error("%s: cannot parse parent commit %s",
+			     me, sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit->buffer, &msg) != 0)
-		die("Cannot get commit message for %s",
-				sha1_to_hex(commit->object.sha1));
+		return error("Cannot get commit message for %s",
+			     sha1_to_hex(commit->object.sha1));
 
 	/*
 	 * "commit" is an existing commit.  We would want to apply
-- 
1.7.3.2.504.g59d466
