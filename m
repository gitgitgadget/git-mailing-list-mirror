From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] commit: fix a segfault when displaying a commit with unreachable parents
Date: Wed, 11 Oct 2006 16:16:02 -0700
Message-ID: <11606085621137-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Oct 12 01:16:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXnJ5-00077f-Gw
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 01:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161277AbWJKXQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 19:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161278AbWJKXQH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 19:16:07 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35212 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1161277AbWJKXQF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 19:16:05 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 10A667DC08E;
	Wed, 11 Oct 2006 16:16:02 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 16:16:02 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.3.rc2.g1cbb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28763>

I was running git show on various commits found by fsck-objects
when I found this bug.  Since find_unique_abbrev() cannot find
an abbreviation for an object not in the database, it will
return NULL, which is bad to run strlen() on.  So instead, we'll
just display the unabbreviated sha1 that we referenced in the
commit.

I'm not sure that this is the best 'fix' for it because the
commit I was trying to show was broken, but I don't think a
program should segfault even if the user tries to do something
stupid.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 commit.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 5b6e082..a6d543e 100644
--- a/commit.c
+++ b/commit.c
@@ -548,10 +548,13 @@ static int add_merge_info(enum cmit_fmt 
 
 	while (parent) {
 		struct commit *p = parent->item;
-		const char *hex = abbrev
-			? find_unique_abbrev(p->object.sha1, abbrev)
-			: sha1_to_hex(p->object.sha1);
-		const char *dots = (abbrev && strlen(hex) != 40) ? "..." : "";
+		const char *hex = NULL;
+		const char *dots;
+		if (abbrev)
+			hex = find_unique_abbrev(p->object.sha1, abbrev);
+		if (!hex)
+			hex = sha1_to_hex(p->object.sha1);
+		dots = (abbrev && strlen(hex) != 40) ?  "..." : "";
 		parent = parent->next;
 
 		offset += sprintf(buf + offset, " %s%s", hex, dots);
-- 
1.4.3.rc2.g823d6-dirty
