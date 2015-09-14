From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] rerere: delay the recording of preimage
Date: Mon, 14 Sep 2015 16:57:27 -0700
Message-ID: <1442275050-30497-5-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 01:58:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbddE-0006bW-4r
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 01:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbbINX5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 19:57:39 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33638 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbINX5h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 19:57:37 -0400
Received: by pacex6 with SMTP id ex6so157665228pac.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=kvllvk6UazTlHzgZY4qPOSUkJk2hPOTDs5IbUbhQ3aQ=;
        b=sbBIhah3INVYrgDIbqB+EPdg7LR+TxgErZQC/kbrdVyl/M8xh8jxaFTcPkY8Zt19ze
         P8nfIU6grKczCp18Q4H4/UzlXU1WPxhXkatc2dYGFa/6mgn+/iOj4ayNYTFJE5+bwReA
         efUtI5lelsQ4gXcFOxdi205eMNwFunc6XVi3L5b02sSYKGynCPdK9E9Gs5iEBrnmRlEQ
         FdX3VTuJPHVPLzPsRw4PuvooWZPykxSSBWFexHe3vIlvD6fBcNd936iFqMsqDa7YftPM
         RaTgu3WOOepr4YRbPKbwr2vfSuCerrft/jwcDKF3b4I3eE4T1SciLBeElOTNA6wVNRoQ
         OPHQ==
X-Received: by 10.68.211.42 with SMTP id mz10mr40962546pbc.118.1442275057438;
        Mon, 14 Sep 2015 16:57:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1935:6a7f:d949:928e])
        by smtp.gmail.com with ESMTPSA id mn2sm18268200pbc.75.2015.09.14.16.57.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 16:57:36 -0700 (PDT)
X-Mailer: git-send-email 2.6.0-rc2-164-gdcd5d00
In-Reply-To: <1442275050-30497-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277882>

We record the preimage only when there is no directory to record the
conflict we encountered, i.e. when $GIT_DIR/rr-cache/$ID does not
exist.  As the plan is to allow multiple <preimage,postimage> pairs
as variants for the same conflict ID eventually, this logic needs to
go.

As the first step in that direction, stop the "did we create the
directory?  Then we record the preimage" logic.  Instead, we record
if a preimage does not exist when we saw a conflict in a path.  Also
make sure that we create a new preimage under $ID with existing
stale postimage, which most likely is totally unrelated to the
resolution of this new conflict.

In later patches, we will further update this logic to be "do we
have <preimage,postimage> pair that cleanly resolve the current
conflicts?  If not, record a new preimage as a new variant", but
that does not happen at this stage yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 52 +++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/rerere.c b/rerere.c
index a1e2963..c0482b8 100644
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
+			id->collection->status &= ~RR_HAS_PREIMAGE;
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
2.6.0-rc2-164-gdcd5d00
