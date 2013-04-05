From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/2] log -L: check range set invariants when we look it up
Date: Fri, 5 Apr 2013 16:34:47 +0200
Message-ID: <1604fca2ca876cfed7f26b914a31607269c2d5de.1365172322.git.trast@inf.ethz.ch>
References: <cover.1365172322.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:09:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWIt-0002u6-Nn
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161838Ab3DEOe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 10:34:56 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:59242 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161744Ab3DEOez (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 10:34:55 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 5 Apr
 2013 16:34:48 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.239) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 5 Apr
 2013 16:34:52 +0200
X-Mailer: git-send-email 1.8.2.662.g6b31d33
In-Reply-To: <cover.1365172322.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.239]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220189>

lookup_line_range() is a good place to check that the range sets
satisfy the invariants: they have been computed and set in earlier
iterations, and we now start working with them.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 line-log.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/line-log.c b/line-log.c
index 30edef4..5a12ceb 100644
--- a/line-log.c
+++ b/line-log.c
@@ -80,6 +80,25 @@ static int range_cmp(const void *_r, const void *_s)
 }
 
 /*
+ * Check that the ranges are non-empty, sorted and non-overlapping
+ */
+static void range_set_check_invariants(struct range_set *rs)
+{
+	int i;
+
+	if (!rs)
+		return;
+
+	if (rs->nr)
+		assert(rs->ranges[0].start < rs->ranges[0].end);
+
+	for (i = 1; i < rs->nr; i++) {
+		assert(rs->ranges[i-1].end < rs->ranges[i].start);
+		assert(rs->ranges[i].start < rs->ranges[i].end);
+	}
+}
+
+/*
  * Helper: In-place pass of sorting and merging the ranges in the
  * range set, to re-establish the invariants after another operation
  *
@@ -103,6 +122,8 @@ static void sort_and_merge_range_set(struct range_set *rs)
 	}
 	assert(o <= rs->nr);
 	rs->nr = o;
+
+	range_set_check_invariants(rs);
 }
 
 /*
@@ -687,8 +708,13 @@ static struct line_log_data *lookup_line_range(struct rev_info *revs,
 					       struct commit *commit)
 {
 	struct line_log_data *ret = NULL;
+	struct line_log_data *d;
 
 	ret = lookup_decoration(&revs->line_log_data, &commit->object);
+
+	for (d = ret; d; d = d->next)
+		range_set_check_invariants(&d->ranges);
+
 	return ret;
 }
 
-- 
1.8.2.662.g6b31d33
