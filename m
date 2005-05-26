From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] Detect copies harder in diff-tree.
Date: Wed, 25 May 2005 20:17:22 -0700
Message-ID: <7vzmuiekvx.fsf_-_@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 05:16:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db8qi-00012W-Qg
	for gcvg-git@gmane.org; Thu, 26 May 2005 05:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVEZDRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 23:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVEZDRf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 23:17:35 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62162 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261159AbVEZDRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 23:17:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526031721.MBYF19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 23:17:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505232314510.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 23 May 2005 23:19:49 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> That said, I don't think -C is that important.

By now, you know I won't listen ;-).

I've done preliminary --detect-copies-harder (that is to feed all
the unmodified files to diffcore when doing -C) and --use-cache
(this is to allow diffcore to avoid expanding blob when there is
a already matching file in the work tree) changes to diff-tree.

This example is from the linux-2.6 tree, with the tip of the
tree in the work tree and the cache, and looking at the commit
when include/asm-um was cleaned up (May 5th).  The first one
does not detect copies from "unmodified" files, but the latter
two do.  In this commit there isn't any copy that "harder"
version finds but ordinary one doesn't.

: siamese; time ../git.junio/git-diff-tree -r \
  -C dbc35cc73f2edd6e39d7e814dbb6eddad6294665 >/dev/null
real    0m0.010s
user    0m0.010s
sys     0m0.000s
: siamese; time ../git.junio/git-diff-tree -r --detect-copies-harder \
  -C dbc35cc73f2edd6e39d7e814dbb6eddad6294665 >/dev/null
real    0m19.938s
user    0m11.520s
sys     0m1.240s
: siamese; time ../git.junio/git-diff-tree -r \
  --detect-copies-harder --use-cache -C \
  dbc35cc73f2edd6e39d7e814dbb6eddad6294665 >/dev/null
real    0m5.858s
user    0m5.110s
sys     0m0.710s

------------
Add --detect-copies-harder and --use-cache to diff-tree.

This adds two new options to diff-tree.  Even when -C is used,
diff-tree does not normally feed "unmodified" filepair to the
diffcore, so copy detection is done only among the files that
have changed.  With --detect-copies-harder, it can also detect
copies made from an unmodified file (this behavior is the
default for diff-files and diff-cache).  When this option is
used, it is recommended to also give --use-cache, which lets
diffcore to avoid expanding blob when the work tree has the same
file unmodified.

Signed-off-by: Junio C Hamano <junkio@cox.net> 
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - linus: git-rev-list: add "end" commit and "--header" flag
# + (working tree)
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -6,6 +6,8 @@ static int show_root_diff = 0;
 static int verbose_header = 0;
 static int ignore_merges = 1;
 static int recursive = 0;
+static int use_cache = 0;
+static int detect_copies_harder = 0;
 static int show_tree_entry_in_recursive = 0;
 static int read_stdin = 0;
 static int diff_output_format = DIFF_FORMAT_HUMAN;
@@ -108,7 +110,8 @@ static int compare_tree_entry(void *tree
 		show_file("+", tree2, size2, base);
 		return 1;
 	}
-	if (!memcmp(sha1, sha2, 20) && mode1 == mode2)
+	if (!memcmp(sha1, sha2, 20) && mode1 == mode2 &&
+	    (detect_rename != DIFF_DETECT_COPY || !detect_copies_harder))
 		return 0;
 
 	/*
@@ -549,6 +552,14 @@ int main(int argc, const char **argv)
 			read_stdin = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--use-cache")) {
+			use_cache = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--detect-copies-harder")) {
+			detect_copies_harder = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--root")) {
 			show_root_diff = 1;
 			continue;
@@ -566,6 +577,16 @@ int main(int argc, const char **argv)
 			pathlens[i] = strlen(paths[i]);
 	}
 
+	if (detect_rename && use_cache && !active_cache) {
+		/* read-cache does not die even when it fails
+		 * so it is safe for us to do this here.  Also
+		 * it does not smudge active_cache or active_nr
+		 * when it fails, so we do not have to worry about
+		 * cleaning it up oufselves either.
+		 */
+		read_cache();
+	}
+
 	switch (nr_sha1) {
 	case 0:
 		if (!read_stdin)

Compilation finished at Wed May 25 19:59:09

