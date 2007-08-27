From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] name-rev: Fix non-shortest description
Date: Mon, 27 Aug 2007 12:37:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708231557590.20400@racer.site>
References: <20070823103817.GF6573@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-365382724-1188214653=:28586"
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Mon Aug 27 13:35:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPcsT-0000a5-MF
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 13:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbXH0LfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 07:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbXH0LfZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 07:35:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:42449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754045AbXH0LfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 07:35:24 -0400
Received: (qmail invoked by alias); 27 Aug 2007 11:35:23 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp028) with SMTP; 27 Aug 2007 13:35:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uyKxJVtvuUOWTSdCenT7UZJimwpgx0OKVBvDqvN
	Da+TXMOWQwdzDl
X-X-Sender: gene099@racer.site
In-Reply-To: <20070823103817.GF6573@informatik.uni-freiburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56818>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-365382724-1188214653=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


Uwe Kleine-König noticed that under certain circumstances, name-rev
picked a non-optimal tag.  Jeff King analyzed that name-rev only
takes into account the number of merge traversals, and then the
_last_ number in the description.

As an easy way to fix it, use a weighting factor for merge traversals:
A merge traversal is now made 65535 times more expensive than a
first-parent traversal.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 23 Aug 2007, Uwe Kleine-K?nig wrote:

	> I want to check to which kernel version I need to upgrade to get 
	> a certain feature.  For my case it was introduced in 
	> 0567a0c022d5b.
	> 
	> zeisberg@cassiopeia:~/gsrc/linux-2.6$ 
	> 	rev=0567a0c022d5b343370a343121f38fd89925de55
	> 
	> zeisberg@cassiopeia:~/gsrc/linux-2.6$ git name-rev --tags $rev
	> 0567a0c02[...] tags/v2.6.22~1686^2~1^3~5
	> 
	> zeisberg@cassiopeia:~/gsrc/linux-2.6$ git name-rev --refs=*-rc1 $rev
	> 0567a0c02[...] tags/v2.6.22-rc1~1009^2~1^3~5

	This fixes it.

 builtin-name-rev.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 61eba34..03083e9 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -11,14 +11,17 @@ static const char name_rev_usage[] =
 
 typedef struct rev_name {
 	const char *tip_name;
-	int merge_traversals;
 	int generation;
+	int distance;
 } rev_name;
 
 static long cutoff = LONG_MAX;
 
+/* How many generations are maximally preferred over _one_ merge traversal? */
+#define MERGE_TRAVERSAL_WEIGHT 65535
+
 static void name_rev(struct commit *commit,
-		const char *tip_name, int merge_traversals, int generation,
+		const char *tip_name, int generation, int distance,
 		int deref)
 {
 	struct rev_name *name = (struct rev_name *)commit->util;
@@ -45,13 +48,11 @@ static void name_rev(struct commit *commit,
 		name = xmalloc(sizeof(rev_name));
 		commit->util = name;
 		goto copy_data;
-	} else if (name->merge_traversals > merge_traversals ||
-			(name->merge_traversals == merge_traversals &&
-			 name->generation > generation)) {
+	} else if (name->distance > distance) {
 copy_data:
 		name->tip_name = tip_name;
-		name->merge_traversals = merge_traversals;
 		name->generation = generation;
+		name->distance = distance;
 	} else
 		return;
 
@@ -74,11 +75,11 @@ copy_data:
 				sprintf(new_name, "%.*s^%d", len, tip_name,
 						parent_number);
 
-			name_rev(parents->item, new_name,
-				merge_traversals + 1 , 0, 0);
+			name_rev(parents->item, new_name, 0,
+				distance + MERGE_TRAVERSAL_WEIGHT, 0);
 		} else {
-			name_rev(parents->item, tip_name, merge_traversals,
-				generation + 1, 0);
+			name_rev(parents->item, tip_name, generation + 1,
+				distance + 1, 0);
 		}
 	}
 }
-- 
1.5.3.rc6.52.g5113-dirty

--8323584-365382724-1188214653=:28586--
