From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/11] rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
Date: Wed,  6 Apr 2016 16:05:26 -0700
Message-ID: <1459983935-25267-3-git-send-email-gitster@pobox.com>
References: <1459204942-26601-1-git-send-email-gitster@pobox.com>
 <1459983935-25267-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 01:05:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anwWF-0008M9-2M
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 01:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbcDFXFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 19:05:42 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752574AbcDFXFl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 19:05:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B56253717;
	Wed,  6 Apr 2016 19:05:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4ktm
	xtuOn1QGzqHeN6DkT1RLfjE=; b=kNDtbNilEbZftft89TPdw44cvu4eCWog3DJ0
	btvFCmYR1J3/v3gi1pOCNw77tQk6KGhrdws8MNAS2FWG0NZONBvlha2IaN4zFJjB
	Yexhjfy5ENZQxUqnIMnYB3Dib+5scuiN6KwA5eBbOj4da+S2w+hytyTJDFgmurdq
	yWwQ43M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hclxGp
	TfNRoUz0PRLOi63BvV2itn/3CfD4lavgdptDfrtzWN0f8bWOnNmzu80bEtO1il7W
	s04hR/xnKklVs0VmsHinPXstAdT3YQ2nNb5bfYbgrrro/iAyW7WNgjSNgV50/i48
	KL8dVm5Xf+F10ZkFooVK5KUIyEqncD3OTvJd4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9352853716;
	Wed,  6 Apr 2016 19:05:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1C14253715;
	Wed,  6 Apr 2016 19:05:40 -0400 (EDT)
X-Mailer: git-send-email 2.3.8-32-g0ce02b3
In-Reply-To: <1459983935-25267-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 14CB6CCE-FC4C-11E5-9B25-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290889>

This will help fixing bootstrap corner-case issues, e.g. having an
empty $GIT_DIR/rr-cache/$ID directory would fail to record a
preimage, in later changes in this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/rerere.c b/rerere.c
index a5d8a06..fbdade8 100644
--- a/rerere.c
+++ b/rerere.c
@@ -26,8 +26,11 @@ static char *merge_rr_path;
 static int rerere_dir_nr;
 static int rerere_dir_alloc;
 
+#define RR_HAS_POSTIMAGE 1
+#define RR_HAS_PREIMAGE 2
 static struct rerere_dir {
 	unsigned char sha1[20];
+	unsigned char status;
 } **rerere_dir;
 
 static void free_rerere_dirs(void)
@@ -58,6 +61,27 @@ const char *rerere_path(const struct rerere_id *id, const char *file)
 	return git_path("rr-cache/%s/%s", rerere_id_hex(id), file);
 }
 
+static int is_rr_file(const char *name, const char *filename)
+{
+	return !strcmp(name, filename);
+}
+
+static void scan_rerere_dir(struct rerere_dir *rr_dir)
+{
+	struct dirent *de;
+	DIR *dir = opendir(git_path("rr-cache/%s", sha1_to_hex(rr_dir->sha1)));
+
+	if (!dir)
+		return;
+	while ((de = readdir(dir)) != NULL) {
+		if (is_rr_file(de->d_name, "postimage"))
+			rr_dir->status |= RR_HAS_POSTIMAGE;
+		else if (is_rr_file(de->d_name, "preimage"))
+			rr_dir->status |= RR_HAS_PREIMAGE;
+	}
+	closedir(dir);
+}
+
 static const unsigned char *rerere_dir_sha1(size_t i, void *table)
 {
 	struct rerere_dir **rr_dir = table;
@@ -76,6 +100,7 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 	if (pos < 0) {
 		rr_dir = xmalloc(sizeof(*rr_dir));
 		hashcpy(rr_dir->sha1, sha1);
+		rr_dir->status = 0;
 		pos = -1 - pos;
 
 		/* Make sure the array is big enough ... */
@@ -85,15 +110,14 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 		memmove(rerere_dir + pos + 1, rerere_dir + pos,
 			(rerere_dir_nr - pos - 1) * sizeof(*rerere_dir));
 		rerere_dir[pos] = rr_dir;
+		scan_rerere_dir(rr_dir);
 	}
 	return rerere_dir[pos];
 }
 
 static int has_rerere_resolution(const struct rerere_id *id)
 {
-	struct stat st;
-
-	return !stat(rerere_path(id, "postimage"), &st);
+	return (id->collection->status & RR_HAS_POSTIMAGE);
 }
 
 static struct rerere_id *new_rerere_id_hex(char *hex)
@@ -737,6 +761,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 	} else if (!handle_file(path, NULL, NULL)) {
 		/* The user has resolved it. */
 		copy_file(rerere_path(id, "postimage"), path, 0666);
+		id->collection->status |= RR_HAS_POSTIMAGE;
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
 	} else {
 		return;
@@ -797,6 +822,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		 * normalized contents to the "preimage" file.
 		 */
 		handle_file(path, NULL, rerere_path(id, "preimage"));
+		id->collection->status |= RR_HAS_PREIMAGE;
 		fprintf(stderr, "Recorded preimage for '%s'\n", path);
 	}
 
-- 
2.8.1-273-ga2cd0f9
