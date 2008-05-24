From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 0/2] Fix output of "git log --graph --boundary"
Date: Sat, 24 May 2008 16:02:03 -0700
Message-ID: <1211670125-10215-1-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 25 01:03:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K02lb-0006Ow-2X
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 01:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbYEXXCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 19:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYEXXCM
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 19:02:12 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:47920 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbYEXXCI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 19:02:08 -0400
Received: from relay3.r3.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay3.r3.iad.emailsrvr.com (SMTP Server) with ESMTP id 22E5F44C089;
	Sat, 24 May 2008 19:02:07 -0400 (EDT)
Received: by relay3.r3.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id BD52D44C0A4;
	Sat, 24 May 2008 19:02:06 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id AE6E814100C8; Sat, 24 May 2008 16:02:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.389.g35a9d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82839>

These two patches fix the graph output when --boundary is used.  They
apply on top of a merge of my recent fixes for handling uninteresting
commits (since they use the new graph_is_interesting() function I
added), and Dscho's "--graph --left-right" changes (since these changes
also need the struct rev_info).

There were two small conflicts when merging Dscho's and my changes.
I've including a merge diff below showing how I resolved them.


Adam Simpkins (2):
  Fix output of "git log --graph --boundary"
  get_revision(): honor the topo_order flag for boundary commits

 graph.c    |   87 ++++++++++++++++++++++++++++++++++++++++-------------------
 revision.c |   75 ++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 117 insertions(+), 45 deletions(-)


8acd45e94a0d42a0ceb164e294049104e0c0f663
diff --cc graph.c
index ba9ede0,85a9ba0..479035d
--- a/graph.c
+++ b/graph.c
@@@ -55,11 -55,13 +55,15 @@@ struct git_graph 
  	 */
  	struct commit *commit;
  	/*
+ 	 * For the --left-right option.
+ 	 */
+ 	struct rev_info *revs;
+ 	/*
 -	 * The number of parents this commit has.
 -	 * (Stored so we don't have to walk over them each time we need
 -	 * this number)
 +	 * The number of interesting parents that this commit has.
 +	 *
 +	 * Note that this is not the same as the actual number of parents.
 +	 * This count excludes parents that won't be printed in the graph
 +	 * output, as determined by graph_is_interesting().
  	 */
  	int num_parents;
  	/*
@@@ -565,18 -545,14 +570,28 @@@ void graph_output_commit_line(struct gi
  
  		if (col_commit == graph->commit) {
  			seen_this = 1;
 +			/*
- 			 * If the commit is a merge, print 'M'.  Otherwise,
- 			 * print '*'.
++			 * If revs->left_right is set, print the '<' or '>'
++			 * depending on which side this commit came from.
++			 *
++			 * If revs->left_right is not set and the commit is
++			 * a merge, print 'M'.  Otherwise, print '*'.
 +			 *
 +			 * Note that we don't check graph->num_parents to
 +			 * determine if the commit is a merge, since that
 +			 * only tracks the number of "interesting" parents.
 +			 * We want to print 'M' for merge commits even if
 +			 * they have less than 2 interesting parents.
 +			 */
- 			if (graph->commit->parents != NULL &&
- 			    graph->commit->parents->next != NULL)
+ 			if (graph->revs && graph->revs->left_right) {
+ 				if (graph->commit->object.flags
+ 						& SYMMETRIC_LEFT)
+ 					strbuf_addch(sb, '<');
+ 				else
+ 					strbuf_addch(sb, '>');
+ 			}
 -			else if (graph->num_parents > 1)
++			else if (graph->commit->parents != NULL &&
++				 graph->commit->parents->next != NULL)
  				strbuf_addch(sb, 'M');
  			else
  				strbuf_addch(sb, '*');
