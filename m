From: Adam Simpkins <simpkins@facebook.com>
Subject: [PATCH] graph API: use a new color when starting a brand new column
Date: Tue, 18 Aug 2009 14:41:12 -0700
Message-ID: <20090818214112.GM8147@facebook.com>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Allan Caffee <allan.caffee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWQq-0002uH-FY
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbZHRVlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbZHRVlU
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:41:20 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:41033 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750872AbZHRVlT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 17:41:19 -0400
X-Greylist: delayed 1374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2009 17:41:19 EDT
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.17] (may be forged))
	by pp02.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n7ILf73N010881
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 18 Aug 2009 14:41:07 -0700
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.104) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 18 Aug
 2009 14:41:17 -0700
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1MdWQf-0007TC-Ea; Tue, 18 Aug 2009 14:41:17 -0700
Mail-Followup-To: git@vger.kernel.org,
	Allan Caffee <allan.caffee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-18_15:2009-08-11,2009-08-18,2009-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908180164
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126464>

Use a new color for commits that don't have any previously printed
children.  The following command demonstrates the changes:

  git log --graph --pretty=tformat:'%h %s%n' -7 481c7a6 18b0793

Now the two independent lines of development are displayed with
different colors, instead of both using the same color.

Signed-off-by: Adam Simpkins <simpkins@facebook.com>
---
 graph.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/graph.c b/graph.c
index e466770..f3226ec 100644
--- a/graph.c
+++ b/graph.c
@@ -225,7 +225,12 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
-	graph->default_column_color = 0;
+	/*
+	 * Start the column color at the maximum value, since we'll
+	 * always increment it for the first commit we output.
+	 * This way we start at 0 for the first commit.
+	 */
+	graph->default_column_color = COLUMN_COLORS_MAX - 1;
 
 	/*
 	 * Allocate a reasonably large default number of columns
@@ -499,11 +504,14 @@ static void graph_update_columns(struct git_graph *graph)
 			     parent;
 			     parent = next_interesting_parent(graph, parent)) {
 				/*
-				 * If this is a merge increment the current
+				 * If this is a merge, or the start of a new
+				 * childless column, increment the current
 				 * color.
 				 */
-				if (graph->num_parents > 1)
+				if (graph->num_parents > 1 ||
+				    !is_commit_in_columns) {
 					graph_increment_column_color(graph);
+				}
 				graph_insert_into_new_columns(graph,
 							      parent->item,
 							      &mapping_idx);
-- 
1.6.4.314.g5667f
