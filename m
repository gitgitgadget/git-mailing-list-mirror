From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH v5 2/3] diff: Let "git diff -O" read orderfile from any file, fail properly
Date: Wed, 18 Dec 2013 19:08:11 -0500
Message-ID: <1387411692-15562-3-git-send-email-naesten@gmail.com>
References: <1387411692-15562-1-git-send-email-naesten@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 19 01:19:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtRKY-00036v-Mh
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 01:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab3LSATF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 19:19:05 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:42051 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab3LSATD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 19:19:03 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so4312880qab.9
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 16:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pdkj5MdBcLanCHpfyIR0Ad8Y6ks2aRLd+jRoYWQ8U5g=;
        b=1FW6wbZUT/MSSI5/iogVqFCoQDf6iJTEB9BkPXD+NfVTr7WJjh1aJvjb5yDVp4yjSF
         70CrC/N34n0GMG1NmUvMKMmu87se7vbR306W9RAQv3ssz1qpdML/S5rU1q128VSbcNlK
         8Pr11QCO9/xnSxDNkfmo/Vz79pqQGuOqgysUDhfUaVuUhrxRTADY5ShMesi5Nlza6bOj
         Up4Vt8pyN6ICYkq0HgNJdch0mQInplM006hKSqZ1RbXMEOkrZj+x7W1tIu7rFCqwcOGe
         5ABLYyhhSxcR6WBzPqfyiN934RnWF/rD2aievSmHh133HGYGM0s/9VxHrUQdFDqwktqC
         NF7g==
X-Received: by 10.224.120.71 with SMTP id c7mr58829287qar.37.1387412343255;
        Wed, 18 Dec 2013 16:19:03 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id lc1sm5567117qeb.5.2013.12.18.16.19.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 16:19:02 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VtRKP-00046U-En; Wed, 18 Dec 2013 19:19:01 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1387411692-15562-1-git-send-email-naesten@gmail.com>
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239504>

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
 t/t4056-diff-order.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 15 deletions(-)

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
index 218f171..0ac1b95 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -59,12 +59,38 @@ test_expect_success "no order (=tree object order)" '
 	test_cmp expect_none actual
 '
 
+test_expect_success 'missing orderfile' '
+	rm -f bogus_file &&
+	test_must_fail git diff -Obogus_file --name-only HEAD^..HEAD
+'
+
+test_expect_success POSIXPERM,SANITY 'unreadable orderfile' '
+	>unreadable_file &&
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
+		rm -f order_fifo &&
+		mkfifo order_fifo &&
+		{
+			cat order_file_$i >order_fifo &
+		} &&
+		git diff -O order_fifo --name-only HEAD^..HEAD >actual &&
+		wait &&
+		test_cmp expect_$i actual
+	'
 done
 
 test_done
-- 
1.8.4.3
