From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/19] apply: --3way with add/add conflict
Date: Wed, 13 Jun 2012 12:32:56 -0700
Message-ID: <1339615980-19727-16-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:34:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetKH-00010Q-8r
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab2FMTdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32858 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590Ab2FMTdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CA5C873A
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Kv88
	js7TQLhASpuDi+HqIoZsD7I=; b=ZPOA9TqlfFVf56ADv6hvYYV6NdSeaEEIJGBS
	YQlaNMMdEs39hlTwY/WeFCQyCl0iR2AoDanK47CErbrTQVxYuODY931QrmAqEQtc
	HN+d/pcIWpW0SsMo+9OBLBhbSUoinyIdt/OT5eqVgbzAvUbjI/I5WClkxrpG6Zp6
	N8Lqdzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UzMOYb
	ZayNRktjz7v4k9JdVqE14/FBdqGduzWbyxVKchQ3Rii8oXSsmLMqqg7jzycWwcHO
	VGrYPkzE09eAtPrFrmh85utRrAGykTGWAi7nCdEcSERKvGoiUVH50oG963VdI/sl
	OJpLNZUzbFC6REEGme3EQ7YAhWLn/4pU/c/LA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63FB68738
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE7C48737 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A80D4C86-B58E-11E1-B117-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199933>

When a patch wants to create a path, but we already have it in our
current state, pretend as if the patch and we independently added
the same path and cause add/add conflict, so that the user can
resolve it just like "git merge" in the same situation.

For that purpose, implement load_current() in terms of the
load_patch_target() helper introduced earlier to read the current
contents from the path given by patch->new_name (patch->old_name is
NULL for a creation patch).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8bc4218..c3b9f76 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -197,6 +197,7 @@ struct patch {
 	unsigned int is_rename:1;
 	unsigned int recount:1;
 	unsigned int conflicted_threeway:1;
+	unsigned int direct_to_threeway:1;
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
@@ -3187,6 +3188,48 @@ static int three_way_merge(struct image *image,
 	return status;
 }
 
+/*
+ * When directly falling back to add/add three-way merge, we read from
+ * the current contents of the new_name.  In no cases other than that
+ * this function will be called.
+ */
+static int load_current(struct image *image, struct patch *patch)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int status, pos;
+	size_t len;
+	char *img;
+	struct stat st;
+	struct cache_entry *ce;
+	char *name = patch->new_name;
+	unsigned mode = patch->new_mode;
+
+	if (!patch->is_new)
+		die("BUG: patch to %s is not a creation", patch->old_name);
+
+	pos = cache_name_pos(name, strlen(name));
+	if (pos < 0)
+		return error(_("%s: does not exist in index"), name);
+	ce = active_cache[pos];
+	if (lstat(name, &st)) {
+		if (errno != ENOENT)
+			return error(_("%s: %s"), name, strerror(errno));
+		if (checkout_target(ce, &st))
+			return -1;
+	}
+	if (verify_index_match(ce, &st))
+		return error(_("%s: does not match index"), name);
+
+	status = load_patch_target(&buf, ce, &st, name, mode);
+	if (status < 0)
+		return status;
+	else if (status)
+		return -1;
+	img = strbuf_detach(&buf, &len);
+	prepare_image(image, img, len, !patch->is_binary);
+	return 0;
+}
+
 static int try_threeway(struct image *image, struct patch *patch,
 			struct stat *st, struct cache_entry *ce)
 {
@@ -3198,13 +3241,15 @@ static int try_threeway(struct image *image, struct patch *patch,
 	struct image tmp_image;
 
 	/* No point falling back to 3-way merge in these cases */
-	if (patch->is_new || patch->is_delete ||
+	if (patch->is_delete ||
 	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
 		return -1;
 
 	/* Preimage the patch was prepared for */
-	if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
-	    read_blob_object(&buf, pre_sha1, patch->old_mode))
+	if (patch->is_new)
+		write_sha1_file("", 0, blob_type, pre_sha1);
+	else if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
+		 read_blob_object(&buf, pre_sha1, patch->old_mode))
 		return error("repository lacks the necessary blob to fall back on 3-way merge.");
 
 	fprintf(stderr, "Falling back to three-way merge...\n");
@@ -3221,9 +3266,15 @@ static int try_threeway(struct image *image, struct patch *patch,
 	clear_image(&tmp_image);
 
 	/* our_sha1[] is ours */
-	if (load_preimage(&tmp_image, patch, st, ce))
-		return error("cannot read the current contents of '%s'",
-			     patch->old_name);
+	if (patch->is_new) {
+		if (load_current(&tmp_image, patch))
+			return error("cannot read the current contents of '%s'",
+				     patch->new_name);
+	} else {
+		if (load_preimage(&tmp_image, patch, st, ce))
+			return error("cannot read the current contents of '%s'",
+				     patch->old_name);
+	}
 	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, our_sha1);
 	clear_image(&tmp_image);
 
@@ -3254,7 +3305,8 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	if (load_preimage(&image, patch, st, ce) < 0)
 		return -1;
 
-	if (apply_fragments(&image, patch) < 0) {
+	if (patch->direct_to_threeway ||
+	    apply_fragments(&image, patch) < 0) {
 		/* Note: with --reject, apply_fragments() returns 0 */
 		if (!threeway || try_threeway(&image, patch, st, ce) < 0)
 			return -1;
@@ -3425,7 +3477,9 @@ static int check_patch(struct patch *patch)
 	    ((0 < patch->is_new) | (0 < patch->is_rename) | patch->is_copy)) {
 		int err = check_to_create(new_name, ok_if_exists);
 
-		switch (err) {
+		if (err && threeway) {
+			patch->direct_to_threeway = 1;
+		} else switch (err) {
 		case 0:
 			break; /* happy */
 		case EXISTS_IN_INDEX:
-- 
1.7.11.rc3.30.g3bdace2
