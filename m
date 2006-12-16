X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-clone: use wildcard specification for tracking branches
Date: Sat, 16 Dec 2006 01:14:39 -0800
Message-ID: <7vfybgjj7k.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 09:14:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 13 Dec 2006 13:35:08 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34596>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvVd2-0000L2-2m for gcvg-git@gmane.org; Sat, 16 Dec
 2006 10:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965338AbWLPJOm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 04:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965340AbWLPJOm
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 04:14:42 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33049 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965338AbWLPJOl (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 04:14:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216091440.SMZH22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 04:14:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zME01V0071kojtg0000000; Sat, 16 Dec 2006
 04:14:00 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This stops enumerating the set of branches found on the remote
side when a clone was made in the configuration file.  Instead,
a single entry that maps each remote branch to the local
tracking branch for the remote under the same name is created.

Doing it this way not only shortens the configuration file, but
automatically adjusts to a new branch added on the remote side
after the clone is made.

Unfortunately this cannot be done for the traditional layout,
where we always need to special case the 'master' to 'origin'
mapping within the local branch namespace.  But that is Ok; it
will be going away before v1.5.0.

We could also lose the "primary branch" mapping at the
beginning, but that has to wait until we implement the "forbid
'git pull' when we do not have branch.$current.merge for the
current branch" policy we earlier discussed.  That should also
be in v1.5.0

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
Junio C Hamano <junkio@cox.net> writes:

> Things that need to be done to complete what have been merged to
> 'master' are:
> ...
>  - 'git-clone' probably should be updated to use wild-card in
>    remote.origin.fetch, instead of listing all the branches it
>    found when the clone was made.

 git-clone.sh |   47 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 1f5d07a..422499a 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -366,41 +366,54 @@ then
 		)
 	)
 
-	# Write out remotes/$origin file, and update our "$head_points_at".
+	# Write out remote.$origin config, and update our "$head_points_at".
 	case "$head_points_at" in
 	?*)
-		mkdir -p "$GIT_DIR/remotes" &&
+		# Local default branch
 		git-symbolic-ref HEAD "refs/heads/$head_points_at" &&
+
+		# Tracking branch for the primary branch at the remote.
 		case "$use_separate_remote" in
 		t)	origin_track="$remote_top/$head_points_at"
 			git-update-ref HEAD "$head_sha1" ;;
 		*)	origin_track="$remote_top/$origin"
 			git-update-ref "refs/heads/$origin" "$head_sha1" ;;
 		esac &&
+
+		# Upstream URL and the primary branch tracking
 		git-repo-config remote."$origin".url "$repo" &&
 		git-repo-config remote."$origin".fetch \
 			"refs/heads/$head_points_at:$origin_track" &&
-		(cd "$GIT_DIR/$remote_top" && find . -type f -print) |
-		while read dotslref
-		do
-			name=`expr "$dotslref" : './\(.*\)'`
-			if test "z$head_points_at" = "z$name"
-			then
-				continue
-			fi
-			if test "$use_separate_remote" = '' &&
-			   test "z$origin" = "z$name"
-			then
-				continue
-			fi
-			git-repo-config remote."$origin".fetch "refs/heads/${name}:$remote_top/${name}" '^$'
-		done &&
+
+		# Set up the mappings to track the remaining branches.
+		case "$use_separate_remote" in
+		t)
+			git-repo-config remote."$origin".fetch \
+				"refs/heads/*:$remote_top/*" '^$'
+			;;
+		*)
+			(cd "$GIT_DIR/$remote_top" && find . -type f -print) |
+			while read dotslref
+			do
+				name=`expr "$dotslref" : './\(.*\)'`
+				if test "z$head_points_at" = "z$name" ||
+					test "z$origin" = "z$name"
+				then
+					continue
+				fi
+				git-repo-config remote."$origin".fetch \
+				"refs/heads/${name}:$remote_top/${name}" '^$'
+			done
+			;;
+		esac &&
+
 		case "$use_separate_remote" in
 		t)
 			rm -f "refs/remotes/$origin/HEAD"
 			git-symbolic-ref "refs/remotes/$origin/HEAD" \
 				"refs/remotes/$origin/$head_points_at"
 		esac &&
+
 		git-repo-config branch."$head_points_at".remote "$origin" &&
 		git-repo-config branch."$head_points_at".merge "refs/heads/$head_points_at"
 	esac
