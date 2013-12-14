From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH v3 2/3] diff: Let "git diff -O" read orderfile from any file, failing when appropriate
Date: Sat, 14 Dec 2013 17:18:40 -0500
Message-ID: <1387059521-23616-3-git-send-email-naesten@gmail.com>
References: <1387059521-23616-1-git-send-email-naesten@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 23:19:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrxYk-0002aS-A9
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 23:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab3LNWTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 17:19:37 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:60257 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab3LNWTg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 17:19:36 -0500
Received: by mail-qa0-f45.google.com with SMTP id o15so548495qap.11
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 14:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DT4H3hi33QAP0rQYiMsKF3w89qfDGWZhvljxxUrSuug=;
        b=WZAPwKddjal3ZEKFC0vNMJCj6DDZkHOw8ZXWZsZCDLIQfG154xokY6GzoiocMLG3E4
         87Ka0O2gXOKopNnAy0XflbtTnwFzWMxN6XvusF+O6Ma7QbYWr05OLtKnzMLvDLFrgfNw
         djoZGANztpJVtMtqwlpIT32L111ggnkBOJzDR/UVbPkBpH8cQpZEDqFMny0Rzw4wjpIt
         TdOq96gIbCPhQ4z3UfNIbbZSBRHPYhS2+3OEvR5nKStJn2hwpN4vQZ2CKiChZZqbonPj
         SdFM3+Xq20kkr887yX/CUHl7nT0Dh3I/yOxtTumty96V2tPT50sw86otfn4vDDkVjvkH
         4Www==
X-Received: by 10.49.84.195 with SMTP id b3mr18702952qez.32.1387059575802;
        Sat, 14 Dec 2013 14:19:35 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id hb2sm21887758qeb.6.2013.12.14.14.19.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 14:19:35 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VrxYc-00069r-Df; Sat, 14 Dec 2013 17:19:34 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1387059521-23616-1-git-send-email-naesten@gmail.com>
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239319>

The -O flag really shouldn't silently fail to do anything when given a
path that it can't read from.

However, it should be able to read from un-mappable files, such as
pipes/fifos, /dev/null (as we document in the next patch), or in fact
*any* empty file (since Linux 2.6.12).  (Especially since we will be
documenting "-O/dev/null" to override "diff.orderfile" when we add that.)

(Note: "-O/dev/null" did have the right effect, since the existing error
handling essentially worked out to "silently ignore the orderfile".)

So lets toss all of that logic to get the file mmapped and just use
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
