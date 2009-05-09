From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/10] bisect: automatically sort sha1_array if needed when
	looking it up
Date: Sat, 09 May 2009 17:55:44 +0200
Message-ID: <20090509155548.5387.70784.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:05:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p2e-0006Vt-Fy
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbZEIQDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbZEIQDw
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:52 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:44528 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809AbZEIQDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:40 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id ED9EB81811C;
	Sat,  9 May 2009 18:03:35 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0459E8180BE;
	Sat,  9 May 2009 18:03:32 +0200 (CEST)
X-git-sha1: 45ef211571436a10b7599eced4ed2ac7d6c0dbbe 
X-Mailer: git-mail-commits v0.4.0
In-Reply-To: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118671>

This makes sha1_array easier to use, so later patches will be simpler.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 77edeca..d2a34d1 100644
--- a/bisect.c
+++ b/bisect.c
@@ -13,6 +13,7 @@ struct sha1_array {
 	unsigned char (*sha1)[20];
 	int sha1_nr;
 	int sha1_alloc;
+	int sorted;
 };
 
 static struct sha1_array good_revs;
@@ -487,6 +488,8 @@ static int array_cmp(const void *a, const void *b)
 static void sort_sha1_array(struct sha1_array *array)
 {
 	qsort(array->sha1, array->sha1_nr, sizeof(*array->sha1), array_cmp);
+
+	array->sorted = 1;
 }
 
 static const unsigned char *sha1_access(size_t index, void *table)
@@ -498,6 +501,9 @@ static const unsigned char *sha1_access(size_t index, void *table)
 static int lookup_sha1_array(struct sha1_array *array,
 			     const unsigned char *sha1)
 {
+	if (!array->sorted)
+		sort_sha1_array(array);
+
 	return sha1_pos(sha1, array->sha1, array->sha1_nr, sha1_access);
 }
 
@@ -512,8 +518,6 @@ struct commit_list *filter_skipped(struct commit_list *list,
 	if (!skipped_revs.sha1_nr)
 		return list;
 
-	sort_sha1_array(&skipped_revs);
-
 	while (list) {
 		struct commit_list *next = list->next;
 		list->next = NULL;
-- 
1.6.3.rc1.112.g17e25
