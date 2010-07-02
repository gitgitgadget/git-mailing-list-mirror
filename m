From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v6 2/3] Try normalizing files to avoid delete/modify conflicts when merging
Date: Fri,  2 Jul 2010 21:20:48 +0200
Message-ID: <0652be563a15e811d053d59532eff62ca5684203.1278093311.git.eyvind.bernhardsen@gmail.com>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:21:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlnn-0007HA-Jz
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759832Ab0GBTVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:21:11 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48947 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757353Ab0GBTVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:21:05 -0400
Received: by ewy23 with SMTP id 23so1135732ewy.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5VFHKULCQ8zC5l2aktTaqlvlbCNQwE0FOJQe7+oIr3I=;
        b=X/oqaaDah823QDClFrKgt/+s7pEEqgiep+HXZezh9lpL4XG9yZpo+cYtCT/qDuu1I7
         w2LzbDV6CvIFn/xXteNr0P338a4LJfwWibRQP9iZH4oNVJPNXkEkj/mkGlsoOX4/WdMv
         K9HdpPswsotozYuTBUuvmhXRjTONRmlwRvNXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LNUuK1rXCBqf+yMTnzFJ/nz3XNsJ5F/T6AZhHUYlYePFP66KPEqxxw7BlfQSxjpno/
         495a/6ZG+LTIGYEEEj9XIo9IsHDk1NKjY4LfJtaZ1jCI+Mtyxlr6t0NnHPOS0MP6i20U
         PHKdfV6UE46kfO1L8LSOTHLcUVOiZpIuxinMs=
Received: by 10.213.20.80 with SMTP id e16mr4312857ebb.45.1278098462710;
        Fri, 02 Jul 2010 12:21:02 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id v8sm8093578eeh.14.2010.07.02.12.21.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 12:21:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
In-Reply-To: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150153>

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
index 856e98c..593c0b1 100644
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
+	if (!merge_renormalize)
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
index 127baf8..d1ab86e 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -51,7 +51,7 @@ test_expect_success 'Check merging addition of text=auto' '
 	test_cmp file file.temp
 '
 
-test_expect_failure 'Test delete/normalize conflict' '
+test_expect_success 'Test delete/normalize conflict' '
 	git checkout side &&
 	git reset --hard initial &&
 	git rm file &&
-- 
1.7.1.575.g383de
