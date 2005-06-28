From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Adjust fsck-cache to packed GIT and alternate object pool.
Date: Tue, 28 Jun 2005 01:49:39 -0700
Message-ID: <7vslz2x3vg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 10:48:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnBlV-0000M3-RA
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 10:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVF1Ixz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 04:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVF1IxA
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 04:53:00 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20460 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261870AbVF1Itl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 04:49:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628084940.XQAC8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 04:49:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 27 Jun 2005 18:14:40 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> There are some other issues too, like the fact that "git-fsck-cache"  
LT> doesn't know about the pack-files yet, so it will complain about missing
LT> objects etc.

And here is a patch to fix it.  It is interesting to know that
the same problem existed for a long time in a different form and
nobody has complained: GIT_ALTERNATE_OBJECT_DIRECTORIES.

Maybe the alternate object pool mechanism is not so widely used
and probably not very useful for everyday use.  I donno.

------------
The fsck-cache complains if objects referred to by files in
.git/refs/ or objects stored in files under .git/objects/??/ are
not found as stand-alone SHA1 files (i.e. found in alternate
object pools GIT_ALTERNATE_OBJECT_DIRECTORIES or packed archives
stored under .git/objects/pack).

Although this is a good semantics to maintain consistency of a
single .git/objects directory as a self contained set of
objects, it sometimes is useful to consider it is OK as long as
these "outside" objects are available.

This commit introduces a new flag, --standalone, to
git-fsck-cache.  When it is not specified, connectivity checks
and .git/refs pointer checks are taught that it is OK when
expected objects do not exist under .git/objects/?? hierarchy
but are available from an packed archive or in an alternate
object pool.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 fsck-cache.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

ea4255429bb0b4b760ba2fe327f5806d8d24d8a6
diff --git a/fsck-cache.c b/fsck-cache.c
--- a/fsck-cache.c
+++ b/fsck-cache.c
@@ -12,6 +12,7 @@
 static int show_root = 0;
 static int show_tags = 0;
 static int show_unreachable = 0;
+static int standalone = 0;
 static int keep_cache_objects = 0; 
 static unsigned char head_sha1[20];
 
@@ -25,13 +26,17 @@ static void check_connectivity(void)
 		struct object_list *refs;
 
 		if (!obj->parsed) {
-			printf("missing %s %s\n",
-			       obj->type, sha1_to_hex(obj->sha1));
+			if (!standalone && has_sha1_file(obj->sha1))
+				; /* it is in pack */
+			else
+				printf("missing %s %s\n",
+				       obj->type, sha1_to_hex(obj->sha1));
 			continue;
 		}
 
 		for (refs = obj->refs; refs; refs = refs->next) {
-			if (refs->item->parsed)
+			if (refs->item->parsed ||
+			    (!standalone && has_sha1_file(refs->item->sha1)))
 				continue;
 			printf("broken link from %7s %s\n",
 			       obj->type, sha1_to_hex(obj->sha1));
@@ -315,8 +320,11 @@ static int read_sha1_reference(const cha
 		return -1;
 
 	obj = lookup_object(sha1);
-	if (!obj)
+	if (!obj) {
+		if (!standalone && has_sha1_file(sha1))
+			return 0; /* it is in pack */
 		return error("%s: invalid sha1 pointer %.40s", path, hexname);
+	}
 
 	obj->used = 1;
 	mark_reachable(obj, REACHABLE);
@@ -390,6 +398,10 @@ int main(int argc, char **argv)
 			keep_cache_objects = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--standalone")) {
+			standalone = 1;
+			continue;
+		}
 		if (*arg == '-')
 			usage("git-fsck-cache [--tags] [[--unreachable] [--cache] <head-sha1>*]");
 	}
------------
