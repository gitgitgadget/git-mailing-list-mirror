From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v4 2/3] Try normalizing files to avoid delete/modify conflicts when merging
Date: Sun, 27 Jun 2010 21:43:06 +0200
Message-ID: <0497dd2d68e65e9d2ec1d40f82231557ff95c04c.1277667177.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 21:43:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSxlM-00061C-7A
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 21:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625Ab0F0TnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 15:43:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab0F0TnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 15:43:16 -0400
Received: by wyb38 with SMTP id 38so1306862wyb.19
        for <git@vger.kernel.org>; Sun, 27 Jun 2010 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=CKgDeeduPYM6sMMQlF5A9rAdEW+cQK44yfl3Qbzbdr4=;
        b=hbnegjAO6VrCoUymVgdKkejXP6DIJ0d8fAZV9+OAvEZizq6Nk9NACjvmpb6ho0hebg
         E7d+08GviyxG6nYU9IHLAvX9ey9+OIj2wTrxkQkwg2fkC9dm37YbHgvf31hOdja++rxK
         eFsAOTlSzbz8AY3n9UKF/rHkaVSYQiZt/iG2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T3UP1WDU/2gpLFHNGh+yppunBXGR3Y7+fuEaGtvAllcggW4cRCgKHDHmezFgR+e6vI
         CzeLzqFbFfRtc0hJGa6JHZDyXmYtfoezr5g0iPCDO5pbvnnjpQE1x3TtrnGRvb0uV0Ss
         AseItH9QDqMCfVYCoCqgeYAaysElBWybvuM7M=
Received: by 10.216.160.145 with SMTP id u17mr7350287wek.18.1277667794660;
        Sun, 27 Jun 2010 12:43:14 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id y39sm4411401weq.3.2010.06.27.12.43.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Jun 2010 12:43:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
In-Reply-To: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
In-Reply-To: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149804>

If a file is modified due to normalization on one branch, and deleted on
another, a merge of the two branches will result in a delete/modify
conflict for that file even if it is otherwise unchanged.

Try to avoid the conflict by normalizing and comparing the "base" file
and the modified file when their sha1s differ.  If they compare equal,
the file is considered unmodified and is deleted.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 merge-recursive.c          |   44 ++++++++++++++++++++++++++++++++++++++++++--
 t/t6038-merge-text-auto.sh |    2 +-
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 206c103..f4f09a2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1056,6 +1056,44 @@ static unsigned char *stage_sha(const unsigned char *sha, unsigned mode)
 	return (is_null_sha1(sha) || mode == 0) ? NULL: (unsigned char *)sha;
 }
 
+static int read_sha1_strbuf(const unsigned char *sha, const char *path,
+			    struct strbuf *dst)
+{
+	void *buf;
+	enum object_type type;
+	unsigned long size;
+	buf = read_sha1_file(sha, &type, &size);
+	if (!buf)
+		return 0;
+	if (type != OBJ_BLOB) {
+		free(buf);
+		return 0;
+	}
+	strbuf_attach(dst, buf, size, size + 1);
+	return 1;
+}
+
+static int normalized_eq(const unsigned char *a_sha,
+			 const unsigned char *b_sha,
+			 const char *path)
+{
+	struct strbuf a = STRBUF_INIT;
+	struct strbuf b = STRBUF_INIT;
+	int ret = 0;
+	if (a_sha && b_sha &&
+	    read_sha1_strbuf(a_sha, path, &a) &&
+	    read_sha1_strbuf(b_sha, path, &b)) {
+		/* Both files must be normalized, so we can't use || */
+		if ((renormalize_buffer(path, a.buf, a.len, &a) |
+		     renormalize_buffer(path, b.buf, b.len, &b)) &&
+		    (a.len == b.len))
+			ret = memcmp(a.buf, b.buf, a.len) == 0;
+	}
+	strbuf_release(&a);
+	strbuf_release(&b);
+	return ret;
+}
+
 /* Per entry merge function */
 static int process_entry(struct merge_options *o,
 			 const char *path, struct stage_data *entry)
@@ -1075,8 +1113,10 @@ static int process_entry(struct merge_options *o,
 	if (o_sha && (!a_sha || !b_sha)) {
 		/* Case A: Deleted in one */
 		if ((!a_sha && !b_sha) ||
-		    (sha_eq(a_sha, o_sha) && !b_sha) ||
-		    (!a_sha && sha_eq(b_sha, o_sha))) {
+		    (!b_sha && sha_eq(a_sha, o_sha) ||
+		     normalized_eq(a_sha, o_sha, path)) ||
+		    (!a_sha && sha_eq(b_sha, o_sha) ||
+		     normalized_eq(b_sha, o_sha, path))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 44e6003..5e45256 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -45,7 +45,7 @@ test_expect_success 'Check merging addition of text=auto' '
 	test_cmp file file.temp
 '
 
-test_expect_failure 'Test delete/normalize conflict' '
+test_expect_success 'Test delete/normalize conflict' '
 	git checkout side &&
 	git reset --hard initial &&
 	git rm file &&
-- 
1.7.1.575.g383de
