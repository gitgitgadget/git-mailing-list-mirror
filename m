From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] git-prune: never lose objects reachable from our refs.
Date: Thu, 08 Dec 2005 23:25:10 -0800
Message-ID: <7vmzja91gp.fsf_-_@assigned-by-dhcp.cox.net>
References: <1134084485547-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
	<1134084485869-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
	<7v4q5jb149.fsf@assigned-by-dhcp.cox.net>
	<7vzmnb9m7w.fsf@assigned-by-dhcp.cox.net>
	<7voe3r9krf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 09 08:25:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekcd8-0003lu-As
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 08:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVLIHZO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 02:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVLIHZO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 02:25:14 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:6124 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932384AbVLIHZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 02:25:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209072353.HQCV17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Dec 2005 02:23:53 -0500
To: git@vger.kernel.org
In-Reply-To: <7voe3r9krf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 08 Dec 2005 16:28:20 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13415>

Explicit <head> arguments to git-prune replaces, instead of
extends, the list of heads used for reachability analysis by
fsck-objects.  By giving a subset of heads by mistake, objects
reachable only from other heads can be removed, resulting in a
corrupted repository.

This commit stops replacing the list of heads, and makes the
command line arguments to add to them instead for safety.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I think this is preferable in general than leaving the
   end-user tool too sharp-edged and dangerous.

 Documentation/git-prune.txt |   27 +++++++++------------------
 git-prune.sh                |    6 +++++-
 2 files changed, 14 insertions(+), 19 deletions(-)

2b86976bfd6e42609692d57fffaef72bd985c23a
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 05c8d49..f694fcb 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -13,10 +13,11 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-This runs `git-fsck-objects --unreachable` using the heads
-specified on the command line (or `$GIT_DIR/refs/heads/\*` and
-`$GIT_DIR/refs/tags/\*` if none is specified), and prunes all
-unreachable objects from the object database.  In addition, it
+This runs `git-fsck-objects --unreachable` using all the refs
+available in `$GIT_DIR/refs`, optionally with additional set of
+objects specified on the command line, and prunes all
+objects unreachable from any of these head objects from the object database.
+In addition, it
 prunes the unpacked objects that are also found in packs by
 running `git prune-packed`.
 
@@ -31,29 +32,19 @@ OPTIONS
 	Do not interpret any more arguments as options.
 
 <head>...::
-	Instead of keeping objects
+	In addition to objects
 	reachable from any of our references, keep objects
-	reachable from only listed <head>s.
-+
-Note that the explicitly named <head>s are *not* appended to the
-default set of references, but they replace them.  In general you
-would want to say `git prune $(git-rev-parse --all) extra1
-extra2` to keep chains of commits leading to extra1, extra2,
-... in addition to what are reachable from your own refs.
-Saying `git prune extra1 extra2` would *lose* objects reachable
-only from the usual refs, which is usually not what you want.
-
+	reachable from listed <head>s.
 
 EXAMPLE
 -------
 
-To prune objects not used by your repository and another that
+To prune objects not used by your repository nor another that
 borrows from your repository via its
 `.git/objects/info/alternates`:
 
 ------------
-$ git prune $(git-rev-parse --all) \
-  $(cd ../another && $(git-rev-parse --all))
+$ git prune $(cd ../another && $(git-rev-parse --all))
 ------------
 
 Author
diff --git a/git-prune.sh b/git-prune.sh
index 1fd8c73..7e7f0ad 100755
--- a/git-prune.sh
+++ b/git-prune.sh
@@ -16,7 +16,11 @@ do
 done
 
 sync
-git-fsck-objects --full --cache --unreachable "$@" |
+case "$#" in
+0) git-fsck-objects --full --cache --unreachable ;;
+*) git-fsck-objects --full --cache --unreachable $(git-rev-parse --all) "$@" ;;
+esac |
+
 sed -ne '/unreachable /{
     s/unreachable [^ ][^ ]* //
     s|\(..\)|\1/|p
-- 
0.99.9.GIT
