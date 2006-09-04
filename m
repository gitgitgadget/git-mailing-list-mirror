From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-repack: create new packs inside $PACKDIR, not cwd
Date: Mon, 04 Sep 2006 02:50:28 -0700
Message-ID: <7vr6ysneor.fsf@assigned-by-dhcp.cox.net>
References: <11573485523752-git-send-email-martin@catalyst.net.nz>
	<20060904090833.GF17042@admingilde.org>
	<7vveo4nfbg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Sep 04 11:50:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKB5q-0001cf-FG
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 11:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWIDJuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 05:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWIDJuK
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 05:50:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35327 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751294AbWIDJuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 05:50:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904095008.PPKS4015.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 Sep 2006 05:50:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id J9q91V00B1kojtg0000000
	Mon, 04 Sep 2006 05:50:09 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <7vveo4nfbg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 04 Sep 2006 02:36:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26411>

Junio C Hamano <junkio@cox.net> writes:

> Writing into $cwd was certainly a carelessness; we tend to use
> $GIT_DIR/ for this kind of thing.

In other words...

-- >8 --
From: Martin Langhoff <martin@catalyst.net.nz>
Date: Mon, 4 Sep 2006 17:42:32 +1200
Subject: [PATCH] git-repack: create new packs inside $GIT_DIR, not cwd

Avoid failing when cwd is !writable by writing the
packfiles in $GIT_DIR, which is more in line with other commands.

Without this, git-repack was failing when run from crontab
by non-root user accounts. For large repositories, this
also makes the mv operation a lot cheaper, and avoids leaving
temp packfiles around the fs upon failure.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-repack.sh |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 584a732..b525fc5 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -24,8 +24,10 @@ do
 	shift
 done
 
-rm -f .tmp-pack-*
 PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
+PACKTMP="$GIT_DIR/.tmp-$$-pack"
+rm -f "$PACKTMP"-*
+trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
 
 # There will be more repacking strategies to come...
 case ",$all_into_one," in
@@ -42,11 +44,12 @@ case ",$all_into_one," in
 	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
 	;;
 esac
+
 pack_objects="$pack_objects $local $quiet $no_reuse_delta$extra"
 name=$( { git-rev-list --objects --all $rev_list ||
 	  echo "git-rev-list died with exit code $?"
 	} |
-	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
+	git-pack-objects --non-empty $pack_objects "$PACKTMP") ||
 	exit 1
 if [ -z "$name" ]; then
 	echo Nothing new to pack.
@@ -64,8 +67,8 @@ else
 				"$PACKDIR/old-pack-$name.$sfx"
 		fi
 	done &&
-	mv -f .tmp-pack-$name.pack "$PACKDIR/pack-$name.pack" &&
-	mv -f .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" &&
+	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
+	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
 	test -f "$PACKDIR/pack-$name.pack" &&
 	test -f "$PACKDIR/pack-$name.idx" || {
 		echo >&2 "Couldn't replace the existing pack with updated one."
-- 
1.4.2.g99d7d



-- 
VGER BF report: U 0.870206
