From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] diffcore-rename: record filepair for rename src
Date: Tue, 22 Mar 2011 14:50:48 -0700
Message-ID: <1300830649-22830-2-git-send-email-gitster@pobox.com>
References: <7vk4fqkewo.fsf@alter.siamese.dyndns.org>
 <1300830649-22830-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 22:51:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q29Tk-0008Pq-Ih
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 22:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386Ab1CVVvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 17:51:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379Ab1CVVu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 17:50:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 170BF465C;
	Tue, 22 Mar 2011 17:52:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=otRQ
	2RoSM0j22nOcxh6gK9bvvhA=; b=u/UX3yY4vrtU+7PpKzrKKMUAWEyljsvLb7iW
	9yK295fsaStQxFAmiLoUKBnOWca2zEGz3pRFqOPpYK+ai3RVp47eXomZ11qFW7bw
	kCozIKzqdSryD7tna75SdpUzi6l1EuYsNeqrwzrTLoRRFDGU/WQpJuaOtXCisgc3
	0lAMh/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	SkYYzcKQKVGC/0ujUONSdULKf/kF+SNz9mAfi5Wzgh9NkWZa98eX8r2TJKekqcCS
	sRRaVc4My6WF6mrhMszu77ExsyXacef/zsudpxfZ8y18Q/hC5eDJv/PBnu1FXVXk
	38eA98kP1huVr9P7s6mYfA/DbDWVIZxjPudmNFkoCSc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F23BD4659;
	Tue, 22 Mar 2011 17:52:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 14D8A4657; Tue, 22 Mar 2011
 17:52:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.554.gfdad8
In-Reply-To: <1300830649-22830-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B216B568-54CE-11E0-82AA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169781>

This will allow us to later skip unmodified entries added due to "-C -C".
We might also want to do something similar to rename_dst side, but that
would only be for the sake of symmetry and not necessary for this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-rename.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 00f7f84..a932f76 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -55,22 +55,23 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 
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
@@ -90,7 +91,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
 	if (first < rename_src_nr)
 		memmove(rename_src + first + 1, rename_src + first,
 			(rename_src_nr - first - 1) * sizeof(*rename_src));
-	rename_src[first].one = one;
+	rename_src[first].p = p;
 	rename_src[first].score = score;
 	return &(rename_src[first]);
 }
@@ -205,7 +206,7 @@ static void record_rename_pair(int dst_index, int src_index, int score)
 	if (rename_dst[dst_index].pair)
 		die("internal error: dst already matched.");
 
-	src = rename_src[src_index].one;
+	src = rename_src[src_index].p->one;
 	src->rename_used++;
 	src->count++;
 
@@ -389,7 +390,7 @@ static int find_exact_renames(struct diff_options *options)
 
 	init_hash(&file_table);
 	for (i = 0; i < rename_src_nr; i++)
-		insert_file_table(&file_table, -1, i, rename_src[i].one);
+		insert_file_table(&file_table, -1, i, rename_src[i].p->one);
 
 	for (i = 0; i < rename_dst_nr; i++)
 		insert_file_table(&file_table, 1, i, rename_dst[i].two);
@@ -460,7 +461,7 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
 		dst = &rename_dst[mx[i].dst];
 		if (dst->pair)
 			continue; /* already done, either exact or fuzzy. */
-		if (!copies && rename_src[mx[i].src].one->rename_used)
+		if (!copies && rename_src[mx[i].src].p->one->rename_used)
 			continue;
 		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
 		count++;
@@ -503,7 +504,7 @@ void diffcore_rename(struct diff_options *options)
 			 */
 			if (p->broken_pair && !p->score)
 				p->one->rename_used++;
-			register_rename_src(p->one, p->score);
+			register_rename_src(p);
 		}
 		else if (detect_rename == DIFF_DETECT_COPY) {
 			/*
@@ -511,7 +512,7 @@ void diffcore_rename(struct diff_options *options)
 			 * one, to indicate ourselves as a user.
 			 */
 			p->one->rename_used++;
-			register_rename_src(p->one, p->score);
+			register_rename_src(p);
 		}
 	}
 	if (rename_dst_nr == 0 || rename_src_nr == 0)
@@ -560,7 +561,7 @@ void diffcore_rename(struct diff_options *options)
 			m[j].dst = -1;
 
 		for (j = 0; j < rename_src_nr; j++) {
-			struct diff_filespec *one = rename_src[j].one;
+			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
 			this_src.score = estimate_similarity(one, two,
 							     minimum_score);
-- 
1.7.4.1.554.gfdad8
