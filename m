X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-add: remove conflicting entry when adding.
Date: Sun, 17 Dec 2006 01:11:54 -0800
Message-ID: <7v3b7e7up1.fsf_-_@assigned-by-dhcp.cox.net>
References: <458437E0.1050501@midwinter.com> <45843C5A.8020501@gmail.com>
	<45848CF8.4000704@midwinter.com>
	<7vvekb73jh.fsf@assigned-by-dhcp.cox.net>
	<7vk60r7139.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 09:12:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vk60r7139.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 16 Dec 2006 17:39:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34680>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvs3w-0007F5-RL for gcvg-git@gmane.org; Sun, 17 Dec
 2006 10:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752278AbWLQJL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 04:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbWLQJL4
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 04:11:56 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40401 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752278AbWLQJLz (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 04:11:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217091154.YZPN16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Sun, 17
 Dec 2006 04:11:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zlC61V00Q1kojtg0000000; Sun, 17 Dec 2006
 04:12:06 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

When replacing an existing file A with a directory A that has a
file A/B in it in the index, 'git add' did not succeed because
it forgot to pass the allow-replace flag to add_cache_entry().

It might be safer to leave this as an error and require the user
to explicitly remove the existing A first before adding A/B
since it is an unusual case, but doing that automatically is
much easier to use.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index e856a2e..b8d83cc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -358,7 +358,7 @@ int add_file_to_index(const char *path, int verbose)
 
 	if (index_path(ce->sha1, path, &st, 1))
 		die("unable to index file %s", path);
-	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD))
+	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
 		die("unable to add %s to index",path);
 	if (verbose)
 		printf("add '%s'\n", path);
-- 
1.4.4.2.g83c5

