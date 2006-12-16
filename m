X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-clone: lose the artificial "first" fetch refspec
Date: Sat, 16 Dec 2006 01:41:51 -0800
Message-ID: <7vvekci3ds.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<7vfybgjj7k.fsf@assigned-by-dhcp.cox.net>
	<7v3b7gji73.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 09:42:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v3b7gji73.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 16 Dec 2006 01:36:32 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34599>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvW3N-0002WV-Up for gcvg-git@gmane.org; Sat, 16 Dec
 2006 10:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965360AbWLPJl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 04:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965361AbWLPJl5
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 04:41:57 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59714 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965360AbWLPJl4 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 04:41:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216094152.ZQSA97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 04:41:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zMhC1V0071kojtg0000000; Sat, 16 Dec 2006
 04:41:12 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Now we lost the "first refspec is the one that is merged by default"
rule, there is no reason for clone to list the remote primary branch
in the config file explicitly anymore.

We still need it for the traditional layout for other reasons,
though.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
> Junio C Hamano <junkio@cox.net> writes:
>
>> We could also lose the "primary branch" mapping at the
>> beginning, but that has to wait until we implement the "forbid
>> 'git pull' when we do not have branch.$current.merge for the
>> current branch" policy we earlier discussed.  That should also
>> be in v1.5.0
>
>   And this does exactly that.

 Next step will be to remove the traditional layout altogether.
 With the recent flurry of UI updates, I think it is sane to do
 that before v1.5.0; opinions?

 git-clone.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 422499a..68dc4f2 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -380,18 +380,18 @@ then
 			git-update-ref "refs/heads/$origin" "$head_sha1" ;;
 		esac &&
 
-		# Upstream URL and the primary branch tracking
+		# Upstream URL
 		git-repo-config remote."$origin".url "$repo" &&
-		git-repo-config remote."$origin".fetch \
-			"refs/heads/$head_points_at:$origin_track" &&
 
-		# Set up the mappings to track the remaining branches.
+		# Set up the mappings to track the remote branches.
 		case "$use_separate_remote" in
 		t)
 			git-repo-config remote."$origin".fetch \
 				"refs/heads/*:$remote_top/*" '^$'
 			;;
 		*)
+			git-repo-config remote."$origin".fetch \
+				"refs/heads/$head_points_at:$origin_track" &&
 			(cd "$GIT_DIR/$remote_top" && find . -type f -print) |
 			while read dotslref
 			do
