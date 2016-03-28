From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/11] rerere: handle leftover rr-cache/$ID directory and postimage files
Date: Mon, 28 Mar 2016 15:42:14 -0700
Message-ID: <1459204942-26601-4-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
 <1459204942-26601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 00:42:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akfrs-0005Di-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbcC1Wmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 18:42:36 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755360AbcC1Wma (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:42:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 724AD4FFA1;
	Mon, 28 Mar 2016 18:42:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ORPh
	hyfNSPJoShvYCVQ3L3o2rao=; b=SZCzQ2tHnx5uX6foLyANzukrQhRlIDHHyCo3
	ItA6h6+Gi9fbYD1Y9UxU5u7X4Bi0Pzwr6dsINfNl3TELZ6cHypKa8BBd9Z0b7qR8
	KX8vGCTr5VroGHNBnv2ldn4RzVlcfqqlIUhYesDPOjtYmw5mHhowVQsBUztpXG4/
	VPaPa+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=T1R9Q/
	/WvqENhv683sJwECPA5TPXKMFSUo0iYGk9S9h51xv+MA/NMTnIAgY332KsTp8eSn
	s4fLRA837eA5bxkqTyYZPehgfPX2VzuScZ6RhFwxyMCNCXLl02+74Su8TG+XvYCk
	8QVFNlr4ee5LDPNRVSMIwcoJTig1XDAM9YSn4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 685934FFA0;
	Mon, 28 Mar 2016 18:42:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D3D444FF9F;
	Mon, 28 Mar 2016 18:42:28 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-g046a488
In-Reply-To: <1459204942-26601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 59D4E632-F536-11E5-8138-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290073>

If by some accident there is only $GIT_DIR/rr-cache/$ID directory
existed, we wouldn't have recorded a preimage for a conflict that
is newly encountered, which would mean after a manual resolution,
we wouldn't have recorded it by storing the postimage, because the
logic used to be "if there is no rr-cache/$ID directory, then we are
the first so record the preimage".  Instead, record preimage if we
do not have one.

In addition, if there is only $GIT_DIR/rr-cache/$ID/postimage
without corresponding preimage, we would have tried to call into
merge() and punted.

These would have been a situation frustratingly hard to recover
from.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * A test that saved away both postimage and preimage has been
   updated to only save postimage, as we do not look at the other
   one.

 rerere.c          | 42 +++++++++++++++++++++++++-----------------
 t/t4200-rerere.sh | 17 ++++++++++++++++-
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/rerere.c b/rerere.c
index fbdade8..a1e2963 100644
--- a/rerere.c
+++ b/rerere.c
@@ -117,7 +117,9 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 
 static int has_rerere_resolution(const struct rerere_id *id)
 {
-	return (id->collection->status & RR_HAS_POSTIMAGE);
+	const int both = RR_HAS_POSTIMAGE|RR_HAS_PREIMAGE;
+
+	return ((id->collection->status & both) == both);
 }
 
 static struct rerere_id *new_rerere_id_hex(char *hex)
@@ -806,24 +808,30 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		string_list_insert(rr, path)->util = id;
 
 		/*
-		 * If the directory does not exist, create
-		 * it.  mkdir_in_gitdir() will fail with
-		 * EEXIST if there already is one.
-		 *
-		 * NEEDSWORK: make sure "gc" does not remove
-		 * preimage without removing the directory.
+		 * Ensure that the directory exists.
+		 * mkdir_in_gitdir() will fail with EEXIST if there
+		 * already is one.
 		 */
-		if (mkdir_in_gitdir(rerere_path(id, NULL)))
-			continue;
+		if (mkdir_in_gitdir(rerere_path(id, NULL)) &&
+		    errno != EEXIST)
+			continue; /* NEEDSWORK: perhaps we should die? */
 
-		/*
-		 * We are the first to encounter this
-		 * conflict.  Ask handle_file() to write the
-		 * normalized contents to the "preimage" file.
-		 */
-		handle_file(path, NULL, rerere_path(id, "preimage"));
-		id->collection->status |= RR_HAS_PREIMAGE;
-		fprintf(stderr, "Recorded preimage for '%s'\n", path);
+		if (id->collection->status & RR_HAS_PREIMAGE) {
+			;
+		} else {
+			/*
+			 * We are the first to encounter this
+			 * conflict.  Ask handle_file() to write the
+			 * normalized contents to the "preimage" file.
+			 *
+			 * NEEDSWORK: what should happen if we had a
+			 * leftover postimage that is totally
+			 * unrelated?  Perhaps we should unlink it?
+			 */
+			handle_file(path, NULL, rerere_path(id, "preimage"));
+			id->collection->status |= RR_HAS_PREIMAGE;
+			fprintf(stderr, "Recorded preimage for '%s'\n", path);
+		}
 	}
 
 	for (i = 0; i < rr->nr; i++)
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index ed9c91e..c428011 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -184,12 +184,27 @@ test_expect_success 'rerere updates postimage timestamp' '
 '
 
 test_expect_success 'rerere clear' '
-	rm $rr/postimage &&
+	mv $rr/postimage .git/post-saved &&
 	echo "$sha1	a1" | perl -pe "y/\012/\000/" >.git/MERGE_RR &&
 	git rerere clear &&
 	! test -d $rr
 '
 
+test_expect_success 'leftover directory' '
+	git reset --hard &&
+	mkdir -p $rr &&
+	test_must_fail git merge first &&
+	test -f $rr/preimage
+'
+
+test_expect_success 'missing preimage' '
+	git reset --hard &&
+	mkdir -p $rr &&
+	cp .git/post-saved $rr/postimage &&
+	test_must_fail git merge first &&
+	test -f $rr/preimage
+'
+
 test_expect_success 'set up for garbage collection tests' '
 	mkdir -p $rr &&
 	echo Hello >$rr/preimage &&
-- 
2.8.0-215-g046a488
