From: Allan Caffee <allan.caffee@gmail.com>
Subject: [RFC/PATCH] graph API: Use horizontal lines for more compact graphs
Date: Mon, 20 Apr 2009 20:40:27 -0400
Message-ID: <20090421004027.GA12330@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 02:42:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw441-0002YE-3S
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 02:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZDUAkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 20:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbZDUAkf
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 20:40:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:8682 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbZDUAke (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 20:40:34 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2152953rvb.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 17:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=5nL9g1zVXUclGEDfZqGmGZ9LUZN5FYugEXeU55aCcJ4=;
        b=YLybeupVlvJcAt2w87vJugkC1M0w+KC+LaGzxH6anl1ku5foDeITTA7Q2pQYv2XnT7
         EtFTJ+9wGC3uZwuHcMD3qgK/kcfWZQSeuu8JWhaFH2vC9xUdBF7WxOQabANYiKRjOnqd
         i+kd26dHRbyZkCzQLhW4wYZJc+ptkWhW5HhVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=t9h4XqKJvbhTq5/QlEwpWCO/ye1NUZanV+Slgdk1VzTvLu+HIYDqfbrEjXYBo8PqPD
         1fu+kffULS/CZb0DUXCAlidmCSll1NNzGHHYxgfffuBKCBazy4BpznqiPggAZIOTuZnW
         61Pa1DRGFO/3c0j8QEYtOhP6l9X4V3T2GIm5Q=
Received: by 10.142.173.8 with SMTP id v8mr1467784wfe.26.1240274433560;
        Mon, 20 Apr 2009 17:40:33 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 30sm18376860wfa.38.2009.04.20.17.40.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 17:40:32 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117051>

Use horizontal lines instead of long diagonal during graph collapsing
and precommit for more compact and legible graphs.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 graph.c        |   57 +++++++++++++++++++++++++++++++++++++++++--------------
 t/t4202-log.sh |    6 +---
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/graph.c b/graph.c
index d4571cf..597e545 100644
--- a/graph.c
+++ b/graph.c
@@ -47,20 +47,6 @@ static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
  * - Limit the number of columns, similar to the way gitk does.
  *   If we reach more than a specified number of columns, omit
  *   sections of some columns.
- *
- * - The output during the GRAPH_PRE_COMMIT and GRAPH_COLLAPSING states
- *   could be made more compact by printing horizontal lines, instead of
- *   long diagonal lines.  For example, during collapsing, something like
- *   this:          instead of this:
- *   | | | | |      | | | | |
- *   | |_|_|/       | | | |/
- *   |/| | |        | | |/|
- *   | | | |        | |/| |
- *                  |/| | |
- *                  | | | |
- *
- *   If there are several parallel diagonal lines, they will need to be
- *   replaced with horizontal lines on subsequent rows.
  */
 
 struct column {
@@ -982,6 +968,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 {
 	int i;
 	int *tmp_mapping;
+	short used_horizontal = 0;
+	int horizontal_edge = -1;
+	int horizontal_edge_target = -1;
 
 	/*
 	 * Clear out the new_mapping array
@@ -1019,6 +1008,17 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			 * Move to the left by one
 			 */
 			graph->new_mapping[i - 1] = target;
+			/*
+			 * If there isn't already an edge moving horizontally
+			 * select this one.
+			 */
+			if (horizontal_edge == -1) {
+				int j;
+				horizontal_edge = i;
+				horizontal_edge_target = target;
+				for (j = (target * 2)+3; j < (i - 2); j += 2)
+					graph->new_mapping[j] = target;
+			}
 		} else if (graph->new_mapping[i - 1] == target) {
 			/*
 			 * There is a branch line to our left
@@ -1039,10 +1039,21 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			 *
 			 * The space just to the left of this
 			 * branch should always be empty.
+			 *
+			 * The branch to the left of that space
+			 * should be our eventual target.
 			 */
 			assert(graph->new_mapping[i - 1] > target);
 			assert(graph->new_mapping[i - 2] < 0);
+			assert(graph->new_mapping[i - 3] == target);
 			graph->new_mapping[i - 2] = target;
+			/*
+			 * Mark this branch as the horizontal edge to
+			 * prevent any other edges from moving
+			 * horizontally.
+			 */
+			if (horizontal_edge == -1)
+				horizontal_edge = i;
 		}
 	}
 
@@ -1061,8 +1072,24 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			strbuf_addch(sb, ' ');
 		else if (target * 2 == i)
 			strbuf_write_column(sb, &graph->new_columns[target], '|');
-		else
+		else if (target == horizontal_edge_target &&
+			 i != horizontal_edge - 1) {
+				/*
+				 * Set the mappings for all but the
+				 * first segment to -1 so that they
+				 * won't continue into the next line.
+				 */
+				if (i != (target * 2)+3)
+					graph->new_mapping[i] = -1;
+				used_horizontal = 1;
+			strbuf_write_column(sb, &graph->new_columns[target], '_');
+		}
+		else {
+			if (used_horizontal && i < horizontal_edge)
+				graph->new_mapping[i] = -1;
 			strbuf_write_column(sb, &graph->new_columns[target], '/');
+
+		}
 	}
 
 	graph_pad_horizontally(graph, sb, graph->mapping_size);
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index b986190..a3b0cb8 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -298,14 +298,12 @@ cat > expect <<\EOF
 * | | |   Merge branch 'side'
 |\ \ \ \
 | * | | | side-2
-| | | |/
-| | |/|
+| | |_|/
 | |/| |
 | * | | side-1
 * | | | Second
 * | | | sixth
-| | |/
-| |/|
+| |_|/
 |/| |
 * | | fifth
 * | | fourth
-- 
1.5.6.3
