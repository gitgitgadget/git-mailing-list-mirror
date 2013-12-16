From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH v4 1/3] diff: Tests for "git diff -O"
Date: Mon, 16 Dec 2013 15:09:44 -0500
Message-ID: <1387224586-10169-2-git-send-email-naesten@gmail.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 16 21:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VseUi-0005kV-Lg
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 21:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab3LPUKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 15:10:15 -0500
Received: from mail-qe0-f43.google.com ([209.85.128.43]:36295 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab3LPUKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 15:10:13 -0500
Received: by mail-qe0-f43.google.com with SMTP id 2so4314745qeb.2
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 12:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TX5RdXmFPRYQ97YQSwdt1aWrtty8XPNPbZydHEQ5Jd8=;
        b=OEto+GKoFJhA/EumZePuKP3pCDZjuRHa25uoAVdBssXj6r+BoaW4mvP5YwSi/5CuiJ
         A7CTvxTUHkkUHeBPtG7UOhlqdYQP548OH208CA5thRMIfIM/g2K7CHuCCkNlvJIhO4Cw
         xSPS4scUV6QWaV9KVo4G3VBUdvVKoFC3AZweNxlViw8EboDHfkTr6mF+WIoHzCn6CJki
         Tpp2eKs1jB1gF5rzhp7V3XRBFxbVPOQikAg8E1oCOggcSuXWx2k4bQ+IHmNlvwEF4jfO
         5hd+avfStQrZqlu8ql03AX0kZ0TuMdAEtzjSWPAG2o1hD5V/avlIclQEnp/gLqbTBzex
         hZhA==
X-Received: by 10.49.24.82 with SMTP id s18mr35906368qef.27.1387224613101;
        Mon, 16 Dec 2013 12:10:13 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id p20sm48488984qay.0.2013.12.16.12.10.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Dec 2013 12:10:12 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VseUV-0002eq-GB; Mon, 16 Dec 2013 15:10:11 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1387224586-10169-1-git-send-email-naesten@gmail.com>
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239360>

Heavily adapted from Anders' patch:
"diff: Add diff.orderfile configuration variable"

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 t/t4056-diff-order.sh | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100755 t/t4056-diff-order.sh

diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
new file mode 100755
index 0000000..398b3f6
--- /dev/null
+++ b/t/t4056-diff-order.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='diff order'
+
+. ./test-lib.sh
+
+create_files () {
+	echo "$1" >a.h &&
+	echo "$1" >b.c &&
+	echo "$1" >c/Makefile &&
+	echo "$1" >d.txt &&
+	git add a.h b.c c/Makefile d.txt &&
+	git commit -m"$1"
+}
+
+test_expect_success 'setup' '
+	mkdir c &&
+	create_files 1 &&
+	create_files 2 &&
+
+	cat >order_file_1 <<-\EOF &&
+	*Makefile
+	*.txt
+	*.h
+	*
+	EOF
+
+	cat >order_file_2 <<-\EOF &&
+	*Makefile
+	*.h
+	*.c
+	*
+	EOF
+
+	cat >expect_none <<-\EOF &&
+	a.h
+	b.c
+	c/Makefile
+	d.txt
+	EOF
+
+	cat >expect_1 <<-\EOF &&
+	c/Makefile
+	d.txt
+	a.h
+	b.c
+	EOF
+
+	cat >expect_2 <<-\EOF &&
+	c/Makefile
+	a.h
+	b.c
+	d.txt
+	EOF
+
+	true	# end chain of &&
+'
+
+test_expect_success "no order (=tree object order)" '
+	git diff --name-only HEAD^..HEAD >actual &&
+	test_cmp expect_none actual
+'
+
+for i in 1 2
+do
+	test_expect_success "orderfile using option ($i)" '
+	git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
+	test_cmp expect_$i actual
+'
+done
+
+test_done
-- 
1.8.4.3
