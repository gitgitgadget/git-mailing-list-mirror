From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix "--pretty=format:" for parent related items.
Date: Wed, 28 Mar 2007 13:37:08 -0700
Message-ID: <7vhcs5f6kr.fsf_-_@assigned-by-dhcp.cox.net>
References: <20070328000828.GA13273@coredump.intra.peff.net>
	<20070328192111.GA2588@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:37:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWetP-0002un-2G
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 22:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbXC1UhL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 16:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbXC1UhL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 16:37:11 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:32991 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbXC1UhK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 16:37:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328203709.CBKU28126.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 28 Mar 2007 16:37:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gLd81W00N1kojtg0000000; Wed, 28 Mar 2007 16:37:09 -0400
In-Reply-To: <20070328192111.GA2588@steel.home> (Alex Riesen's message of
	"Wed, 28 Mar 2007 21:21:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43385>

There are two breakages in the %P/%p interpolation.  It appended
an excess SP at the end of the list, and it gave uninitialized
contents of a buffer on the stack for root commits.

This fixes it, while updating the t6006 test which expected the
wrong output.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 commit.c                   |   12 ++++++++----
 t/t6006-rev-list-format.sh |    8 ++++----
 2 files changed, 12 insertions(+), 8 deletions(-)
 mode change 100644 => 100755 t/t6006-rev-list-format.sh

diff --git a/commit.c b/commit.c
index a92958c..33b63c4 100644
--- a/commit.c
+++ b/commit.c
@@ -849,19 +849,23 @@ static long format_commit_message(const struct commit *commit,
 	interp_set_entry(table, ITREE_ABBREV,
 			find_unique_abbrev(commit->tree->object.sha1,
 				DEFAULT_ABBREV));
+
+	parents[1] = 0;
 	for (i = 0, p = commit->parents;
 			p && i < sizeof(parents) - 1;
 			p = p->next)
-		i += snprintf(parents + i, sizeof(parents) - i - 1, "%s ",
+		i += snprintf(parents + i, sizeof(parents) - i - 1, " %s",
 			sha1_to_hex(p->item->object.sha1));
-	interp_set_entry(table, IPARENTS, parents);
+	interp_set_entry(table, IPARENTS, parents + 1);
+
+	parents[1] = 0;
 	for (i = 0, p = commit->parents;
 			p && i < sizeof(parents) - 1;
 			p = p->next)
-		i += snprintf(parents + i, sizeof(parents) - i - 1, "%s ",
+		i += snprintf(parents + i, sizeof(parents) - i - 1, " %s",
 			find_unique_abbrev(p->item->object.sha1,
 				DEFAULT_ABBREV));
-	interp_set_entry(table, IPARENTS_ABBREV, parents);
+	interp_set_entry(table, IPARENTS_ABBREV, parents + 1);
 
 	for (i = 0, state = HEADER; msg[i] && state < BODY; i++) {
 		int eol;
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
old mode 100644
new mode 100755
index cf096c3..ce9c7dc
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -39,11 +39,11 @@ EOF
 
 test_format parents %P%n%p <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
-86c75cfd708a0e5868dc876ed5b8bb66c80b4873 
-86c75cf 
+86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+86c75cf
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cf 
-86c75cf 
+
+
 EOF
 
 # we don't test relative here
-- 
1.5.1.rc2.632.g054ea8
