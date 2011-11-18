From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] bulk-checkin: do not write the same object twice
Date: Thu, 17 Nov 2011 23:11:56 -0800
Message-ID: <1321600317-30546-3-git-send-email-gitster@pobox.com>
References: <1319846051-462-1-git-send-email-gitster@pobox.com>
 <1321600317-30546-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 08:12:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRIcQ-0007eY-EU
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 08:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab1KRHMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 02:12:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab1KRHMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 02:12:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5771B2308
	for <git@vger.kernel.org>; Fri, 18 Nov 2011 02:12:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=91n5
	R5a3aBlhNFYATSSmGjv93EM=; b=NildyLk5JtpJmxvrQYdfwkji8MAhBnBo9Yms
	ScfUwtUNhmKgNxvTnC7ZrRGXRAEf/iXUHmQtCtSOj0wwxCC1cS1zXB0aN1HoWTPR
	O8dEW6s6xNoieUIDm9y2pSH7PjpQMO1v4csbwC8VPibr6TBhgAs/bmyZQOdY63qS
	Xvsf2bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Gcn0n7
	7a8TyNl+h3Iwv3TzXdXZzLUOb6oZXoRyNusOuqTO6nKg2ksfi+f8s90OQ9wrVLLb
	0Y5kLs1GNiJpPGD3DnzdUe7D4SDOedCNfY7wTJe/QSDDkrbiLiv7leBx9+n305ox
	+FoHmAR7PXFocqddezLN/vGrfHY9o2Q+KqzCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EC7D2307
	for <git@vger.kernel.org>; Fri, 18 Nov 2011 02:12:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A32FE2306 for
 <git@vger.kernel.org>; Fri, 18 Nov 2011 02:12:02 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc3.111.g7d421
In-Reply-To: <1321600317-30546-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9D301204-11B4-11E1-951C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185640>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bulk-checkin.c   |   28 ++++++++++++++++++++++++----
 t/t1050-large.sh |   20 +++++++++++++-------
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index c7e693e..82166ba 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -52,6 +52,17 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 	reprepare_packed_git();
 }
 
+static int already_written(struct bulk_checkin_state *state, unsigned char sha1[])
+{
+	int i;
+
+	/* Might want to keep the list sorted */
+	for (i = 0; i < state->nr_written; i++)
+		if (!hashcmp(state->written[i]->sha1, sha1))
+			return 1;
+	return 0;
+}
+
 static void deflate_to_pack(struct bulk_checkin_state *state,
 			    unsigned char sha1[],
 			    int fd, size_t size, enum object_type type,
@@ -64,6 +75,7 @@ static void deflate_to_pack(struct bulk_checkin_state *state,
 	int write_object = (flags & HASH_WRITE_OBJECT);
 	int status = Z_OK;
 	struct pack_idx_entry *idx = NULL;
+	struct sha1file_checkpoint checkpoint;
 
 	hdrlen = sprintf((char *)obuf, "%s %" PRIuMAX,
 			 typename(type), (uintmax_t)size) + 1;
@@ -73,6 +85,7 @@ static void deflate_to_pack(struct bulk_checkin_state *state,
 	if (write_object) {
 		idx = xcalloc(1, sizeof(*idx));
 		idx->offset = state->offset;
+		sha1file_checkpoint(state->f, &checkpoint);
 		crc32_begin(state->f);
 	}
 	memset(&s, 0, sizeof(s));
@@ -121,10 +134,17 @@ static void deflate_to_pack(struct bulk_checkin_state *state,
 	git_SHA1_Final(sha1, &ctx);
 	if (write_object) {
 		idx->crc32 = crc32_end(state->f);
-		hashcpy(idx->sha1, sha1);
-		ALLOC_GROW(state->written,
-			   state->nr_written + 1, state->alloc_written);
-		state->written[state->nr_written++] = idx;
+
+		if (already_written(state, sha1)) {
+			sha1file_truncate(state->f, &checkpoint);
+			state->offset = checkpoint.offset;
+			free(idx);
+		} else {
+			hashcpy(idx->sha1, sha1);
+			ALLOC_GROW(state->written,
+				   state->nr_written + 1, state->alloc_written);
+			state->written[state->nr_written++] = idx;
+		}
 	}
 }
 
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 36def25..fbd5ced 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -7,22 +7,28 @@ test_description='adding and checking out large blobs'
 
 test_expect_success setup '
 	git config core.bigfilethreshold 200k &&
-	echo X | dd of=large bs=1k seek=2000 &&
+	echo X | dd of=large1 bs=1k seek=2000 &&
+	echo X | dd of=large2 bs=1k seek=2000 &&
 	echo Y | dd of=huge bs=1k seek=2500
 '
 
 test_expect_success 'add a large file or two' '
-	git add large huge &&
+	git add large1 huge large2 &&
 	# make sure we got a single packfile and no loose objects
-	bad= count=0 &&
+	bad= count=0 idx= &&
 	for p in .git/objects/pack/pack-*.pack
 	do
 		count=$(( $count + 1 ))
-		test -f "$p" && continue
+		if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
+		then
+			continue
+		fi
 		bad=t
 	done &&
 	test -z "$bad" &&
 	test $count = 1 &&
+	cnt=$(git show-index <"$idx" | wc -l) &&
+	test $cnt = 2 &&
 	for l in .git/objects/??/??????????????????????????????????????
 	do
 		test -f "$l" || continue
@@ -32,10 +38,10 @@ test_expect_success 'add a large file or two' '
 '
 
 test_expect_success 'checkout a large file' '
-	large=$(git rev-parse :large) &&
-	git update-index --add --cacheinfo 100644 $large another &&
+	large1=$(git rev-parse :large1) &&
+	git update-index --add --cacheinfo 100644 $large1 another &&
 	git checkout another &&
-	cmp large another ;# this must not be test_cmp
+	cmp large1 another ;# this must not be test_cmp
 '
 
 test_done
-- 
1.7.8.rc3.111.g7d421
