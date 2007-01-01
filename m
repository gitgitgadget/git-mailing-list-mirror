From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-fetch: remove .keep file even on other errors.
Date: Mon, 01 Jan 2007 12:42:57 -0800
Message-ID: <7vr6ue7a26.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611301441440.9647@xanadu.home>
	<7vd574iqa0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612282031390.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 21:43:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Tzz-0001wV-54
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 21:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbXAAUm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 15:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbXAAUm7
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 15:42:59 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39692 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbXAAUm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 15:42:59 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070101204258.IBJ9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jan 2007 15:42:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5wiB1W00b1kojtg0000000; Mon, 01 Jan 2007 15:42:12 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0612282031390.18171@xanadu.home> (Nicolas Pitre's
	message of "Thu, 28 Dec 2006 20:41:53 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35740>

Actually removal of them is needed especially on errors.  The
original code had the removal outside of the process which sets
the flag to tell the later step what to remove, but it runs as a
downstream of a pipeline and its effect was lost.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
  Nicolas Pitre <nico@cam.org> writes:

  > [ resuming an old thread ]

  Likewise...  This should fix it, I think.

 git-fetch.sh |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 8bd11f8..466fe59 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -382,13 +382,22 @@ fetch_main () {
       ;; # we are already done.
   *)
     ( : subshell because we muck with IFS
-      pack_lockfile=
       IFS=" 	$LF"
       (
-	  git-fetch-pack --thin $exec $keep $shallow_depth "$remote" $rref || echo failed "$remote"
+	  git-fetch-pack --thin $exec $keep $shallow_depth "$remote" $rref ||
+	  echo failed "$remote"
       ) |
-      while read sha1 remote_name
-      do
+      (
+	trap '
+		if test -n "$keepfile" && test -f "$keepfile"
+		then
+			rm -f "$keepfile"
+		fi
+	' 0
+
+        keepfile=
+	while read sha1 remote_name
+	do
 	  case "$sha1" in
 	  failed)
 		  echo >&2 "Fetch failure: $remote"
@@ -397,7 +406,7 @@ fetch_main () {
 	  pack)
 		  continue ;;
 	  keep)
-		  pack_lockfile="$GIT_OBJECT_DIRECTORY/pack/pack-$remote_name.keep"
+		  keepfile="$GIT_OBJECT_DIRECTORY/pack/pack-$remote_name.keep"
 		  continue ;;
 	  esac
 	  found=
@@ -429,8 +438,8 @@ fetch_main () {
 	  append_fetch_head "$sha1" "$remote" \
 		  "$remote_name" "$remote_nick" "$local_name" \
 		  "$not_for_merge" || exit
-      done &&
-      if [ "$pack_lockfile" ]; then rm -f "$pack_lockfile"; fi
+        done
+      )
     ) || exit ;;
   esac
 
-- 
1.5.0.rc0.ga105
