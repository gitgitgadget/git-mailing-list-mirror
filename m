From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] rerere: handle leftover rr-cache/$ID directory and postimage files
Date: Mon, 14 Sep 2015 16:57:26 -0700
Message-ID: <1442275050-30497-4-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 01:57:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbdd3-0006Ie-5U
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 01:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbbINX5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 19:57:41 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34536 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbbINX5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 19:57:36 -0400
Received: by padhy16 with SMTP id hy16so157262931pad.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=s8CFCO/2E2fac77Sh/VGpyGgLwmS3AcHkVungzrhNJk=;
        b=wUlo1rBMuQV+GkIEKtJPpk+gIJ/Vm3SJLvbrc1rpsBsTrRLTdrrg0x4TTYKG146R6s
         jekjrU8vAfkUtsYdTF4sekMyCnclhUB5vL84mOowfvXNRYdg34UH9nE6wSIe9EHoCi/L
         2sKCT//AbiTd5IQqSTpwJMVkNY7TR26Ug4wxuA/QiGg17RZMmTiHG7W1xHmW91bO6d0i
         RJnZ7LGBbwyQqlP+m3r7f7fvO0H2UsD3qw0BW4acY8AXTBL6fpo4YV9mURTH5545Stq6
         1o/yaQRdIt//rh2LZx+NESpgzY664uLutzJ0KAYKM/jm3feWjBBPIJ2PzEBhdRByQNZv
         SxNg==
X-Received: by 10.68.104.227 with SMTP id gh3mr41032839pbb.108.1442275056215;
        Mon, 14 Sep 2015 16:57:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1935:6a7f:d949:928e])
        by smtp.gmail.com with ESMTPSA id bz4sm18343831pbd.6.2015.09.14.16.57.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 16:57:35 -0700 (PDT)
X-Mailer: git-send-email 2.6.0-rc2-164-gdcd5d00
In-Reply-To: <1442275050-30497-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277881>

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
 rerere.c          | 42 +++++++++++++++++++++++++-----------------
 t/t4200-rerere.sh | 18 +++++++++++++++++-
 2 files changed, 42 insertions(+), 18 deletions(-)

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
index ed9c91e..52a8e09 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -184,12 +184,28 @@ test_expect_success 'rerere updates postimage timestamp' '
 '
 
 test_expect_success 'rerere clear' '
-	rm $rr/postimage &&
+	cp $rr/preimage .git/pre-saved &&
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
2.6.0-rc2-164-gdcd5d00
