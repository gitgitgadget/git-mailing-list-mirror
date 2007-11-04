From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/5] pretty describe: avoid calling find_unique_abbrev() if
 not needed
Date: Sun, 04 Nov 2007 12:49:15 +0100
Message-ID: <472DB1BB.9080805@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:49:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IodzE-0001LI-Cl
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263AbXKDLtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757310AbXKDLtb
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:49:31 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:43797
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757048AbXKDLta (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 06:49:30 -0500
Received: from [10.0.1.201] (p57B7FCFB.dip.t-dialin.net [87.183.252.251])
	by neapel230.server4you.de (Postfix) with ESMTP id ABA06873BA;
	Sun,  4 Nov 2007 12:49:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63393>

As suggested by Junio, --pretty=format can be sped up by avoiding to
call find_unique_abbrev() if it's not needed.  This is quite easy
after the "pretty describe" series, as interp_count() exists and has
already been called to avoid the (even bigger) overhead of the
describe placeholders.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 commit.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/commit.c b/commit.c
index 06d5cec..9ff4735 100644
--- a/commit.c
+++ b/commit.c
@@ -851,13 +851,17 @@ void format_commit_message(struct commit *commit,
 	if (!commit->object.parsed)
 		parse_object(commit->object.sha1);
 	interp_set_entry(table, IHASH, sha1_to_hex(commit->object.sha1));
-	interp_set_entry(table, IHASH_ABBREV,
-			find_unique_abbrev(commit->object.sha1,
-				DEFAULT_ABBREV));
+	if (occurs[IHASH_ABBREV]) {
+		interp_set_entry(table, IHASH_ABBREV,
+		                 find_unique_abbrev(commit->object.sha1,
+		                                    DEFAULT_ABBREV));
+	}
 	interp_set_entry(table, ITREE, sha1_to_hex(commit->tree->object.sha1));
-	interp_set_entry(table, ITREE_ABBREV,
-			find_unique_abbrev(commit->tree->object.sha1,
-				DEFAULT_ABBREV));
+	if (occurs[ITREE_ABBREV]) {
+		interp_set_entry(table, ITREE_ABBREV,
+		                 find_unique_abbrev(commit->tree->object.sha1,
+		                                    DEFAULT_ABBREV));
+	}
 	interp_set_entry(table, ILEFT_RIGHT,
 			 (commit->object.flags & BOUNDARY)
 			 ? "-"
@@ -873,14 +877,17 @@ void format_commit_message(struct commit *commit,
 			sha1_to_hex(p->item->object.sha1));
 	interp_set_entry(table, IPARENTS, parents + 1);
 
-	parents[1] = 0;
-	for (i = 0, p = commit->parents;
-			p && i < sizeof(parents) - 1;
-			p = p->next)
-		i += snprintf(parents + i, sizeof(parents) - i - 1, " %s",
-			find_unique_abbrev(p->item->object.sha1,
-				DEFAULT_ABBREV));
-	interp_set_entry(table, IPARENTS_ABBREV, parents + 1);
+	if (occurs[IPARENTS_ABBREV]) {
+		parents[1] = 0;
+		for (i = 0, p = commit->parents;
+		     p && i < sizeof(parents) - 1;
+		     p = p->next)
+			i += snprintf(parents + i, sizeof(parents) - i - 1,
+			              " %s",
+			              find_unique_abbrev(p->item->object.sha1,
+			                                 DEFAULT_ABBREV));
+		interp_set_entry(table, IPARENTS_ABBREV, parents + 1);
+	}
 
 	if (occurs[IDESC] || occurs[IDESC_DEPTH] || occurs[IDESC_NAME]) {
 		struct strbuf desc;
-- 
1.5.3.5.529.ge3d6d
