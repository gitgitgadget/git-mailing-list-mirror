From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 09/25] sha1_name.c: restructure disambiguation of short
 names
Date: Tue,  3 Jul 2012 14:36:59 -0700
Message-ID: <1341351435-31011-10-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAnb-0005Fb-S8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab2GCViN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756518Ab2GCVhf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 785C8864F
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=nhyK
	KjaQcOLUyms57ediJ0JCJbc=; b=Vy3dMoeIaDzQm4cRxYoqjIuqQOWyKw2nmezB
	D4XjKGMYvINJlKDdSE6tJIA3NH4zraBUD00XQRf2EifVDQrnc0ihbqCre4ZZIlRN
	UGnzb3Xqad1f/JwPMt2h9jXShqCHI5XIufPHFLaHchw9ByMaePR1iU1VzorbZduf
	E/3n4jI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Tou3iO
	t5WGPB+392DRzJ9KlYbpGQR5XX3c3KVyY42E4Di2HpNAnsBWC7vLnW/RVNWXne+a
	wy/zgKfmT+wKrXtPWWR8ghUvpL5kRzhtREU7bm3sUqf+LnHvla4M7zA5cRTYKju7
	eaGYAlKBBhiBTOoit7/9s8WjnXButw1HCz3g8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EC55864E
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C1A3864B for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4C9A75E4-C557-11E1-8873-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200951>

We try to find zero, one or more matches from loose objects and
packed objects independently and then decide if the given short
object name is unique across them.

Instead, introduce a "struct disambiguate_state" that keeps track of
what we have found so far, that can be one of:

 - We have seen one object that _could_ be what we are looking for;
 - We have also checked that object for additional constraints (if any),
   and found that the object satisfies it;
 - We have also checked that object for additional constraints (if any),
   and found that the object does not satisfy it; or
 - We have seen more than one objects that satisfy the constraints.

and pass it to the enumeration functions for loose and packed
objects.  The disambiguation state can optionally take a callback
function that takes a candidate object name and reports if the
object satisifies additional criteria (e.g. when the caller knows
that the short name must refer to a commit, this mechanism can be
used to check the type of the given object).

Compared to the earlier attempt, this round avoids the optional
check if there is only one candidate that matches the short name in
the first place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 172 +++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 112 insertions(+), 60 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index db8ac83..2e2dbb8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -9,11 +9,67 @@
 
 static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
 
