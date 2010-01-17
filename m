From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/8] merge-tree: use ll_merge() not xdl_merge()
Date: Sun, 17 Jan 2010 01:39:00 -0800
Message-ID: <1263721144-18605-5-git-send-email-gitster@pobox.com>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 10:39:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWRbu-0003v2-E6
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab0AQJj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651Ab0AQJjV
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:39:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab0AQJjR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:39:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 444419140A;
	Sun, 17 Jan 2010 04:39:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yTdE
	3sgVxAXHELJKWfZFeMSUyQE=; b=W2xHs+mfRQ8na0M8iVfVOGj1Ti7JSmAoVA1m
	ImmzJ5gN8xyWUl89MBqRzafqOSmENmlqWovIKVgAZhYgAvTV31h8u7u0vPTHTpVt
	Df6Ym3MF+6+CQkORnsEw1XV2qld/P+Q1xGpu8EI/hO5HmcB4hvKGQ4QbXrW5QyfG
	VZpmfIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	DHKpP9EMjVw9yROMnc0A64WM+0DlEozmuVTD7HUZkh1impGbkHqIuPQsrqRmlL0a
	qwBt6RKUsUmjEbAdv8o4EDpHQdDRI54PVA7HvlxUVdkwcUvcHnpI6W2vmmDrMebK
	5Df+EuqqdfnX/V+6WGN5rL3GLz9ycFGStdXhsvduDuE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3027C91409;
	Sun, 17 Jan 2010 04:39:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F18B91408; Sun, 17 Jan
 2010 04:39:13 -0500 (EST)
X-Mailer: git-send-email 1.6.6.405.g80ed6.dirty
In-Reply-To: <1263721144-18605-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2CFE7476-034C-11DF-B287-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137287>

ll_merge() interface was designed to merge contents under git control
while taking per-path attributes into account.  Update the three-way
merge implementation used by merge-tree to use it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-file.c |   16 +++++++---------
 merge-tree.c |    4 ++--
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/merge-file.c b/merge-file.c
index 5c00c7e..fd34d76 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "xdiff-interface.h"
+#include "ll-merge.h"
 #include "blob.h"
 
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
@@ -24,16 +25,13 @@ static void free_mmfile(mmfile_t *f)
 	free(f->ptr);
 }
 
-static void *three_way_filemerge(mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
+static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
 {
-	mmbuffer_t res;
-	xmparam_t xmp;
 	int merge_status;
+	mmbuffer_t res;
 
-	memset(&xmp, 0, sizeof(xmp));
-	merge_status = xdl_merge(base, our, ".our", their, ".their",
-		&xmp, XDL_MERGE_ZEALOUS, &res);
-
+	merge_status = ll_merge(&res, path, base,
+				our, ".our", their, ".their", 0);
 	if (merge_status < 0)
 		return NULL;
 
@@ -75,7 +73,7 @@ static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
 	return xdi_diff(f1, f2, &xpp, &xecfg, &ecb);
 }
 
-void *merge_file(struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
+void *merge_file(const char *path, struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
 {
 	void *res = NULL;
 	mmfile_t f1, f2, common;
@@ -108,7 +106,7 @@ void *merge_file(struct blob *base, struct blob *our, struct blob *their, unsign
 		if (generate_common_file(&common, &f1, &f2) < 0)
 			goto out_free_f2_f1;
 	}
-	res = three_way_filemerge(&common, &f1, &f2, size);
+	res = three_way_filemerge(path, &common, &f1, &f2, size);
 	free_mmfile(&common);
 out_free_f2_f1:
 	free_mmfile(&f2);
diff --git a/merge-tree.c b/merge-tree.c
index f01e7c8..37b94d9 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -54,7 +54,7 @@ static const char *explanation(struct merge_list *entry)
 	return "removed in remote";
 }
 
-extern void *merge_file(struct blob *, struct blob *, struct blob *, unsigned long *);
+extern void *merge_file(const char *, struct blob *, struct blob *, struct blob *, unsigned long *);
 
 static void *result(struct merge_list *entry, unsigned long *size)
 {
@@ -76,7 +76,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	their = NULL;
 	if (entry)
 		their = entry->blob;
-	return merge_file(base, our, their, size);
+	return merge_file(entry->path, base, our, their, size);
 }
 
 static void *origin(struct merge_list *entry, unsigned long *size)
-- 
1.6.6.405.g80ed6.dirty
