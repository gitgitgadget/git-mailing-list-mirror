From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Tue, 24 May 2005 02:05:08 -0700
Message-ID: <7vr7fxuh8b.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
	<7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
	<Pine.LNX.4.58.0505211128570.2206@ppc970.osdl.org>
	<Pine.LNX.4.58.0505211137250.2206@ppc970.osdl.org>
	<7vbr71xjyt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505232314510.2307@ppc970.osdl.org>
	<7vll65vy10.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505240129420.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 11:05:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaVLB-0001HM-48
	for gcvg-git@gmane.org; Tue, 24 May 2005 11:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVEXJGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 05:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVEXJGJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 05:06:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:52618 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261453AbVEXJFO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 05:05:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524090508.BURU7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 05:05:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505240129420.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 01:31:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> (I think that's just because the "silent" test used to depend on the 
LT> magical behaviour of the "header" thing, and now that the header 
LT> generation and suppression is sane, "silent" doesn't work any more)

I think you will be more efficient for this task but I'm willing
to volunteer if you let me know how "silent" should behave.  The
documentation says it is useful only with -v and supresses the
diffs, so if that is the only thing it does, I think something
like this is sufficient?  Not tested enough but I am going to
crash for the day now.

------------
Use DIFF_FORMAT_NO_OUTPUT to implement diff-tree -s option.

Instead of checking silent flag all over the place, simply use
the NO_OUTPUT option diffcore provides to suppress the diff
output.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - HEAD: Allow symlinks in the leading path in checkout-cache --prefix=
# + (working tree)
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -2,7 +2,6 @@
 #include "cache.h"
 #include "diff.h"
 
-static int silent = 0;
 static int show_root_diff = 0;
 static int verbose_header = 0;
 static int ignore_merges = 1;
@@ -67,9 +66,6 @@ static void show_file(const char *prefix
 	const char *path;
 	const unsigned char *sha1 = extract(tree, size, &path, &mode);
 
-	if (silent)
-		return;
-
 	if (recursive && S_ISDIR(mode)) {
 		char type[20];
 		unsigned long size;
@@ -132,9 +128,6 @@ static int compare_tree_entry(void *tree
 		return retval;
 	}
 
-	if (silent)
-		return 0;
-
 	diff_change(mode1, mode2, sha1, sha2, base, path1);
 	return 0;
 }
@@ -395,8 +388,7 @@ static char *generate_header(const char 
 		if (this_header[offset-1] != '\n')
 			this_header[offset++] = '\n';
 		/* Add _another_ EOLN if we are doing diff output */
-		if (!silent)
-			this_header[offset++] = '\n';
+		this_header[offset++] = '\n';
 		this_header[offset] = 0;
 	}
 
@@ -442,8 +434,6 @@ static int diff_tree_commit(const unsign
 			 * Don't print multiple merge entries if we
 			 * don't print the diffs.
 			 */
-			if (silent)
-				break;
 		}
 		offset += 48;
 	}
@@ -540,7 +530,7 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-s")) {
-			silent = 1;
+			diff_output_format = DIFF_FORMAT_NO_OUTPUT;
 			continue;
 		}
 		if (!strcmp(arg, "-v")) {

Compilation finished at Tue May 24 02:03:10



