From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 07/25] sha1_name.c: refactor find_short_packed_object()
Date: Tue,  3 Jul 2012 14:36:57 -0700
Message-ID: <1341351435-31011-8-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:39:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAoi-0007F5-BZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223Ab2GCViL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34921 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756448Ab2GCVha (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB66E8647
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=VrDT
	N6gqkEIDEYjf7ESWvQ8BRJo=; b=UK9CynNNBl8fKTT5Gnhf872qxmHOkfOTdZ/V
	YZdsDwCx0n6cA39Rk9iAgOXHC6OWPgDWuD2aW7gbBMe0N+vYNeUJ6y3Py5rD8sfF
	EAMnRIzUprqDYKn5hYlajbsX0ymTmYnGpAmd7HdObSoxlSYukpE6x1kFHYvbpwuu
	LA2G/1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=lx5unv
	Te/VNZjG4sXPvabgucz/XqC+xNW+iB6Sq2itc7Qdy8k0pIZ9gwFflPVH+ZZGvRZS
	r8QdlUrnsv+CdFF49+SrP4DUZKr/R9CsamDaXQmh7EHkd3wTfZkKkv6ApCLvsQjh
	bADSv/PQKMVFqb7enS3LJvgrFnAJtR0xMuMUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E23C78646
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 555278645 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4A15CE9A-C557-11E1-8578-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200967>

Extract the logic to find object(s) that match a given prefix inside
a single pack into a separate helper function, and give it a bit more
comment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 103 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index c5c4591..7bef45f 100644
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
1.7.11.1.229.g706c98f
