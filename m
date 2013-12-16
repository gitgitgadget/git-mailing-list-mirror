From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any file, fail properly
Date: Mon, 16 Dec 2013 15:09:45 -0500
Message-ID: <1387224586-10169-3-git-send-email-naesten@gmail.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 16 21:10:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VseUr-0005ql-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 21:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab3LPUKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 15:10:21 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:49214 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab3LPUKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 15:10:17 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so1892781qab.16
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 12:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QPsUpC5IszVjAuSaViLlXbAKq750YHOqiy+gRtkU/iU=;
        b=So2nxPimBMM/3+sgqxAmZDFxxl8SroYjwdZCxR4GMpzXCUB7usLzvVbmJ9G3elE7RO
         fMnZrv9mkUghI9a/D2+ceAuWEbIjP+kFbxwCtpTfxBluXyWOEfSXMQhrtAvD3KM4DTGK
         F26Xk2lD6YAI3RtRSY87n3IISjq5lrt1ByVgn87GFnoUw1aZZlBrY228MrK/LH5ryWBM
         Vg/YhyFYsWXWvlBT8qmvmhPOoAgZjD7+KoFLIoCQpiKHig0ASfmDX9MyUwTxAk3rOiwA
         jp2sv71+DO6JGiUiJeCU6v202VcbKV2eT2Stv7m0GFUL33MZIlFL2KyWPdHhBSN/Zosp
         3IiA==
X-Received: by 10.224.16.204 with SMTP id p12mr36545638qaa.26.1387224616097;
        Mon, 16 Dec 2013 12:10:16 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id f10sm43135178qej.1.2013.12.16.12.10.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Dec 2013 12:10:14 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VseUW-0002ev-G3; Mon, 16 Dec 2013 15:10:12 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1387224586-10169-1-git-send-email-naesten@gmail.com>
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239362>

The -O flag really shouldn't silently fail to do anything when given a
path that it can't read from.

However, it should be able to read from un-mmappable files, such as:

 * pipes/fifos

 * /dev/null:  It's a character device (at least on Linux)

 * ANY empty file:

   Quoting Linux mmap(2), "SUSv3 specifies that mmap() should fail if
   length is 0.  However, in kernels before 2.6.12, mmap() succeeded in
   this case: no mapping was created and the call returned addr.  Since
   kernel 2.6.12, mmap() fails with the error EINVAL for this case."

We especially want "-O/dev/null" to work, since we will be documenting
it as the way to cancel "diff.orderfile" when we add that.

(Note: "-O/dev/null" did have the right effect, since the existing error
handling essentially worked out to "silently ignore the orderfile".  But
this was probably more coincidence than anything else.)

So, lets toss all of that logic to get the file mmapped and just use
strbuf_read_file() instead, which gives us decent error handling
practically for free.

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 diffcore-order.c      | 23 ++++++++---------------
 t/t4056-diff-order.sh | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/diffcore-order.c b/diffcore-order.c
index 23e9385..a63f332 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -10,28 +10,21 @@ static int order_cnt;
 
 static void prepare_order(const char *orderfile)
 {
-	int fd, cnt, pass;
+	int cnt, pass;
+	struct strbuf sb = STRBUF_INIT;
 	void *map;
 	char *cp, *endp;
-	struct stat st;
-	size_t sz;
+	ssize_t sz;
 
 	if (order)
 		return;
 
-	fd = open(orderfile, O_RDONLY);
-	if (fd < 0)
-		return;
-	if (fstat(fd, &st)) {
-		close(fd);
-		return;
-	}
-	sz = xsize_t(st.st_size);
-	map = mmap(NULL, sz, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
-	close(fd);
-	if (map == MAP_FAILED)
-		return;
+	sz = strbuf_read_file(&sb, orderfile, 0);
+	if (sz < 0)
+		die_errno(_("failed to read orderfile '%s'"), orderfile);
+	map = strbuf_detach(&sb, NULL);
 	endp = (char *) map + sz;
+
 	for (pass = 0; pass < 2; pass++) {
 		cnt = 0;
 		cp = map;
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index 398b3f6..eb471e7 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -61,12 +61,35 @@ test_expect_success "no order (=tree object order)" '
 	test_cmp expect_none actual
 '
 
+test_expect_success 'missing orderfile' '
+	rm -f bogus_file &&
+	test_must_fail git diff -Obogus_file --name-only HEAD^..HEAD
+'
+
+test_expect_success 'unreadable orderfile' '
+	touch unreadable_file &&
+	chmod -r unreadable_file &&
+	test_must_fail git diff -Ounreadable_file --name-only HEAD^..HEAD
+'
+
+test_expect_success 'orderfile is a directory' '
+	test_must_fail git diff -O/ --name-only HEAD^..HEAD
+'
+
 for i in 1 2
 do
 	test_expect_success "orderfile using option ($i)" '
 	git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
 	test_cmp expect_$i actual
 '
+
+	test_expect_success PIPE "orderfile is fifo ($i)" '
+	rm -f order_fifo &&
+	mkfifo order_fifo &&
+	cat order_file_$i >order_fifo &
+	git diff -O order_fifo --name-only HEAD^..HEAD >actual &&
+	test_cmp expect_$i actual
+'
 done
 
 test_done
-- 
1.8.4.3
