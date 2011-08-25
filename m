From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH] vcs-svn: fix broken test 'keep content, but change mode'
Date: Thu, 25 Aug 2011 22:02:04 +0600
Message-ID: <1314288124-16969-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 17:59:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwcLG-0008IG-RH
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 17:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248Ab1HYP7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 11:59:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39472 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab1HYP7h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 11:59:37 -0400
Received: by bke11 with SMTP id 11so1844776bke.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Buueh9PZUqO6UTI3S5R3EbzYtY1bI3CcxBgFFqpfuvU=;
        b=Reju/peY03E2w8Hd1231y9zPfuMKrqjhuN8ahMNrpksXdncmr2kjCrYXPQxfAdizs+
         vitGgoAh7tlNk0nabJ87hto1CA+msxmivlfE5TsqDgTmHpczacmmym88Vx0bOMZdRt6y
         +JogiE3aBnmtWSJ5S/xYxppYQVkcENySj9t7k=
Received: by 10.204.134.3 with SMTP id h3mr3249777bkt.402.1314287975756;
        Thu, 25 Aug 2011 08:59:35 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id b17sm216204bkd.65.2011.08.25.08.59.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Aug 2011 08:59:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180084>

svn symlinks are files with "link destination" content and a
"svn:special=*" property set. These are imported as blobs with
"destination" content and S_IFLNK mode. When svn copy a file without
altering it's content(but maybe altering it's mode), we reuse the blob
object thus loosing or not adding the "link " prefix.

But we take possible prefix into account when applying svn deltas. And
this is the only place we ask fast-import for original blob. So pretend
that we want to apply a zero delta to resolve the issue.

There is some overhead due to using a temporary file to store such a small
blob. But hopefully such node change is too rare to care.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
This could be done better if we just read the cat-blob to memory, added or
removed the "link " prefix and wrote it to the stream, because the link
destination should be a tiny string. But on the other hand it'd blow up
if for some reason it's huge.

And taking into account that changing file mode from/to link without a
content change should be extremely rare anyway, I think it's ok.

Maybe it is redundant to add svndiff0_identity function to just cat blob
to a temporary file. The excuse is that svndiff.c is the only user of this
temporary file and the cat-blob response, so keep it there.

The patch base is svn-fe branch at git://repo.or.cz/git/jrn.git
Not backporting it to git master because vcs-svn stuff differs quite much
around this change.

 t/t9010-svn-fe.sh     |    2 +-
 vcs-svn/fast_export.c |    6 +++++-
 vcs-svn/svndiff.c     |   17 +++++++++++++++++
 vcs-svn/svndiff.h     |    1 +
 vcs-svn/svndump.c     |   16 +++++++++++++++-
 5 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b7eed24..b6bdfeb 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -413,7 +413,7 @@ test_expect_success PIPE 'action: add node without text' '
 	try_dump textless.dump must_fail
 '
 
-test_expect_failure PIPE 'change file mode but keep old content' '
+test_expect_success PIPE 'change file mode but keep old content' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
 	OBJID
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 19d7c34..8c7295f 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -209,7 +209,11 @@ static long apply_delta(off_t len, struct line_buffer *input,
 		preimage.max_off += strlen("link ");
 		check_preimage_overflow(preimage.max_off, 1);
 	}
-	if (svndiff0_apply(input, len, &preimage, out))
+
+	if (!input) {
+		if (svndiff0_identity(&preimage, out))
+			die("cannot cat blob");
+	} else if (svndiff0_apply(input, len, &preimage, out))
 		die("cannot apply delta");
 	if (old_data) {
 		/* Read the remainder of preimage and trailing newline. */
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 9ee41bb..bf104db 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -306,3 +306,20 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 	}
 	return 0;
 }
+int svndiff0_identity(struct sliding_view *preimage, FILE *postimage)
+{
+	assert(preimage && postimage);
+	off_t pre_off = 0;
+
+	while (pre_off != preimage->max_off) {
+		size_t pre_len = 8192;
+		if (pre_off + pre_len > preimage->max_off)
+			pre_len = preimage->max_off - pre_off;
+		if (move_window(preimage, pre_off, pre_len) ||
+			write_strbuf(&preimage->buf, postimage))
+			return -1;
+		pre_off += pre_len;
+	}
+
+	return 0;
+}
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
index 74eb464..5afa3f2 100644
--- a/vcs-svn/svndiff.h
+++ b/vcs-svn/svndiff.h
@@ -6,5 +6,6 @@ struct sliding_view;
 
 extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 		struct sliding_view *preimage, FILE *postimage);
+extern int svndiff0_identity(struct sliding_view *preimage, FILE *postimage);
 
 #endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index b1f4161..1e7ed48 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -285,7 +285,21 @@ static void handle_node(void)
 		/* For the fast_export_* functions, NULL means empty. */
 		old_data = NULL;
 	if (!have_text) {
-		fast_export_modify(node_ctx.dst.buf, node_ctx.type, old_data);
+		/*
+		 * This is clean content copy in svn, but we alter the content
+		 * of symlinks (add/remove "link " prefix used by svn). So when
+		 * mode changes from/to symlink specify (recreate) data inline.
+		 */
+		if (node_ctx.type != old_mode && (old_mode == REPO_MODE_LNK
+					|| node_ctx.type == REPO_MODE_LNK)) {
+
+			fast_export_modify(node_ctx.dst.buf,
+						node_ctx.type, "inline");
+			fast_export_blob_delta(node_ctx.type, old_mode,
+						old_data, 0, NULL);
+		} else
+			fast_export_modify(node_ctx.dst.buf,
+						node_ctx.type, old_data);
 		return;
 	}
 	if (!node_ctx.text_delta) {
-- 
1.7.3.4
