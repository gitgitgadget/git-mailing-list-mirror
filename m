From: Jim Hill <gjthill@gmail.com>
Subject: [PATCH] sha1_file: pass empty buffer to index empty file
Date: Thu, 14 May 2015 10:23:39 -0700
Message-ID: <1431624219-25045-1-git-send-email-gjthill@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 19:23:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YswrS-000101-98
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933530AbbENRXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:23:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36118 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbbENRXs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:23:48 -0400
Received: by iepk2 with SMTP id k2so65102746iep.3
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5qdAAONgRLQYI7dPx53qVb75X0gtV2DJO9vIuznDMRA=;
        b=kzoxEFIiVaWrEWDO3Jim4n89O5MF7Vm2qA68CK8JfisVvwi5CHbhlnNMmcJC7Gv4zd
         Ft8idoN+czmjNhBrRsjRZvM0MfO1qCVX9hMRpfNA5fEISLCmGeafdsk5xTh38v2xKH3i
         NFN2fGQ6RkNKHP5MO3dRHyQDmOW1AgSFHyxiD3gUjs4VYV8RlbVU5ResNmax9yenC/R8
         eWut7Oyo0iJaoqJZ+sAtRCE92JnVHnoLeWB/vhze+6AsYUhlf8l7lZlckxbY45r11AG+
         p3ZNIrGs4dd8j8k6xp7EtYuNi2oalXTT6mq6dxkkqnGdF8JaSjqiFcdWalK3xGmLFEm7
         27fw==
X-Received: by 10.50.8.68 with SMTP id p4mr7816019iga.4.1431624228110;
        Thu, 14 May 2015 10:23:48 -0700 (PDT)
Received: from gadabout.domain.actdsltmp (pool-71-119-14-52.lsanca.dsl-w.verizon.net. [71.119.14.52])
        by mx.google.com with ESMTPSA id 69sm16905227ioz.10.2015.05.14.10.23.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 10:23:47 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.4.gd9c648d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269050>

`git add` of an empty file with a filter currently pops complaints from
`copy_fd` about a bad file descriptor.

This traces back to these lines in sha1_file.c:index_core:

	if (!size) {
		ret = index_mem(sha1, NULL, size, type, path, flags);

The problem here is that content to be added to the index can be
supplied from an fd, or from a memory buffer, or from a pathname. This
call is supplying a NULL buffer pointer and a zero size.

Downstream logic takes the complete absence of a buffer to mean the
data is to be found elsewhere -- for instance, these, from convert.c:

	if (params->src) {
		write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
	} else {
		write_err = copy_fd(params->fd, child_process.in);
	}

~If there's a buffer, write from that, otherwise the data must be coming
from an open fd.~

Perfectly reasonable logic in a routine that's going to write from
either a buffer or an fd.

So change `index_core` to supply an empty buffer when indexing an empty
file.

There's a patch out there that instead changes the logic quoted above to
take a `-1` fd to mean "use the buffer", but it seems to me that the
distinction between a missing buffer and an empty one carries intrinsic
semantics, where the logic change is adapting the code to handle
incorrect arguments.

Signed-off-by: Jim Hill <gjthill@gmail.com>
---
 sha1_file.c                        |  2 +-
 t/t2205-add-empty-filtered-file.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100755 t/t2205-add-empty-filtered-file.sh

diff --git a/sha1_file.c b/sha1_file.c
index f860d67..61e2735 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3186,7 +3186,7 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
 	int ret;
 
 	if (!size) {
-		ret = index_mem(sha1, NULL, size, type, path, flags);
+		ret = index_mem(sha1, "", size, type, path, flags);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
 		if (size == read_in_full(fd, buf, size))
diff --git a/t/t2205-add-empty-filtered-file.sh b/t/t2205-add-empty-filtered-file.sh
new file mode 100755
index 0000000..28903c4
--- /dev/null
+++ b/t/t2205-add-empty-filtered-file.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='adding empty filtered file'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo "* filter=test" >>.gitattributes &&
+	git config filter.test.clean cat &&
+	git config filter.test.smudge cat &&
+	git add . &&
+	git commit -m-
+
+'
+
+test_expect_success "add of empty filtered file produces no complaints" '
+	touch emptyfile &&
+	git add emptyfile 2>out &&
+	test -e out -a ! -s out
+'
+test_done
-- 
2.4.1.4.gd9c648d
