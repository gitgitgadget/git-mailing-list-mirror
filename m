From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 1/2] graph API: fix graph mis-alignment after uninteresting commits
Date: Fri, 23 May 2008 19:24:10 -0700
Message-ID: <1211595851-11992-2-git-send-email-adam@adamsimpkins.net>
References: <7vk5hkpjj5.fsf@gitster.siamese.dyndns.org>
 <1211595851-11992-1-git-send-email-adam@adamsimpkins.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 04:25:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzjRp-0006aC-AE
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 04:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135AbYEXCYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 22:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756942AbYEXCYN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 22:24:13 -0400
Received: from smtp172.sat.emailsrvr.com ([66.216.121.172]:58831 "EHLO
	smtp172.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471AbYEXCYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 22:24:12 -0400
Received: from relay7.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 4A2961B423A;
	Fri, 23 May 2008 22:24:12 -0400 (EDT)
Received: by relay7.relay.sat.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 2CC811B4292;
	Fri, 23 May 2008 22:24:12 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 76EA814100C9; Fri, 23 May 2008 19:24:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.384.g3f697
In-Reply-To: <1211595851-11992-1-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82792>

The graphing code had a bug that caused it to output branch lines
incorrectly after ignoring an uninteresting commit.  When computing how
to match up the branch lines from the current commit to the next one, it
forgot to take into account that it needed to initially start with 2
empty spaces where the missing commit would have gone.

So, instead of drawing this,

| * | <- Commit with uninteresting parent
|  /
* |

It used to incorrectly draw this:

| * | <- Commit with uninteresting parent
* |

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 graph.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/graph.c b/graph.c
index 9d6ed30..400f014 100644
--- a/graph.c
+++ b/graph.c
@@ -190,7 +190,10 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	 * Ignore uinteresting and pruned commits
 	 */
 	if (commit->object.flags & (UNINTERESTING | TREESAME))
+	{
+		*mapping_index += 2;
 		return;
+	}
 
 	/*
 	 * If the commit is already in the new_columns list, we don't need to
-- 
1.5.5.1.359.gebc23.dirty
