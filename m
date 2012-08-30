From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] name_rev: clarify the logic to assign a new tip-name
 to a commit
Date: Wed, 29 Aug 2012 20:50:25 -0700
Message-ID: <1346298629-13730-3-git-send-email-gitster@pobox.com>
References: <1346298629-13730-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 05:51:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vnC-0007zl-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab2H3DvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:51:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48036 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409Ab2H3Duf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:50:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 877DA88AA
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=E8VQ
	OoUXxzqYz0JyYaGf2TbXVFE=; b=otLHMz0LP+qiHjpFZW64+salnyR2Z2WbcyGf
	MKH1GQMgWpInevHqzbI51ej0YcobT/0SfVgZwi1JIHu8pa6HCMcbZ205vjnFTpSS
	0w5dTmHyqh+BlRrPQ5JGUXRfb5pQpo+itMnSsE2WjN0ey/Lfs1LJCKG+JJVFcV7Z
	oWCt00A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DdXIMY
	rmGlGe146edbo5cqVMY7hSn24Ke3MVta8PqLPrayUYi1uQlpFgx5+6TeChvDXYNX
	MnRqdY0b09MMDdMH4Yk/J01T0+XUVKqsLvbUYqS7E30hYFrSxmaHP5ccb4+cicme
	5FyqjXAFGlNP23qqOU3EniBMWUQg985bFfSwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75D3988A9
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1FD888A7 for
 <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.286.g9df01f7
In-Reply-To: <1346298629-13730-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DA5AF3A6-F255-11E1-8AA8-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204516>

In preparation for later changes, restructure the logic a little bit
to separate how the code decides to use the new "tip" for naming a
particular commit, and what happens based on the decision.

Also re-indent and correct style of this function while we are at it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/name-rev.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 8af2cfa..ebbf541 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -19,12 +19,13 @@ static long cutoff = LONG_MAX;
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
 static void name_rev(struct commit *commit,
-		const char *tip_name, int generation, int distance,
-		int deref)
+		     const char *tip_name, int generation, int distance,
+		     int deref)
 {
 	struct rev_name *name = (struct rev_name *)commit->util;
 	struct commit_list *parents;
-	int parent_number = 1;
+	int parent_number;
+	int use_this_tip = 0;
 
 	if (!commit->object.parsed)
 		parse_commit(commit);
@@ -42,21 +43,26 @@ static void name_rev(struct commit *commit,
 			die("generation: %d, but deref?", generation);
 	}
 
-	if (name == NULL) {
-		name = xmalloc(sizeof(struct rev_name));
+	if (!name) {
+		name = xcalloc(1, sizeof(struct rev_name));
 		commit->util = name;
-		goto copy_data;
-	} else if (name->distance > distance) {
-copy_data:
-		name->tip_name = tip_name;
-		name->generation = generation;
-		name->distance = distance;
-	} else
+		use_this_tip = 1;
+	}
+
+	if (distance < name->distance)
+		use_this_tip = 1;
+
+	if (!use_this_tip)
 		return;
 
-	for (parents = commit->parents;
-			parents;
-			parents = parents->next, parent_number++) {
+	name->tip_name = tip_name;
+	name->generation = generation;
+	name->distance = distance;
+
+	/* Propagate our name to our parents */
+	for (parents = commit->parents, parent_number = 1;
+	     parents;
+	     parents = parents->next, parent_number++) {
 		if (parent_number > 1) {
 			int len = strlen(tip_name);
 			char *new_name = xmalloc(len +
@@ -68,16 +74,15 @@ copy_data:
 				len -= 2;
 			if (generation > 0)
 				sprintf(new_name, "%.*s~%d^%d", len, tip_name,
-						generation, parent_number);
+					generation, parent_number);
 			else
 				sprintf(new_name, "%.*s^%d", len, tip_name,
-						parent_number);
-
+					parent_number);
 			name_rev(parents->item, new_name, 0,
-				distance + MERGE_TRAVERSAL_WEIGHT, 0);
+				 distance + MERGE_TRAVERSAL_WEIGHT, 0);
 		} else {
 			name_rev(parents->item, tip_name, generation + 1,
-				distance + 1, 0);
+				 distance + 1, 0);
 		}
 	}
 }
-- 
1.7.12.286.g9df01f7
