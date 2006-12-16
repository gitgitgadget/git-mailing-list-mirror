X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-pull: refuse default merge without branch.*.merge
Date: Sat, 16 Dec 2006 01:36:32 -0800
Message-ID: <7v3b7gji73.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<7vfybgjj7k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 09:36:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34597>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvVyG-0001yc-T1 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 10:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965351AbWLPJge (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 04:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965352AbWLPJge
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 04:36:34 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34698 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965351AbWLPJgd (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 04:36:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216093632.SRGA22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 04:36:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zMbs1V00F1kojtg0000000; Sat, 16 Dec 2006
 04:35:53 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Everybody hated the pull behaviour of merging the first branch
listed on remotes/* file (or remote.*.fetch config) into the
current branch.  This finally corrects that UI wart by
forbidding "git pull" without an explicit branch name on the
command line or branch.$current.merge for the current branch.

The matching change to git-clone was made to prepare the default
branch.*.merge entry for the primary branch some time ago.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
Junio C Hamano <junkio@cox.net> writes:

> We could also lose the "primary branch" mapping at the
> beginning, but that has to wait until we implement the "forbid
> 'git pull' when we do not have branch.$current.merge for the
> current branch" policy we earlier discussed.  That should also
> be in v1.5.0

  And this does exactly that.

 git-parse-remote.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 6ae534b..7cd79c2 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -144,7 +144,8 @@ canon_refs_list_for_fetch () {
 			curr_branch=$(git-symbolic-ref HEAD | \
 			    sed -e 's|^refs/heads/||')
 			merge_branches=$(git-repo-config \
-			    --get-all "branch.${curr_branch}.merge")
+			    --get-all "branch.${curr_branch}.merge") ||
+			merge_branches=.this.would.never.match.any.ref.
 		fi
 		set x $(expand_refs_wildcard "$@")
 		shift
