From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/10] bisect: make skipped array functions more generic
Date: Sat, 09 May 2009 17:55:43 +0200
Message-ID: <20090509155548.5387.88589.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:05:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p2d-0006Vt-FR
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbZEIQDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbZEIQDt
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:49 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:53166 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648AbZEIQDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:40 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 8C5CF4B0089;
	Sat,  9 May 2009 18:03:34 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 8FEA04B0056;
	Sat,  9 May 2009 18:03:32 +0200 (CEST)
X-git-sha1: 822d6ab9580f954ab04ab293786b701a03cd7972 
X-Mailer: git-mail-commits v0.4.0
In-Reply-To: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118670>

So they can be used on the good array too.

This is done by renaming many functions and some variables to
remove "skip" in the name, and by adding a
"struct sha1_array *array" argument where needed.

While at it, make the second argument to "lookup_sha1_array"
const. It becomes "const unsigned char *sha1".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/bisect.c b/bisect.c
index 9e01b9e..77edeca 100644
--- a/bisect.c
+++ b/bisect.c
@@ -479,27 +479,26 @@ void read_bisect_paths(struct argv_array *array)
 	fclose(fp);
 }
 
-static int skipcmp(const void *a, const void *b)
+static int array_cmp(const void *a, const void *b)
 {
 	return hashcmp(a, b);
 }
 
-static void prepare_skipped(void)
+static void sort_sha1_array(struct sha1_array *array)
 {
-	qsort(skipped_revs.sha1, skipped_revs.sha1_nr,
-	      sizeof(*skipped_revs.sha1), skipcmp);
+	qsort(array->sha1, array->sha1_nr, sizeof(*array->sha1), array_cmp);
 }
 
-static const unsigned char *skipped_sha1_access(size_t index, void *table)
+static const unsigned char *sha1_access(size_t index, void *table)
 {
-	unsigned char (*skipped)[20] = table;
-	return skipped[index];
+	unsigned char (*array)[20] = table;
+	return array[index];
 }
 
-static int lookup_skipped(unsigned char *sha1)
+static int lookup_sha1_array(struct sha1_array *array,
+			     const unsigned char *sha1)
 {
-	return sha1_pos(sha1, skipped_revs.sha1, skipped_revs.sha1_nr,
-			skipped_sha1_access);
+	return sha1_pos(sha1, array->sha1, array->sha1_nr, sha1_access);
 }
 
 struct commit_list *filter_skipped(struct commit_list *list,
@@ -513,12 +512,13 @@ struct commit_list *filter_skipped(struct commit_list *list,
 	if (!skipped_revs.sha1_nr)
 		return list;
 
-	prepare_skipped();
+	sort_sha1_array(&skipped_revs);
 
 	while (list) {
 		struct commit_list *next = list->next;
 		list->next = NULL;
-		if (0 <= lookup_skipped(list->item->object.sha1)) {
+		if (0 <= lookup_sha1_array(&skipped_revs,
+					   list->item->object.sha1)) {
 			/* Move current to tried list */
 			*tried = list;
 			tried = &list->next;
-- 
1.6.3.rc1.112.g17e25
