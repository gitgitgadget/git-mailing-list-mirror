From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] rerere: do use multiple variants
Date: Mon, 14 Sep 2015 16:57:30 -0700
Message-ID: <1442275050-30497-8-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 01:57:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbdd3-0006Ie-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 01:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbbINX5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 19:57:42 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36027 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbbINX5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 19:57:41 -0400
Received: by padhk3 with SMTP id hk3so157175506pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=qRrf3jjT5eJEeEyd2hCQ+yJB1l0OmygOsyPGlIZZafQ=;
        b=VLaYSNAbVvWUFdIjjdAXDsZwbL81FIlNosfS/eicqCduVZk6LVQruHFjlWp5YgmJxk
         HXsJsb8DVZ/n3XHzUwq5hQDpyW+XpQsJtCkw+tgtd7w0bDqS6q9benAqpOKnAewDvYW+
         V7yv+1QprhRKefHMSCS/NjTvbTlkoZyhHMw44cShXNIUwWSddOAqHGvfkn/uQYoOhu3V
         flUn6JyLFQTU/vw+kcpXrxHUd8/XBkMKlmMd9vAbxMuDrYoXoJXKM6EU0cN1vj9eIcwC
         bs3C0NdYCCCHSn2eB/LiC4b+bZ1cWjz/PYZ1HiHKBfJDmXXVZWDXbED/uurEBMwcNm8/
         8xGA==
X-Received: by 10.67.3.3 with SMTP id bs3mr40439002pad.121.1442275061010;
        Mon, 14 Sep 2015 16:57:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1935:6a7f:d949:928e])
        by smtp.gmail.com with ESMTPSA id fa1sm18313587pbb.35.2015.09.14.16.57.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 16:57:40 -0700 (PDT)
X-Mailer: git-send-email 2.6.0-rc2-164-gdcd5d00
In-Reply-To: <1442275050-30497-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277880>

This enables the multiple-variant support for real.  Multiple
conflicts of the same shape can have differences in contexts where
they appear, interfering the replaying of recorded resolution of one
conflict to another, and in such a case, their resolutions are
recorded as different variants under the same conflict ID.

We still need to adjust garbage collection codepaths for this
change, but the basic "replay" functionality is functional with
this change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c          | 94 +++++++++++++++++++++++++++++++++----------------------
 t/t4200-rerere.sh |  2 +-
 2 files changed, 57 insertions(+), 39 deletions(-)

diff --git a/rerere.c b/rerere.c
index f674461..cefc865 100644
--- a/rerere.c
+++ b/rerere.c
@@ -74,7 +74,9 @@ static void assign_variant(struct rerere_id *id)
 
 	variant = id->variant;
 	if (variant < 0) {
-		variant = 0; /* for now */
+		for (variant = 0; variant < rr_dir->status_nr; variant++)
+			if (!rr_dir->status[variant])
+				break;
 	}
 	fit_variant(rr_dir, variant);
 	id->variant = variant;
@@ -177,15 +179,6 @@ static int has_rerere_resolution(const struct rerere_id *id)
 	return ((id->collection->status[variant] & both) == both);
 }
 
-static int has_rerere_preimage(const struct rerere_id *id)
-{
-	int variant = id->variant;
-
-	if (variant < 0)
-		return 0;
-	return (id->collection->status[variant] & RR_HAS_PREIMAGE);
-}
-
 static struct rerere_id *new_rerere_id_hex(char *hex)
 {
 	struct rerere_id *id = xmalloc(sizeof(*id));
@@ -818,6 +811,13 @@ static void update_paths(struct string_list *update)
 		rollback_lock_file(&index_lock);
 }
 
