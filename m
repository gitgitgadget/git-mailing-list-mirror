From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/9] sha1_name.c: refactor find_short_packed_object()
Date: Mon, 18 Jun 2012 15:05:33 -0700
Message-ID: <1340057139-8311-5-git-send-email-gitster@pobox.com>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:06:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgk5D-0000AS-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab2FRWFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:05:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967Ab2FRWFs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:05:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3820997E7
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=n7YQ
	+h+wLMzd3vq+2DXOobBNVJE=; b=Ijr30AqUNs6U+afAqjPQIlMQRnrWO8oLB2iF
	os/I79k7jQv2V9tm2xn9+UCYUfcnvbvhC3pT5zk43klL/cOpwKQ7H1ix2EHsZLgp
	rXU57yLecvfkyIes34rxn7CLVZRvTXnyaXEkwRnrArnuUpsdgYIz+SA8ypU3pI2x
	wYme2Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=uOyuA5
	pc3rwGhPSNNYKTdJT1OuBzrBhFKdGT0hPHXCEIwoGp7LUotifetpl6Xt0Y+TbAIy
	91p4OEOo9H8vjjBWud/m0sgwt34voODHrZKoQFfDbQkAII+hOTRM9XhdGzWqOQBN
	Nd86NaGjdvRyjN+sGDUemvnIAUBrkZvxmybkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3053797E6
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8021597E5 for
 <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340057139-8311-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C2146A68-B991-11E1-AD0D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200168>

Extract the logic to find object(s) that match a given prefix inside
a single pack into a separate helper function, and give it a bit more
comment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 103 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 5224f39..e03992c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -78,6 +78,59 @@ static int match_sha(unsigned len, const unsigned char *a, const unsigned char *
 	return 1;
 }
 
+static int unique_in_pack(int len,
+			  const unsigned char *match,
+			  struct packed_git *p,
+			  const unsigned char **found_sha1,
+			  int seen_so_far)
+{
+	uint32_t num, last, i, first = 0;
+	const unsigned char *current = NULL;
+
+	open_pack_index(p);
+	num = p->num_objects;
+	last = num;
+	while (first < last) {
+		uint32_t mid = (first + last) / 2;
+		const unsigned char *current;
+		int cmp;
+
+		current = nth_packed_object_sha1(p, mid);
+		cmp = hashcmp(match, current);
+		if (!cmp) {
+			first = mid;
+			break;
+		}
+		if (cmp > 0) {
+			first = mid+1;
+			continue;
+		}
+		last = mid;
+	}
+
+	/*
+	 * At this point, "first" is the location of the lowest object
+	 * with an object name that could match "match".  See if we have
+	 * 0, 1 or more objects that actually match(es).
+	 */
+	for (i = first; i < num; i++) {
+		current = nth_packed_object_sha1(p, first);
+		if (!match_sha(len, match, current))
+			break;
+
+		/* current matches */
+		if (!seen_so_far) {
+			*found_sha1 = current;
+			seen_so_far++;
+		} else if (seen_so_far) {
+			/* is it the same as the one previously found elsewhere? */
+			if (hashcmp(*found_sha1, current))
+				return 2; /* definitely not unique */
+		}
+	}
+	return seen_so_far;
+}
+
 static int find_short_packed_object(int len, const unsigned char *match, unsigned char *sha1)
 {
 	struct packed_git *p;
@@ -85,53 +138,9 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 	int found = 0;
 
 	prepare_packed_git();
-	for (p = packed_git; p && found < 2; p = p->next) {
-		uint32_t num, last;
-		uint32_t first = 0;
-		open_pack_index(p);
-		num = p->num_objects;
-		last = num;
-		while (first < last) {
-			uint32_t mid = (first + last) / 2;
-			const unsigned char *current;
-			int cmp;
-
-			current = nth_packed_object_sha1(p, mid);
-			cmp = hashcmp(match, current);
-			if (!cmp) {
-				first = mid;
-				break;
-			}
-			if (cmp > 0) {
-				first = mid+1;
-				continue;
-			}
-			last = mid;
-		}
-		if (first < num) {
-			const unsigned char *current, *next;
-			current = nth_packed_object_sha1(p, first);
-			if (match_sha(len, match, current)) {
-				next = nth_packed_object_sha1(p, first+1);
-				if (!next|| !match_sha(len, match, next)) {
-					/* unique within this pack */
-					if (!found) {
-						found_sha1 = current;
-						found++;
-					}
-					else if (hashcmp(found_sha1, current)) {
-						found = 2;
-						break;
-					}
-				}
-				else {
-					/* not even unique within this pack */
-					found = 2;
-					break;
-				}
-			}
-		}
-	}
+	for (p = packed_git; p && found < 2; p = p->next)
+		found = unique_in_pack(len, match, p, &found_sha1, found);
+
 	if (found == 1)
 		hashcpy(sha1, found_sha1);
 	return found;
-- 
1.7.11
