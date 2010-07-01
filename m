From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v5 3/4] Try normalizing files to avoid delete/modify conflicts when merging
Date: Thu,  1 Jul 2010 11:09:51 +0200
Message-ID: <1081907f5a1044050c912e742b8500785dcc6b48.1277974452.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 11:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUFmx-0007IR-3G
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab0GAJKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 05:10:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41516 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497Ab0GAJKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 05:10:08 -0400
Received: by bwz1 with SMTP id 1so797034bwz.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vF15QDyW2QG+w+a6VlACfRlismWm3aqrfIgXxDLQ6dA=;
        b=sq3QVZrXelkABILVH4q/1w/SouXImjceYzdFhbwrIqR2qMD2Vg4B2fXgWgiTdpiCz0
         hVpEOn/YzkVRyepZ6xxTIcfLLm8VEU0pPff/UEMfxUsgirM9irs2LGxFRVSjbqelpl9X
         2uTFg48qiACZ8nZowuYSAewrhR2rH0XD42fXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bqKYEx+LzlM+rYv17muNMtmnGDpvW3QW2d+PIHJcY9GDA6tSSAGIur+rOuJzhx3hOa
         Qd5oHVNhhDfU+95uFqpe29HkQYwuDw4Ys4XEd+laSKhGKwrRFtt1Xn/db9/kGjgTujP1
         WQFXOf4K/LI4U/XkVFggTwCbs6XShultGrnpE=
Received: by 10.204.83.101 with SMTP id e37mr6844691bkl.48.1277975406571;
        Thu, 01 Jul 2010 02:10:06 -0700 (PDT)
Received: from localhost.localdomain ([62.113.137.5])
        by mx.google.com with ESMTPS id bi18sm11444654bkb.21.2010.07.01.02.10.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 02:10:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.4.g09d06
In-Reply-To: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150017>

If a file is modified due to normalization on one branch, and deleted on
another, a merge of the two branches will result in a delete/modify
conflict for that file even if it is otherwise unchanged.

Try to avoid the conflict by normalizing and comparing the "base" file
and the modified file when their sha1s differ.  If they compare equal,
the file is considered unmodified and is deleted.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c          |   51 ++++++++++++++++++++++++++++++++++++++++++-
 t/t6038-merge-text-auto.sh |    2 +-
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 856e98c..4a84efe 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1056,6 +1056,53 @@ static unsigned char *stage_sha(const unsigned char *sha, unsigned mode)
 	return (is_null_sha1(sha) || mode == 0) ? NULL: (unsigned char *)sha;
 }
 
+static int read_sha1_strbuf(const unsigned char *sha1, struct strbuf *dst)
+{
+	void *buf;
+	enum object_type type;
+	unsigned long size;
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("cannot read object %s", sha1_to_hex(sha1));
+	if (type != OBJ_BLOB) {
+		free(buf);
+		return error("object %s is not a blob", sha1_to_hex(sha1));
+	}
+	strbuf_attach(dst, buf, size, size + 1);
+	return 0;
+}
+
+static int blob_unchanged(const unsigned char *o_sha,
+			  const unsigned char *a_sha,
+			  const char *path)
+{
+	struct strbuf o = STRBUF_INIT;
+	struct strbuf a = STRBUF_INIT;
+	int ret = 0; /* assume changed for safety */
+
+	if (sha_eq(o_sha, a_sha))
+		return 1;
+	if (!core_merge_prefilter)
+		return 0;
+
+	assert(o_sha && a_sha);
+	if (read_sha1_strbuf(o_sha, &o) || read_sha1_strbuf(a_sha, &a))
+		goto error_return;
+	/*
+	 * Note: binary | is used so that both renormalizations are
+	 * performed.  Comparison can be skipped if both files are
+	 * unchanged since their sha1s have already been compared.
+	 */
+	if (renormalize_buffer(path, o.buf, o.len, &o) |
+	    renormalize_buffer(path, a.buf, o.len, &a))
+		ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));
+
+error_return:
+	strbuf_release(&o);
+	strbuf_release(&a);
+	return ret;
+}
+
 /* Per entry merge function */
 static int process_entry(struct merge_options *o,
 			 const char *path, struct stage_data *entry)
@@ -1075,8 +1122,8 @@ static int process_entry(struct merge_options *o,
 	if (o_sha && (!a_sha || !b_sha)) {
 		/* Case A: Deleted in one */
 		if ((!a_sha && !b_sha) ||
-		    (sha_eq(a_sha, o_sha) && !b_sha) ||
-		    (!a_sha && sha_eq(b_sha, o_sha))) {
+		    (!b_sha && blob_unchanged(o_sha, a_sha, path)) ||
+		    (!a_sha && blob_unchanged(o_sha, b_sha, path))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 1f2b3a8..1307ec0 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -46,7 +46,7 @@ test_expect_success 'Check merging addition of text=auto' '
 	test_cmp file file.temp
 '
 
-test_expect_failure 'Test delete/normalize conflict' '
+test_expect_success 'Test delete/normalize conflict' '
 	git checkout side &&
 	git reset --hard initial &&
 	git rm file &&
-- 
1.7.2.rc1.4.g09d06