+static void remove_variant(struct rerere_id *id)
+{
+	unlink_or_warn(rerere_path(id, "postimage"));
+	unlink_or_warn(rerere_path(id, "preimage"));
+	id->collection->status[id->variant] = 0;
+}
+
 /*
  * The path indicated by rr_item may still have conflict for which we
  * have a recorded resolution, in which case replay it and optionally
@@ -830,32 +830,42 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 {
 	const char *path = rr_item->string;
 	struct rerere_id *id = rr_item->util;
+	struct rerere_dir *rr_dir = id->collection;
 	int variant;
 
-	if (id->variant < 0)
-		assign_variant(id);
 	variant = id->variant;
 
-	if (!has_rerere_preimage(id)) {
+	/* Has the user resolved it already? */
+	if (variant >= 0) {
+		if (!handle_file(path, NULL, NULL)) {
+			copy_file(rerere_path(id, "postimage"), path, 0666);
+			id->collection->status[variant] |= RR_HAS_POSTIMAGE;
+			fprintf(stderr, "Recorded resolution for '%s'.\n", path);
+			free_rerere_id(rr_item);
+			rr_item->util = NULL;
+			return;
+		}
 		/*
-		 * We are the first to encounter this conflict.  Ask
-		 * handle_file() to write the normalized contents to
-		 * the "preimage" file.
+		 * There may be other variants that can cleanly
+		 * replay.  Try them and update the variant number for
+		 * this one.
 		 */
-		handle_file(path, NULL, rerere_path(id, "preimage"));
-		if (id->collection->status[variant] & RR_HAS_POSTIMAGE) {
-			const char *path = rerere_path(id, "postimage");
-			if (unlink(path))
-				die_errno("cannot unlink stray '%s'", path);
-			id->collection->status[variant] &= ~RR_HAS_PREIMAGE;
-		}
-		id->collection->status[variant] |= RR_HAS_PREIMAGE;
-		fprintf(stderr, "Recorded preimage for '%s'\n", path);
-		return;
-	} else if (has_rerere_resolution(id)) {
-		/* Is there a recorded resolution we could attempt to apply? */
-		if (merge(id, path))
-			return; /* failed to replay */
+	}
+
+	/* Does any existing resolution apply cleanly? */
+	for (variant = 0; variant < rr_dir->status_nr; variant++) {
+		const int both = RR_HAS_PREIMAGE | RR_HAS_POSTIMAGE;
+		struct rerere_id vid = *id;
+
+		if ((rr_dir->status[variant] & both) != both)
+			continue;
+
+		vid.variant = variant;
+		if (merge(&vid, path))
+			continue; /* failed to replay */
+
+		if (0 <= id->variant && id->variant != variant)
+			remove_variant(id);
 
 		if (rerere_autoupdate)
 			string_list_insert(update, path);
@@ -863,16 +873,24 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 			fprintf(stderr,
 				"Resolved '%s' using previous resolution.\n",
 				path);
-	} else if (!handle_file(path, NULL, NULL)) {
-		/* The user has resolved it. */
-		copy_file(rerere_path(id, "postimage"), path, 0666);
-		id->collection->status[variant] |= RR_HAS_POSTIMAGE;
-		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
-	} else {
+		free_rerere_id(rr_item);
+		rr_item->util = NULL;
 		return;
 	}
-	free_rerere_id(rr_item);
-	rr_item->util = NULL;
+
+	/* None of the existing one applies; we need a new variant */
+	assign_variant(id);
+
+	variant = id->variant;
+	handle_file(path, NULL, rerere_path(id, "preimage"));
+	if (id->collection->status[variant] & RR_HAS_POSTIMAGE) {
+		const char *path = rerere_path(id, "postimage");
+		if (unlink(path))
+			die_errno("cannot unlink stray '%s'", path);
+		id->collection->status[variant] &= ~RR_HAS_PREIMAGE;
+	}
+	id->collection->status[variant] |= RR_HAS_PREIMAGE;
+	fprintf(stderr, "Recorded preimage for '%s'\n", path);
 }
 
 static int do_plain_rerere(struct string_list *rr, int fd)
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 8d52854..5649829 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -413,7 +413,7 @@ concat_insert () {
 	cat early && printf "%s\n" "$@" && cat late "$last"
 }
 
-test_expect_failure 'multiple identical conflicts' '
+test_expect_success 'multiple identical conflicts' '
 	git reset --hard &&
 
 	test_seq 1 6 >early &&
-- 
2.6.0-rc2-164-gdcd5d00
