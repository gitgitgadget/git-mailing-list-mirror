From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/11] rerere: do use multiple variants
Date: Wed,  6 Apr 2016 16:05:31 -0700
Message-ID: <1459983935-25267-8-git-send-email-gitster@pobox.com>
References: <1459204942-26601-1-git-send-email-gitster@pobox.com>
 <1459983935-25267-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 01:06:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anwWQ-0008RF-Fx
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 01:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbcDFXFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 19:05:53 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754364AbcDFXFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 19:05:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80FC553735;
	Wed,  6 Apr 2016 19:05:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kvdE
	efQbmEagmUlFqRLsVCrywHE=; b=iMqXm2FYwG5aP8wUX3Xy3s1dmKf8ZIbqpILk
	EZpwLmlXYrky7EdNPyHAe1cuDE7UhCWijoH38ygbDgwRC4XQJQwstCpyNEN2BFaQ
	d1VjGKy2OqibQ2hR4JQnh0oY/phOMCeOM/m4NFOaFbLdbjFhDbnHRzSiAZ8kWUu2
	315ZmmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=unPAM9
	lY56X9B677i67i+7hko/Xl8fm98wyQ8RDz6VXjTfnKmDQUQtgFaDpgLH1Im5CnNC
	i0TV6m+ASc+bEl3P27yTRB3aDaa+bjVmyZ5T8VBNV/l+Jeo8R3d9CRpI/Z1V8KJd
	zLa/fwsx7JkSIhti9CUAqhtzXb5Z1VmM+mYzQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 628C853734;
	Wed,  6 Apr 2016 19:05:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BE57D53733;
	Wed,  6 Apr 2016 19:05:48 -0400 (EDT)
X-Mailer: git-send-email 2.3.8-32-g0ce02b3
In-Reply-To: <1459983935-25267-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 19F5DA40-FC4C-11E5-96C0-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290896>

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
 rerere.c          | 98 ++++++++++++++++++++++++++++++++++---------------------
 t/t4200-rerere.sh |  2 +-
 2 files changed, 61 insertions(+), 39 deletions(-)

diff --git a/rerere.c b/rerere.c
index 0cf857b..353227c 100644
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
@@ -830,32 +830,46 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
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
-			id->collection->status[variant] &= ~RR_HAS_POSTIMAGE;
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
+		/*
+		 * If there already is a different variant that applies
+		 * cleanly, there is no point maintaining our own variant.
+		 */
+		if (0 <= id->variant && id->variant != variant)
+			remove_variant(id);
 
 		if (rerere_autoupdate)
 			string_list_insert(update, path);
@@ -863,16 +877,24 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
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
+		id->collection->status[variant] &= ~RR_HAS_POSTIMAGE;
+	}
+	id->collection->status[variant] |= RR_HAS_PREIMAGE;
+	fprintf(stderr, "Recorded preimage for '%s'\n", path);
 }
 
 static int do_plain_rerere(struct string_list *rr, int fd)
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 6fcc6d4..b1bda20 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -412,7 +412,7 @@ concat_insert () {
 	cat early && printf "%s\n" "$@" && cat late "$last"
 }
 
-test_expect_failure 'multiple identical conflicts' '
+test_expect_success 'multiple identical conflicts' '
 	git reset --hard &&
 
 	test_seq 1 6 >early &&
-- 
2.8.1-273-ga2cd0f9
