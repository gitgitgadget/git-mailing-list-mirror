From: Junio C Hamano <junkio@cox.net>
Subject: Re: Broken adding of cache entries
Date: Sat, 07 May 2005 12:22:21 -0700
Message-ID: <7vhdhealjm.fsf@assigned-by-dhcp.cox.net>
References: <1115408460.32065.37.camel@localhost.localdomain>
	<20050506231447.GG32629@pasky.ji.cz>
	<1115421933.32065.111.camel@localhost.localdomain>
	<20050506233003.GJ32629@pasky.ji.cz>
	<1115423450.32065.138.camel@localhost.localdomain>
	<20050507001409.GP32629@pasky.ji.cz>
	<1115431767.32065.182.camel@localhost.localdomain>
	<20050507152849.GD9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Sat May 07 21:16:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUUm6-0000gH-Pv
	for gcvg-git@gmane.org; Sat, 07 May 2005 21:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVEGTWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 15:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVEGTWg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 15:22:36 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:62919 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261648AbVEGTWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 15:22:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050507192221.BZJJ23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 May 2005 15:22:21 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050507152849.GD9495@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 7 May 2005 17:28:50 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'll keep this in git-jc repository until Linus returns.  Pasky
and Kay could you give it a try?

-- test case --

$ ls -a
./  ../
$ git-init-db
defaulting to local storage area
$ date >path
$ git-update-cache --add path
$ rm path
$ mkdir path
$ date >path/file
$ git-update-cache --add path/file
$ git-ls-files --stage
100644 1738f2536b1201218c41153941da065cc26174c9 0 path
100644 620c72f1c1de15f56ff9d63d6d7cdc69e828f1e3 0 path/file
$ git-ls-tree $(git-write-tree)                     ;# using old one
100644	blob	1738f2536b1201218c41153941da065cc26174c9	path
040000	tree	ec116937f223e3df95aeac9f076902ae1618ae98	path
$ ../git-write-tree                                 ;# using new one
You have both path and path/file
fatal: write-tree: not able to write tree
$ exit

----------------------------------------------------------------
Notice index that has path and path/file and refuse to write such a tree.

Kay Sievers noticed that you can have both path and path/file in
the cache and write-tree happily creates a tree object from such
a state.  Since a merge can result in such situation and the
user should be able to see the situation by looking at the
cache, rather than forbidding add_cache_entry() to create such
conflicts, fix it by making write-tree refuse to write such an
nonsensical tree.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

write-tree.c |   35 +++++++++++++++++++++++++++++++----
1 files changed, 31 insertions(+), 4 deletions(-)

--- a/write-tree.c
+++ b/write-tree.c
@@ -84,7 +84,7 @@ static int write_tree(struct cache_entry
 
 int main(int argc, char **argv)
 {
-	int i, unmerged;
+	int i, funny;
 	int entries = read_cache();
 	unsigned char sha1[20];
 
@@ -92,18 +92,45 @@ int main(int argc, char **argv)
 		die("write-tree: no cache contents to write");
 
 	/* Verify that the tree is merged */
-	unmerged = 0;
+	funny = 0;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ntohs(ce->ce_flags) & ~CE_NAMEMASK) {
-			if (++unmerged > 10) {
+			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
 			}
 			fprintf(stderr, "%s: unmerged (%s)\n", ce->name, sha1_to_hex(ce->sha1));
 		}
 	}
-	if (unmerged)
+	if (funny)
+		die("write-tree: not able to write tree");
+
+	/* Also verify that the cache does not have path and path/file
+	 * at the same time.  At this point we know the cache has only
+	 * stage 0 entries.
+	 */
+	funny = 0;
+	for (i = 0; i < entries - 1; i++) {
+		/* path/file always comes after path because of the way
+		 * the cache is sorted.  Also path can appear only once,
+		 * which means conflicting one would immediately follow.
+		 */
+		const char *this_name = active_cache[i]->name;
+		const char *next_name = active_cache[i+1]->name;
+		int this_len = strlen(this_name);
+		if (this_len < strlen(next_name) &&
+		    strncmp(this_name, next_name, this_len) == 0 &&
+		    next_name[this_len] == '/') {
+			if (10 < ++funny) {
+				fprintf(stderr, "...\n");
+				break;
+			}
+			fprintf(stderr, "You have both %s and %s\n",
+				this_name, next_name);
+		}
+	}
+	if (funny)
 		die("write-tree: not able to write tree");
 
 	/* Ok, write it out */

