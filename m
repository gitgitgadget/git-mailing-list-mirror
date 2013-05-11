From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 1/2] commit: add commit_list_contains function
Date: Sat, 11 May 2013 13:23:43 +0100
Message-ID: <f3e086bee6b59fead4f9866b3f616a916b932706.1368274689.git.john@keeping.me.uk>
References: <cover.1368274689.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 14:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub8qo-0004bt-Ei
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 14:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab3EKMYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 08:24:30 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:51707 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab3EKMY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 08:24:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3EE90198007;
	Sat, 11 May 2013 13:24:29 +0100 (BST)
X-Quarantine-ID: <CDJePtoTt3UZ>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CDJePtoTt3UZ; Sat, 11 May 2013 13:24:28 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id AD5A2198003;
	Sat, 11 May 2013 13:24:28 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 9DBF4161E4A9;
	Sat, 11 May 2013 13:24:28 +0100 (BST)
X-Quarantine-ID: <D-tMuDS9kTxW>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D-tMuDS9kTxW; Sat, 11 May 2013 13:24:28 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 37222161E410;
	Sat, 11 May 2013 13:24:17 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc1.289.gcb3647f
In-Reply-To: <cover.1368274689.git.john@keeping.me.uk>
In-Reply-To: <cover.1368274689.git.john@keeping.me.uk>
References: <cover.1368274689.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223960>

This is the same as the in_commit_list function already in builtin/tag.c
so we also replace that by the new commit_list_contains function.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/tag.c | 10 +---------
 commit.c      |  8 ++++++++
 commit.h      |  1 +
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index af3af3f..1c24772 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -65,14 +65,6 @@ static const unsigned char *match_points_at(const char *refname,
 	return NULL;
 }
 
-static int in_commit_list(const struct commit_list *want, struct commit *c)
-{
-	for (; want; want = want->next)
-		if (!hashcmp(want->item->object.sha1, c->object.sha1))
-			return 1;
-	return 0;
-}
-
 static int contains_recurse(struct commit *candidate,
 			    const struct commit_list *want)
 {
@@ -85,7 +77,7 @@ static int contains_recurse(struct commit *candidate,
 	if (candidate->object.flags & UNINTERESTING)
 		return 0;
 	/* or are we it? */
-	if (in_commit_list(want, candidate))
+	if (commit_list_contains(want, candidate))
 		return 1;
 
 	if (parse_commit(candidate) < 0)
diff --git a/commit.c b/commit.c
index 888e02a..a8263c3 100644
--- a/commit.c
+++ b/commit.c
@@ -420,6 +420,14 @@ void commit_list_sort_by_date(struct commit_list **list)
 				commit_list_compare_by_date);
 }
 
+int commit_list_contains(const struct commit_list *list, const struct commit *item)
+{
+	for (; list; list = list->next)
+		if (!hashcmp(list->item->object.sha1, item->object.sha1))
+			return 1;
+	return 0;
+}
+
 struct commit *pop_most_recent_commit(struct commit_list **list,
 				      unsigned int mark)
 {
diff --git a/commit.h b/commit.h
index 67bd509..d686ea8 100644
--- a/commit.h
+++ b/commit.h
@@ -60,6 +60,7 @@ unsigned commit_list_count(const struct commit_list *l);
 struct commit_list *commit_list_insert_by_date(struct commit *item,
 				    struct commit_list **list);
 void commit_list_sort_by_date(struct commit_list **list);
+int commit_list_contains(const struct commit_list *list, const struct commit *item);
 
 void free_commit_list(struct commit_list *list);
 
-- 
1.8.3.rc1.289.gcb3647f
