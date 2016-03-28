From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/11] rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
Date: Mon, 28 Mar 2016 15:42:13 -0700
Message-ID: <1459204942-26601-3-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
 <1459204942-26601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 00:42:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akfrr-0005Di-AD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495AbcC1Wmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 18:42:35 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754385AbcC1Wm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:42:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5D1A4FF9D;
	Mon, 28 Mar 2016 18:42:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=R5Bi
	VXYhoIR+hboyRyIkmZbvpxQ=; b=VMCFV/Rp5xjmKQlvatXt0un+KOXE/rDXWWVH
	3eQzyYGGNm3VRJ7U9On/loOu7gT4PVfL2SMcY3ZWYPJa/Cm0IRPmzjguIw1V3JId
	iYK6UgE5mfIhNsrif9+m0vawf1ddSfGiwk3Yyr79IT4rr8mSeLJ20NoR6bBh1F1f
	ilbPCC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=aboGD0
	I3N1EEySyTAuo8ghgHcUOlLm5V2Feh4wDtUW9SER+gBU3Qe5it3IP8F6PH2jX9/q
	cDLmGEw5tdVkS2WgNryiEF0GWwjokP7XIeR3HHs4kIWnOqUdWp3BfG9egeTINk2l
	IeACoSRlegq4T8l95/F314nUzKPYc4goAnY+A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D5BD4FF9C;
	Mon, 28 Mar 2016 18:42:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1BA764FF9B;
	Mon, 28 Mar 2016 18:42:27 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-g046a488
In-Reply-To: <1459204942-26601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 58C8EE1E-F536-11E5-9211-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290069>

This will help fixing bootstrap corner-case issues, e.g. having an
empty $GIT_DIR/rr-cache/$ID directory would fail to record a
preimage, in later changes in this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Unchanged.

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
2.8.0-215-g046a488