-static int find_short_object_filename(int len, const char *hex_pfx, unsigned char *sha1)
+typedef int (*disambiguate_hint_fn)(const unsigned char *, void *);
+
+struct disambiguate_state {
+	disambiguate_hint_fn fn;
+	void *cb_data;
+	unsigned char candidate[20];
+	unsigned candidate_exists:1;
+	unsigned candidate_checked:1;
+	unsigned candidate_ok:1;
+	unsigned disambiguate_fn_used:1;
+	unsigned ambiguous:1;
+};
+
+static void update_candidates(struct disambiguate_state *ds, const unsigned char *current)
+{
+	if (!ds->candidate_exists) {
+		/* this is the first candidate */
+		hashcpy(ds->candidate, current);
+		ds->candidate_exists = 1;
+		return;
+	} else if (!hashcmp(ds->candidate, current)) {
+		/* the same as what we already have seen */
+		return;
+	}
+
+	if (!ds->fn) {
+		/* cannot disambiguate between ds->candidate and current */
+		ds->ambiguous = 1;
+		return;
+	}
+
+	if (!ds->candidate_checked) {
+		ds->candidate_ok = ds->fn(ds->candidate, ds->cb_data);
+		ds->disambiguate_fn_used = 1;
+		ds->candidate_checked = 1;
+	}
+
+	if (!ds->candidate_ok) {
+		/* discard the candidate; we know it does not satisify fn */
+		hashcpy(ds->candidate, current);
+		ds->candidate_checked = 0;
+		return;
+	}
+
+	/* if we reach this point, we know ds->candidate satisfies fn */
+	if (ds->fn(current, ds->cb_data)) {
+		/*
+		 * if both current and candidate satisfy fn, we cannot
+		 * disambiguate.
+		 */
+		ds->candidate_ok = 0;
+		ds->ambiguous = 1;
+	}
+
+	/* otherwise, current can be discarded and candidate is still good */
+}
+
+static void find_short_object_filename(int len, const char *hex_pfx, struct disambiguate_state *ds)
 {
 	struct alternate_object_database *alt;
 	char hex[40];
-	int found = 0;
 	static struct alternate_object_database *fakeent;
 
 	if (!fakeent) {
@@ -35,32 +91,27 @@ static int find_short_object_filename(int len, const char *hex_pfx, unsigned cha
 	fakeent->next = alt_odb_list;
 
 	sprintf(hex, "%.2s", hex_pfx);
-	for (alt = fakeent; alt && found < 2; alt = alt->next) {
+	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
 		struct dirent *de;
 		DIR *dir;
 		sprintf(alt->name, "%.2s/", hex_pfx);
 		dir = opendir(alt->base);
 		if (!dir)
 			continue;
-		while ((de = readdir(dir)) != NULL) {
+
+		while (!ds->ambiguous && (de = readdir(dir)) != NULL) {
+			unsigned char sha1[20];
+
 			if (strlen(de->d_name) != 38)
 				continue;
 			if (memcmp(de->d_name, hex_pfx + 2, len - 2))
 				continue;
-			if (!found) {
-				memcpy(hex + 2, de->d_name, 38);
-				found++;
-			}
-			else if (memcmp(hex + 2, de->d_name, 38)) {
-				found = 2;
-				break;
-			}
+			memcpy(hex + 2, de->d_name, 38);
+			if (!get_sha1_hex(hex, sha1))
+				update_candidates(ds, sha1);
 		}
 		closedir(dir);
 	}
-	if (found == 1)
-		return get_sha1_hex(hex, sha1) == 0;
-	return found;
 }
 
 static int match_sha(unsigned len, const unsigned char *a, const unsigned char *b)
@@ -78,11 +129,10 @@ static int match_sha(unsigned len, const unsigned char *a, const unsigned char *
 	return 1;
 }
 
-static int unique_in_pack(int len,
+static void unique_in_pack(int len,
 			  const unsigned char *bin_pfx,
-			  struct packed_git *p,
-			  const unsigned char **found_sha1,
-			  int seen_so_far)
+			   struct packed_git *p,
+			   struct disambiguate_state *ds)
 {
 	uint32_t num, last, i, first = 0;
 	const unsigned char *current = NULL;
@@ -113,63 +163,58 @@ static int unique_in_pack(int len,
 	 * with an object name that could match "bin_pfx".  See if we have
 	 * 0, 1 or more objects that actually match(es).
 	 */
-	for (i = first; i < num; i++) {
-		current = nth_packed_object_sha1(p, first);
+	for (i = first; i < num && !ds->ambiguous; i++) {
+		current = nth_packed_object_sha1(p, i);
 		if (!match_sha(len, bin_pfx, current))
 			break;
-
-		/* current matches */
-		if (!seen_so_far) {
-			*found_sha1 = current;
-			seen_so_far++;
-		} else if (seen_so_far) {
-			/* is it the same as the one previously found elsewhere? */
-			if (hashcmp(*found_sha1, current))
-				return 2; /* definitely not unique */
-		}
+		update_candidates(ds, current);
 	}
-	return seen_so_far;
 }
 
-static int find_short_packed_object(int len, const unsigned char *bin_pfx, unsigned char *sha1)
+static void find_short_packed_object(int len, const unsigned char *bin_pfx,
+				     struct disambiguate_state *ds)
 {
 	struct packed_git *p;
-	const unsigned char *found_sha1 = NULL;
-	int found = 0;
 
 	prepare_packed_git();
-	for (p = packed_git; p && found < 2; p = p->next)
-		found = unique_in_pack(len, bin_pfx, p, &found_sha1, found);
-
-	if (found == 1)
-		hashcpy(sha1, found_sha1);
-	return found;
+	for (p = packed_git; p && !ds->ambiguous; p = p->next)
+		unique_in_pack(len, bin_pfx, p, ds);
 }
 
 #define SHORT_NAME_NOT_FOUND (-1)
 #define SHORT_NAME_AMBIGUOUS (-2)
 
-static int find_unique_short_object(int len, char *hex_pfx,
-				    unsigned char *bin_pfx, unsigned char *sha1)
+static int finish_object_disambiguation(struct disambiguate_state *ds,
+					unsigned char *sha1)
 {
-	int has_unpacked, has_packed;
-	unsigned char unpacked_sha1[20], packed_sha1[20];
+	if (ds->ambiguous)
+		return SHORT_NAME_AMBIGUOUS;
 
-	prepare_alt_odb();
-	has_unpacked = find_short_object_filename(len, hex_pfx, unpacked_sha1);
-	has_packed = find_short_packed_object(len, bin_pfx, packed_sha1);
-	if (!has_unpacked && !has_packed)
+	if (!ds->candidate_exists)
 		return SHORT_NAME_NOT_FOUND;
-	if (1 < has_unpacked || 1 < has_packed)
-		return SHORT_NAME_AMBIGUOUS;
-	if (has_unpacked != has_packed) {
-		hashcpy(sha1, (has_packed ? packed_sha1 : unpacked_sha1));
-		return 0;
-	}
-	/* Both have unique ones -- do they match? */
-	if (hashcmp(packed_sha1, unpacked_sha1))
-		return SHORT_NAME_AMBIGUOUS;
-	hashcpy(sha1, packed_sha1);
+
+	if (!ds->candidate_checked)
+		/*
+		 * If this is the only candidate, there is no point
+		 * calling the disambiguation hint callback.
+		 *
+		 * On the other hand, if the current candidate
+		 * replaced an earlier candidate that did _not_ pass
+		 * the disambiguation hint callback, then we do have
+		 * more than one objects that match the short name
+		 * given, so we should make sure this one matches;
+		 * otherwise, if we discovered this one and the one
+		 * that we previously discarded in the reverse order,
+		 * we would end up showing different results in the
+		 * same repository!
+		 */
+		ds->candidate_ok = (!ds->disambiguate_fn_used ||
+				    ds->fn(ds->candidate, ds->cb_data));
+
+	if (!ds->candidate_ok)
+		return SHORT_NAME_NOT_FOUND;
+
+	hashcpy(sha1, ds->candidate);
 	return 0;
 }
 
@@ -179,6 +224,7 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	int i, status;
 	char hex_pfx[40];
 	unsigned char bin_pfx[20];
+	struct disambiguate_state ds;
 
 	if (len < MINIMUM_ABBREV || len > 40)
 		return -1;
@@ -203,7 +249,13 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 		bin_pfx[i >> 1] |= val;
 	}
 
-	status = find_unique_short_object(i, hex_pfx, bin_pfx, sha1);
+	prepare_alt_odb();
+
+	memset(&ds, 0, sizeof(ds));
+	find_short_object_filename(len, hex_pfx, &ds);
+	find_short_packed_object(len, bin_pfx, &ds);
+	status = finish_object_disambiguation(&ds, sha1);
+
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
 		return error("short SHA1 %.*s is ambiguous.", len, hex_pfx);
 	return status;
-- 
1.7.11.1.229.g706c98f
