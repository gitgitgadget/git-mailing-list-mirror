X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-checkout: allow pathspec to recover lost working tree directory
Date: Wed, 15 Nov 2006 11:07:19 -0800
Message-ID: <7vbqn8msuw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 19:08:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31472>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQ7P-0006Ee-6U for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030902AbWKOTHh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030900AbWKOTHh
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:07:37 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63691 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1030902AbWKOTHf
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:07:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115190735.SGYZ4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 14:07:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n77h1V0061kojtg0000000; Wed, 15 Nov 2006
 14:07:41 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

It is often wanted on the #git channel that this were to work to
recover removed directory:

	rm -fr Documentation
	git checkout -- Documentation
	git checkout HEAD -- Documentation ;# alternatively

Now it does.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * Back to fixing usability issues one at a time instead of
   throwing everything away with bathwater.

 git-checkout.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index eb28b29..737abd0 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -112,7 +112,11 @@ Did you intend to checkout '$@' which ca
 		git-ls-tree --full-name -r "$new" "$@" |
 		git-update-index --index-info || exit $?
 	fi
-	git-checkout-index -f -u -- "$@"
+
+	# Make sure the request is about existing paths.
+	git-ls-files --error-unmatch -- "$@" >/dev/null || exit
+	git-ls-files -- "$@" |
+	git-checkout-index -f -u --stdin
 	exit $?
 else
 	# Make sure we did not fall back on $arg^{tree} codepath
-- 
1.4.4

