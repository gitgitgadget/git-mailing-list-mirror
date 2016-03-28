From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/11] rerere: delay the recording of preimage
Date: Mon, 28 Mar 2016 15:42:15 -0700
Message-ID: <1459204942-26601-5-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
 <1459204942-26601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 00:42:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akfrt-0005Di-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbcC1Wmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 18:42:38 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755486AbcC1Wmc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:42:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1ED854FFA8;
	Mon, 28 Mar 2016 18:42:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QbS8
	FOY/UoFxNC/NtDckgcWKwI4=; b=JncV8jorl5V1DavRpUUY/Lx5uxDNSWzdQCNu
	qw+YJsfBPWMWeUiC55id2lcBmIvIzAoPZ5FGAI3/LrHPPPb21PAd+mcJY8ZGOVXT
	aboV062hHfUj5CvjTXFY4OvsFCqHFcuNKCrIIHPSdPUN3pi2k7Yt3jJuawnqXD2g
	hMCRs5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HIcjCr
	LSShNrboco2KNPxCR99u2cUkiN03xw8qHotcvQVE+QPF0/kV/OtOagApjcWnWQF7
	XqFCmKSmfqJmwZV93NOO2hojup7J+02z5NaqWESHjJCPwfT1e6KIyS0D0YS/NQ2l
	1xJYRjPtB40XFemnxn5dfdOjPQiPhk3uF23Yk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 169034FFA7;
	Mon, 28 Mar 2016 18:42:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 855414FFA5;
	Mon, 28 Mar 2016 18:42:30 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-g046a488
In-Reply-To: <1459204942-26601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5AD4EB7C-F536-11E5-815C-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290070>

We record the preimage only when there is no directory to record the
conflict we encountered, i.e. when $GIT_DIR/rr-cache/$ID does not
exist.  As the plan is to allow multiple <preimage,postimage> pairs
as variants for the same conflict ID eventually, this logic needs to
go.

As the first step in that direction, stop the "did we create the
directory?  Then we record the preimage" logic.  Instead, we record
if a preimage does not exist when we saw a conflict in a path.  Also
make sure that we remove a stale postimage, which most likely is
totally unrelated to the resolution of this new conflict, when we
create a new preimage under $ID when $GIT_DIR/rr-cache/$ID already
exists.

In later patches, we will further update this logic to be "do we
have <preimage,postimage> pair that cleanly resolve the current
conflicts?  If not, record a new preimage as a new variant", but
that does not happen at this stage yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The previous one had a handful of confusions between which of
   RR_HAS_{PRE,POST}IMAGE bit to clear, which was pointed out by
   J6t.  The corrections to them appear here and a few patches
   that follow this one in this round.

 rerere.c | 52 +++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/rerere.c b/rerere.c
index a1e2963..33b1348 100644
--- a/rerere.c
+++ b/rerere.c
@@ -122,6 +122,11 @@ static int has_rerere_resolution(const struct rerere_id *id)
 	return ((id->collection->status & both) == both);
 }
 
+static int has_rerere_preimage(const struct rerere_id *id)
+{
+	return (id->collection->status & RR_HAS_PREIMAGE);
+}
+
 static struct rerere_id *new_rerere_id_hex(char *hex)
 {
 	struct rerere_id *id = xmalloc(sizeof(*id));
@@ -749,8 +754,24 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 	const char *path = rr_item->string;
 	const struct rerere_id *id = rr_item->util;
 
-	/* Is there a recorded resolution we could attempt to apply? */
-	if (has_rerere_resolution(id)) {
+	if (!has_rerere_preimage(id)) {
+		/*
+		 * We are the first to encounter this conflict.  Ask
+		 * handle_file() to write the normalized contents to
+		 * the "preimage" file.
+		 */
+		handle_file(path, NULL, rerere_path(id, "preimage"));
+		if (id->collection->status & RR_HAS_POSTIMAGE) {
+			const char *path = rerere_path(id, "postimage");
+			if (unlink(path))
+				die_errno("cannot unlink stray '%s'", path);
+			id->collection->status &= ~RR_HAS_POSTIMAGE;
+		}
+		id->collection->status |= RR_HAS_PREIMAGE;
+		fprintf(stderr, "Recorded preimage for '%s'\n", path);
+		return;
+	} else if (has_rerere_resolution(id)) {
+		/* Is there a recorded resolution we could attempt to apply? */
 		if (merge(id, path))
 			return; /* failed to replay */
 
@@ -807,31 +828,8 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		id = new_rerere_id(sha1);
 		string_list_insert(rr, path)->util = id;
 
-		/*
-		 * Ensure that the directory exists.
-		 * mkdir_in_gitdir() will fail with EEXIST if there
-		 * already is one.
-		 */
-		if (mkdir_in_gitdir(rerere_path(id, NULL)) &&
-		    errno != EEXIST)
-			continue; /* NEEDSWORK: perhaps we should die? */
-
-		if (id->collection->status & RR_HAS_PREIMAGE) {
-			;
-		} else {
-			/*
-			 * We are the first to encounter this
-			 * conflict.  Ask handle_file() to write the
-			 * normalized contents to the "preimage" file.
-			 *
-			 * NEEDSWORK: what should happen if we had a
-			 * leftover postimage that is totally
-			 * unrelated?  Perhaps we should unlink it?
-			 */
-			handle_file(path, NULL, rerere_path(id, "preimage"));
-			id->collection->status |= RR_HAS_PREIMAGE;
-			fprintf(stderr, "Recorded preimage for '%s'\n", path);
-		}
+		/* Ensure that the directory exists. */
+		mkdir_in_gitdir(rerere_path(id, NULL));
 	}
 
 	for (i = 0; i < rr->nr; i++)
-- 
2.8.0-215-g046a488
