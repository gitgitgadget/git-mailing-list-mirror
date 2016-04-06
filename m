From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/11] rerere: adjust 'forget' to multi-variant world order
Date: Wed,  6 Apr 2016 16:05:35 -0700
Message-ID: <1459983935-25267-12-git-send-email-gitster@pobox.com>
References: <1459204942-26601-1-git-send-email-gitster@pobox.com>
 <1459983935-25267-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 01:06:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anwWS-0008RF-Mo
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 01:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbcDFXGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 19:06:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754467AbcDFXF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 19:05:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76C9353749;
	Wed,  6 Apr 2016 19:05:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2zl/
	wOIpHK3dGDFpo3giAmmc2i8=; b=tgG9tTIpb3j9QXy+B7Yca+avxuIE5alPx80m
	53hcdzxb1lm3XZK+TS9oLIUUBoGfYtgmbwc/R71KaQFB9ULjtAQqN8JyFvCgCYiL
	hXhO8spuPBU1JVURDJ3wCMk1TAJSPegscVsVyum4jaYhfLwYv00nKbxOBGdXNWt4
	zGl1eAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LJckuu
	LtNqRLAVAQZvUKJ3nawdr4ZWcbVj+ffxM2PT1e8Ik5iTXxM7lSV7oyrqfK8dOVts
	nEJ0AJU40gj+nBj2xbmfuO4bvUUMamToEdGvPpOyJYNRpdJf960BjgBhR06UPKZc
	HkhhIqpijvhcgH7JXk8fCFl6BM4fVl3euAI7E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6DC3D53748;
	Wed,  6 Apr 2016 19:05:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DCF6153747;
	Wed,  6 Apr 2016 19:05:55 -0400 (EDT)
X-Mailer: git-send-email 2.3.8-32-g0ce02b3
In-Reply-To: <1459983935-25267-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1E354F00-FC4C-11E5-8CD0-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290895>

Because conflicts with the same contents inside conflict blocks
enclosed by "<<<<<<<" and ">>>>>>>" can now have multiple variants
to help three-way merge to adjust to the differences outside the
conflict blocks, "rerere forget $path" needs to be taught that there
may be multiple recorded resolutions that share the same conflict
hash (which groups the conflicts with "the same contents inside
conflict blocks"), among which there are some that would not be
relevant to the conflict we are looking at.  These "other variants"
that happen to share the same conflict hash should not be cleared,
and the variant that would apply to the current conflict may not be
the zero-th one (which is the only one that is cleared by the
current code).

After finding the conflict hash, iterate over the existing variants
and try to resolve the conflict using each of them to find the one
that "cleanly" resolves the current conflict.  That is the one we
want to forget and record the preimage for, so that the user can
record the corrected resolution.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c          | 28 +++++++++++++++++++++++++++-
 t/t4200-rerere.sh | 10 ++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index e636d4b..1693866 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1038,7 +1038,33 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 
 	/* Nuke the recorded resolution for the conflict */
 	id = new_rerere_id(sha1);
-	id->variant = 0; /* for now */
+
+	for (id->variant = 0;
+	     id->variant < id->collection->status_nr;
+	     id->variant++) {
+		mmfile_t cur = { NULL, 0 };
+		mmbuffer_t result = {NULL, 0};
+		int cleanly_resolved;
+
+		if (!has_rerere_resolution(id))
+			continue;
+
+		handle_cache(path, sha1, rerere_path(id, "thisimage"));
+		if (read_mmfile(&cur, rerere_path(id, "thisimage"))) {
+			free(cur.ptr);
+			return error("Failed to update conflicted state in '%s'",
+				     path);
+		}
+		cleanly_resolved = !try_merge(id, path, &cur, &result);
+		free(result.ptr);
+		free(cur.ptr);
+		if (cleanly_resolved)
+			break;
+	}
+
+	if (id->collection->status_nr <= id->variant)
+		return error("no remembered resolution for '%s'", path);
+
 	filename = rerere_path(id, "postimage");
 	if (unlink(filename))
 		return (errno == ENOENT
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index a85fc7d..1a080e7 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -536,6 +536,16 @@ test_expect_success 'multiple identical conflicts' '
 	test_cmp file1.expect file1 &&
 	test_cmp file2.expect file2 &&
 
+	# Forget resolution for file2
+	git rerere forget file2 &&
+	echo file2 >expect &&
+	git rerere status >actual &&
+	test_cmp expect actual &&
+	count_pre_post 2 1 &&
+
+	# file2 already has correct resolution, so record it again
+	git rerere &&
+
 	# Pretend that the resolutions are old again
 	find .git/rr-cache/ -type f | xargs test-chmtime -172800 &&
 
-- 
2.8.1-273-ga2cd0f9
