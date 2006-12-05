X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] git-reset to remove "$GIT_DIR/MERGE_MSG"
Date: Mon, 04 Dec 2006 19:44:40 -0800
Message-ID: <7v4psbknvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 03:44:47 +0000 (UTC)
Cc: ltuikov@yahoo.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33291>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrREb-0001vW-2B for gcvg-git@gmane.org; Tue, 05 Dec
 2006 04:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968051AbWLEDom (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 22:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968064AbWLEDom
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 22:44:42 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53606 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968051AbWLEDol (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 22:44:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205034441.ZTPR18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Mon, 4
 Dec 2006 22:44:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id urkq1V00h1kojtg0000000; Mon, 04 Dec 2006
 22:44:51 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

An earlier commit a9cb3c6e changed git-commit to use the
contents of MERGE_MSG even when we do not have MERGE_HEAD (the
rationale is in its log message).

However, the change tricks the following sequence to include a
merge message in a completely unrelated commit:

	$ git pull somewhere
	: oops, the conflicts are too much.  forget it.
        $ git reset --hard
        : work work work
        $ git commit

To fix this confusion, this patch makes "git reset" to remove
the leftover MERGE_MSG that was prepared when the user abandoned
the merge.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Marked as RFC because I suspect I am missing a valid use case
   where a user might want to say "reset" as part of continuing
   the conflicted merge resolution, although I do not think of
   any offhand...

 git-reset.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index 3133b5b..c0feb44 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -63,6 +63,7 @@ case "$reset_type" in
 	;;
 esac
 
-rm -f "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/rr-cache/MERGE_RR" "$GIT_DIR/SQUASH_MSG"
+rm -f "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/rr-cache/MERGE_RR" \
+	"$GIT_DIR/SQUASH_MSG" "$GIT_DIR/MERGE_MSG"
 
 exit $update_ref_status

