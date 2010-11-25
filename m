From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 05/18] commit: move reverse_commit_list() into commit.{h, 
	c}
Date: Thu, 25 Nov 2010 22:20:36 +0100
Message-ID: <20101125212050.5188.71328.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrGr-0006kW-Vv
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab0KZFyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:54:40 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47377 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806Ab0KZFyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:54:39 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 56F4AA60F5;
	Fri, 26 Nov 2010 06:54:32 +0100 (CET)
X-git-sha1: 10e5675e8c565ae2b1e3605820c7a1c042537243 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162189>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 commit.c          |   11 +++++++++++
 commit.h          |    2 ++
 merge-recursive.c |   11 -----------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index 0094ec1..f9d5bf9 100644
--- a/commit.c
+++ b/commit.c
@@ -351,6 +351,17 @@ unsigned commit_list_count(const struct commit_list *l)
 	return c;
 }
 
+struct commit_list *reverse_commit_list(struct commit_list *list)
+{
+	struct commit_list *next = NULL, *current, *backup;
+	for (current = list; current; current = backup) {
+		backup = current->next;
+		current->next = next;
+		next = current;
+	}
+	return next;
+}
+
 void free_commit_list(struct commit_list *list)
 {
 	while (list) {
diff --git a/commit.h b/commit.h
index 9113bbe..6a074a1 100644
--- a/commit.h
+++ b/commit.h
@@ -48,6 +48,8 @@ struct commit_list * commit_list_insert(struct commit *item, struct commit_list
 unsigned commit_list_count(const struct commit_list *l);
 struct commit_list * insert_by_date(struct commit *item, struct commit_list **list);
 
+struct commit_list *reverse_commit_list(struct commit_list *list);
+
 void free_commit_list(struct commit_list *list);
 
 void sort_by_date(struct commit_list **list);
diff --git a/merge-recursive.c b/merge-recursive.c
index 16c2dbe..d02fda6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1573,17 +1573,6 @@ int merge_trees(struct merge_options *o,
 	return clean;
 }
 
-static struct commit_list *reverse_commit_list(struct commit_list *list)
-{
-	struct commit_list *next = NULL, *current, *backup;
-	for (current = list; current; current = backup) {
-		backup = current->next;
-		current->next = next;
-		next = current;
-	}
-	return next;
-}
-
 /*
  * Merge the commits h1 and h2, return the resulting virtual
  * commit object and a flag indicating the cleanness of the merge.
-- 
1.7.3.2.504.g59d466
