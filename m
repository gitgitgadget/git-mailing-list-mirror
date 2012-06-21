From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/9] sha1_name.c: correct misnamed "canonical" and "res"
Date: Wed, 20 Jun 2012 23:35:28 -0700
Message-ID: <1340260532-11378-6-git-send-email-gitster@pobox.com>
References: <1340260532-11378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 08:36:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shazn-0006l5-0d
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640Ab2FUGfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:35:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754373Ab2FUGfn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:35:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E5098B26
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/aJI
	R3gIMLfpWNAkkLIaD0FKtNM=; b=FGz6wC3fV9P62tXon0P+c3UmQ9OKDEyEWOG4
	TBV39kD9gRROAfPpXpDCqtY3aJxs+q6ER6Hi4bZrxD3HvzK/ZALtYF3r289cKhVX
	ryGQKMkryJqAPp5ptE80B+2nwt9vWuivaf6Rx3GKWXwAWvYoFQSg3yG0wSCnrpWb
	ZwSZxH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=IYT5Lk
	geyG70HuQ0llddRgay5DmMHX4BcFLft+EBR9dA5lQNb7zU3c5uGgU2aOvs4WkSP+
	fVR9mcZHOeAgXfFNSnjbQGuFZHLwuhalw8ZOhpNB8qHa8tarkbprgM8kPfdKSF3X
	tcrK7FG1+5h1n+wazhosGSfGluuxHvaRcvioo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 443008B24
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FB0F8B22 for
 <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.gd284367
In-Reply-To: <1340260532-11378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 52FC269E-BB6B-11E1-A204-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200391>

These are hexadecimal and binary representation of the short object
name given to the callchain as its input.  Rename them with _pfx
suffix to make it clear they are prefixes, and call them hex and bin
respectively.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index e03992c..7062f72 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -9,7 +9,7 @@
 
 static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
 
-static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
+static int find_short_object_filename(int len, const char *hex_pfx, unsigned char *sha1)
 {
 	struct alternate_object_database *alt;
 	char hex[40];
@@ -34,18 +34,18 @@ static int find_short_object_filename(int len, const char *name, unsigned char *
 	}
 	fakeent->next = alt_odb_list;
 
-	sprintf(hex, "%.2s", name);
+	sprintf(hex, "%.2s", hex_pfx);
 	for (alt = fakeent; alt && found < 2; alt = alt->next) {
 		struct dirent *de;
 		DIR *dir;
-		sprintf(alt->name, "%.2s/", name);
+		sprintf(alt->name, "%.2s/", hex_pfx);
 		dir = opendir(alt->base);
 		if (!dir)
 			continue;
 		while ((de = readdir(dir)) != NULL) {
 			if (strlen(de->d_name) != 38)
 				continue;
-			if (memcmp(de->d_name, name + 2, len - 2))
+			if (memcmp(de->d_name, hex_pfx + 2, len - 2))
 				continue;
 			if (!found) {
 				memcpy(hex + 2, de->d_name, 38);
@@ -79,7 +79,7 @@ static int match_sha(unsigned len, const unsigned char *a, const unsigned char *
 }
 
 static int unique_in_pack(int len,
-			  const unsigned char *match,
+			  const unsigned char *bin_pfx,
 			  struct packed_git *p,
 			  const unsigned char **found_sha1,
 			  int seen_so_far)
@@ -96,7 +96,7 @@ static int unique_in_pack(int len,
 		int cmp;
 
 		current = nth_packed_object_sha1(p, mid);
-		cmp = hashcmp(match, current);
+		cmp = hashcmp(bin_pfx, current);
 		if (!cmp) {
 			first = mid;
 			break;
@@ -110,12 +110,12 @@ static int unique_in_pack(int len,
 
 	/*
 	 * At this point, "first" is the location of the lowest object
-	 * with an object name that could match "match".  See if we have
+	 * with an object name that could match "bin_pfx".  See if we have
 	 * 0, 1 or more objects that actually match(es).
 	 */
 	for (i = first; i < num; i++) {
 		current = nth_packed_object_sha1(p, first);
-		if (!match_sha(len, match, current))
+		if (!match_sha(len, bin_pfx, current))
 			break;
 
 		/* current matches */
@@ -131,7 +131,7 @@ static int unique_in_pack(int len,
 	return seen_so_far;
 }
 
-static int find_short_packed_object(int len, const unsigned char *match, unsigned char *sha1)
+static int find_short_packed_object(int len, const unsigned char *bin_pfx, unsigned char *sha1)
 {
 	struct packed_git *p;
 	const unsigned char *found_sha1 = NULL;
@@ -139,7 +139,7 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 
 	prepare_packed_git();
 	for (p = packed_git; p && found < 2; p = p->next)
-		found = unique_in_pack(len, match, p, &found_sha1, found);
+		found = unique_in_pack(len, bin_pfx, p, &found_sha1, found);
 
 	if (found == 1)
 		hashcpy(sha1, found_sha1);
@@ -149,15 +149,15 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 #define SHORT_NAME_NOT_FOUND (-1)
 #define SHORT_NAME_AMBIGUOUS (-2)
 
-static int find_unique_short_object(int len, char *canonical,
-				    unsigned char *res, unsigned char *sha1)
+static int find_unique_short_object(int len, char *hex_pfx,
+				    unsigned char *bin_pfx, unsigned char *sha1)
 {
 	int has_unpacked, has_packed;
 	unsigned char unpacked_sha1[20], packed_sha1[20];
 
 	prepare_alt_odb();
-	has_unpacked = find_short_object_filename(len, canonical, unpacked_sha1);
-	has_packed = find_short_packed_object(len, res, packed_sha1);
+	has_unpacked = find_short_object_filename(len, hex_pfx, unpacked_sha1);
+	has_packed = find_short_packed_object(len, bin_pfx, packed_sha1);
 	if (!has_unpacked && !has_packed)
 		return SHORT_NAME_NOT_FOUND;
 	if (1 < has_unpacked || 1 < has_packed)
@@ -177,13 +177,13 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  int quietly)
 {
 	int i, status;
-	char canonical[40];
-	unsigned char res[20];
+	char hex_pfx[40];
+	unsigned char bin_pfx[20];
 
 	if (len < MINIMUM_ABBREV || len > 40)
 		return -1;
-	hashclr(res);
-	memset(canonical, 'x', 40);
+	hashclr(bin_pfx);
+	memset(hex_pfx, 'x', 40);
 	for (i = 0; i < len ;i++) {
 		unsigned char c = name[i];
 		unsigned char val;
@@ -197,15 +197,15 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 		}
 		else
 			return -1;
-		canonical[i] = c;
+		hex_pfx[i] = c;
 		if (!(i & 1))
 			val <<= 4;
-		res[i >> 1] |= val;
+		bin_pfx[i >> 1] |= val;
 	}
 
-	status = find_unique_short_object(i, canonical, res, sha1);
+	status = find_unique_short_object(i, hex_pfx, bin_pfx, sha1);
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
-		return error("short SHA1 %.*s is ambiguous.", len, canonical);
+		return error("short SHA1 %.*s is ambiguous.", len, hex_pfx);
 	return status;
 }
 
-- 
1.7.11.2.gd284367
