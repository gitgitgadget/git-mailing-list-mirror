From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 1/1] graph API: always print 'M' for merge commits
Date: Sat, 24 May 2008 13:52:01 -0700
Message-ID: <1211662321-28846-2-git-send-email-adam@adamsimpkins.net>
References: <20080524182530.GB2997@mithlond.arda.local>
 <1211662321-28846-1-git-send-email-adam@adamsimpkins.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 22:52:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K00jZ-0003At-N8
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 22:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761005AbYEXUwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 16:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760992AbYEXUwG
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 16:52:06 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:41862 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760AbYEXUwF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 16:52:05 -0400
Received: from relay8.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id C9CF91B58C5;
	Sat, 24 May 2008 16:52:03 -0400 (EDT)
Received: by relay8.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 9FA1C1B537F;
	Sat, 24 May 2008 16:52:03 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 3A07014100C7; Sat, 24 May 2008 13:52:02 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.385.ge74ed
In-Reply-To: <1211662321-28846-1-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82830>

The recent changes for handling uninteresting commits changed the
behavior so that merge commits were displayed as 'M' only if they had
multiple interesting parents.

This change reverts to the old behavior of displaying merges as 'M',
even if they have less than 2 parents displayed in the graph.
---
 graph.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/graph.c b/graph.c
index add7e44..ba9ede0 100644
--- a/graph.c
+++ b/graph.c
@@ -566,15 +566,17 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 		if (col_commit == graph->commit) {
 			seen_this = 1;
 			/*
-			 * If the commit has more than 1 interesting
-			 * parent, print 'M' to indicate that it is a
-			 * merge.  Otherwise, print '*'.
+			 * If the commit is a merge, print 'M'.  Otherwise,
+			 * print '*'.
 			 *
-			 * Note that even if this is actually a merge
-			 * commit, we still print '*' if less than 2 of its
-			 * parents are interesting.
+			 * Note that we don't check graph->num_parents to
+			 * determine if the commit is a merge, since that
+			 * only tracks the number of "interesting" parents.
+			 * We want to print 'M' for merge commits even if
+			 * they have less than 2 interesting parents.
 			 */
-			if (graph->num_parents > 1)
+			if (graph->commit->parents != NULL &&
+			    graph->commit->parents->next != NULL)
 				strbuf_addch(sb, 'M');
 			else
 				strbuf_addch(sb, '*');
-- 
1.5.5.1.385.ge74ed
