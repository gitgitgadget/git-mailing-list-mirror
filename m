From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH v5 1/3] diff: Tests for "git diff -O"
Date: Wed, 18 Dec 2013 19:08:10 -0500
Message-ID: <1387411692-15562-2-git-send-email-naesten@gmail.com>
References: <1387411692-15562-1-git-send-email-naesten@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 19 01:19:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtRKZ-00036v-9U
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 01:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823Ab3LSATE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 19:19:04 -0500
Received: from mail-qe0-f51.google.com ([209.85.128.51]:64798 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab3LSATC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 19:19:02 -0500
Received: by mail-qe0-f51.google.com with SMTP id 1so383880qee.38
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 16:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vicO5SfnoqCZ037/qAOT2wNHDC3Rh7Xs4NuASORLAo8=;
        b=LcW95gCXS4FdgHQrWPIoI/gsYgev8u//1u/A9zrXxbdq3UiT98QCFY7BvhztpbIhwo
         skrCQscwtVnpmmO/CM+4UPy3+70lt63ic6mgs2FGkLrNVX2d5cwT1WWBnoKKw2QQ8IuP
         FVKQJSJiVA/Be9xwU6GKghRphlydzXtDH/GyQKoL99c3zwJ4/3hsUYD4F3UJOPZA/nIh
         9/N705aZjhQuvc3DXFn6OWhBCPg0f1O2bfn+j6AT5SSqtCGr1P/eeQ/uLxm8X44mM7pk
         Vh4gjzEqRpomh/wSKO224azEusQiJfJZNwTMK/Utu2P4ff9x62z98nGqj4o1Bo1vCQS+
         66dw==
X-Received: by 10.49.12.43 with SMTP id v11mr59145973qeb.50.1387412342108;
        Wed, 18 Dec 2013 16:19:02 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id f19sm4894701qaq.12.2013.12.18.16.19.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 16:19:01 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VtRKN-00046O-UA; Wed, 18 Dec 2013 19:18:59 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1387411692-15562-1-git-send-email-naesten@gmail.com>
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239505>

Heavily adapted from Anders' patch:
"diff: Add diff.orderfile configuration variable"

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 t/t4056-diff-order.sh | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100755 t/t4056-diff-order.sh

diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
new file mode 100755
index 0000000..218f171
--- /dev/null
+++ b/t/t4056-diff-order.sh
@@ -0,0 +1,70 @@
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
+	EOF
+
+	cat >order_file_2 <<-\EOF &&
+	*Makefile
+	*.h
+	*.c
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
+		git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
+		test_cmp expect_$i actual
+	'
+done
+
+test_done
-- 
1.8.4.3
