From: Daniel Hagerty <hag@linnaean.org>
Subject: Re: git merge a b when a == b but neither == o is always a
 successful merge?
Date: Mon, 17 Nov 2014 17:21:03 -0500
Message-ID: <21610.29903.366230.851787@perdition.linnaean.org>
References: <21610.16623.746985.383838@perdition.linnaean.org>
	<20141117205304.GA15880@peff.net>
Reply-To: Daniel Hagerty <hag@linnaean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 17 23:21:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqUfY-0001aG-QD
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 23:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbaKQWVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 17:21:08 -0500
Received: from perdition.linnaean.org ([173.166.106.33]:19090 "EHLO
	perdition.linnaean.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaKQWVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 17:21:07 -0500
Received: by perdition.linnaean.org (Postfix, from userid 31013)
	id 74DCF980; Mon, 17 Nov 2014 17:21:03 -0500 (EST)
In-Reply-To: <20141117205304.GA15880@peff.net>
X-Mailer: VM 7.19 under Emacs 23.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 > Just to be clear, you were expecting "git merge b" to produce a
 > conflict?

    Yessir.

 > I can imagine there might be times you would like to notice this case
 > and visit it manually (e.g., even though the conflict would show both
 > sides with the same content, you might want the resolution to take the
 > two sides sequentially, duplicating them).

    This is roughly the case here.  Judgement is needed from the
person at the wheel.

 > I don't think there is an easy way to get what you want. You would have
 > to write a new merge 3-way strategy that handles this case differently.
 > And most of the file-level heavy lifting in merge strategies is done by
 > the low-level unpack_trees code, which handles this case. From "git help

    I have a very rough draft that seems to do what I want, exposed
through .gitattributes (below).  Given that this is something you probably
want tightly scoped, does it make sense to expose it anywhere else?

    Is it accurate to speak of this as exposing merge minimal?

    Thanks!

commit 3a8bc89950576c0445167e4f5ee5f42d9d737d2d
Author: Daniel Hagerty <hag@linnaean.org>
Date:   Mon Nov 17 15:42:04 2014 -0500

    merge: expose XDL_MERGE_MINIMAL behavior:

    When performing a 3-way merge, an identical change to a file in both
    branches is not considered a conflict by default.  There exist content
    for which this isn't true; simultaneous, identical edits are a
    conflict.

    Expose the ability to perform a minimal merge for selective files as
    directed by gitattributes.

diff --git a/ll-merge.c b/ll-merge.c
index da59738..2a06ac9 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -84,7 +84,16 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	}

 	memset(&xmp, 0, sizeof(xmp));
-	xmp.level = XDL_MERGE_ZEALOUS;
+
+	struct git_attr_check check;
+	check.attr = git_attr("merge-minimal");
+	(void) git_check_attr(path, 1, &check);
+
+	if(ATTR_TRUE(check.value))
+	  xmp.level = XDL_MERGE_MINIMAL;
+	else
+	  xmp.level = XDL_MERGE_ZEALOUS;
+
 	xmp.favor = opts->variant;
 	xmp.xpp.flags = opts->xdl_opts;
 	if (git_xmerge_style >= 0)
diff --git a/merge-recursive.c b/merge-recursive.c
index 3efc04e..dac6252 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -924,7 +924,11 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			}
 		}

-		if (sha_eq(a->sha1, b->sha1) || sha_eq(a->sha1, one->sha1))
+		struct git_attr_check check;
+		check.attr = git_attr("merge-minimal");
+		(void) git_check_attr(a->path, 1, &check);
+
+		if (!ATTR_TRUE(check.value) && (sha_eq(a->sha1, b->sha1) || sha_eq(a->sha1, one->sha1)))
 			hashcpy(result.sha, b->sha1);
 		else if (sha_eq(b->sha1, one->sha1))
 			hashcpy(result.sha, a->sha1);
diff --git a/unpack-trees.c b/unpack-trees.c
index cc616c3..627356a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1597,7 +1597,12 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)

 	if (head) {
 		/* #5ALT, #15 */
-		if (same(head, remote))
+
+		struct git_attr_check check;
+		check.attr = git_attr("merge-minimal");
+		(void) git_check_attr(head->name, 1, &check);
+
+		if (!ATTR_TRUE(check.value) && same(head, remote))
 			return merged_entry(head, index, o);
 		/* #13, #3ALT */
 		if (!df_conflict_remote && remote_match && !head_match)
