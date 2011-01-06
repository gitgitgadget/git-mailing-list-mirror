From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] diffcore-rename: record filepair for rename src
Date: Thu,  6 Jan 2011 13:50:05 -0800
Message-ID: <1294350606-19530-3-git-send-email-gitster@pobox.com>
References: <1294350606-19530-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 22:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaxjF-0005g3-SE
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 22:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944Ab1AFVuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 16:50:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab1AFVuP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 16:50:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 80E613157
	for <git@vger.kernel.org>; Thu,  6 Jan 2011 16:50:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Ctve
	z4BOS1ILpd0aaV3+ZAquWCk=; b=rcqmz8VfWKFc1whNTjIl+I1mCUcf4KTD3+3z
	2ADyxEJbC0BotqdPAer8LFLY0HmOJgTnI0msKZ6m2zbdu+0bSAuebnVcaOB+5cnS
	dtRm3p7lL3hdHJfOTwwuG1hZP36/ZkBESSFjDcWU2Csc1yrTEwybKLLNkAequEei
	3TwT1/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CQU5bZ
	RQqjvKE15NBB+Ce7noPq9KOfT7nhUJnIdKzwZAKPuZSB+2Q7JGS27KZZNYD6pJFq
	lVOBpREKc9rovT49QBwO1FMA6s0QyMTTGFwvc9DR/QNYXE4dyStPWs19FUQqR3pc
	p51UbBHST1V7sh8cDiQOZdwksKONfZXHBWc6E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7E5383155
	for <git@vger.kernel.org>; Thu,  6 Jan 2011 16:50:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B8B6A3154 for
 <git@vger.kernel.org>; Thu,  6 Jan 2011 16:50:51 -0500 (EST)
X-Mailer: git-send-email 1.7.4.rc1.214.g2a4f9
In-Reply-To: <1294350606-19530-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 08102D8A-19DF-11E0-B2BC-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164680>

This will allow us to later skip unmodified entries added due to "-C -C".
We might also want to do something similar to rename_dst side, but that
would only be for the sake of symmetry and not necessary for this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-rename.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6ab050d..9ce81b6 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -54,22 +54,23 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 
 /* Table of rename/copy src files */
 static struct diff_rename_src {
-	struct diff_filespec *one;
+	struct diff_filepair *p;
 	unsigned short score; /* to remember the break score */
 } *rename_src;
 static int rename_src_nr, rename_src_alloc;
 
-static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
-						   unsigned short score)
+static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
 {
 	int first, last;
+	struct diff_filespec *one = p->one;
+	unsigned short score = p->score;
 
 	first = 0;
 	last = rename_src_nr;
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct diff_rename_src *src = &(rename_src[next]);
-		int cmp = strcmp(one->path, src->one->path);
+		int cmp = strcmp(one->path, src->p->one->path);
 		if (!cmp)
 			return src;
 		if (cmp < 0) {
@@ -89,7 +90,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
 	if (first < rename_src_nr)
 		memmove(rename_src + first + 1, rename_src + first,
 			(rename_src_nr - first - 1) * sizeof(*rename_src));
-	rename_src[first].one = one;
+	rename_src[first].p = p;
 	rename_src[first].score = score;
 	return &(rename_src[first]);
 }
@@ -204,7 +205,7 @@ static void record_rename_pair(int dst_index, int src_index, int score)
 	if (rename_dst[dst_index].pair)
 		die("internal error: dst already matched.");
 
-	src = rename_src[src_index].one;
+	src = rename_src[src_index].p->one;
 	src->rename_used++;
 	src->count++;
 
@@ -384,7 +385,7 @@ static int find_exact_renames(void)
 
 	init_hash(&file_table);
 	for (i = 0; i < rename_src_nr; i++)
-		insert_file_table(&file_table, -1, i, rename_src[i].one);
+		insert_file_table(&file_table, -1, i, rename_src[i].p->one);
 
 	for (i = 0; i < rename_dst_nr; i++)
 		insert_file_table(&file_table, 1, i, rename_dst[i].two);
@@ -472,7 +473,7 @@ void diffcore_rename(struct diff_options *options)
 			 */
 			if (p->broken_pair && !p->score)
 				p->one->rename_used++;
-			register_rename_src(p->one, p->score);
+			register_rename_src(p);
 		}
 		else if (detect_rename == DIFF_DETECT_COPY) {
 			/*
@@ -480,7 +481,7 @@ void diffcore_rename(struct diff_options *options)
 			 * one, to indicate ourselves as a user.
 			 */
 			p->one->rename_used++;
-			register_rename_src(p->one, p->score);
+			register_rename_src(p);
 		}
 	}
 	if (rename_dst_nr == 0 || rename_src_nr == 0)
@@ -526,7 +527,7 @@ void diffcore_rename(struct diff_options *options)
 			m[j].dst = -1;
 
 		for (j = 0; j < rename_src_nr; j++) {
-			struct diff_filespec *one = rename_src[j].one;
+			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
 			this_src.score = estimate_similarity(one, two,
 							     minimum_score);
@@ -556,7 +557,7 @@ void diffcore_rename(struct diff_options *options)
 		dst = &rename_dst[mx[i].dst];
 		if (dst->pair)
 			continue; /* already done, either exact or fuzzy. */
-		if (rename_src[mx[i].src].one->rename_used)
+		if (rename_src[mx[i].src].p->one->rename_used)
 			continue;
 		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
 		rename_count++;
-- 
1.7.4.rc1.214.g2a4f9
