From: Junio C Hamano <junkio@cox.net>
Subject: Re: Broken adding of cache entries
Date: Sun, 08 May 2005 15:42:28 -0700
Message-ID: <7voebl2vcb.fsf@assigned-by-dhcp.cox.net>
References: <20050507001409.GP32629@pasky.ji.cz>
	<1115431767.32065.182.camel@localhost.localdomain>
	<20050507152849.GD9495@pasky.ji.cz>
	<7vhdhealjm.fsf@assigned-by-dhcp.cox.net>
	<20050507224116.GF9495@pasky.ji.cz>
	<7vll6q8s4o.fsf@assigned-by-dhcp.cox.net>
	<7vbr7m8p05.fsf@assigned-by-dhcp.cox.net>
	<7vll6q70mg.fsf@assigned-by-dhcp.cox.net>
	<20050508165915.GW9495@pasky.ji.cz>
	<7v3bsx5sxx.fsf@assigned-by-dhcp.cox.net>
	<20050508212202.GM9495@pasky.ji.cz>
	<7v7ji94b1d.fsf@assigned-by-dhcp.cox.net>
	<7v3bsx4aum.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 00:35:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUuN2-0005gp-EC
	for gcvg-git@gmane.org; Mon, 09 May 2005 00:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVEHWmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 18:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVEHWmj
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 18:42:39 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:59070 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262996AbVEHWma (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 18:42:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508224228.ZCXX550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 18:42:28 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <7v3bsx4aum.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 08 May 2005 15:22:09 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> Ok, having thought about it a bit more, I think we can yank it
JCH> out.  I'd rather keep ourselves cautious, though; there may be
JCH> some other ways we haven't thought of to create such nonsense,
JCH> and it would not hurt to be cautious before writing a tree out.

Here is a revert you can apply after merging with the tip of my
tree if you wanted to.  As you pointed out correctly, three-way
read-tree would not produce the situation as I feared, and the
attempt to postprocess the result by git-merge-one-file-script
git-merge-cache calls would be caught with the changes we made
to git-update-cache, so there is no need for the extra check by
write-tree in that workflow example.  Sorry for being ultra
dense.

The only reason why I am holding off from pushing this out is
because I still cannot convince myself that we eradicated _all_
the possibile paths to create such nonsense in the index, and I
feel safer to keep the check this patch is reverting, at least
for now.

---
Author: Junio C Hamano <junkio@cox.net>
Date:   Sun May 8 15:34:17 2005 -0700
    
Revert the extra-careful check in write-tree.c

I am not particularly fond of reverting this, but with the
git-update-cache changes it is unlikely that we will have file
vs directory conflicts in the index anymore, so there may be no
point in being extra careful when writing the tree out.

Signed-off-by: Junio C Hamano <junkio@cox.net>

--- a/write-tree.c
+++ b/write-tree.c
@@ -84,7 +84,7 @@ static int write_tree(struct cache_entry
 
 int main(int argc, char **argv)
 {
-	int i, funny;
+	int i, unmerged;
 	int entries = read_cache();
 	unsigned char sha1[20];
 
@@ -92,45 +92,18 @@ int main(int argc, char **argv)
 		die("write-tree: no cache contents to write");
 
 	/* Verify that the tree is merged */
-	funny = 0;
+	unmerged = 0;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ntohs(ce->ce_flags) & ~CE_NAMEMASK) {
-			if (10 < ++funny) {
+			if (++unmerged > 10) {
 				fprintf(stderr, "...\n");
 				break;
 			}
 			fprintf(stderr, "%s: unmerged (%s)\n", ce->name, sha1_to_hex(ce->sha1));
 		}
 	}
-	if (funny)
-		die("write-tree: not able to write tree");
-
-	/* Also verify that the cache does not have path and path/file
-	 * at the same time.  At this point we know the cache has only
-	 * stage 0 entries.
-	 */
-	funny = 0;
-	for (i = 0; i < entries - 1; i++) {
-		/* path/file always comes after path because of the way
-		 * the cache is sorted.  Also path can appear only once,
-		 * which means conflicting one would immediately follow.
-		 */
-		const char *this_name = active_cache[i]->name;
-		const char *next_name = active_cache[i+1]->name;
-		int this_len = strlen(this_name);
-		if (this_len < strlen(next_name) &&
-		    strncmp(this_name, next_name, this_len) == 0 &&
-		    next_name[this_len] == '/') {
-			if (10 < ++funny) {
-				fprintf(stderr, "...\n");
-				break;
-			}
-			fprintf(stderr, "You have both %s and %s\n",
-				this_name, next_name);
-		}
-	}
-	if (funny)
+	if (unmerged)
 		die("write-tree: not able to write tree");
 
 	/* Ok, write it out */



