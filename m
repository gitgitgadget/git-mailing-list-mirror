From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug in read-tree -m on A -> A/A
Date: Thu, 15 Mar 2007 22:01:16 -0700
Message-ID: <7v4polzsrn.fsf@assigned-by-dhcp.cox.net>
References: <20070316041932.GA31606@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 06:01:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS4Z6-0000vk-Ls
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 06:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbXCPFBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 01:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbXCPFBS
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 01:01:18 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:60814 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbXCPFBR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 01:01:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316050117.FJQZ18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Mar 2007 01:01:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bH1G1W00a1kojtg0000000; Fri, 16 Mar 2007 01:01:17 -0400
In-Reply-To: <20070316041932.GA31606@spearce.org> (Shawn O. Pearce's message
	of "Fri, 16 Mar 2007 00:19:32 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42325>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> ....  The following test appears to
> trigger the same failure,...

You have file "A" on one branch, and file "A/A" on another
branch.  You are on the latter branch and switching to the
former one.

The following patch illustrates where you need to implement an
alternate, loosened check, but should not be applied to your
tree as-is.  If you have local modification to path "A/A", this
will lose it.

-- >8 --
diff --git a/unpack-trees.c b/unpack-trees.c
index 2e2232c..345b2ee 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -479,9 +479,27 @@ static void verify_absent(const char *path, const char *action,
 
 	if (o->index_only || o->reset || !o->update)
 		return;
-	if (!lstat(path, &st) && !(o->dir && excluded(o->dir, path)))
+
+	if (!lstat(path, &st)) {
+		if (o->dir && excluded(o->dir, path))
+			/*
+			 * path is explicitly excluded, so it is Ok to
+			 * overwrite it.
+			 */
+			return;
+		if (S_ISDIR(st.st_mode))
+			/*
+			 * We are checking out path "foo" and
+			 * found "foo/." in the working tree.
+			 * This is tricky -- if we have modified
+			 * files that are in "foo/" we would lose
+			 * it if we just uncoditinally return here.
+			 */
+			return;
+
 		die("Untracked working tree file '%s' "
 		    "would be %s by merge.", path, action);
+	}
 }
 
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,


-- 8< --

To solve this sanely I think you would need to merge bottom-up,
which is quite a large change to read-tree.  Currently the code
asks "is it Ok to extract A from the new tree?" and if we say
yes here it would remove all existing cache entries "A/*" and
replaces it with "A".  After that happens, you would not even
have a chance to see if A/A has local modifications, or if you
have a local file that is not even known to git, say A/C, that
will also be lost by this tree switching.
